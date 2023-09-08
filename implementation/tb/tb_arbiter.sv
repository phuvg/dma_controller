////////////////////////////////////////////////////////////////////////////////
// Filename    : tb_arbiter.v
// Description : 
//
// Author      : Phu Vuong
// History     : Aug 18, 2023 : Initial 	
//
////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps
module tb_arbiter();
	////////////////////////////////////////////////////////////////////////////
    //param declaration
    ////////////////////////////////////////////////////////////////////////////
	parameter					CLK_PERIOD = 1; //T=1ns => F=1GHz
    parameter                   DMA_CH = 8;
    parameter                   NUM_PRT_LVL = 16;
    parameter                   PRT_LVL_CASE = 0;
	
	////////////////////////////////////////////////////////////////////////////
    //port declaration
    ////////////////////////////////////////////////////////////////////////////
	//-----------------------
	//clk and reset
    reg                             clk;
    reg                             rstn;
	//-----------------------
	//input
    reg                             req                 [DMA_CH-1:0]        ;
    reg     [3:0]                   priority_level      [DMA_CH-1:0]        ;
	//-----------------------
	//output
    wire                            grant               [DMA_CH-1:0]        ;
	
	////////////////////////////////////////////////////////////////////////////
    //testbench reg - wire declaration
    ////////////////////////////////////////////////////////////////////////////
    genvar i;
    reg                             req_to_arbiter      [DMA_CH-1:0]        ;
    reg     [7:0]                   cnt                 [DMA_CH-1:0]        ;
    reg     [7:0]                   cnt_target          [DMA_CH-1:0]        ;
    reg     [9:0]                   clk_cnt                                 ;
	
	////////////////////////////////////////////////////////////////////////////
    //instance
    ////////////////////////////////////////////////////////////////////////////
    //#--> arbiter
    arbiter #(
        .DMA_CH(DMA_CH)
    ) arbiter00(
	    //-----------------------
	    //clk and reset
        .clk_i(clk),
        .rstn_i(rstn),
	    //-----------------------
	    //input
        .req_i(req),
        .priority_level_i(priority_level),
	    //-----------------------
	    //output
        .grant_o(grant)
    );

	
	////////////////////////////////////////////////////////////////////////////
    //testbench logic connection
    ////////////////////////////////////////////////////////////////////////////
    generate
        for(i=0; i<DMA_CH; i++) begin
            always @(posedge clk or negedge rstn) begin
                if(~rstn) begin
                    cnt[i] <= 8'h0;
                end else begin
                    if(grant[i] == 1'b1) begin
                        cnt[i] <= cnt[i] + 8'h1;
                    end else begin
                        cnt[i] <= 8'h0;
                    end
                end
            end

            always @(negedge clk or negedge rstn) begin
                if(~rstn) begin
                    req[i] <= 1'b0;
                end else begin
                    if(cnt[i] == cnt_target[i]) begin
                        req[i] <= 1'b0;
                    end
                end
            end

            always @(posedge clk or negedge rstn) begin
                if(~rstn) begin
                    req_to_arbiter[i] <= 1'b0;
                end else begin
                    req_to_arbiter[i] <= req[i];
                end
            end
        end
    endgenerate
	
	////////////////////////////////////////////////////////////////////////////
    //testbench
    ////////////////////////////////////////////////////////////////////////////
	//-----------------------
    //#--> testcase
    initial begin
        //#--> init
        clk = 1'b0;
        rstn = 1'b1;
        clk_cnt = 9'h0;

        //#--> reset
        #(CLK_PERIOD*4) rstn = 1'b0;
        #(CLK_PERIOD*1) rstn = 1'b1;

        //#--> 1st req
        #(CLK_PERIOD*6.5);
        request0(8'h4);
        request1(8'h2);
        request2(8'h5);
        request6(8'h1);

        //#--> 2nd req
        #(CLK_PERIOD*20);
        request0(8'h3);
        request1(8'h8);
        request2(8'h4);
        #(CLK_PERIOD*4);
        request5(8'h6);
        request7(8'h6);
        #(CLK_PERIOD*10);
        request0(8'h5);

        //#--> finish
        #(50*CLK_PERIOD);
        $finish();
    end

    //#--> init for req
    generate
        for(i=0; i<DMA_CH; i++) begin : req_GEN
            initial begin
                req[i] = 1'b0;
            end
        end
    endgenerate

    //#--> init for priority_level
    generate
        if(PRT_LVL_CASE == 0) begin : priority_level_case0__GEN
            for(i=0; i<DMA_CH; i++) begin : priority_level__GEN
                initial begin
                    priority_level[i] = i;
                end
            end
        end else if(PRT_LVL_CASE == 1) begin : priority_level_case1__GEN
            for(i=0; i<DMA_CH; i++) begin : priority_level__GEN
                initial begin
                    priority_level[i] = 1'b0;
                end
            end
        end
    endgenerate

    //#--> init for req
    generate
        for(i=0; i<DMA_CH; i++) begin : cnt_target__GEN
            initial begin
                cnt_target[i] = 8'h2;
            end
        end
    endgenerate
    
	//-----------------------
    //#--> clock gen
    always begin
        #(0.5 * CLK_PERIOD) clk <= ~clk;
    end

	//-----------------------
    //#--> clk counter for test
    always @(posedge clk) begin
        clk_cnt <= clk_cnt + 9'h1;
    end

    
	////////////////////////////////////////////////////////////////////////////
    //task
    ////////////////////////////////////////////////////////////////////////////
    task request0;
        input [7:0] target;
        begin
            if(req[0] != 1'b1) begin
                req[0] = 1'b1;
                cnt_target[0] = target;
            end
        end
    endtask

    task request1;
        input [7:0] target;
        begin
            if(req[1] != 1'b1) begin
                req[1] = 1'b1;
                cnt_target[1] = target;
            end
        end
    endtask

    task request2;
        input [7:0] target;
        begin
            if(req[2] != 1'b1) begin
                req[2] = 1'b1;
                cnt_target[2] = target;
            end
        end
    endtask

    task request3;
        input [7:0] target;
        begin
            if(req[3] != 1'b1) begin
                req[3] = 1'b1;
                cnt_target[3] = target;
            end
        end
    endtask

    task request4;
        input [7:0] target;
        begin
            if(req[4] != 1'b1) begin
                req[4] = 1'b1;
                cnt_target[4] = target;
            end
        end
    endtask

    task request5;
        input [7:0] target;
        begin
            if(req[5] != 1'b1) begin
                req[5] = 1'b1;
                cnt_target[5] = target;
            end
        end
    endtask

    task request6;
        input [7:0] target;
        begin
            if(req[6] != 1'b1) begin
                req[6] = 1'b1;
                cnt_target[6] = target;
            end
        end
    endtask

    task request7;
        input [7:0] target;
        begin
            if(req[7] != 1'b1) begin
                req[7] = 1'b1;
                cnt_target[7] = target;
            end
        end
    endtask
	
	////////////////////////////////////////////////////////////////////////////
    //dump waveform
    ////////////////////////////////////////////////////////////////////////////
    initial begin
        $dumpfile("wf_arbiter.vcd");
        $dumpvars(tb_arbiter);
    end
endmodule
