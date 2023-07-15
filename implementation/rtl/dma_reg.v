////////////////////////////////////////////////////////////////////////////////
// Filename    : dma_reg.v
// Description :
//
// Author      : Phu Vuong
// History     : 2023-07-15 : last update
//
////////////////////////////////////////////////////////////////////////////////
module dma_reg(
    //-----------------------
    //#--> clk and rstn
    clk,
    rstn,
    //-----------------------
    //#--> regiter interface
    reg_addr_i,
    reg_wr_en_i,
    reg_wr_data_i,
    reg_rd_en_i,
    reg_rd_data_o,

    //-----------------------
    //#--> addr = 0x0000
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
    //#--> addr = 0x0004
    CDMAStatus_Err_Irq_o,
    CDMAStatus_Dly_Irq_o,
    CDMAStatus_IOC_Irq_o,

    //-----------------------
    //#--> addr = 0x0008
    CDMACurDescPntr_Cur_Desc_Pntr_o,

    //-----------------------
    //#--> addr = 0x000c
    CDMACurDescPntrMSB_Cur_Desc_Pntr_o,

    //-----------------------
    //#--> addr = 0x0010
    CDMATailDescPntr_Tail_Desc_Pntr_o,

    //-----------------------
    //#--> addr = 0x0014
    CDMATailDescPntrMSB_Tail_Desc_Pntr_o,

    //-----------------------
    //#--> addr = 0x0018
    CDMASA_Source_Address_o,

    //-----------------------
    //#--> addr = 0x001c
    CDMASAMSB_Source_Address_o,

    //-----------------------
    //#--> addr = 0x0020

    //-----------------------
    //#--> addr = 0x0024

    //-----------------------
    //#--> addr = 0x0028
    CDMABTT_Bytes_To_Transfer_o,

    //-----------------------
    //#--> addr = 0x002c

    //-----------------------
    //#--> addr = 0x0030
    MAINCFG_dma_en_o,
    MAINCFG_ch_int_en_o,

    //-----------------------
    //#--> addr = 0x0034

    //-----------------------
    //#--> addr = 0x0038

    //-----------------------
    //#--> addr = 0x003c

    //-----------------------
    //#--> addr = 0x0040
    CRCH0_sw_reset_o,
    CRCH0_ch_pri_o,
    CRCH0_mode_o,
    CRCH0_inc_des_o,
    CRCH0_inc_src_o,
    CRCH0_done_int_en_o,
    CRCH0_stop_err_int_en_o,
    CRCH0_wtt_err_int_en_o,
    CRCH0_ch_en_o,

    //-----------------------
    //#--> addr = 0x0044

    //-----------------------
    //#--> addr = 0x0048
    TSRCH0_size_o,

    //-----------------------
    //#--> addr = 0x004c

    //-----------------------
    //#--> addr = 0x0050
    SARCH0_sa_o,

    //-----------------------
    //#--> addr = 0x0054
    DARCH0_da_o,

    //-----------------------
    //#--> addr = 0x0060
    CRCH1_sw_reset_o,
    CRCH1_ch_pri_o,
    CRCH1_mode_o,
    CRCH1_inc_des_o,
    CRCH1_inc_src_o,
    CRCH1_done_int_en_o,
    CRCH1_stop_err_int_en_o,
    CRCH1_wtt_err_int_en_o,
    CRCH1_ch_en_o,

    //-----------------------
    //#--> addr = 0x0064

    //-----------------------
    //#--> addr = 0x0068
    TSRCH1_size_o,

    //-----------------------
    //#--> addr = 0x006c

    //-----------------------
    //#--> addr = 0x0070
    SARCH1_sa_o,

    //-----------------------
    //#--> addr = 0x0074
    DARCH1_da_o,

    //-----------------------
    //#--> addr = 0x0080
    CRCH2_sw_reset_o,
    CRCH2_ch_pri_o,
    CRCH2_mode_o,
    CRCH2_inc_des_o,
    CRCH2_inc_src_o,
    CRCH2_done_int_en_o,
    CRCH2_stop_err_int_en_o,
    CRCH2_wtt_err_int_en_o,
    CRCH2_ch_en_o,

    //-----------------------
    //#--> addr = 0x0084

    //-----------------------
    //#--> addr = 0x0088
    TSRCH2_size_o,

    //-----------------------
    //#--> addr = 0x008c

    //-----------------------
    //#--> addr = 0x0090
    SARCH2_sa_o,

    //-----------------------
    //#--> addr = 0x0094
    DARCH2_da_o,

    //-----------------------
    //#--> addr = 0x00a0
    CRCH3_sw_reset_o,
    CRCH3_ch_pri_o,
    CRCH3_mode_o,
    CRCH3_inc_des_o,
    CRCH3_inc_src_o,
    CRCH3_done_int_en_o,
    CRCH3_stop_err_int_en_o,
    CRCH3_wtt_err_int_en_o,
    CRCH3_ch_en_o,

    //-----------------------
    //#--> addr = 0x00a4

    //-----------------------
    //#--> addr = 0x00a8
    TSRCH3_size_o,

    //-----------------------
    //#--> addr = 0x00ac

    //-----------------------
    //#--> addr = 0x00b0
    SARCH3_sa_o,

    //-----------------------
    //#--> addr = 0x00b4
    DARCH3_da_o,

    //-----------------------
    //#--> addr = 0x00a0
    CRCH4_sw_reset_o,
    CRCH4_ch_pri_o,
    CRCH4_mode_o,
    CRCH4_inc_des_o,
    CRCH4_inc_src_o,
    CRCH4_done_int_en_o,
    CRCH4_stop_err_int_en_o,
    CRCH4_wtt_err_int_en_o,
    CRCH4_ch_en_o,

    //-----------------------
    //#--> addr = 0x00a4

    //-----------------------
    //#--> addr = 0x00a8
    TSRCH4_size_o,

    //-----------------------
    //#--> addr = 0x00ac

    //-----------------------
    //#--> addr = 0x00b0
    SARCH4_sa_o,

    //-----------------------
    //#--> addr = 0x00b4
    DARCH4_da_o,

    //-----------------------
    //#--> addr = 0x00c0
    CRCH5_sw_reset_o,
    CRCH5_ch_pri_o,
    CRCH5_mode_o,
    CRCH5_inc_des_o,
    CRCH5_inc_src_o,
    CRCH5_done_int_en_o,
    CRCH5_stop_err_int_en_o,
    CRCH5_wtt_err_int_en_o,
    CRCH5_ch_en_o,

    //-----------------------
    //#--> addr = 0x00c4

    //-----------------------
    //#--> addr = 0x00c8
    TSRCH5_size_o,

    //-----------------------
    //#--> addr = 0x00cc

    //-----------------------
    //#--> addr = 0x00d0
    SARCH5_sa_o,

    //-----------------------
    //#--> addr = 0x00d4
    DARCH5_da_o,

    //-----------------------
    //#--> addr = 0x00e0
    CRCH6_sw_reset_o,
    CRCH6_ch_pri_o,
    CRCH6_mode_o,
    CRCH6_inc_des_o,
    CRCH6_inc_src_o,
    CRCH6_done_int_en_o,
    CRCH6_stop_err_int_en_o,
    CRCH6_wtt_err_int_en_o,
    CRCH6_ch_en_o,

    //-----------------------
    //#--> addr = 0x00e4

    //-----------------------
    //#--> addr = 0x00e8
    TSRCH6_size_o,

    //-----------------------
    //#--> addr = 0x00ec

    //-----------------------
    //#--> addr = 0x00f0
    SARCH6_sa_o,

    //-----------------------
    //#--> addr = 0x00f4
    DARCH6_da_o,

    //-----------------------
    //#--> addr = 0x0100
    CRCH7_sw_reset_o,
    CRCH7_ch_pri_o,
    CRCH7_mode_o,
    CRCH7_inc_des_o,
    CRCH7_inc_src_o,
    CRCH7_done_int_en_o,
    CRCH7_stop_err_int_en_o,
    CRCH7_wtt_err_int_en_o,
    CRCH7_ch_en_o,

    //-----------------------
    //#--> addr = 0x0104

    //-----------------------
    //#--> addr = 0x0108
    TSRCH7_size_o,

    //-----------------------
    //#--> addr = 0x010c

    //-----------------------
    //#--> addr = 0x0110
    SARCH7_sa_o,

    //-----------------------
    //#--> addr = 0x0114
    DARCH7_da_o
);
    ////////////////////////////////////////////////////////////////////////////
    //parameter declaration
    ////////////////////////////////////////////////////////////////////////////
    parameter ADDR_WIDTH = 16;
    parameter DATA_WIDTH = 32;

    ////////////////////////////////////////////////////////////////////////////
    //pin - port declaration
    ////////////////////////////////////////////////////////////////////////////
    //-----------------------
    //#--> clk and rstn
    input									clk;
    input									rstn;
    //-----------------------
    //#--> regiter interface
    input	[ADDR_WIDTH-1:0]				reg_addr_i;
    input									reg_wr_en_i;
    input	[DATA_WIDTH-1:0]				reg_wr_data_i;
    input									reg_rd_en_i;
    output	[DATA_WIDTH-1:0]				reg_rd_data_o;
    //-----------------------;
    //#--> addr = 0x0000;
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
    //#--> addr = 0x0004;
    output									CDMAStatus_Err_Irq_o;
    output									CDMAStatus_Dly_Irq_o;
    output									CDMAStatus_IOC_Irq_o;

    //-----------------------;
    //#--> addr = 0x0008;
    output	[31:6]							CDMACurDescPntr_Cur_Desc_Pntr_o;

    //-----------------------;
    //#--> addr = 0x000c;
    output									CDMACurDescPntrMSB_Cur_Desc_Pntr_o;

    //-----------------------;
    //#--> addr = 0x0010;
    output	[31:6]							CDMATailDescPntr_Tail_Desc_Pntr_o;

    //-----------------------;
    //#--> addr = 0x0014;
    output	[31:0]							CDMATailDescPntrMSB_Tail_Desc_Pntr_o;

    //-----------------------;
    //#--> addr = 0x0018;
    output	[31:0]							CDMASA_Source_Address_o;

    //-----------------------;
    //#--> addr = 0x001c;
    output	[31:0]							CDMASAMSB_Source_Address_o;

    //-----------------------;
    //#--> addr = 0x0020;

    //-----------------------;
    //#--> addr = 0x0024;

    //-----------------------;
    //#--> addr = 0x0028;
    output	[25:0]							CDMABTT_Bytes_To_Transfer_o;

    //-----------------------;
    //#--> addr = 0x002c;

    //-----------------------;
    //#--> addr = 0x0030;
    output									MAINCFG_dma_en_o;
    output	[7:0]							MAINCFG_ch_int_en_o;

    //-----------------------;
    //#--> addr = 0x0034;

    //-----------------------;
    //#--> addr = 0x0038;

    //-----------------------;
    //#--> addr = 0x003c;

    //-----------------------;
    //#--> addr = 0x0040;
    output									CRCH0_sw_reset_o;
    output	[9:8]							CRCH0_ch_pri_o;
    output	[7:6]							CRCH0_mode_o;
    output									CRCH0_inc_des_o;
    output									CRCH0_inc_src_o;
    output									CRCH0_done_int_en_o;
    output									CRCH0_stop_err_int_en_o;
    output									CRCH0_wtt_err_int_en_o;
    output									CRCH0_ch_en_o;

    //-----------------------;
    //#--> addr = 0x0044;

    //-----------------------;
    //#--> addr = 0x0048;
    output	[7:0]							TSRCH0_size_o;

    //-----------------------;
    //#--> addr = 0x004c;

    //-----------------------;
    //#--> addr = 0x0050;
    output	[31:0]							SARCH0_sa_o;

    //-----------------------;
    //#--> addr = 0x0054;
    output	[31:0]							DARCH0_da_o;

    //-----------------------;
    //#--> addr = 0x0060;
    output									CRCH1_sw_reset_o;
    output	[9:8]							CRCH1_ch_pri_o;
    output	[7:6]							CRCH1_mode_o;
    output									CRCH1_inc_des_o;
    output									CRCH1_inc_src_o;
    output									CRCH1_done_int_en_o;
    output									CRCH1_stop_err_int_en_o;
    output									CRCH1_wtt_err_int_en_o;
    output									CRCH1_ch_en_o;

    //-----------------------;
    //#--> addr = 0x0064;

    //-----------------------;
    //#--> addr = 0x0068;
    output	[7:0]							TSRCH1_size_o;

    //-----------------------;
    //#--> addr = 0x006c;

    //-----------------------;
    //#--> addr = 0x0070;
    output	[31:0]							SARCH1_sa_o;

    //-----------------------;
    //#--> addr = 0x0074;
    output	[31:0]							DARCH1_da_o;

    //-----------------------;
    //#--> addr = 0x0080;
    output									CRCH2_sw_reset_o;
    output	[9:8]							CRCH2_ch_pri_o;
    output	[7:6]							CRCH2_mode_o;
    output									CRCH2_inc_des_o;
    output									CRCH2_inc_src_o;
    output									CRCH2_done_int_en_o;
    output									CRCH2_stop_err_int_en_o;
    output									CRCH2_wtt_err_int_en_o;
    output									CRCH2_ch_en_o;

    //-----------------------;
    //#--> addr = 0x0084;

    //-----------------------;
    //#--> addr = 0x0088;
    output	[7:0]							TSRCH2_size_o;

    //-----------------------;
    //#--> addr = 0x008c;

    //-----------------------;
    //#--> addr = 0x0090;
    output	[31:0]							SARCH2_sa_o;

    //-----------------------;
    //#--> addr = 0x0094;
    output	[31:0]							DARCH2_da_o;

    //-----------------------;
    //#--> addr = 0x00a0;
    output									CRCH3_sw_reset_o;
    output	[9:8]							CRCH3_ch_pri_o;
    output	[7:6]							CRCH3_mode_o;
    output									CRCH3_inc_des_o;
    output									CRCH3_inc_src_o;
    output									CRCH3_done_int_en_o;
    output									CRCH3_stop_err_int_en_o;
    output									CRCH3_wtt_err_int_en_o;
    output									CRCH3_ch_en_o;

    //-----------------------;
    //#--> addr = 0x00a4;

    //-----------------------;
    //#--> addr = 0x00a8;
    output	[7:0]							TSRCH3_size_o;

    //-----------------------;
    //#--> addr = 0x00ac;

    //-----------------------;
    //#--> addr = 0x00b0;
    output	[31:0]							SARCH3_sa_o;

    //-----------------------;
    //#--> addr = 0x00b4;
    output	[31:0]							DARCH3_da_o;

    //-----------------------;
    //#--> addr = 0x00a0;
    output									CRCH4_sw_reset_o;
    output	[9:8]							CRCH4_ch_pri_o;
    output	[7:6]							CRCH4_mode_o;
    output									CRCH4_inc_des_o;
    output									CRCH4_inc_src_o;
    output									CRCH4_done_int_en_o;
    output									CRCH4_stop_err_int_en_o;
    output									CRCH4_wtt_err_int_en_o;
    output									CRCH4_ch_en_o;

    //-----------------------;
    //#--> addr = 0x00a4;

    //-----------------------;
    //#--> addr = 0x00a8;
    output	[7:0]							TSRCH4_size_o;

    //-----------------------;
    //#--> addr = 0x00ac;

    //-----------------------;
    //#--> addr = 0x00b0;
    output	[31:0]							SARCH4_sa_o;

    //-----------------------;
    //#--> addr = 0x00b4;
    output	[31:0]							DARCH4_da_o;

    //-----------------------;
    //#--> addr = 0x00c0;
    output									CRCH5_sw_reset_o;
    output	[9:8]							CRCH5_ch_pri_o;
    output	[7:6]							CRCH5_mode_o;
    output									CRCH5_inc_des_o;
    output									CRCH5_inc_src_o;
    output									CRCH5_done_int_en_o;
    output									CRCH5_stop_err_int_en_o;
    output									CRCH5_wtt_err_int_en_o;
    output									CRCH5_ch_en_o;

    //-----------------------;
    //#--> addr = 0x00c4;

    //-----------------------;
    //#--> addr = 0x00c8;
    output	[7:0]							TSRCH5_size_o;

    //-----------------------;
    //#--> addr = 0x00cc;

    //-----------------------;
    //#--> addr = 0x00d0;
    output	[31:0]							SARCH5_sa_o;

    //-----------------------;
    //#--> addr = 0x00d4;
    output	[31:0]							DARCH5_da_o;

    //-----------------------;
    //#--> addr = 0x00e0;
    output									CRCH6_sw_reset_o;
    output	[9:8]							CRCH6_ch_pri_o;
    output	[7:6]							CRCH6_mode_o;
    output									CRCH6_inc_des_o;
    output									CRCH6_inc_src_o;
    output									CRCH6_done_int_en_o;
    output									CRCH6_stop_err_int_en_o;
    output									CRCH6_wtt_err_int_en_o;
    output									CRCH6_ch_en_o;

    //-----------------------;
    //#--> addr = 0x00e4;

    //-----------------------;
    //#--> addr = 0x00e8;
    output	[7:0]							TSRCH6_size_o;

    //-----------------------;
    //#--> addr = 0x00ec;

    //-----------------------;
    //#--> addr = 0x00f0;
    output	[31:0]							SARCH6_sa_o;

    //-----------------------;
    //#--> addr = 0x00f4;
    output	[31:0]							DARCH6_da_o;

    //-----------------------;
    //#--> addr = 0x0100;
    output									CRCH7_sw_reset_o;
    output	[9:8]							CRCH7_ch_pri_o;
    output	[7:6]							CRCH7_mode_o;
    output									CRCH7_inc_des_o;
    output									CRCH7_inc_src_o;
    output									CRCH7_done_int_en_o;
    output									CRCH7_stop_err_int_en_o;
    output									CRCH7_wtt_err_int_en_o;
    output									CRCH7_ch_en_o;

    //-----------------------;
    //#--> addr = 0x0104;

    //-----------------------;
    //#--> addr = 0x0108;
    output	[7:0]							TSRCH7_size_o;

    //-----------------------;
    //#--> addr = 0x010c;

    //-----------------------;
    //#--> addr = 0x0110;
    output	[31:0]							SARCH7_sa_o;

    //-----------------------;
    //#--> addr = 0x0114;
    output	[31:0]							DARCH7_da_o;

    ////////////////////////////////////////////////////////////////////////////
    //wire - reg name declaration
    ////////////////////////////////////////////////////////////////////////////
    //#--> addr = 0x0000;
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

    //#--> addr = 0x0004;
    wire									CDMAStatus_sel;
    wire									CDMAStatus_rd_en;
    wire									CDMAStatus_wr_en;
    wire									nxt_CDMAStatus_Err_Irq;
    wire									nxt_CDMAStatus_Dly_Irq;
    wire									nxt_CDMAStatus_IOC_Irq;
    reg										CDMAStatus_Err_Irq;
    reg										CDMAStatus_Dly_Irq;
    reg										CDMAStatus_IOC_Irq;

    //#--> addr = 0x0008;
    wire									CDMACurDescPntr_sel;
    wire									CDMACurDescPntr_rd_en;
    wire									CDMACurDescPntr_wr_en;
    wire	[31:6]							nxt_CDMACurDescPntr_Cur_Desc_Pntr;
    reg		[31:6]							CDMACurDescPntr_Cur_Desc_Pntr;

    //#--> addr = 0x000c;
    wire									CDMACurDescPntrMSB_sel;
    wire									CDMACurDescPntrMSB_rd_en;
    wire									CDMACurDescPntrMSB_wr_en;
    wire									nxt_CDMACurDescPntrMSB_Cur_Desc_Pntr;
    reg										CDMACurDescPntrMSB_Cur_Desc_Pntr;

    //#--> addr = 0x0010;
    wire									CDMATailDescPntr_sel;
    wire									CDMATailDescPntr_rd_en;
    wire									CDMATailDescPntr_wr_en;
    wire	[31:6]							nxt_CDMATailDescPntr_Tail_Desc_Pntr;
    reg		[31:6]							CDMATailDescPntr_Tail_Desc_Pntr;

    //#--> addr = 0x0014;
    wire									CDMATailDescPntrMSB_sel;
    wire									CDMATailDescPntrMSB_rd_en;
    wire									CDMATailDescPntrMSB_wr_en;
    wire	[31:0]							nxt_CDMATailDescPntrMSB_Tail_Desc_Pntr;
    reg		[31:0]							CDMATailDescPntrMSB_Tail_Desc_Pntr;

    //#--> addr = 0x0018;
    wire									CDMASA_sel;
    wire									CDMASA_rd_en;
    wire									CDMASA_wr_en;
    wire	[31:0]							nxt_CDMASA_Source_Address;
    reg		[31:0]							CDMASA_Source_Address;

    //#--> addr = 0x001c;
    wire									CDMASAMSB_sel;
    wire									CDMASAMSB_rd_en;
    wire									CDMASAMSB_wr_en;
    wire	[31:0]							nxt_CDMASAMSB_Source_Address;
    reg		[31:0]							CDMASAMSB_Source_Address;

    //#--> addr = 0x0020;
    wire									CDMADA_sel;
    wire									CDMADA_rd_en;

    //#--> addr = 0x0024;
    wire									CDMADAMSB_sel;
    wire									CDMADAMSB_rd_en;

    //#--> addr = 0x0028;
    wire									CDMABTT_sel;
    wire									CDMABTT_rd_en;
    wire									CDMABTT_wr_en;
    wire	[25:0]							nxt_CDMABTT_Bytes_To_Transfer;
    reg		[25:0]							CDMABTT_Bytes_To_Transfer;

    //#--> addr = 0x002c;
    wire									CDMARSV_sel;
    wire									CDMARSV_rd_en;

    //#--> addr = 0x0030;
    wire									MAINCFG_sel;
    wire									MAINCFG_rd_en;
    wire									MAINCFG_wr_en;
    wire									nxt_MAINCFG_dma_en;
    wire	[7:0]							nxt_MAINCFG_ch_int_en;
    reg										MAINCFG_dma_en;
    reg		[7:0]							MAINCFG_ch_int_en;

    //#--> addr = 0x0034;
    wire									MAINDMASTT_sel;
    wire									MAINDMASTT_rd_en;

    //#--> addr = 0x0038;
    wire									MAINRSV0_sel;
    wire									MAINRSV0_rd_en;

    //#--> addr = 0x003c;
    wire									MAINRSV1_sel;
    wire									MAINRSV1_rd_en;

    //#--> addr = 0x0040;
    wire									CRCH0_sel;
    wire									CRCH0_rd_en;
    wire									CRCH0_wr_en;
    wire									nxt_CRCH0_sw_reset;
    wire	[9:8]							nxt_CRCH0_ch_pri;
    wire	[7:6]							nxt_CRCH0_mode;
    wire									nxt_CRCH0_inc_des;
    wire									nxt_CRCH0_inc_src;
    wire									nxt_CRCH0_done_int_en;
    wire									nxt_CRCH0_stop_err_int_en;
    wire									nxt_CRCH0_wtt_err_int_en;
    wire									nxt_CRCH0_ch_en;
    reg										CRCH0_sw_reset;
    reg		[9:8]							CRCH0_ch_pri;
    reg		[7:6]							CRCH0_mode;
    reg										CRCH0_inc_des;
    reg										CRCH0_inc_src;
    reg										CRCH0_done_int_en;
    reg										CRCH0_stop_err_int_en;
    reg										CRCH0_wtt_err_int_en;
    reg										CRCH0_ch_en;

    //#--> addr = 0x0044;
    wire									SRCH0_sel;
    wire									SRCH0_rd_en;

    //#--> addr = 0x0048;
    wire									TSRCH0_sel;
    wire									TSRCH0_rd_en;
    wire									TSRCH0_wr_en;
    wire	[7:0]							nxt_TSRCH0_size;
    reg		[7:0]							TSRCH0_size;

    //#--> addr = 0x004c;
    wire									CDPRCH0_sel;
    wire									CDPRCH0_rd_en;

    //#--> addr = 0x0050;
    wire									SARCH0_sel;
    wire									SARCH0_rd_en;
    wire									SARCH0_wr_en;
    wire	[31:0]							nxt_SARCH0_sa;
    reg		[31:0]							SARCH0_sa;

    //#--> addr = 0x0054;
    wire									DARCH0_sel;
    wire									DARCH0_rd_en;
    wire									DARCH0_wr_en;
    wire	[31:0]							nxt_DARCH0_da;
    reg		[31:0]							DARCH0_da;

    //#--> addr = 0x0060;
    wire									CRCH1_sel;
    wire									CRCH1_rd_en;
    wire									CRCH1_wr_en;
    wire									nxt_CRCH1_sw_reset;
    wire	[9:8]							nxt_CRCH1_ch_pri;
    wire	[7:6]							nxt_CRCH1_mode;
    wire									nxt_CRCH1_inc_des;
    wire									nxt_CRCH1_inc_src;
    wire									nxt_CRCH1_done_int_en;
    wire									nxt_CRCH1_stop_err_int_en;
    wire									nxt_CRCH1_wtt_err_int_en;
    wire									nxt_CRCH1_ch_en;
    reg										CRCH1_sw_reset;
    reg		[9:8]							CRCH1_ch_pri;
    reg		[7:6]							CRCH1_mode;
    reg										CRCH1_inc_des;
    reg										CRCH1_inc_src;
    reg										CRCH1_done_int_en;
    reg										CRCH1_stop_err_int_en;
    reg										CRCH1_wtt_err_int_en;
    reg										CRCH1_ch_en;

    //#--> addr = 0x0064;
    wire									SRCH1_sel;
    wire									SRCH1_rd_en;

    //#--> addr = 0x0068;
    wire									TSRCH1_sel;
    wire									TSRCH1_rd_en;
    wire									TSRCH1_wr_en;
    wire	[7:0]							nxt_TSRCH1_size;
    reg		[7:0]							TSRCH1_size;

    //#--> addr = 0x006c;
    wire									CDPRCH1_sel;
    wire									CDPRCH1_rd_en;

    //#--> addr = 0x0070;
    wire									SARCH1_sel;
    wire									SARCH1_rd_en;
    wire									SARCH1_wr_en;
    wire	[31:0]							nxt_SARCH1_sa;
    reg		[31:0]							SARCH1_sa;

    //#--> addr = 0x0074;
    wire									DARCH1_sel;
    wire									DARCH1_rd_en;
    wire									DARCH1_wr_en;
    wire	[31:0]							nxt_DARCH1_da;
    reg		[31:0]							DARCH1_da;

    //#--> addr = 0x0080;
    wire									CRCH2_sel;
    wire									CRCH2_rd_en;
    wire									CRCH2_wr_en;
    wire									nxt_CRCH2_sw_reset;
    wire	[9:8]							nxt_CRCH2_ch_pri;
    wire	[7:6]							nxt_CRCH2_mode;
    wire									nxt_CRCH2_inc_des;
    wire									nxt_CRCH2_inc_src;
    wire									nxt_CRCH2_done_int_en;
    wire									nxt_CRCH2_stop_err_int_en;
    wire									nxt_CRCH2_wtt_err_int_en;
    wire									nxt_CRCH2_ch_en;
    reg										CRCH2_sw_reset;
    reg		[9:8]							CRCH2_ch_pri;
    reg		[7:6]							CRCH2_mode;
    reg										CRCH2_inc_des;
    reg										CRCH2_inc_src;
    reg										CRCH2_done_int_en;
    reg										CRCH2_stop_err_int_en;
    reg										CRCH2_wtt_err_int_en;
    reg										CRCH2_ch_en;

    //#--> addr = 0x0084;
    wire									SRCH2_sel;
    wire									SRCH2_rd_en;

    //#--> addr = 0x0088;
    wire									TSRCH2_sel;
    wire									TSRCH2_rd_en;
    wire									TSRCH2_wr_en;
    wire	[7:0]							nxt_TSRCH2_size;
    reg		[7:0]							TSRCH2_size;

    //#--> addr = 0x008c;
    wire									CDPRCH2_sel;
    wire									CDPRCH2_rd_en;

    //#--> addr = 0x0090;
    wire									SARCH2_sel;
    wire									SARCH2_rd_en;
    wire									SARCH2_wr_en;
    wire	[31:0]							nxt_SARCH2_sa;
    reg		[31:0]							SARCH2_sa;

    //#--> addr = 0x0094;
    wire									DARCH2_sel;
    wire									DARCH2_rd_en;
    wire									DARCH2_wr_en;
    wire	[31:0]							nxt_DARCH2_da;
    reg		[31:0]							DARCH2_da;

    //#--> addr = 0x00a0;
    wire									CRCH3_sel;
    wire									CRCH3_rd_en;
    wire									CRCH3_wr_en;
    wire									nxt_CRCH3_sw_reset;
    wire	[9:8]							nxt_CRCH3_ch_pri;
    wire	[7:6]							nxt_CRCH3_mode;
    wire									nxt_CRCH3_inc_des;
    wire									nxt_CRCH3_inc_src;
    wire									nxt_CRCH3_done_int_en;
    wire									nxt_CRCH3_stop_err_int_en;
    wire									nxt_CRCH3_wtt_err_int_en;
    wire									nxt_CRCH3_ch_en;
    reg										CRCH3_sw_reset;
    reg		[9:8]							CRCH3_ch_pri;
    reg		[7:6]							CRCH3_mode;
    reg										CRCH3_inc_des;
    reg										CRCH3_inc_src;
    reg										CRCH3_done_int_en;
    reg										CRCH3_stop_err_int_en;
    reg										CRCH3_wtt_err_int_en;
    reg										CRCH3_ch_en;

    //#--> addr = 0x00a4;
    wire									SRCH3_sel;
    wire									SRCH3_rd_en;

    //#--> addr = 0x00a8;
    wire									TSRCH3_sel;
    wire									TSRCH3_rd_en;
    wire									TSRCH3_wr_en;
    wire	[7:0]							nxt_TSRCH3_size;
    reg		[7:0]							TSRCH3_size;

    //#--> addr = 0x00ac;
    wire									CDPRCH3_sel;
    wire									CDPRCH3_rd_en;

    //#--> addr = 0x00b0;
    wire									SARCH3_sel;
    wire									SARCH3_rd_en;
    wire									SARCH3_wr_en;
    wire	[31:0]							nxt_SARCH3_sa;
    reg		[31:0]							SARCH3_sa;

    //#--> addr = 0x00b4;
    wire									DARCH3_sel;
    wire									DARCH3_rd_en;
    wire									DARCH3_wr_en;
    wire	[31:0]							nxt_DARCH3_da;
    reg		[31:0]							DARCH3_da;

    //#--> addr = 0x00a0;
    wire									CRCH4_sel;
    wire									CRCH4_rd_en;
    wire									CRCH4_wr_en;
    wire									nxt_CRCH4_sw_reset;
    wire	[9:8]							nxt_CRCH4_ch_pri;
    wire	[7:6]							nxt_CRCH4_mode;
    wire									nxt_CRCH4_inc_des;
    wire									nxt_CRCH4_inc_src;
    wire									nxt_CRCH4_done_int_en;
    wire									nxt_CRCH4_stop_err_int_en;
    wire									nxt_CRCH4_wtt_err_int_en;
    wire									nxt_CRCH4_ch_en;
    reg										CRCH4_sw_reset;
    reg		[9:8]							CRCH4_ch_pri;
    reg		[7:6]							CRCH4_mode;
    reg										CRCH4_inc_des;
    reg										CRCH4_inc_src;
    reg										CRCH4_done_int_en;
    reg										CRCH4_stop_err_int_en;
    reg										CRCH4_wtt_err_int_en;
    reg										CRCH4_ch_en;

    //#--> addr = 0x00a4;
    wire									SRCH4_sel;
    wire									SRCH4_rd_en;

    //#--> addr = 0x00a8;
    wire									TSRCH4_sel;
    wire									TSRCH4_rd_en;
    wire									TSRCH4_wr_en;
    wire	[7:0]							nxt_TSRCH4_size;
    reg		[7:0]							TSRCH4_size;

    //#--> addr = 0x00ac;
    wire									CDPRCH4_sel;
    wire									CDPRCH4_rd_en;

    //#--> addr = 0x00b0;
    wire									SARCH4_sel;
    wire									SARCH4_rd_en;
    wire									SARCH4_wr_en;
    wire	[31:0]							nxt_SARCH4_sa;
    reg		[31:0]							SARCH4_sa;

    //#--> addr = 0x00b4;
    wire									DARCH4_sel;
    wire									DARCH4_rd_en;
    wire									DARCH4_wr_en;
    wire	[31:0]							nxt_DARCH4_da;
    reg		[31:0]							DARCH4_da;

    //#--> addr = 0x00c0;
    wire									CRCH5_sel;
    wire									CRCH5_rd_en;
    wire									CRCH5_wr_en;
    wire									nxt_CRCH5_sw_reset;
    wire	[9:8]							nxt_CRCH5_ch_pri;
    wire	[7:6]							nxt_CRCH5_mode;
    wire									nxt_CRCH5_inc_des;
    wire									nxt_CRCH5_inc_src;
    wire									nxt_CRCH5_done_int_en;
    wire									nxt_CRCH5_stop_err_int_en;
    wire									nxt_CRCH5_wtt_err_int_en;
    wire									nxt_CRCH5_ch_en;
    reg										CRCH5_sw_reset;
    reg		[9:8]							CRCH5_ch_pri;
    reg		[7:6]							CRCH5_mode;
    reg										CRCH5_inc_des;
    reg										CRCH5_inc_src;
    reg										CRCH5_done_int_en;
    reg										CRCH5_stop_err_int_en;
    reg										CRCH5_wtt_err_int_en;
    reg										CRCH5_ch_en;

    //#--> addr = 0x00c4;
    wire									SRCH5_sel;
    wire									SRCH5_rd_en;

    //#--> addr = 0x00c8;
    wire									TSRCH5_sel;
    wire									TSRCH5_rd_en;
    wire									TSRCH5_wr_en;
    wire	[7:0]							nxt_TSRCH5_size;
    reg		[7:0]							TSRCH5_size;

    //#--> addr = 0x00cc;
    wire									CDPRCH5_sel;
    wire									CDPRCH5_rd_en;

    //#--> addr = 0x00d0;
    wire									SARCH5_sel;
    wire									SARCH5_rd_en;
    wire									SARCH5_wr_en;
    wire	[31:0]							nxt_SARCH5_sa;
    reg		[31:0]							SARCH5_sa;

    //#--> addr = 0x00d4;
    wire									DARCH5_sel;
    wire									DARCH5_rd_en;
    wire									DARCH5_wr_en;
    wire	[31:0]							nxt_DARCH5_da;
    reg		[31:0]							DARCH5_da;

    //#--> addr = 0x00e0;
    wire									CRCH6_sel;
    wire									CRCH6_rd_en;
    wire									CRCH6_wr_en;
    wire									nxt_CRCH6_sw_reset;
    wire	[9:8]							nxt_CRCH6_ch_pri;
    wire	[7:6]							nxt_CRCH6_mode;
    wire									nxt_CRCH6_inc_des;
    wire									nxt_CRCH6_inc_src;
    wire									nxt_CRCH6_done_int_en;
    wire									nxt_CRCH6_stop_err_int_en;
    wire									nxt_CRCH6_wtt_err_int_en;
    wire									nxt_CRCH6_ch_en;
    reg										CRCH6_sw_reset;
    reg		[9:8]							CRCH6_ch_pri;
    reg		[7:6]							CRCH6_mode;
    reg										CRCH6_inc_des;
    reg										CRCH6_inc_src;
    reg										CRCH6_done_int_en;
    reg										CRCH6_stop_err_int_en;
    reg										CRCH6_wtt_err_int_en;
    reg										CRCH6_ch_en;

    //#--> addr = 0x00e4;
    wire									SRCH6_sel;
    wire									SRCH6_rd_en;

    //#--> addr = 0x00e8;
    wire									TSRCH6_sel;
    wire									TSRCH6_rd_en;
    wire									TSRCH6_wr_en;
    wire	[7:0]							nxt_TSRCH6_size;
    reg		[7:0]							TSRCH6_size;

    //#--> addr = 0x00ec;
    wire									CDPRCH6_sel;
    wire									CDPRCH6_rd_en;

    //#--> addr = 0x00f0;
    wire									SARCH6_sel;
    wire									SARCH6_rd_en;
    wire									SARCH6_wr_en;
    wire	[31:0]							nxt_SARCH6_sa;
    reg		[31:0]							SARCH6_sa;

    //#--> addr = 0x00f4;
    wire									DARCH6_sel;
    wire									DARCH6_rd_en;
    wire									DARCH6_wr_en;
    wire	[31:0]							nxt_DARCH6_da;
    reg		[31:0]							DARCH6_da;

    //#--> addr = 0x0100;
    wire									CRCH7_sel;
    wire									CRCH7_rd_en;
    wire									CRCH7_wr_en;
    wire									nxt_CRCH7_sw_reset;
    wire	[9:8]							nxt_CRCH7_ch_pri;
    wire	[7:6]							nxt_CRCH7_mode;
    wire									nxt_CRCH7_inc_des;
    wire									nxt_CRCH7_inc_src;
    wire									nxt_CRCH7_done_int_en;
    wire									nxt_CRCH7_stop_err_int_en;
    wire									nxt_CRCH7_wtt_err_int_en;
    wire									nxt_CRCH7_ch_en;
    reg										CRCH7_sw_reset;
    reg		[9:8]							CRCH7_ch_pri;
    reg		[7:6]							CRCH7_mode;
    reg										CRCH7_inc_des;
    reg										CRCH7_inc_src;
    reg										CRCH7_done_int_en;
    reg										CRCH7_stop_err_int_en;
    reg										CRCH7_wtt_err_int_en;
    reg										CRCH7_ch_en;

    //#--> addr = 0x0104;
    wire									SRCH7_sel;
    wire									SRCH7_rd_en;

    //#--> addr = 0x0108;
    wire									TSRCH7_sel;
    wire									TSRCH7_rd_en;
    wire									TSRCH7_wr_en;
    wire	[7:0]							nxt_TSRCH7_size;
    reg		[7:0]							TSRCH7_size;

    //#--> addr = 0x010c;
    wire									CDPRCH7_sel;
    wire									CDPRCH7_rd_en;

    //#--> addr = 0x0110;
    wire									SARCH7_sel;
    wire									SARCH7_rd_en;
    wire									SARCH7_wr_en;
    wire	[31:0]							nxt_SARCH7_sa;
    reg		[31:0]							SARCH7_sa;

    //#--> addr = 0x0114;
    wire									DARCH7_sel;
    wire									DARCH7_rd_en;
    wire									DARCH7_wr_en;
    wire	[31:0]							nxt_DARCH7_da;
    reg		[31:0]							DARCH7_da;

    //#--> read path
    reg     [DATA_WIDTH-1:0]                reg_rd_data;
    reg     [DATA_WIDTH-1:0]                nxt_reg_rd_data;
    
    ////////////////////////////////////////////////////////////////////////////
    //design description
    ////////////////////////////////////////////////////////////////////////////
    //-----------------------
    //select path
    //address = 0x0000
    //-----------------------
    assign CDMAControl_sel = (reg_addr_i[15:0] == 16'h0000);
    assign CDMAControl_rd_en = CDMAControl_sel & reg_rd_en_i;
    assign CDMAControl_wr_en = CDMAControl_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x0004
    //-----------------------
    assign CDMAStatus_sel = (reg_addr_i[15:0] == 16'h0004);
    assign CDMAStatus_rd_en = CDMAStatus_sel & reg_rd_en_i;
    assign CDMAStatus_wr_en = CDMAStatus_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x0008
    //-----------------------
    assign CDMACurDescPntr_sel = (reg_addr_i[15:0] == 16'h0008);
    assign CDMACurDescPntr_rd_en = CDMACurDescPntr_sel & reg_rd_en_i;
    assign CDMACurDescPntr_wr_en = CDMACurDescPntr_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x000c
    //-----------------------
    assign CDMACurDescPntrMSB_sel = (reg_addr_i[15:0] == 16'h000c);
    assign CDMACurDescPntrMSB_rd_en = CDMACurDescPntrMSB_sel & reg_rd_en_i;
    assign CDMACurDescPntrMSB_wr_en = CDMACurDescPntrMSB_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x0010
    //-----------------------
    assign CDMATailDescPntr_sel = (reg_addr_i[15:0] == 16'h0010);
    assign CDMATailDescPntr_rd_en = CDMATailDescPntr_sel & reg_rd_en_i;
    assign CDMATailDescPntr_wr_en = CDMATailDescPntr_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x0014
    //-----------------------
    assign CDMATailDescPntrMSB_sel = (reg_addr_i[15:0] == 16'h0014);
    assign CDMATailDescPntrMSB_rd_en = CDMATailDescPntrMSB_sel & reg_rd_en_i;
    assign CDMATailDescPntrMSB_wr_en = CDMATailDescPntrMSB_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x0018
    //-----------------------
    assign CDMASA_sel = (reg_addr_i[15:0] == 16'h0018);
    assign CDMASA_rd_en = CDMASA_sel & reg_rd_en_i;
    assign CDMASA_wr_en = CDMASA_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x001c
    //-----------------------
    assign CDMASAMSB_sel = (reg_addr_i[15:0] == 16'h001c);
    assign CDMASAMSB_rd_en = CDMASAMSB_sel & reg_rd_en_i;
    assign CDMASAMSB_wr_en = CDMASAMSB_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x0020
    //-----------------------
    assign CDMADA_sel = (reg_addr_i[15:0] == 16'h0020);
    assign CDMADA_rd_en = CDMADA_sel & reg_rd_en_i;

    //-----------------------
    //select path
    //address = 0x0024
    //-----------------------
    assign CDMADAMSB_sel = (reg_addr_i[15:0] == 16'h0024);
    assign CDMADAMSB_rd_en = CDMADAMSB_sel & reg_rd_en_i;

    //-----------------------
    //select path
    //address = 0x0028
    //-----------------------
    assign CDMABTT_sel = (reg_addr_i[15:0] == 16'h0028);
    assign CDMABTT_rd_en = CDMABTT_sel & reg_rd_en_i;
    assign CDMABTT_wr_en = CDMABTT_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x002c
    //-----------------------
    assign CDMARSV_sel = (reg_addr_i[15:0] == 16'h002c);
    assign CDMARSV_rd_en = CDMARSV_sel & reg_rd_en_i;

    //-----------------------
    //select path
    //address = 0x0030
    //-----------------------
    assign MAINCFG_sel = (reg_addr_i[15:0] == 16'h0030);
    assign MAINCFG_rd_en = MAINCFG_sel & reg_rd_en_i;
    assign MAINCFG_wr_en = MAINCFG_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x0034
    //-----------------------
    assign MAINDMASTT_sel = (reg_addr_i[15:0] == 16'h0034);
    assign MAINDMASTT_rd_en = MAINDMASTT_sel & reg_rd_en_i;

    //-----------------------
    //select path
    //address = 0x0038
    //-----------------------
    assign MAINRSV0_sel = (reg_addr_i[15:0] == 16'h0038);
    assign MAINRSV0_rd_en = MAINRSV0_sel & reg_rd_en_i;

    //-----------------------
    //select path
    //address = 0x003c
    //-----------------------
    assign MAINRSV1_sel = (reg_addr_i[15:0] == 16'h003c);
    assign MAINRSV1_rd_en = MAINRSV1_sel & reg_rd_en_i;

    //-----------------------
    //select path
    //address = 0x0040
    //-----------------------
    assign CRCH0_sel = (reg_addr_i[15:0] == 16'h0040);
    assign CRCH0_rd_en = CRCH0_sel & reg_rd_en_i;
    assign CRCH0_wr_en = CRCH0_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x0044
    //-----------------------
    assign SRCH0_sel = (reg_addr_i[15:0] == 16'h0044);
    assign SRCH0_rd_en = SRCH0_sel & reg_rd_en_i;

    //-----------------------
    //select path
    //address = 0x0048
    //-----------------------
    assign TSRCH0_sel = (reg_addr_i[15:0] == 16'h0048);
    assign TSRCH0_rd_en = TSRCH0_sel & reg_rd_en_i;
    assign TSRCH0_wr_en = TSRCH0_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x004c
    //-----------------------
    assign CDPRCH0_sel = (reg_addr_i[15:0] == 16'h004c);
    assign CDPRCH0_rd_en = CDPRCH0_sel & reg_rd_en_i;

    //-----------------------
    //select path
    //address = 0x0050
    //-----------------------
    assign SARCH0_sel = (reg_addr_i[15:0] == 16'h0050);
    assign SARCH0_rd_en = SARCH0_sel & reg_rd_en_i;
    assign SARCH0_wr_en = SARCH0_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x0054
    //-----------------------
    assign DARCH0_sel = (reg_addr_i[15:0] == 16'h0054);
    assign DARCH0_rd_en = DARCH0_sel & reg_rd_en_i;
    assign DARCH0_wr_en = DARCH0_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x0060
    //-----------------------
    assign CRCH1_sel = (reg_addr_i[15:0] == 16'h0060);
    assign CRCH1_rd_en = CRCH1_sel & reg_rd_en_i;
    assign CRCH1_wr_en = CRCH1_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x0064
    //-----------------------
    assign SRCH1_sel = (reg_addr_i[15:0] == 16'h0064);
    assign SRCH1_rd_en = SRCH1_sel & reg_rd_en_i;

    //-----------------------
    //select path
    //address = 0x0068
    //-----------------------
    assign TSRCH1_sel = (reg_addr_i[15:0] == 16'h0068);
    assign TSRCH1_rd_en = TSRCH1_sel & reg_rd_en_i;
    assign TSRCH1_wr_en = TSRCH1_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x006c
    //-----------------------
    assign CDPRCH1_sel = (reg_addr_i[15:0] == 16'h006c);
    assign CDPRCH1_rd_en = CDPRCH1_sel & reg_rd_en_i;

    //-----------------------
    //select path
    //address = 0x0070
    //-----------------------
    assign SARCH1_sel = (reg_addr_i[15:0] == 16'h0070);
    assign SARCH1_rd_en = SARCH1_sel & reg_rd_en_i;
    assign SARCH1_wr_en = SARCH1_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x0074
    //-----------------------
    assign DARCH1_sel = (reg_addr_i[15:0] == 16'h0074);
    assign DARCH1_rd_en = DARCH1_sel & reg_rd_en_i;
    assign DARCH1_wr_en = DARCH1_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x0080
    //-----------------------
    assign CRCH2_sel = (reg_addr_i[15:0] == 16'h0080);
    assign CRCH2_rd_en = CRCH2_sel & reg_rd_en_i;
    assign CRCH2_wr_en = CRCH2_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x0084
    //-----------------------
    assign SRCH2_sel = (reg_addr_i[15:0] == 16'h0084);
    assign SRCH2_rd_en = SRCH2_sel & reg_rd_en_i;

    //-----------------------
    //select path
    //address = 0x0088
    //-----------------------
    assign TSRCH2_sel = (reg_addr_i[15:0] == 16'h0088);
    assign TSRCH2_rd_en = TSRCH2_sel & reg_rd_en_i;
    assign TSRCH2_wr_en = TSRCH2_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x008c
    //-----------------------
    assign CDPRCH2_sel = (reg_addr_i[15:0] == 16'h008c);
    assign CDPRCH2_rd_en = CDPRCH2_sel & reg_rd_en_i;

    //-----------------------
    //select path
    //address = 0x0090
    //-----------------------
    assign SARCH2_sel = (reg_addr_i[15:0] == 16'h0090);
    assign SARCH2_rd_en = SARCH2_sel & reg_rd_en_i;
    assign SARCH2_wr_en = SARCH2_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x0094
    //-----------------------
    assign DARCH2_sel = (reg_addr_i[15:0] == 16'h0094);
    assign DARCH2_rd_en = DARCH2_sel & reg_rd_en_i;
    assign DARCH2_wr_en = DARCH2_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x00a0
    //-----------------------
    assign CRCH3_sel = (reg_addr_i[15:0] == 16'h00a0);
    assign CRCH3_rd_en = CRCH3_sel & reg_rd_en_i;
    assign CRCH3_wr_en = CRCH3_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x00a4
    //-----------------------
    assign SRCH3_sel = (reg_addr_i[15:0] == 16'h00a4);
    assign SRCH3_rd_en = SRCH3_sel & reg_rd_en_i;

    //-----------------------
    //select path
    //address = 0x00a8
    //-----------------------
    assign TSRCH3_sel = (reg_addr_i[15:0] == 16'h00a8);
    assign TSRCH3_rd_en = TSRCH3_sel & reg_rd_en_i;
    assign TSRCH3_wr_en = TSRCH3_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x00ac
    //-----------------------
    assign CDPRCH3_sel = (reg_addr_i[15:0] == 16'h00ac);
    assign CDPRCH3_rd_en = CDPRCH3_sel & reg_rd_en_i;

    //-----------------------
    //select path
    //address = 0x00b0
    //-----------------------
    assign SARCH3_sel = (reg_addr_i[15:0] == 16'h00b0);
    assign SARCH3_rd_en = SARCH3_sel & reg_rd_en_i;
    assign SARCH3_wr_en = SARCH3_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x00b4
    //-----------------------
    assign DARCH3_sel = (reg_addr_i[15:0] == 16'h00b4);
    assign DARCH3_rd_en = DARCH3_sel & reg_rd_en_i;
    assign DARCH3_wr_en = DARCH3_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x00a0
    //-----------------------
    assign CRCH4_sel = (reg_addr_i[15:0] == 16'h00a0);
    assign CRCH4_rd_en = CRCH4_sel & reg_rd_en_i;
    assign CRCH4_wr_en = CRCH4_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x00a4
    //-----------------------
    assign SRCH4_sel = (reg_addr_i[15:0] == 16'h00a4);
    assign SRCH4_rd_en = SRCH4_sel & reg_rd_en_i;

    //-----------------------
    //select path
    //address = 0x00a8
    //-----------------------
    assign TSRCH4_sel = (reg_addr_i[15:0] == 16'h00a8);
    assign TSRCH4_rd_en = TSRCH4_sel & reg_rd_en_i;
    assign TSRCH4_wr_en = TSRCH4_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x00ac
    //-----------------------
    assign CDPRCH4_sel = (reg_addr_i[15:0] == 16'h00ac);
    assign CDPRCH4_rd_en = CDPRCH4_sel & reg_rd_en_i;

    //-----------------------
    //select path
    //address = 0x00b0
    //-----------------------
    assign SARCH4_sel = (reg_addr_i[15:0] == 16'h00b0);
    assign SARCH4_rd_en = SARCH4_sel & reg_rd_en_i;
    assign SARCH4_wr_en = SARCH4_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x00b4
    //-----------------------
    assign DARCH4_sel = (reg_addr_i[15:0] == 16'h00b4);
    assign DARCH4_rd_en = DARCH4_sel & reg_rd_en_i;
    assign DARCH4_wr_en = DARCH4_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x00c0
    //-----------------------
    assign CRCH5_sel = (reg_addr_i[15:0] == 16'h00c0);
    assign CRCH5_rd_en = CRCH5_sel & reg_rd_en_i;
    assign CRCH5_wr_en = CRCH5_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x00c4
    //-----------------------
    assign SRCH5_sel = (reg_addr_i[15:0] == 16'h00c4);
    assign SRCH5_rd_en = SRCH5_sel & reg_rd_en_i;

    //-----------------------
    //select path
    //address = 0x00c8
    //-----------------------
    assign TSRCH5_sel = (reg_addr_i[15:0] == 16'h00c8);
    assign TSRCH5_rd_en = TSRCH5_sel & reg_rd_en_i;
    assign TSRCH5_wr_en = TSRCH5_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x00cc
    //-----------------------
    assign CDPRCH5_sel = (reg_addr_i[15:0] == 16'h00cc);
    assign CDPRCH5_rd_en = CDPRCH5_sel & reg_rd_en_i;

    //-----------------------
    //select path
    //address = 0x00d0
    //-----------------------
    assign SARCH5_sel = (reg_addr_i[15:0] == 16'h00d0);
    assign SARCH5_rd_en = SARCH5_sel & reg_rd_en_i;
    assign SARCH5_wr_en = SARCH5_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x00d4
    //-----------------------
    assign DARCH5_sel = (reg_addr_i[15:0] == 16'h00d4);
    assign DARCH5_rd_en = DARCH5_sel & reg_rd_en_i;
    assign DARCH5_wr_en = DARCH5_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x00e0
    //-----------------------
    assign CRCH6_sel = (reg_addr_i[15:0] == 16'h00e0);
    assign CRCH6_rd_en = CRCH6_sel & reg_rd_en_i;
    assign CRCH6_wr_en = CRCH6_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x00e4
    //-----------------------
    assign SRCH6_sel = (reg_addr_i[15:0] == 16'h00e4);
    assign SRCH6_rd_en = SRCH6_sel & reg_rd_en_i;

    //-----------------------
    //select path
    //address = 0x00e8
    //-----------------------
    assign TSRCH6_sel = (reg_addr_i[15:0] == 16'h00e8);
    assign TSRCH6_rd_en = TSRCH6_sel & reg_rd_en_i;
    assign TSRCH6_wr_en = TSRCH6_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x00ec
    //-----------------------
    assign CDPRCH6_sel = (reg_addr_i[15:0] == 16'h00ec);
    assign CDPRCH6_rd_en = CDPRCH6_sel & reg_rd_en_i;

    //-----------------------
    //select path
    //address = 0x00f0
    //-----------------------
    assign SARCH6_sel = (reg_addr_i[15:0] == 16'h00f0);
    assign SARCH6_rd_en = SARCH6_sel & reg_rd_en_i;
    assign SARCH6_wr_en = SARCH6_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x00f4
    //-----------------------
    assign DARCH6_sel = (reg_addr_i[15:0] == 16'h00f4);
    assign DARCH6_rd_en = DARCH6_sel & reg_rd_en_i;
    assign DARCH6_wr_en = DARCH6_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x0100
    //-----------------------
    assign CRCH7_sel = (reg_addr_i[15:0] == 16'h0100);
    assign CRCH7_rd_en = CRCH7_sel & reg_rd_en_i;
    assign CRCH7_wr_en = CRCH7_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x0104
    //-----------------------
    assign SRCH7_sel = (reg_addr_i[15:0] == 16'h0104);
    assign SRCH7_rd_en = SRCH7_sel & reg_rd_en_i;

    //-----------------------
    //select path
    //address = 0x0108
    //-----------------------
    assign TSRCH7_sel = (reg_addr_i[15:0] == 16'h0108);
    assign TSRCH7_rd_en = TSRCH7_sel & reg_rd_en_i;
    assign TSRCH7_wr_en = TSRCH7_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x010c
    //-----------------------
    assign CDPRCH7_sel = (reg_addr_i[15:0] == 16'h010c);
    assign CDPRCH7_rd_en = CDPRCH7_sel & reg_rd_en_i;

    //-----------------------
    //select path
    //address = 0x0110
    //-----------------------
    assign SARCH7_sel = (reg_addr_i[15:0] == 16'h0110);
    assign SARCH7_rd_en = SARCH7_sel & reg_rd_en_i;
    assign SARCH7_wr_en = SARCH7_sel & reg_wr_en_i;

    //-----------------------
    //select path
    //address = 0x0114
    //-----------------------
    assign DARCH7_sel = (reg_addr_i[15:0] == 16'h0114);
    assign DARCH7_rd_en = DARCH7_sel & reg_rd_en_i;
    assign DARCH7_wr_en = DARCH7_sel & reg_wr_en_i;

    //-----------------------
    //write path
    //address = 0x0000
    //-----------------------
    assign nxt_CDMAControl_IRQDelay = (CDMAControl_wr_en) ? reg_wr_data_i[31:24] : CDMAControl_IRQDelay;
    assign nxt_CDMAControl_IRQThreshold = (CDMAControl_wr_en) ? reg_wr_data_i[23:16] : CDMAControl_IRQThreshold;
    assign nxt_CDMAControl_Err_IrqEn = (CDMAControl_wr_en) ? reg_wr_data_i[14] : CDMAControl_Err_IrqEn;
    assign nxt_CDMAControl_Dly_IrqEn = (CDMAControl_wr_en) ? reg_wr_data_i[13] : CDMAControl_Dly_IrqEn;
    assign nxt_CDMAControl_IOC_IrqEn = (CDMAControl_wr_en) ? reg_wr_data_i[12] : CDMAControl_IOC_IrqEn;
    assign nxt_CDMAControl_Cyclic_BD_Enable = (CDMAControl_wr_en) ? reg_wr_data_i[6] : CDMAControl_Cyclic_BD_Enable;
    assign nxt_CDMAControl_Key_Hole_Write = (CDMAControl_wr_en) ? reg_wr_data_i[5] : CDMAControl_Key_Hole_Write;
    assign nxt_CDMAControl_Key_Hole_Read = (CDMAControl_wr_en) ? reg_wr_data_i[4] : CDMAControl_Key_Hole_Read;
    assign nxt_CDMAControl_SGMode = (CDMAControl_wr_en) ? reg_wr_data_i[3] : CDMAControl_SGMode;
    assign nxt_CDMAControl_Reset = (CDMAControl_wr_en) ? reg_wr_data_i[2] : CDMAControl_Reset;
    
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
    //address = 0x0004
    //-----------------------
    assign nxt_CDMAStatus_Err_Irq = (CDMAStatus_wr_en) ? reg_wr_data_i[14] : CDMAStatus_Err_Irq;
    assign nxt_CDMAStatus_Dly_Irq = (CDMAStatus_wr_en) ? reg_wr_data_i[13] : CDMAStatus_Dly_Irq;
    assign nxt_CDMAStatus_IOC_Irq = (CDMAStatus_wr_en) ? reg_wr_data_i[12] : CDMAStatus_IOC_Irq;
    
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
    //write path
    //address = 0x0008
    //-----------------------
    assign nxt_CDMACurDescPntr_Cur_Desc_Pntr = (CDMACurDescPntr_wr_en) ? reg_wr_data_i[31:6] : CDMACurDescPntr_Cur_Desc_Pntr;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            CDMACurDescPntr_Cur_Desc_Pntr <= 26'h0;
        end else begin
            CDMACurDescPntr_Cur_Desc_Pntr <= nxt_CDMACurDescPntr_Cur_Desc_Pntr;
        end
    end
    
    assign CDMACurDescPntr_Cur_Desc_Pntr_o = CDMACurDescPntr_Cur_Desc_Pntr;

    //-----------------------
    //write path
    //address = 0x000c
    //-----------------------
    assign nxt_CDMACurDescPntrMSB_Cur_Desc_Pntr = (CDMACurDescPntrMSB_wr_en) ? reg_wr_data_i[31:0] : CDMACurDescPntrMSB_Cur_Desc_Pntr;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            CDMACurDescPntrMSB_Cur_Desc_Pntr <= 32'h0;
        end else begin
            CDMACurDescPntrMSB_Cur_Desc_Pntr <= nxt_CDMACurDescPntrMSB_Cur_Desc_Pntr;
        end
    end
    
    assign CDMACurDescPntrMSB_Cur_Desc_Pntr_o = CDMACurDescPntrMSB_Cur_Desc_Pntr;

    //-----------------------
    //write path
    //address = 0x0010
    //-----------------------
    assign nxt_CDMATailDescPntr_Tail_Desc_Pntr = (CDMATailDescPntr_wr_en) ? reg_wr_data_i[31:6] : CDMATailDescPntr_Tail_Desc_Pntr;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            CDMATailDescPntr_Tail_Desc_Pntr <= 26'h0;
        end else begin
            CDMATailDescPntr_Tail_Desc_Pntr <= nxt_CDMATailDescPntr_Tail_Desc_Pntr;
        end
    end
    
    assign CDMATailDescPntr_Tail_Desc_Pntr_o = CDMATailDescPntr_Tail_Desc_Pntr;

    //-----------------------
    //write path
    //address = 0x0014
    //-----------------------
    assign nxt_CDMATailDescPntrMSB_Tail_Desc_Pntr = (CDMATailDescPntrMSB_wr_en) ? reg_wr_data_i[31:0] : CDMATailDescPntrMSB_Tail_Desc_Pntr;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            CDMATailDescPntrMSB_Tail_Desc_Pntr <= 32'h0;
        end else begin
            CDMATailDescPntrMSB_Tail_Desc_Pntr <= nxt_CDMATailDescPntrMSB_Tail_Desc_Pntr;
        end
    end
    
    assign CDMATailDescPntrMSB_Tail_Desc_Pntr_o = CDMATailDescPntrMSB_Tail_Desc_Pntr;

    //-----------------------
    //write path
    //address = 0x0018
    //-----------------------
    assign nxt_CDMASA_Source_Address = (CDMASA_wr_en) ? reg_wr_data_i[31:0] : CDMASA_Source_Address;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            CDMASA_Source_Address <= 32'h0;
        end else begin
            CDMASA_Source_Address <= nxt_CDMASA_Source_Address;
        end
    end
    
    assign CDMASA_Source_Address_o = CDMASA_Source_Address;

    //-----------------------
    //write path
    //address = 0x001c
    //-----------------------
    assign nxt_CDMASAMSB_Source_Address = (CDMASAMSB_wr_en) ? reg_wr_data_i[31:0] : CDMASAMSB_Source_Address;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            CDMASAMSB_Source_Address <= 32'h0;
        end else begin
            CDMASAMSB_Source_Address <= nxt_CDMASAMSB_Source_Address;
        end
    end
    
    assign CDMASAMSB_Source_Address_o = CDMASAMSB_Source_Address;

    //-----------------------
    //write path
    //address = 0x0028
    //-----------------------
    assign nxt_CDMABTT_Bytes_To_Transfer = (CDMABTT_wr_en) ? reg_wr_data_i[25:0] : CDMABTT_Bytes_To_Transfer;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            CDMABTT_Bytes_To_Transfer <= 26'h0;
        end else begin
            CDMABTT_Bytes_To_Transfer <= nxt_CDMABTT_Bytes_To_Transfer;
        end
    end
    
    assign CDMABTT_Bytes_To_Transfer_o = CDMABTT_Bytes_To_Transfer;

    //-----------------------
    //write path
    //address = 0x0030
    //-----------------------
    assign nxt_MAINCFG_dma_en = (MAINCFG_wr_en) ? reg_wr_data_i[8] : MAINCFG_dma_en;
    assign nxt_MAINCFG_ch_int_en = (MAINCFG_wr_en) ? reg_wr_data_i[7:0] : MAINCFG_ch_int_en;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            MAINCFG_dma_en <= 1'h0;
            MAINCFG_ch_int_en <= 8'h0;
        end else begin
            MAINCFG_dma_en <= nxt_MAINCFG_dma_en;
            MAINCFG_ch_int_en <= nxt_MAINCFG_ch_int_en;
        end
    end
    
    assign MAINCFG_dma_en_o = MAINCFG_dma_en;
    assign MAINCFG_ch_int_en_o = MAINCFG_ch_int_en;

    //-----------------------
    //write path
    //address = 0x0040
    //-----------------------
    assign nxt_CRCH0_sw_reset = (CRCH0_wr_en) ? reg_wr_data_i[10] : CRCH0_sw_reset;
    assign nxt_CRCH0_ch_pri = (CRCH0_wr_en) ? reg_wr_data_i[9:8] : CRCH0_ch_pri;
    assign nxt_CRCH0_mode = (CRCH0_wr_en) ? reg_wr_data_i[7:6] : CRCH0_mode;
    assign nxt_CRCH0_inc_des = (CRCH0_wr_en) ? reg_wr_data_i[5] : CRCH0_inc_des;
    assign nxt_CRCH0_inc_src = (CRCH0_wr_en) ? reg_wr_data_i[4] : CRCH0_inc_src;
    assign nxt_CRCH0_done_int_en = (CRCH0_wr_en) ? reg_wr_data_i[3] : CRCH0_done_int_en;
    assign nxt_CRCH0_stop_err_int_en = (CRCH0_wr_en) ? reg_wr_data_i[2] : CRCH0_stop_err_int_en;
    assign nxt_CRCH0_wtt_err_int_en = (CRCH0_wr_en) ? reg_wr_data_i[1] : CRCH0_wtt_err_int_en;
    assign nxt_CRCH0_ch_en = (CRCH0_wr_en) ? reg_wr_data_i[0] : CRCH0_ch_en;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            CRCH0_sw_reset <= 1'h0;
            CRCH0_ch_pri <= 1'h0;
            CRCH0_mode <= 2'h0;
            CRCH0_inc_des <= 1'h0;
            CRCH0_inc_src <= 1'h0;
            CRCH0_done_int_en <= 1'h0;
            CRCH0_stop_err_int_en <= 1'h0;
            CRCH0_wtt_err_int_en <= 1'h0;
            CRCH0_ch_en <= 1'h0;
        end else begin
            CRCH0_sw_reset <= nxt_CRCH0_sw_reset;
            CRCH0_ch_pri <= nxt_CRCH0_ch_pri;
            CRCH0_mode <= nxt_CRCH0_mode;
            CRCH0_inc_des <= nxt_CRCH0_inc_des;
            CRCH0_inc_src <= nxt_CRCH0_inc_src;
            CRCH0_done_int_en <= nxt_CRCH0_done_int_en;
            CRCH0_stop_err_int_en <= nxt_CRCH0_stop_err_int_en;
            CRCH0_wtt_err_int_en <= nxt_CRCH0_wtt_err_int_en;
            CRCH0_ch_en <= nxt_CRCH0_ch_en;
        end
    end
    
    assign CRCH0_sw_reset_o = CRCH0_sw_reset;
    assign CRCH0_ch_pri_o = CRCH0_ch_pri;
    assign CRCH0_mode_o = CRCH0_mode;
    assign CRCH0_inc_des_o = CRCH0_inc_des;
    assign CRCH0_inc_src_o = CRCH0_inc_src;
    assign CRCH0_done_int_en_o = CRCH0_done_int_en;
    assign CRCH0_stop_err_int_en_o = CRCH0_stop_err_int_en;
    assign CRCH0_wtt_err_int_en_o = CRCH0_wtt_err_int_en;
    assign CRCH0_ch_en_o = CRCH0_ch_en;

    //-----------------------
    //write path
    //address = 0x0048
    //-----------------------
    assign nxt_TSRCH0_size = (TSRCH0_wr_en) ? reg_wr_data_i[7:0] : TSRCH0_size;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            TSRCH0_size <= 8'h0;
        end else begin
            TSRCH0_size <= nxt_TSRCH0_size;
        end
    end
    
    assign TSRCH0_size_o = TSRCH0_size;

    //-----------------------
    //write path
    //address = 0x0050
    //-----------------------
    assign nxt_SARCH0_sa = (SARCH0_wr_en) ? reg_wr_data_i[31:0] : SARCH0_sa;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            SARCH0_sa <= 31'h0;
        end else begin
            SARCH0_sa <= nxt_SARCH0_sa;
        end
    end
    
    assign SARCH0_sa_o = SARCH0_sa;

    //-----------------------
    //write path
    //address = 0x0054
    //-----------------------
    assign nxt_DARCH0_da = (DARCH0_wr_en) ? reg_wr_data_i[31:0] : DARCH0_da;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            DARCH0_da <= 31'h0;
        end else begin
            DARCH0_da <= nxt_DARCH0_da;
        end
    end
    
    assign DARCH0_da_o = DARCH0_da;

    //-----------------------
    //write path
    //address = 0x0060
    //-----------------------
    assign nxt_CRCH1_sw_reset = (CRCH1_wr_en) ? reg_wr_data_i[10] : CRCH1_sw_reset;
    assign nxt_CRCH1_ch_pri = (CRCH1_wr_en) ? reg_wr_data_i[9:8] : CRCH1_ch_pri;
    assign nxt_CRCH1_mode = (CRCH1_wr_en) ? reg_wr_data_i[7:6] : CRCH1_mode;
    assign nxt_CRCH1_inc_des = (CRCH1_wr_en) ? reg_wr_data_i[5] : CRCH1_inc_des;
    assign nxt_CRCH1_inc_src = (CRCH1_wr_en) ? reg_wr_data_i[4] : CRCH1_inc_src;
    assign nxt_CRCH1_done_int_en = (CRCH1_wr_en) ? reg_wr_data_i[3] : CRCH1_done_int_en;
    assign nxt_CRCH1_stop_err_int_en = (CRCH1_wr_en) ? reg_wr_data_i[2] : CRCH1_stop_err_int_en;
    assign nxt_CRCH1_wtt_err_int_en = (CRCH1_wr_en) ? reg_wr_data_i[1] : CRCH1_wtt_err_int_en;
    assign nxt_CRCH1_ch_en = (CRCH1_wr_en) ? reg_wr_data_i[0] : CRCH1_ch_en;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            CRCH1_sw_reset <= 1'h0;
            CRCH1_ch_pri <= 1'h0;
            CRCH1_mode <= 2'h0;
            CRCH1_inc_des <= 1'h0;
            CRCH1_inc_src <= 1'h0;
            CRCH1_done_int_en <= 1'h0;
            CRCH1_stop_err_int_en <= 1'h0;
            CRCH1_wtt_err_int_en <= 1'h0;
            CRCH1_ch_en <= 1'h0;
        end else begin
            CRCH1_sw_reset <= nxt_CRCH1_sw_reset;
            CRCH1_ch_pri <= nxt_CRCH1_ch_pri;
            CRCH1_mode <= nxt_CRCH1_mode;
            CRCH1_inc_des <= nxt_CRCH1_inc_des;
            CRCH1_inc_src <= nxt_CRCH1_inc_src;
            CRCH1_done_int_en <= nxt_CRCH1_done_int_en;
            CRCH1_stop_err_int_en <= nxt_CRCH1_stop_err_int_en;
            CRCH1_wtt_err_int_en <= nxt_CRCH1_wtt_err_int_en;
            CRCH1_ch_en <= nxt_CRCH1_ch_en;
        end
    end
    
    assign CRCH1_sw_reset_o = CRCH1_sw_reset;
    assign CRCH1_ch_pri_o = CRCH1_ch_pri;
    assign CRCH1_mode_o = CRCH1_mode;
    assign CRCH1_inc_des_o = CRCH1_inc_des;
    assign CRCH1_inc_src_o = CRCH1_inc_src;
    assign CRCH1_done_int_en_o = CRCH1_done_int_en;
    assign CRCH1_stop_err_int_en_o = CRCH1_stop_err_int_en;
    assign CRCH1_wtt_err_int_en_o = CRCH1_wtt_err_int_en;
    assign CRCH1_ch_en_o = CRCH1_ch_en;

    //-----------------------
    //write path
    //address = 0x0068
    //-----------------------
    assign nxt_TSRCH1_size = (TSRCH1_wr_en) ? reg_wr_data_i[7:0] : TSRCH1_size;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            TSRCH1_size <= 8'h0;
        end else begin
            TSRCH1_size <= nxt_TSRCH1_size;
        end
    end
    
    assign TSRCH1_size_o = TSRCH1_size;

    //-----------------------
    //write path
    //address = 0x0070
    //-----------------------
    assign nxt_SARCH1_sa = (SARCH1_wr_en) ? reg_wr_data_i[31:0] : SARCH1_sa;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            SARCH1_sa <= 31'h0;
        end else begin
            SARCH1_sa <= nxt_SARCH1_sa;
        end
    end
    
    assign SARCH1_sa_o = SARCH1_sa;

    //-----------------------
    //write path
    //address = 0x0074
    //-----------------------
    assign nxt_DARCH1_da = (DARCH1_wr_en) ? reg_wr_data_i[31:0] : DARCH1_da;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            DARCH1_da <= 31'h0;
        end else begin
            DARCH1_da <= nxt_DARCH1_da;
        end
    end
    
    assign DARCH1_da_o = DARCH1_da;

    //-----------------------
    //write path
    //address = 0x0080
    //-----------------------
    assign nxt_CRCH2_sw_reset = (CRCH2_wr_en) ? reg_wr_data_i[10] : CRCH2_sw_reset;
    assign nxt_CRCH2_ch_pri = (CRCH2_wr_en) ? reg_wr_data_i[9:8] : CRCH2_ch_pri;
    assign nxt_CRCH2_mode = (CRCH2_wr_en) ? reg_wr_data_i[7:6] : CRCH2_mode;
    assign nxt_CRCH2_inc_des = (CRCH2_wr_en) ? reg_wr_data_i[5] : CRCH2_inc_des;
    assign nxt_CRCH2_inc_src = (CRCH2_wr_en) ? reg_wr_data_i[4] : CRCH2_inc_src;
    assign nxt_CRCH2_done_int_en = (CRCH2_wr_en) ? reg_wr_data_i[3] : CRCH2_done_int_en;
    assign nxt_CRCH2_stop_err_int_en = (CRCH2_wr_en) ? reg_wr_data_i[2] : CRCH2_stop_err_int_en;
    assign nxt_CRCH2_wtt_err_int_en = (CRCH2_wr_en) ? reg_wr_data_i[1] : CRCH2_wtt_err_int_en;
    assign nxt_CRCH2_ch_en = (CRCH2_wr_en) ? reg_wr_data_i[0] : CRCH2_ch_en;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            CRCH2_sw_reset <= 1'h0;
            CRCH2_ch_pri <= 1'h0;
            CRCH2_mode <= 2'h0;
            CRCH2_inc_des <= 1'h0;
            CRCH2_inc_src <= 1'h0;
            CRCH2_done_int_en <= 1'h0;
            CRCH2_stop_err_int_en <= 1'h0;
            CRCH2_wtt_err_int_en <= 1'h0;
            CRCH2_ch_en <= 1'h0;
        end else begin
            CRCH2_sw_reset <= nxt_CRCH2_sw_reset;
            CRCH2_ch_pri <= nxt_CRCH2_ch_pri;
            CRCH2_mode <= nxt_CRCH2_mode;
            CRCH2_inc_des <= nxt_CRCH2_inc_des;
            CRCH2_inc_src <= nxt_CRCH2_inc_src;
            CRCH2_done_int_en <= nxt_CRCH2_done_int_en;
            CRCH2_stop_err_int_en <= nxt_CRCH2_stop_err_int_en;
            CRCH2_wtt_err_int_en <= nxt_CRCH2_wtt_err_int_en;
            CRCH2_ch_en <= nxt_CRCH2_ch_en;
        end
    end
    
    assign CRCH2_sw_reset_o = CRCH2_sw_reset;
    assign CRCH2_ch_pri_o = CRCH2_ch_pri;
    assign CRCH2_mode_o = CRCH2_mode;
    assign CRCH2_inc_des_o = CRCH2_inc_des;
    assign CRCH2_inc_src_o = CRCH2_inc_src;
    assign CRCH2_done_int_en_o = CRCH2_done_int_en;
    assign CRCH2_stop_err_int_en_o = CRCH2_stop_err_int_en;
    assign CRCH2_wtt_err_int_en_o = CRCH2_wtt_err_int_en;
    assign CRCH2_ch_en_o = CRCH2_ch_en;

    //-----------------------
    //write path
    //address = 0x0088
    //-----------------------
    assign nxt_TSRCH2_size = (TSRCH2_wr_en) ? reg_wr_data_i[7:0] : TSRCH2_size;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            TSRCH2_size <= 8'h0;
        end else begin
            TSRCH2_size <= nxt_TSRCH2_size;
        end
    end
    
    assign TSRCH2_size_o = TSRCH2_size;

    //-----------------------
    //write path
    //address = 0x0090
    //-----------------------
    assign nxt_SARCH2_sa = (SARCH2_wr_en) ? reg_wr_data_i[31:0] : SARCH2_sa;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            SARCH2_sa <= 31'h0;
        end else begin
            SARCH2_sa <= nxt_SARCH2_sa;
        end
    end
    
    assign SARCH2_sa_o = SARCH2_sa;

    //-----------------------
    //write path
    //address = 0x0094
    //-----------------------
    assign nxt_DARCH2_da = (DARCH2_wr_en) ? reg_wr_data_i[31:0] : DARCH2_da;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            DARCH2_da <= 31'h0;
        end else begin
            DARCH2_da <= nxt_DARCH2_da;
        end
    end
    
    assign DARCH2_da_o = DARCH2_da;

    //-----------------------
    //write path
    //address = 0x00a0
    //-----------------------
    assign nxt_CRCH3_sw_reset = (CRCH3_wr_en) ? reg_wr_data_i[10] : CRCH3_sw_reset;
    assign nxt_CRCH3_ch_pri = (CRCH3_wr_en) ? reg_wr_data_i[9:8] : CRCH3_ch_pri;
    assign nxt_CRCH3_mode = (CRCH3_wr_en) ? reg_wr_data_i[7:6] : CRCH3_mode;
    assign nxt_CRCH3_inc_des = (CRCH3_wr_en) ? reg_wr_data_i[5] : CRCH3_inc_des;
    assign nxt_CRCH3_inc_src = (CRCH3_wr_en) ? reg_wr_data_i[4] : CRCH3_inc_src;
    assign nxt_CRCH3_done_int_en = (CRCH3_wr_en) ? reg_wr_data_i[3] : CRCH3_done_int_en;
    assign nxt_CRCH3_stop_err_int_en = (CRCH3_wr_en) ? reg_wr_data_i[2] : CRCH3_stop_err_int_en;
    assign nxt_CRCH3_wtt_err_int_en = (CRCH3_wr_en) ? reg_wr_data_i[1] : CRCH3_wtt_err_int_en;
    assign nxt_CRCH3_ch_en = (CRCH3_wr_en) ? reg_wr_data_i[0] : CRCH3_ch_en;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            CRCH3_sw_reset <= 1'h0;
            CRCH3_ch_pri <= 1'h0;
            CRCH3_mode <= 2'h0;
            CRCH3_inc_des <= 1'h0;
            CRCH3_inc_src <= 1'h0;
            CRCH3_done_int_en <= 1'h0;
            CRCH3_stop_err_int_en <= 1'h0;
            CRCH3_wtt_err_int_en <= 1'h0;
            CRCH3_ch_en <= 1'h0;
        end else begin
            CRCH3_sw_reset <= nxt_CRCH3_sw_reset;
            CRCH3_ch_pri <= nxt_CRCH3_ch_pri;
            CRCH3_mode <= nxt_CRCH3_mode;
            CRCH3_inc_des <= nxt_CRCH3_inc_des;
            CRCH3_inc_src <= nxt_CRCH3_inc_src;
            CRCH3_done_int_en <= nxt_CRCH3_done_int_en;
            CRCH3_stop_err_int_en <= nxt_CRCH3_stop_err_int_en;
            CRCH3_wtt_err_int_en <= nxt_CRCH3_wtt_err_int_en;
            CRCH3_ch_en <= nxt_CRCH3_ch_en;
        end
    end
    
    assign CRCH3_sw_reset_o = CRCH3_sw_reset;
    assign CRCH3_ch_pri_o = CRCH3_ch_pri;
    assign CRCH3_mode_o = CRCH3_mode;
    assign CRCH3_inc_des_o = CRCH3_inc_des;
    assign CRCH3_inc_src_o = CRCH3_inc_src;
    assign CRCH3_done_int_en_o = CRCH3_done_int_en;
    assign CRCH3_stop_err_int_en_o = CRCH3_stop_err_int_en;
    assign CRCH3_wtt_err_int_en_o = CRCH3_wtt_err_int_en;
    assign CRCH3_ch_en_o = CRCH3_ch_en;

    //-----------------------
    //write path
    //address = 0x00a8
    //-----------------------
    assign nxt_TSRCH3_size = (TSRCH3_wr_en) ? reg_wr_data_i[7:0] : TSRCH3_size;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            TSRCH3_size <= 8'h0;
        end else begin
            TSRCH3_size <= nxt_TSRCH3_size;
        end
    end
    
    assign TSRCH3_size_o = TSRCH3_size;

    //-----------------------
    //write path
    //address = 0x00b0
    //-----------------------
    assign nxt_SARCH3_sa = (SARCH3_wr_en) ? reg_wr_data_i[31:0] : SARCH3_sa;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            SARCH3_sa <= 31'h0;
        end else begin
            SARCH3_sa <= nxt_SARCH3_sa;
        end
    end
    
    assign SARCH3_sa_o = SARCH3_sa;

    //-----------------------
    //write path
    //address = 0x00b4
    //-----------------------
    assign nxt_DARCH3_da = (DARCH3_wr_en) ? reg_wr_data_i[31:0] : DARCH3_da;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            DARCH3_da <= 31'h0;
        end else begin
            DARCH3_da <= nxt_DARCH3_da;
        end
    end
    
    assign DARCH3_da_o = DARCH3_da;

    //-----------------------
    //write path
    //address = 0x00a0
    //-----------------------
    assign nxt_CRCH4_sw_reset = (CRCH4_wr_en) ? reg_wr_data_i[10] : CRCH4_sw_reset;
    assign nxt_CRCH4_ch_pri = (CRCH4_wr_en) ? reg_wr_data_i[9:8] : CRCH4_ch_pri;
    assign nxt_CRCH4_mode = (CRCH4_wr_en) ? reg_wr_data_i[7:6] : CRCH4_mode;
    assign nxt_CRCH4_inc_des = (CRCH4_wr_en) ? reg_wr_data_i[5] : CRCH4_inc_des;
    assign nxt_CRCH4_inc_src = (CRCH4_wr_en) ? reg_wr_data_i[4] : CRCH4_inc_src;
    assign nxt_CRCH4_done_int_en = (CRCH4_wr_en) ? reg_wr_data_i[3] : CRCH4_done_int_en;
    assign nxt_CRCH4_stop_err_int_en = (CRCH4_wr_en) ? reg_wr_data_i[2] : CRCH4_stop_err_int_en;
    assign nxt_CRCH4_wtt_err_int_en = (CRCH4_wr_en) ? reg_wr_data_i[1] : CRCH4_wtt_err_int_en;
    assign nxt_CRCH4_ch_en = (CRCH4_wr_en) ? reg_wr_data_i[0] : CRCH4_ch_en;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            CRCH4_sw_reset <= 1'h0;
            CRCH4_ch_pri <= 1'h0;
            CRCH4_mode <= 2'h0;
            CRCH4_inc_des <= 1'h0;
            CRCH4_inc_src <= 1'h0;
            CRCH4_done_int_en <= 1'h0;
            CRCH4_stop_err_int_en <= 1'h0;
            CRCH4_wtt_err_int_en <= 1'h0;
            CRCH4_ch_en <= 1'h0;
        end else begin
            CRCH4_sw_reset <= nxt_CRCH4_sw_reset;
            CRCH4_ch_pri <= nxt_CRCH4_ch_pri;
            CRCH4_mode <= nxt_CRCH4_mode;
            CRCH4_inc_des <= nxt_CRCH4_inc_des;
            CRCH4_inc_src <= nxt_CRCH4_inc_src;
            CRCH4_done_int_en <= nxt_CRCH4_done_int_en;
            CRCH4_stop_err_int_en <= nxt_CRCH4_stop_err_int_en;
            CRCH4_wtt_err_int_en <= nxt_CRCH4_wtt_err_int_en;
            CRCH4_ch_en <= nxt_CRCH4_ch_en;
        end
    end
    
    assign CRCH4_sw_reset_o = CRCH4_sw_reset;
    assign CRCH4_ch_pri_o = CRCH4_ch_pri;
    assign CRCH4_mode_o = CRCH4_mode;
    assign CRCH4_inc_des_o = CRCH4_inc_des;
    assign CRCH4_inc_src_o = CRCH4_inc_src;
    assign CRCH4_done_int_en_o = CRCH4_done_int_en;
    assign CRCH4_stop_err_int_en_o = CRCH4_stop_err_int_en;
    assign CRCH4_wtt_err_int_en_o = CRCH4_wtt_err_int_en;
    assign CRCH4_ch_en_o = CRCH4_ch_en;

    //-----------------------
    //write path
    //address = 0x00a8
    //-----------------------
    assign nxt_TSRCH4_size = (TSRCH4_wr_en) ? reg_wr_data_i[7:0] : TSRCH4_size;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            TSRCH4_size <= 8'h0;
        end else begin
            TSRCH4_size <= nxt_TSRCH4_size;
        end
    end
    
    assign TSRCH4_size_o = TSRCH4_size;

    //-----------------------
    //write path
    //address = 0x00b0
    //-----------------------
    assign nxt_SARCH4_sa = (SARCH4_wr_en) ? reg_wr_data_i[31:0] : SARCH4_sa;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            SARCH4_sa <= 31'h0;
        end else begin
            SARCH4_sa <= nxt_SARCH4_sa;
        end
    end
    
    assign SARCH4_sa_o = SARCH4_sa;

    //-----------------------
    //write path
    //address = 0x00b4
    //-----------------------
    assign nxt_DARCH4_da = (DARCH4_wr_en) ? reg_wr_data_i[31:0] : DARCH4_da;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            DARCH4_da <= 31'h0;
        end else begin
            DARCH4_da <= nxt_DARCH4_da;
        end
    end
    
    assign DARCH4_da_o = DARCH4_da;

    //-----------------------
    //write path
    //address = 0x00c0
    //-----------------------
    assign nxt_CRCH5_sw_reset = (CRCH5_wr_en) ? reg_wr_data_i[10] : CRCH5_sw_reset;
    assign nxt_CRCH5_ch_pri = (CRCH5_wr_en) ? reg_wr_data_i[9:8] : CRCH5_ch_pri;
    assign nxt_CRCH5_mode = (CRCH5_wr_en) ? reg_wr_data_i[7:6] : CRCH5_mode;
    assign nxt_CRCH5_inc_des = (CRCH5_wr_en) ? reg_wr_data_i[5] : CRCH5_inc_des;
    assign nxt_CRCH5_inc_src = (CRCH5_wr_en) ? reg_wr_data_i[4] : CRCH5_inc_src;
    assign nxt_CRCH5_done_int_en = (CRCH5_wr_en) ? reg_wr_data_i[3] : CRCH5_done_int_en;
    assign nxt_CRCH5_stop_err_int_en = (CRCH5_wr_en) ? reg_wr_data_i[2] : CRCH5_stop_err_int_en;
    assign nxt_CRCH5_wtt_err_int_en = (CRCH5_wr_en) ? reg_wr_data_i[1] : CRCH5_wtt_err_int_en;
    assign nxt_CRCH5_ch_en = (CRCH5_wr_en) ? reg_wr_data_i[0] : CRCH5_ch_en;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            CRCH5_sw_reset <= 1'h0;
            CRCH5_ch_pri <= 1'h0;
            CRCH5_mode <= 2'h0;
            CRCH5_inc_des <= 1'h0;
            CRCH5_inc_src <= 1'h0;
            CRCH5_done_int_en <= 1'h0;
            CRCH5_stop_err_int_en <= 1'h0;
            CRCH5_wtt_err_int_en <= 1'h0;
            CRCH5_ch_en <= 1'h0;
        end else begin
            CRCH5_sw_reset <= nxt_CRCH5_sw_reset;
            CRCH5_ch_pri <= nxt_CRCH5_ch_pri;
            CRCH5_mode <= nxt_CRCH5_mode;
            CRCH5_inc_des <= nxt_CRCH5_inc_des;
            CRCH5_inc_src <= nxt_CRCH5_inc_src;
            CRCH5_done_int_en <= nxt_CRCH5_done_int_en;
            CRCH5_stop_err_int_en <= nxt_CRCH5_stop_err_int_en;
            CRCH5_wtt_err_int_en <= nxt_CRCH5_wtt_err_int_en;
            CRCH5_ch_en <= nxt_CRCH5_ch_en;
        end
    end
    
    assign CRCH5_sw_reset_o = CRCH5_sw_reset;
    assign CRCH5_ch_pri_o = CRCH5_ch_pri;
    assign CRCH5_mode_o = CRCH5_mode;
    assign CRCH5_inc_des_o = CRCH5_inc_des;
    assign CRCH5_inc_src_o = CRCH5_inc_src;
    assign CRCH5_done_int_en_o = CRCH5_done_int_en;
    assign CRCH5_stop_err_int_en_o = CRCH5_stop_err_int_en;
    assign CRCH5_wtt_err_int_en_o = CRCH5_wtt_err_int_en;
    assign CRCH5_ch_en_o = CRCH5_ch_en;

    //-----------------------
    //write path
    //address = 0x00c8
    //-----------------------
    assign nxt_TSRCH5_size = (TSRCH5_wr_en) ? reg_wr_data_i[7:0] : TSRCH5_size;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            TSRCH5_size <= 8'h0;
        end else begin
            TSRCH5_size <= nxt_TSRCH5_size;
        end
    end
    
    assign TSRCH5_size_o = TSRCH5_size;

    //-----------------------
    //write path
    //address = 0x00d0
    //-----------------------
    assign nxt_SARCH5_sa = (SARCH5_wr_en) ? reg_wr_data_i[31:0] : SARCH5_sa;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            SARCH5_sa <= 31'h0;
        end else begin
            SARCH5_sa <= nxt_SARCH5_sa;
        end
    end
    
    assign SARCH5_sa_o = SARCH5_sa;

    //-----------------------
    //write path
    //address = 0x00d4
    //-----------------------
    assign nxt_DARCH5_da = (DARCH5_wr_en) ? reg_wr_data_i[31:0] : DARCH5_da;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            DARCH5_da <= 31'h0;
        end else begin
            DARCH5_da <= nxt_DARCH5_da;
        end
    end
    
    assign DARCH5_da_o = DARCH5_da;

    //-----------------------
    //write path
    //address = 0x00e0
    //-----------------------
    assign nxt_CRCH6_sw_reset = (CRCH6_wr_en) ? reg_wr_data_i[10] : CRCH6_sw_reset;
    assign nxt_CRCH6_ch_pri = (CRCH6_wr_en) ? reg_wr_data_i[9:8] : CRCH6_ch_pri;
    assign nxt_CRCH6_mode = (CRCH6_wr_en) ? reg_wr_data_i[7:6] : CRCH6_mode;
    assign nxt_CRCH6_inc_des = (CRCH6_wr_en) ? reg_wr_data_i[5] : CRCH6_inc_des;
    assign nxt_CRCH6_inc_src = (CRCH6_wr_en) ? reg_wr_data_i[4] : CRCH6_inc_src;
    assign nxt_CRCH6_done_int_en = (CRCH6_wr_en) ? reg_wr_data_i[3] : CRCH6_done_int_en;
    assign nxt_CRCH6_stop_err_int_en = (CRCH6_wr_en) ? reg_wr_data_i[2] : CRCH6_stop_err_int_en;
    assign nxt_CRCH6_wtt_err_int_en = (CRCH6_wr_en) ? reg_wr_data_i[1] : CRCH6_wtt_err_int_en;
    assign nxt_CRCH6_ch_en = (CRCH6_wr_en) ? reg_wr_data_i[0] : CRCH6_ch_en;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            CRCH6_sw_reset <= 1'h0;
            CRCH6_ch_pri <= 1'h0;
            CRCH6_mode <= 2'h0;
            CRCH6_inc_des <= 1'h0;
            CRCH6_inc_src <= 1'h0;
            CRCH6_done_int_en <= 1'h0;
            CRCH6_stop_err_int_en <= 1'h0;
            CRCH6_wtt_err_int_en <= 1'h0;
            CRCH6_ch_en <= 1'h0;
        end else begin
            CRCH6_sw_reset <= nxt_CRCH6_sw_reset;
            CRCH6_ch_pri <= nxt_CRCH6_ch_pri;
            CRCH6_mode <= nxt_CRCH6_mode;
            CRCH6_inc_des <= nxt_CRCH6_inc_des;
            CRCH6_inc_src <= nxt_CRCH6_inc_src;
            CRCH6_done_int_en <= nxt_CRCH6_done_int_en;
            CRCH6_stop_err_int_en <= nxt_CRCH6_stop_err_int_en;
            CRCH6_wtt_err_int_en <= nxt_CRCH6_wtt_err_int_en;
            CRCH6_ch_en <= nxt_CRCH6_ch_en;
        end
    end
    
    assign CRCH6_sw_reset_o = CRCH6_sw_reset;
    assign CRCH6_ch_pri_o = CRCH6_ch_pri;
    assign CRCH6_mode_o = CRCH6_mode;
    assign CRCH6_inc_des_o = CRCH6_inc_des;
    assign CRCH6_inc_src_o = CRCH6_inc_src;
    assign CRCH6_done_int_en_o = CRCH6_done_int_en;
    assign CRCH6_stop_err_int_en_o = CRCH6_stop_err_int_en;
    assign CRCH6_wtt_err_int_en_o = CRCH6_wtt_err_int_en;
    assign CRCH6_ch_en_o = CRCH6_ch_en;

    //-----------------------
    //write path
    //address = 0x00e8
    //-----------------------
    assign nxt_TSRCH6_size = (TSRCH6_wr_en) ? reg_wr_data_i[7:0] : TSRCH6_size;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            TSRCH6_size <= 8'h0;
        end else begin
            TSRCH6_size <= nxt_TSRCH6_size;
        end
    end
    
    assign TSRCH6_size_o = TSRCH6_size;

    //-----------------------
    //write path
    //address = 0x00f0
    //-----------------------
    assign nxt_SARCH6_sa = (SARCH6_wr_en) ? reg_wr_data_i[31:0] : SARCH6_sa;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            SARCH6_sa <= 31'h0;
        end else begin
            SARCH6_sa <= nxt_SARCH6_sa;
        end
    end
    
    assign SARCH6_sa_o = SARCH6_sa;

    //-----------------------
    //write path
    //address = 0x00f4
    //-----------------------
    assign nxt_DARCH6_da = (DARCH6_wr_en) ? reg_wr_data_i[31:0] : DARCH6_da;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            DARCH6_da <= 31'h0;
        end else begin
            DARCH6_da <= nxt_DARCH6_da;
        end
    end
    
    assign DARCH6_da_o = DARCH6_da;

    //-----------------------
    //write path
    //address = 0x0100
    //-----------------------
    assign nxt_CRCH7_sw_reset = (CRCH7_wr_en) ? reg_wr_data_i[10] : CRCH7_sw_reset;
    assign nxt_CRCH7_ch_pri = (CRCH7_wr_en) ? reg_wr_data_i[9:8] : CRCH7_ch_pri;
    assign nxt_CRCH7_mode = (CRCH7_wr_en) ? reg_wr_data_i[7:6] : CRCH7_mode;
    assign nxt_CRCH7_inc_des = (CRCH7_wr_en) ? reg_wr_data_i[5] : CRCH7_inc_des;
    assign nxt_CRCH7_inc_src = (CRCH7_wr_en) ? reg_wr_data_i[4] : CRCH7_inc_src;
    assign nxt_CRCH7_done_int_en = (CRCH7_wr_en) ? reg_wr_data_i[3] : CRCH7_done_int_en;
    assign nxt_CRCH7_stop_err_int_en = (CRCH7_wr_en) ? reg_wr_data_i[2] : CRCH7_stop_err_int_en;
    assign nxt_CRCH7_wtt_err_int_en = (CRCH7_wr_en) ? reg_wr_data_i[1] : CRCH7_wtt_err_int_en;
    assign nxt_CRCH7_ch_en = (CRCH7_wr_en) ? reg_wr_data_i[0] : CRCH7_ch_en;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            CRCH7_sw_reset <= 1'h0;
            CRCH7_ch_pri <= 1'h0;
            CRCH7_mode <= 2'h0;
            CRCH7_inc_des <= 1'h0;
            CRCH7_inc_src <= 1'h0;
            CRCH7_done_int_en <= 1'h0;
            CRCH7_stop_err_int_en <= 1'h0;
            CRCH7_wtt_err_int_en <= 1'h0;
            CRCH7_ch_en <= 1'h0;
        end else begin
            CRCH7_sw_reset <= nxt_CRCH7_sw_reset;
            CRCH7_ch_pri <= nxt_CRCH7_ch_pri;
            CRCH7_mode <= nxt_CRCH7_mode;
            CRCH7_inc_des <= nxt_CRCH7_inc_des;
            CRCH7_inc_src <= nxt_CRCH7_inc_src;
            CRCH7_done_int_en <= nxt_CRCH7_done_int_en;
            CRCH7_stop_err_int_en <= nxt_CRCH7_stop_err_int_en;
            CRCH7_wtt_err_int_en <= nxt_CRCH7_wtt_err_int_en;
            CRCH7_ch_en <= nxt_CRCH7_ch_en;
        end
    end
    
    assign CRCH7_sw_reset_o = CRCH7_sw_reset;
    assign CRCH7_ch_pri_o = CRCH7_ch_pri;
    assign CRCH7_mode_o = CRCH7_mode;
    assign CRCH7_inc_des_o = CRCH7_inc_des;
    assign CRCH7_inc_src_o = CRCH7_inc_src;
    assign CRCH7_done_int_en_o = CRCH7_done_int_en;
    assign CRCH7_stop_err_int_en_o = CRCH7_stop_err_int_en;
    assign CRCH7_wtt_err_int_en_o = CRCH7_wtt_err_int_en;
    assign CRCH7_ch_en_o = CRCH7_ch_en;

    //-----------------------
    //write path
    //address = 0x0108
    //-----------------------
    assign nxt_TSRCH7_size = (TSRCH7_wr_en) ? reg_wr_data_i[7:0] : TSRCH7_size;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            TSRCH7_size <= 8'h0;
        end else begin
            TSRCH7_size <= nxt_TSRCH7_size;
        end
    end
    
    assign TSRCH7_size_o = TSRCH7_size;

    //-----------------------
    //write path
    //address = 0x0110
    //-----------------------
    assign nxt_SARCH7_sa = (SARCH7_wr_en) ? reg_wr_data_i[31:0] : SARCH7_sa;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            SARCH7_sa <= 31'h0;
        end else begin
            SARCH7_sa <= nxt_SARCH7_sa;
        end
    end
    
    assign SARCH7_sa_o = SARCH7_sa;

    //-----------------------
    //write path
    //address = 0x0114
    //-----------------------
    assign nxt_DARCH7_da = (DARCH7_wr_en) ? reg_wr_data_i[31:0] : DARCH7_da;
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            DARCH7_da <= 31'h0;
        end else begin
            DARCH7_da <= nxt_DARCH7_da;
        end
    end
    
    assign DARCH7_da_o = DARCH7_da;

    //-----------------------
    //read path
    //-----------------------
    always @(*) begin
        case(reg_addr_i)
            16'h0000: nxt_reg_rd_data = {CDMAControl_IRQDelay, CDMAControl_IRQThreshold, 1'h0, CDMAControl_Err_IrqEn, CDMAControl_Dly_IrqEn, CDMAControl_IOC_IrqEn, 5'h00, CDMAControl_Cyclic_BD_Enable, CDMAControl_Key_Hole_Write, CDMAControl_Key_Hole_Read, CDMAControl_SGMode, CDMAControl_Reset, 1'h1, 1'h0};
            16'h0004: nxt_reg_rd_data = {8'h00, 8'h01, 1'h0, CDMAStatus_Err_Irq, CDMAStatus_Dly_Irq, CDMAStatus_IOC_Irq, 1'h0, 1'h0, 1'h0, 1'h0, 1'h0, 1'h0, 1'h0, 1'h0, 1'h0, 1'h0, 1'h0, 1'h0};
            16'h0008: nxt_reg_rd_data = {CDMACurDescPntr_Cur_Desc_Pntr, 6'h0};
            16'h000c: nxt_reg_rd_data = {CDMACurDescPntrMSB_Cur_Desc_Pntr};
            16'h0010: nxt_reg_rd_data = {CDMATailDescPntr_Tail_Desc_Pntr, 6'h0};
            16'h0014: nxt_reg_rd_data = {CDMATailDescPntrMSB_Tail_Desc_Pntr};
            16'h0018: nxt_reg_rd_data = {CDMASA_Source_Address};
            16'h001c: nxt_reg_rd_data = {CDMASAMSB_Source_Address};
            16'h0020: nxt_reg_rd_data = {32'h0};
            16'h0024: nxt_reg_rd_data = {32'h0};
            16'h0028: nxt_reg_rd_data = {6'h0, CDMABTT_Bytes_To_Transfer};
            16'h002c: nxt_reg_rd_data = {32'h0};
            16'h0030: nxt_reg_rd_data = {23'h0, MAINCFG_dma_en, MAINCFG_ch_int_en};
            16'h0034: nxt_reg_rd_data = {23'h0, 1'h0, 8'h0};
            16'h0038: nxt_reg_rd_data = {32'h0};
            16'h003c: nxt_reg_rd_data = {32'h0};
            16'h0040: nxt_reg_rd_data = {21'h0, CRCH0_sw_reset, CRCH0_ch_pri, CRCH0_mode, CRCH0_inc_des, CRCH0_inc_src, CRCH0_done_int_en, CRCH0_stop_err_int_en, CRCH0_wtt_err_int_en, CRCH0_ch_en};
            16'h0044: nxt_reg_rd_data = {28'h0, 1'h0, 1'h0, 1'h0, 1'h0};
            16'h0048: nxt_reg_rd_data = {24'h0, TSRCH0_size};
            16'h004c: nxt_reg_rd_data = {28'h0, 4'h0};
            16'h0050: nxt_reg_rd_data = {SARCH0_sa};
            16'h0054: nxt_reg_rd_data = {DARCH0_da};
            16'h0060: nxt_reg_rd_data = {21'h0, CRCH1_sw_reset, CRCH1_ch_pri, CRCH1_mode, CRCH1_inc_des, CRCH1_inc_src, CRCH1_done_int_en, CRCH1_stop_err_int_en, CRCH1_wtt_err_int_en, CRCH1_ch_en};
            16'h0064: nxt_reg_rd_data = {28'h0, 1'h0, 1'h0, 1'h0, 1'h0};
            16'h0068: nxt_reg_rd_data = {24'h0, TSRCH1_size};
            16'h006c: nxt_reg_rd_data = {28'h0, 4'h0};
            16'h0070: nxt_reg_rd_data = {SARCH1_sa};
            16'h0074: nxt_reg_rd_data = {DARCH1_da};
            16'h0080: nxt_reg_rd_data = {21'h0, CRCH2_sw_reset, CRCH2_ch_pri, CRCH2_mode, CRCH2_inc_des, CRCH2_inc_src, CRCH2_done_int_en, CRCH2_stop_err_int_en, CRCH2_wtt_err_int_en, CRCH2_ch_en};
            16'h0084: nxt_reg_rd_data = {28'h0, 1'h0, 1'h0, 1'h0, 1'h0};
            16'h0088: nxt_reg_rd_data = {24'h0, TSRCH2_size};
            16'h008c: nxt_reg_rd_data = {28'h0, 4'h0};
            16'h0090: nxt_reg_rd_data = {SARCH2_sa};
            16'h0094: nxt_reg_rd_data = {DARCH2_da};
            16'h00a0: nxt_reg_rd_data = {21'h0, CRCH3_sw_reset, CRCH3_ch_pri, CRCH3_mode, CRCH3_inc_des, CRCH3_inc_src, CRCH3_done_int_en, CRCH3_stop_err_int_en, CRCH3_wtt_err_int_en, CRCH3_ch_en};
            16'h00a4: nxt_reg_rd_data = {28'h0, 1'h0, 1'h0, 1'h0, 1'h0};
            16'h00a8: nxt_reg_rd_data = {24'h0, TSRCH3_size};
            16'h00ac: nxt_reg_rd_data = {28'h0, 4'h0};
            16'h00b0: nxt_reg_rd_data = {SARCH3_sa};
            16'h00b4: nxt_reg_rd_data = {DARCH3_da};
            16'h00a0: nxt_reg_rd_data = {21'h0, CRCH4_sw_reset, CRCH4_ch_pri, CRCH4_mode, CRCH4_inc_des, CRCH4_inc_src, CRCH4_done_int_en, CRCH4_stop_err_int_en, CRCH4_wtt_err_int_en, CRCH4_ch_en};
            16'h00a4: nxt_reg_rd_data = {28'h0, 1'h0, 1'h0, 1'h0, 1'h0};
            16'h00a8: nxt_reg_rd_data = {24'h0, TSRCH4_size};
            16'h00ac: nxt_reg_rd_data = {28'h0, 4'h0};
            16'h00b0: nxt_reg_rd_data = {SARCH4_sa};
            16'h00b4: nxt_reg_rd_data = {DARCH4_da};
            16'h00c0: nxt_reg_rd_data = {21'h0, CRCH5_sw_reset, CRCH5_ch_pri, CRCH5_mode, CRCH5_inc_des, CRCH5_inc_src, CRCH5_done_int_en, CRCH5_stop_err_int_en, CRCH5_wtt_err_int_en, CRCH5_ch_en};
            16'h00c4: nxt_reg_rd_data = {28'h0, 1'h0, 1'h0, 1'h0, 1'h0};
            16'h00c8: nxt_reg_rd_data = {24'h0, TSRCH5_size};
            16'h00cc: nxt_reg_rd_data = {28'h0, 4'h0};
            16'h00d0: nxt_reg_rd_data = {SARCH5_sa};
            16'h00d4: nxt_reg_rd_data = {DARCH5_da};
            16'h00e0: nxt_reg_rd_data = {21'h0, CRCH6_sw_reset, CRCH6_ch_pri, CRCH6_mode, CRCH6_inc_des, CRCH6_inc_src, CRCH6_done_int_en, CRCH6_stop_err_int_en, CRCH6_wtt_err_int_en, CRCH6_ch_en};
            16'h00e4: nxt_reg_rd_data = {28'h0, 1'h0, 1'h0, 1'h0, 1'h0};
            16'h00e8: nxt_reg_rd_data = {24'h0, TSRCH6_size};
            16'h00ec: nxt_reg_rd_data = {28'h0, 4'h0};
            16'h00f0: nxt_reg_rd_data = {SARCH6_sa};
            16'h00f4: nxt_reg_rd_data = {DARCH6_da};
            16'h0100: nxt_reg_rd_data = {21'h0, CRCH7_sw_reset, CRCH7_ch_pri, CRCH7_mode, CRCH7_inc_des, CRCH7_inc_src, CRCH7_done_int_en, CRCH7_stop_err_int_en, CRCH7_wtt_err_int_en, CRCH7_ch_en};
            16'h0104: nxt_reg_rd_data = {28'h0, 1'h0, 1'h0, 1'h0, 1'h0};
            16'h0108: nxt_reg_rd_data = {24'h0, TSRCH7_size};
            16'h010c: nxt_reg_rd_data = {28'h0, 4'h0};
            16'h0110: nxt_reg_rd_data = {SARCH7_sa};
            16'h0114: nxt_reg_rd_data = {DARCH7_da};
            default: nxt_reg_rd_data = {(DATA_WIDTH){1'b0}};
        endcase
    end
    
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            reg_rd_data <= 32'h0;
        end else begin
            reg_rd_data <= {(DATA_WIDTH){reg_rd_en_i}} & nxt_reg_rd_data;
        end
    end
    
    assign reg_rd_data_o = reg_rd_data;
endmodule