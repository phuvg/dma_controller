////////////////////////////////////////////////////////////////////////////////
// Filename    : tb_top.v
// Description : 
//
// Author      : Phu Vuong
// History     : Jul 03, 2023 : Initial
//
////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps
module tb_dma_reg();
	////////////////////////////////////////////////////////////////////////////
    //param declaration
    ////////////////////////////////////////////////////////////////////////////
	parameter					            CLK_PERIOD = 1; //T=1ns => F=1GHz
    #file_declare_parameter.txt
	
	////////////////////////////////////////////////////////////////////////////
    //port declaration
    ////////////////////////////////////////////////////////////////////////////
    #file_declare_input_output_fixed.txt
    #file_declare_output_field.txt
	
	////////////////////////////////////////////////////////////////////////////
    //testbench reg - wire declaration
    ////////////////////////////////////////////////////////////////////////////
    reg                                     false_enable;
    reg                                     false_flag;
	
	////////////////////////////////////////////////////////////////////////////
    //instance
    ////////////////////////////////////////////////////////////////////////////
    dma_reg inst_dma_reg(
        #file_declare_input_output_fixed.txt
        #file_declare_output_field.txt
    );
	
	////////////////////////////////////////////////////////////////////////////
    //testbench logic connection
    ////////////////////////////////////////////////////////////////////////////
    always @(posedge false_enable) begin
        false_flag <= 1'b1;
    end
	
	////////////////////////////////////////////////////////////////////////////
    //testbench
    ////////////////////////////////////////////////////////////////////////////
    initial begin
        reg_addr_i = {(ADDR_WIDTH){1'b0}};
        reg_wr_en_i = 1'b0;
        reg_wr_data_i = {(DATA_WIDTH){1'b0}};
        reg_rd_en_i = 1'b0;
        clk = 1'b0;
        rstn = 1'b1;
        false_enable = 1'b0;
        false_flag = 1'b0;
        
        //#--> reset
        #(4*CLK_PERIOD) rstn = 1'b0;
        #(4*CLK_PERIOD) rstn = 1'b1;
        #(2*CLK_PERIOD);
        
        #file_tb_write_register.txt
        #file_tb_read_register.txt
        #(10*CLK_PERIOD);
        summary(false_flag);
        $finish();
    end
    
    //#--> clock gen
    always begin
        #(0.5 * CLK_PERIOD) clk <= ~clk;
    end
    
	////////////////////////////////////////////////////////////////////////////
    //task
    ////////////////////////////////////////////////////////////////////////////
    #file_tb_report_register.txt
    //#--> summary
    task summary;
        input false_flag;
        begin
            if(~false_flag) begin
                $display("===================================");
                $display("==============SUMMARY==============");
                $display("===============PASS================");
                $display("==============PHUVUONG=============");
                $display("===================================");
            end else begin
                $display("===================================");
                $display("==============SUMMARY==============");
                $display("===============FAIL================");
                $display("==============PHUVUONG=============");
                $display("===================================");
            end
        end
    endtask
	
	////////////////////////////////////////////////////////////////////////////
    //dump waveform
    ////////////////////////////////////////////////////////////////////////////
    initial begin
        $dumpfile("wf_dma_reg.vcd");
        $dumpvars(tb_dma_reg);
    end
endmodule