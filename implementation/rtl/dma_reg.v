////////////////////////////////////////////////////////////////////////////////
// Filename    : dma_reg.v
// Description :
//
// Author      : Phu Vuong
// History     : 2023-06-26 : last update
//
////////////////////////////////////////////////////////////////////////////////
module dma_reg(
    //-----------------------
    //#--> regiter interface
    reg_addr_i,
    reg_wr_en_i,
    reg_wr_data_i,
    reg_rd_en_i,
    reg_rd_data_o,

    //-----------------------
    //#--> addr = 0x00
    CDMAControl_IRQDelay_o,
    CDMAControl_IRQThreshold_o,
    CDMAControl_Err_IrqEn_o,
    CDMAControl_Dly_IrqEn_o,
    CDMAControl_IOC_IrqEn_o,
    CDMAControl_Cyclic_BD_Enable_o,
    CDMAControl_Key_Hole_Write_o,
    CDMAControl_Key_Hole_Read_o,
    CDMAControl_SGMode_o,
    CDMAControl_Reset_o,

    //-----------------------
    //#--> addr = 0x04
    CDMAStatus_Err_Irq_o,
    CDMAStatus_Dly_Irq_o,
    CDMAStatus_IOC_Irq_o,

);
    ////////////////////////////////////////////////////////////////////////////
    //parameter declaration
    ////////////////////////////////////////////////////////////////////////////
    parameter ADDR_WIDTH = 8;
    parameter DATA_WIDTH = 32;

    ////////////////////////////////////////////////////////////////////////////
    //pin - port declaration
    ////////////////////////////////////////////////////////////////////////////
    //-----------------------
    //#--> regiter interface
    input	[ADDR_WIDTH-1:0]				reg_addr_i;
    input									reg_wr_en_i;
    input	[DATA_WIDTH-1:0]				reg_wr_data_i;
    input									reg_rd_en_i;
    output	[DATA_WIDTH-1:0]				reg_rd_data_o;
    //-----------------------;
    //#--> addr = 0x00;
    output	[31:24]							CDMAControl_IRQDelay_o;
    output	[23:16]							CDMAControl_IRQThreshold_o;
    output									CDMAControl_Err_IrqEn_o;
    output									CDMAControl_Dly_IrqEn_o;
    output									CDMAControl_IOC_IrqEn_o;
    output									CDMAControl_Cyclic_BD_Enable_o;
    output									CDMAControl_Key_Hole_Write_o;
    output									CDMAControl_Key_Hole_Read_o;
    output									CDMAControl_SGMode_o;
    output									CDMAControl_Reset_o;

    //-----------------------;
    //#--> addr = 0x04;
    output									CDMAStatus_Err_Irq_o;
    output									CDMAStatus_Dly_Irq_o;
    output									CDMAStatus_IOC_Irq_o;

    ////////////////////////////////////////////////////////////////////////////
    //wire - reg name declaration
    ////////////////////////////////////////////////////////////////////////////
    //#--> addr = 0x00;
    wire									CDMAControl_sel;
    wire									CDMAControl_rd_en;
    wire									CDMAControl_wr_en;
    wire	[31:24]							nxt_CDMAControl_IRQDelay;
    wire	[23:16]							nxt_CDMAControl_IRQThreshold;
    wire									nxt_CDMAControl_Err_IrqEn;
    wire									nxt_CDMAControl_Dly_IrqEn;
    wire									nxt_CDMAControl_IOC_IrqEn;
    wire									nxt_CDMAControl_Cyclic_BD_Enable;
    wire									nxt_CDMAControl_Key_Hole_Write;
    wire									nxt_CDMAControl_Key_Hole_Read;
    wire									nxt_CDMAControl_SGMode;
    wire									nxt_CDMAControl_Reset;
    reg		[31:24]							CDMAControl_IRQDelay;
    reg		[23:16]							CDMAControl_IRQThreshold;
    reg										CDMAControl_Err_IrqEn;
    reg										CDMAControl_Dly_IrqEn;
    reg										CDMAControl_IOC_IrqEn;
    reg										CDMAControl_Cyclic_BD_Enable;
    reg										CDMAControl_Key_Hole_Write;
    reg										CDMAControl_Key_Hole_Read;
    reg										CDMAControl_SGMode;
    reg										CDMAControl_Reset;

    //#--> addr = 0x04;
    wire									CDMAStatus_sel;
    wire									CDMAStatus_rd_en;
    wire									CDMAStatus_wr_en;
    wire									nxt_CDMAStatus_Err_Irq;
    wire									nxt_CDMAStatus_Dly_Irq;
    wire									nxt_CDMAStatus_IOC_Irq;
    reg										CDMAStatus_Err_Irq;
    reg										CDMAStatus_Dly_Irq;
    reg										CDMAStatus_IOC_Irq;

    //#--> read path
    reg     [ADDR_WIDTH-1:0]                reg_rd_data;
    
    ////////////////////////////////////////////////////////////////////////////
    //design description
    ////////////////////////////////////////////////////////////////////////////
    //-----------------------
    //select path
    //address = 0x00
    //-----------------------
    assign CDMAControl_sel = (reg_addr_i[7:0] == 8'h00);
    assign CDMAControl_rd_en = CDMAControl_sel & reg_rd_en_i;
    assign CDMAControl_wr_en = CDMAControl_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x04
    //-----------------------
    assign CDMAStatus_sel = (reg_addr_i[7:0] == 8'h04);
    assign CDMAStatus_rd_en = CDMAStatus_sel & reg_rd_en_i;
    assign CDMAStatus_wr_en = CDMAStatus_sel & reg_wr_en_i;

    //-----------------------
    //write path
    //address = 0x00
    //-----------------------
    assign nxt_CDMAControl_IRQDelay = (CDMAControl_wr_en) ? reg_wr_data_i : CDMAControl_IRQDelay;
    assign nxt_CDMAControl_IRQThreshold = (CDMAControl_wr_en) ? reg_wr_data_i : CDMAControl_IRQThreshold;
    assign nxt_CDMAControl_Err_IrqEn = (CDMAControl_wr_en) ? reg_wr_data_i : CDMAControl_Err_IrqEn;
    assign nxt_CDMAControl_Dly_IrqEn = (CDMAControl_wr_en) ? reg_wr_data_i : CDMAControl_Dly_IrqEn;
    assign nxt_CDMAControl_IOC_IrqEn = (CDMAControl_wr_en) ? reg_wr_data_i : CDMAControl_IOC_IrqEn;
    assign nxt_CDMAControl_Cyclic_BD_Enable = (CDMAControl_wr_en) ? reg_wr_data_i : CDMAControl_Cyclic_BD_Enable;
    assign nxt_CDMAControl_Key_Hole_Write = (CDMAControl_wr_en) ? reg_wr_data_i : CDMAControl_Key_Hole_Write;
    assign nxt_CDMAControl_Key_Hole_Read = (CDMAControl_wr_en) ? reg_wr_data_i : CDMAControl_Key_Hole_Read;
    assign nxt_CDMAControl_SGMode = (CDMAControl_wr_en) ? reg_wr_data_i : CDMAControl_SGMode;
    assign nxt_CDMAControl_Reset = (CDMAControl_wr_en) ? reg_wr_data_i : CDMAControl_Reset;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            CDMAControl_IRQDelay <= 8'h00;
            CDMAControl_IRQThreshold <= 8'h01;
            CDMAControl_Err_IrqEn <= 1'h0;
            CDMAControl_Dly_IrqEn <= 1'h0;
            CDMAControl_IOC_IrqEn <= 1'h0;
            CDMAControl_Cyclic_BD_Enable <= 1'h0;
            CDMAControl_Key_Hole_Write <= 1'h0;
            CDMAControl_Key_Hole_Read <= 1'h0;
            CDMAControl_SGMode <= 1'h0;
            CDMAControl_Reset <= 1'h0;
        end else begin
            CDMAControl_IRQDelay <= nxt_CDMAControl_IRQDelay;
            CDMAControl_IRQThreshold <= nxt_CDMAControl_IRQThreshold;
            CDMAControl_Err_IrqEn <= nxt_CDMAControl_Err_IrqEn;
            CDMAControl_Dly_IrqEn <= nxt_CDMAControl_Dly_IrqEn;
            CDMAControl_IOC_IrqEn <= nxt_CDMAControl_IOC_IrqEn;
            CDMAControl_Cyclic_BD_Enable <= nxt_CDMAControl_Cyclic_BD_Enable;
            CDMAControl_Key_Hole_Write <= nxt_CDMAControl_Key_Hole_Write;
            CDMAControl_Key_Hole_Read <= nxt_CDMAControl_Key_Hole_Read;
            CDMAControl_SGMode <= nxt_CDMAControl_SGMode;
            CDMAControl_Reset <= nxt_CDMAControl_Reset;
        end
    end
    
    assign CDMAControl_IRQDelay_o = CDMAControl_IRQDelay;
    assign CDMAControl_IRQThreshold_o = CDMAControl_IRQThreshold;
    assign CDMAControl_Err_IrqEn_o = CDMAControl_Err_IrqEn;
    assign CDMAControl_Dly_IrqEn_o = CDMAControl_Dly_IrqEn;
    assign CDMAControl_IOC_IrqEn_o = CDMAControl_IOC_IrqEn;
    assign CDMAControl_Cyclic_BD_Enable_o = CDMAControl_Cyclic_BD_Enable;
    assign CDMAControl_Key_Hole_Write_o = CDMAControl_Key_Hole_Write;
    assign CDMAControl_Key_Hole_Read_o = CDMAControl_Key_Hole_Read;
    assign CDMAControl_SGMode_o = CDMAControl_SGMode;
    assign CDMAControl_Reset_o = CDMAControl_Reset;

    //-----------------------
    //write path
    //address = 0x04
    //-----------------------
    assign nxt_CDMAStatus_Err_Irq = (CDMAStatus_wr_en) ? reg_wr_data_i : CDMAStatus_Err_Irq;
    assign nxt_CDMAStatus_Dly_Irq = (CDMAStatus_wr_en) ? reg_wr_data_i : CDMAStatus_Dly_Irq;
    assign nxt_CDMAStatus_IOC_Irq = (CDMAStatus_wr_en) ? reg_wr_data_i : CDMAStatus_IOC_Irq;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            CDMAStatus_Err_Irq <= 1'h0;
            CDMAStatus_Dly_Irq <= 1'h0;
            CDMAStatus_IOC_Irq <= 1'h0;
        end else begin
            CDMAStatus_Err_Irq <= nxt_CDMAStatus_Err_Irq;
            CDMAStatus_Dly_Irq <= nxt_CDMAStatus_Dly_Irq;
            CDMAStatus_IOC_Irq <= nxt_CDMAStatus_IOC_Irq;
        end
    end
    
    assign CDMAStatus_Err_Irq_o = CDMAStatus_Err_Irq;
    assign CDMAStatus_Dly_Irq_o = CDMAStatus_Dly_Irq;
    assign CDMAStatus_IOC_Irq_o = CDMAStatus_IOC_Irq;

    //-----------------------
    //read path
    //-----------------------
    always @(*) begin
        case(reg_addr_i):
            8'h0x00: reg_rd_data = {CDMAControl_IRQDelay, CDMAControl_IRQThreshold, 1'h0, CDMAControl_Err_IrqEn, CDMAControl_Dly_IrqEn, CDMAControl_IOC_IrqEn, 5'h00, CDMAControl_Cyclic_BD_Enable, CDMAControl_Key_Hole_Write, CDMAControl_Key_Hole_Read, CDMAControl_SGMode, CDMAControl_Reset, 1'h1, 1'h0};
            8'h0x04: reg_rd_data = {8'h00, 8'h01, 1'h0, CDMAStatus_Err_Irq, CDMAStatus_Dly_Irq, CDMAStatus_IOC_Irq, 1'h0, 1'h0, 1'h0, 1'h0, 1'h0, 1'h0, 1'h0, 1'h0, 1'h0, 1'h0, 1'h0, 1'h0};
            default: 32'h0;
        endcase
    end
    
    assign reg_rd_data_o = reg_rd_data;
endmodule