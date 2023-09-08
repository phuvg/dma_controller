////////////////////////////////////////////////////////////////////////////////
// Filename    : arbiter.sv
// Description : 
//
// Author      : Phu Vuong
// History     : Aug 15, 2023 : Initial     
//
////////////////////////////////////////////////////////////////////////////////
module arbiter(
    //-----------------------
    //clk and reset
    clk_i,
    rstn_i,
    //-----------------------
    //input
    req_i,
    priority_level_i,
    //-----------------------
    //output
    grant_o
);
    /////////////////////////////////////////////////////////////////////////////////////////
    //param declaration
    /////////////////////////////////////////////////////////////////////////////////////////
    parameter                       DMA_CH                      = 8                 ;
    parameter                       NUM_PRT_LVL                 = 16                ;

    /////////////////////////////////////////////////////////////////////////////////////////
    //pin - port declaration
    /////////////////////////////////////////////////////////////////////////////////////////
    //-----------------------
    //clk and reset
    input                           clk_i                                           ;
    input                           rstn_i                                          ;
	//-----------------------
	//input
    input                           req_i                       [DMA_CH-1:0]        ;
    input   [3:0]                   priority_level_i            [DMA_CH-1:0]        ;
	//-----------------------
	//output
    output                          grant_o                     [DMA_CH-1:0]        ;
    
    /////////////////////////////////////////////////////////////////////////////////////////
    //wire - reg name declaration
    /////////////////////////////////////////////////////////////////////////////////////////
    //#--> genvar
    genvar                          i                                               ;
    genvar                          j                                               ;
    genvar                          m                                               ;
    genvar                          n                                               ;
    //#--> Priority selection
    wire    [DMA_CH*NUM_PRT_LVL-1:0]    req_with_priority_level                     ;
    //#--> Asserted request check
    wire    [DMA_CH-1:0]                pre_or_priority_result  [NUM_PRT_LVL-1:0]   ;
    wire                                or_priority_result      [NUM_PRT_LVL-1:0]   ;
    //#--> Request enable
    wire    [NUM_PRT_LVL-2:0]           req_en_gating_in        [NUM_PRT_LVL-1:1]   ;
    wire    [15:0]                      req_en                                      ;
    //#--> Request mask
    wire    [DMA_CH*NUM_PRT_LVL-1:0]    grant_mask                                  ;
    //#--> Grant set
    wire    [DMA_CH-1:0]                set_grant                                   ;
    //#--> Same priority filter
    wire    [DMA_CH-2:0]                set_prt_grant_gating_in [DMA_CH-1:1]        ;
    wire    [DMA_CH:0]                  set_prt_grant                               ;
    //#--> Grant
    wire                                no_grant                                    ;
    wire                                grant_and_req           [DMA_CH-1:0]        ;
    wire                                nxt_grant               [DMA_CH-1:0]        ;
    reg     [DMA_CH-1:0]                grant                                       ;

    /////////////////////////////////////////////////////////////////////////////////////////
    //design description
    /////////////////////////////////////////////////////////////////////////////////////////
    //#--> Priority selection
    generate
        for(i=0; i<DMA_CH; i++) begin : priority_selection__GEN
            decoder_4to16 decoder_4to16(
                .en_i(req_i[i]),
                .in_i(priority_level_i[i]),
                .out_o(req_with_priority_level[(i*NUM_PRT_LVL)+:NUM_PRT_LVL])
            );
        end
    endgenerate

    //#--> Asserted request check
    generate
        for(i=0; i<NUM_PRT_LVL; i++) begin : pre_or_priority_result_GEN
            for(j=0; j<DMA_CH; j++) begin : pre_or_priority_result_bit__GEN
                assign pre_or_priority_result[i][j] = req_with_priority_level[j*NUM_PRT_LVL+i];
            end
        end
    endgenerate

    generate
        for(i=0; i<NUM_PRT_LVL; i++) begin : or_priority_result__GEN
            assign or_priority_result[i] = |pre_or_priority_result[i];
        end
    endgenerate

    //#--> Request enable
    generate
        if(DMA_CH == 1) begin : req_en_gating_in_1CH__GEN
            for(i=1; i<NUM_PRT_LVL; i++) begin : req_en_gating_in__GEN
                assign req_en_gating_in[i] = {(NUM_PRT_LVL-1){1'b0}};
            end
        end else begin : req_en_gating_in_nCH__GEN
            for(i=1; i<NUM_PRT_LVL; i++) begin : req_en_gating_in__GEN
                for(m=0; m<i; m++) begin : req_en_gating_in_mapping__GEN
                    assign req_en_gating_in[i][m] = or_priority_result[m];
                end
                for(n=i; n<NUM_PRT_LVL-1; n++) begin : req_en_gating_in_fixed__GEN
                    assign req_en_gating_in[i][n] = 1'b0;
                end
            end
        end
    endgenerate

    generate
        if(DMA_CH == 1) begin : req_en_1CH__GEN
            assign req_en[0] = or_priority_result[0];
            assign req_en[15:1] = {(NUM_PRT_LVL-1){1'b0}};
        end else begin : req_en_nCH__GEN
            assign req_en[0] = or_priority_result[0];
            for(i=1; i<NUM_PRT_LVL; i++) begin : req_en_bit__GEN
                assign req_en[i] = ~(|(req_en_gating_in[i])) & or_priority_result[i];
            end
        end
    endgenerate

    //#--> Request mask
    generate
        for(i=0; i<DMA_CH; i++) begin : grant_mask_req__GEN
            for(j=0; j<NUM_PRT_LVL; j++) begin : grant_mask_req_bit__GEN
                assign grant_mask[(i*NUM_PRT_LVL)+j] = req_en[j] & req_with_priority_level[(i*NUM_PRT_LVL)+j];
            end        
        end
    endgenerate

    //#--> Grant set
    generate
        for(i=0; i<DMA_CH; i++) begin : set_grant__GEN
            assign set_grant[i] = |grant_mask[(i*NUM_PRT_LVL) +: NUM_PRT_LVL];
        end
    endgenerate

    //#--> Same priority filter
    generate
        if(DMA_CH == 1) begin : set_prt_grant_gating_in_1CH__GEN
            for(i=1; i<DMA_CH; i++) begin : set_prt_grant_gating_in__GEN
                assign set_prt_grant_gating_in[i] = {(DMA_CH-1){1'b0}};
            end
        end else begin : set_prt_grant_gating_in_nCH__GEN
            for(i=1; i<DMA_CH; i++) begin : set_prt_grant_gating_in__GEN
                for(m=0; m<i; m++) begin : set_prt_grant_gating_in_mapping__GEN
                    assign set_prt_grant_gating_in[i][m] = set_grant[m];
                end
                for(n=i; n<DMA_CH-1; n++) begin : set_prt_grant_gating_in_fixed__GEN
                    assign set_prt_grant_gating_in[i][n] = 1'b0;
                end
            end
        end
    endgenerate

    generate
        if(DMA_CH == 1) begin : set_prt_grant_1CH__GEN
            assign set_prt_grant[0] = set_grant[0];
            assign set_prt_grant[15:1] = {(NUM_PRT_LVL-1){1'b0}};
        end else begin :set_prt_grant_nCH__GEN
            assign set_prt_grant[0] = set_grant[0];
            for(i=1; i<DMA_CH; i++) begin : set_prt_grant_bit__GEN
                assign set_prt_grant[i] = ~(|set_prt_grant_gating_in[i]) & set_grant[i];
            end
        end
    endgenerate

    //#--> Grant
    generate
        for(i=0; i<DMA_CH; i++) begin : grant__GEN
            assign grant_and_req[i] = req_i[i] & grant_o[i];
            assign nxt_grant[i] = (no_grant) ? set_prt_grant[i] : grant_and_req[i];

            always @(posedge clk_i or negedge rstn_i) begin
                if(~rstn_i) begin
                    grant[i] <= 1'b0;
                end else begin
                    grant[i] <= nxt_grant[i];
                end
            end

        assign grant_o[i] = grant[i];
        end
    endgenerate

    assign no_grant = ~(|(grant));
endmodule
