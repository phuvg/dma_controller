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
    parameter ADDR_WIDTH = 16;
    parameter DATA_WIDTH = 32;
	
	////////////////////////////////////////////////////////////////////////////
    //port declaration
    ////////////////////////////////////////////////////////////////////////////
    //-----------------------
    //#--> clk and rstn
    reg										clk;
    reg										rstn;
    //-----------------------
    //#--> regiter interface
    reg		[ADDR_WIDTH-1:0]				reg_addr_i;
    reg										reg_wr_en_i;
    reg		[DATA_WIDTH-1:0]				reg_wr_data_i;
    reg										reg_rd_en_i;
    wire	[DATA_WIDTH-1:0]				reg_rd_data_o;
    //-----------------------
    //#--> addr = 0x0000
    wire	[31:24]							CDMAControl_IRQDelay_o;
    wire	[23:16]							CDMAControl_IRQThreshold_o;
    wire									CDMAControl_Err_IrqEn_o;
    wire									CDMAControl_Dly_IrqEn_o;
    wire									CDMAControl_IOC_IrqEn_o;
    wire									CDMAControl_Cyclic_BD_Enable_o;
    wire									CDMAControl_Key_Hole_Write_o;
    wire									CDMAControl_Key_Hole_Read_o;
    wire									CDMAControl_SGMode_o;
    wire									CDMAControl_Reset_o;
    //-----------------------
    //#--> addr = 0x0004
    wire									CDMAStatus_Err_Irq_o;
    wire									CDMAStatus_Dly_Irq_o;
    wire									CDMAStatus_IOC_Irq_o;
    //-----------------------
    //#--> addr = 0x0008
    wire	[31:6]							CDMACurDescPntr_Cur_Desc_Pntr_o;
    //-----------------------
    //#--> addr = 0x000c
    wire									CDMACurDescPntrMSB_Cur_Desc_Pntr_o;
    //-----------------------
    //#--> addr = 0x0010
    wire	[31:6]							CDMATailDescPntr_Tail_Desc_Pntr_o;
    //-----------------------
    //#--> addr = 0x0014
    wire	[31:0]							CDMATailDescPntrMSB_Tail_Desc_Pntr_o;
    //-----------------------
    //#--> addr = 0x0018
    wire	[31:0]							CDMASA_Source_Address_o;
    //-----------------------
    //#--> addr = 0x001c
    wire	[31:0]							CDMASAMSB_Source_Address_o;
    //-----------------------
    //#--> addr = 0x0020
    //-----------------------
    //#--> addr = 0x0024
    //-----------------------
    //#--> addr = 0x0028
    wire	[25:0]							CDMABTT_Bytes_To_Transfer_o;
    //-----------------------
    //#--> addr = 0x002c
    //-----------------------
    //#--> addr = 0x0030
    wire									MAINCFG_dma_en_o;
    wire	[7:0]							MAINCFG_ch_int_en_o;
    //-----------------------
    //#--> addr = 0x0034
    //-----------------------
    //#--> addr = 0x0038
    //-----------------------
    //#--> addr = 0x003c
    //-----------------------
    //#--> addr = 0x0040
    wire									CRCH0_sw_reset_o;
    wire	[9:8]							CRCH0_ch_pri_o;
    wire	[7:6]							CRCH0_mode_o;
    wire									CRCH0_inc_des_o;
    wire									CRCH0_inc_src_o;
    wire									CRCH0_done_int_en_o;
    wire									CRCH0_stop_err_int_en_o;
    wire									CRCH0_wtt_err_int_en_o;
    wire									CRCH0_ch_en_o;
    //-----------------------
    //#--> addr = 0x0044
    //-----------------------
    //#--> addr = 0x0048
    wire	[7:0]							TSRCH0_size_o;
    //-----------------------
    //#--> addr = 0x004c
    //-----------------------
    //#--> addr = 0x0050
    wire	[31:0]							SARCH0_sa_o;
    //-----------------------
    //#--> addr = 0x0054
    wire	[31:0]							DARCH0_da_o;
    //-----------------------
    //#--> addr = 0x0060
    wire									CRCH1_sw_reset_o;
    wire	[9:8]							CRCH1_ch_pri_o;
    wire	[7:6]							CRCH1_mode_o;
    wire									CRCH1_inc_des_o;
    wire									CRCH1_inc_src_o;
    wire									CRCH1_done_int_en_o;
    wire									CRCH1_stop_err_int_en_o;
    wire									CRCH1_wtt_err_int_en_o;
    wire									CRCH1_ch_en_o;
    //-----------------------
    //#--> addr = 0x0064
    //-----------------------
    //#--> addr = 0x0068
    wire	[7:0]							TSRCH1_size_o;
    //-----------------------
    //#--> addr = 0x006c
    //-----------------------
    //#--> addr = 0x0070
    wire	[31:0]							SARCH1_sa_o;
    //-----------------------
    //#--> addr = 0x0074
    wire	[31:0]							DARCH1_da_o;
    //-----------------------
    //#--> addr = 0x0080
    wire									CRCH2_sw_reset_o;
    wire	[9:8]							CRCH2_ch_pri_o;
    wire	[7:6]							CRCH2_mode_o;
    wire									CRCH2_inc_des_o;
    wire									CRCH2_inc_src_o;
    wire									CRCH2_done_int_en_o;
    wire									CRCH2_stop_err_int_en_o;
    wire									CRCH2_wtt_err_int_en_o;
    wire									CRCH2_ch_en_o;
    //-----------------------
    //#--> addr = 0x0084
    //-----------------------
    //#--> addr = 0x0088
    wire	[7:0]							TSRCH2_size_o;
    //-----------------------
    //#--> addr = 0x008c
    //-----------------------
    //#--> addr = 0x0090
    wire	[31:0]							SARCH2_sa_o;
    //-----------------------
    //#--> addr = 0x0094
    wire	[31:0]							DARCH2_da_o;
    //-----------------------
    //#--> addr = 0x00a0
    wire									CRCH3_sw_reset_o;
    wire	[9:8]							CRCH3_ch_pri_o;
    wire	[7:6]							CRCH3_mode_o;
    wire									CRCH3_inc_des_o;
    wire									CRCH3_inc_src_o;
    wire									CRCH3_done_int_en_o;
    wire									CRCH3_stop_err_int_en_o;
    wire									CRCH3_wtt_err_int_en_o;
    wire									CRCH3_ch_en_o;
    //-----------------------
    //#--> addr = 0x00a4
    //-----------------------
    //#--> addr = 0x00a8
    wire	[7:0]							TSRCH3_size_o;
    //-----------------------
    //#--> addr = 0x00ac
    //-----------------------
    //#--> addr = 0x00b0
    wire	[31:0]							SARCH3_sa_o;
    //-----------------------
    //#--> addr = 0x00b4
    wire	[31:0]							DARCH3_da_o;
    //-----------------------
    //#--> addr = 0x00a0
    wire									CRCH4_sw_reset_o;
    wire	[9:8]							CRCH4_ch_pri_o;
    wire	[7:6]							CRCH4_mode_o;
    wire									CRCH4_inc_des_o;
    wire									CRCH4_inc_src_o;
    wire									CRCH4_done_int_en_o;
    wire									CRCH4_stop_err_int_en_o;
    wire									CRCH4_wtt_err_int_en_o;
    wire									CRCH4_ch_en_o;
    //-----------------------
    //#--> addr = 0x00a4
    //-----------------------
    //#--> addr = 0x00a8
    wire	[7:0]							TSRCH4_size_o;
    //-----------------------
    //#--> addr = 0x00ac
    //-----------------------
    //#--> addr = 0x00b0
    wire	[31:0]							SARCH4_sa_o;
    //-----------------------
    //#--> addr = 0x00b4
    wire	[31:0]							DARCH4_da_o;
    //-----------------------
    //#--> addr = 0x00c0
    wire									CRCH5_sw_reset_o;
    wire	[9:8]							CRCH5_ch_pri_o;
    wire	[7:6]							CRCH5_mode_o;
    wire									CRCH5_inc_des_o;
    wire									CRCH5_inc_src_o;
    wire									CRCH5_done_int_en_o;
    wire									CRCH5_stop_err_int_en_o;
    wire									CRCH5_wtt_err_int_en_o;
    wire									CRCH5_ch_en_o;
    //-----------------------
    //#--> addr = 0x00c4
    //-----------------------
    //#--> addr = 0x00c8
    wire	[7:0]							TSRCH5_size_o;
    //-----------------------
    //#--> addr = 0x00cc
    //-----------------------
    //#--> addr = 0x00d0
    wire	[31:0]							SARCH5_sa_o;
    //-----------------------
    //#--> addr = 0x00d4
    wire	[31:0]							DARCH5_da_o;
    //-----------------------
    //#--> addr = 0x00e0
    wire									CRCH6_sw_reset_o;
    wire	[9:8]							CRCH6_ch_pri_o;
    wire	[7:6]							CRCH6_mode_o;
    wire									CRCH6_inc_des_o;
    wire									CRCH6_inc_src_o;
    wire									CRCH6_done_int_en_o;
    wire									CRCH6_stop_err_int_en_o;
    wire									CRCH6_wtt_err_int_en_o;
    wire									CRCH6_ch_en_o;
    //-----------------------
    //#--> addr = 0x00e4
    //-----------------------
    //#--> addr = 0x00e8
    wire	[7:0]							TSRCH6_size_o;
    //-----------------------
    //#--> addr = 0x00ec
    //-----------------------
    //#--> addr = 0x00f0
    wire	[31:0]							SARCH6_sa_o;
    //-----------------------
    //#--> addr = 0x00f4
    wire	[31:0]							DARCH6_da_o;
    //-----------------------
    //#--> addr = 0x0100
    wire									CRCH7_sw_reset_o;
    wire	[9:8]							CRCH7_ch_pri_o;
    wire	[7:6]							CRCH7_mode_o;
    wire									CRCH7_inc_des_o;
    wire									CRCH7_inc_src_o;
    wire									CRCH7_done_int_en_o;
    wire									CRCH7_stop_err_int_en_o;
    wire									CRCH7_wtt_err_int_en_o;
    wire									CRCH7_ch_en_o;
    //-----------------------
    //#--> addr = 0x0104
    //-----------------------
    //#--> addr = 0x0108
    wire	[7:0]							TSRCH7_size_o;
    //-----------------------
    //#--> addr = 0x010c
    //-----------------------
    //#--> addr = 0x0110
    wire	[31:0]							SARCH7_sa_o;
    //-----------------------
    //#--> addr = 0x0114
    wire	[31:0]							DARCH7_da_o;
	
	////////////////////////////////////////////////////////////////////////////
    //testbench reg - wire declaration
    ////////////////////////////////////////////////////////////////////////////
    reg                                     false_enable;
    reg                                     false_flag;
	
	////////////////////////////////////////////////////////////////////////////
    //instance
    ////////////////////////////////////////////////////////////////////////////
    dma_reg inst_dma_reg(
        //-----------------------
        //#--> clk and rstn
        .clk(clk),
        .rstn(rstn),
        //-----------------------
        //#--> regiter interface
        .reg_addr_i(reg_addr_i),
        .reg_wr_en_i(reg_wr_en_i),
        .reg_wr_data_i(reg_wr_data_i),
        .reg_rd_en_i(reg_rd_en_i),
        .reg_rd_data_o(reg_rd_data_o),
        //-----------------------
        //#--> addr = 0x0000
        .CDMAControl_IRQDelay_o(CDMAControl_IRQDelay_o),
        .CDMAControl_IRQThreshold_o(CDMAControl_IRQThreshold_o),
        .CDMAControl_Err_IrqEn_o(CDMAControl_Err_IrqEn_o),
        .CDMAControl_Dly_IrqEn_o(CDMAControl_Dly_IrqEn_o),
        .CDMAControl_IOC_IrqEn_o(CDMAControl_IOC_IrqEn_o),
        .CDMAControl_Cyclic_BD_Enable_o(CDMAControl_Cyclic_BD_Enable_o),
        .CDMAControl_Key_Hole_Write_o(CDMAControl_Key_Hole_Write_o),
        .CDMAControl_Key_Hole_Read_o(CDMAControl_Key_Hole_Read_o),
        .CDMAControl_SGMode_o(CDMAControl_SGMode_o),
        .CDMAControl_Reset_o(CDMAControl_Reset_o),
        //-----------------------
        //#--> addr = 0x0004
        .CDMAStatus_Err_Irq_o(CDMAStatus_Err_Irq_o),
        .CDMAStatus_Dly_Irq_o(CDMAStatus_Dly_Irq_o),
        .CDMAStatus_IOC_Irq_o(CDMAStatus_IOC_Irq_o),
        //-----------------------
        //#--> addr = 0x0008
        .CDMACurDescPntr_Cur_Desc_Pntr_o(CDMACurDescPntr_Cur_Desc_Pntr_o),
        //-----------------------
        //#--> addr = 0x000c
        .CDMACurDescPntrMSB_Cur_Desc_Pntr_o(CDMACurDescPntrMSB_Cur_Desc_Pntr_o),
        //-----------------------
        //#--> addr = 0x0010
        .CDMATailDescPntr_Tail_Desc_Pntr_o(CDMATailDescPntr_Tail_Desc_Pntr_o),
        //-----------------------
        //#--> addr = 0x0014
        .CDMATailDescPntrMSB_Tail_Desc_Pntr_o(CDMATailDescPntrMSB_Tail_Desc_Pntr_o),
        //-----------------------
        //#--> addr = 0x0018
        .CDMASA_Source_Address_o(CDMASA_Source_Address_o),
        //-----------------------
        //#--> addr = 0x001c
        .CDMASAMSB_Source_Address_o(CDMASAMSB_Source_Address_o),
        //-----------------------
        //#--> addr = 0x0020
        //-----------------------
        //#--> addr = 0x0024
        //-----------------------
        //#--> addr = 0x0028
        .CDMABTT_Bytes_To_Transfer_o(CDMABTT_Bytes_To_Transfer_o),
        //-----------------------
        //#--> addr = 0x002c
        //-----------------------
        //#--> addr = 0x0030
        .MAINCFG_dma_en_o(MAINCFG_dma_en_o),
        .MAINCFG_ch_int_en_o(MAINCFG_ch_int_en_o),
        //-----------------------
        //#--> addr = 0x0034
        //-----------------------
        //#--> addr = 0x0038
        //-----------------------
        //#--> addr = 0x003c
        //-----------------------
        //#--> addr = 0x0040
        .CRCH0_sw_reset_o(CRCH0_sw_reset_o),
        .CRCH0_ch_pri_o(CRCH0_ch_pri_o),
        .CRCH0_mode_o(CRCH0_mode_o),
        .CRCH0_inc_des_o(CRCH0_inc_des_o),
        .CRCH0_inc_src_o(CRCH0_inc_src_o),
        .CRCH0_done_int_en_o(CRCH0_done_int_en_o),
        .CRCH0_stop_err_int_en_o(CRCH0_stop_err_int_en_o),
        .CRCH0_wtt_err_int_en_o(CRCH0_wtt_err_int_en_o),
        .CRCH0_ch_en_o(CRCH0_ch_en_o),
        //-----------------------
        //#--> addr = 0x0044
        //-----------------------
        //#--> addr = 0x0048
        .TSRCH0_size_o(TSRCH0_size_o),
        //-----------------------
        //#--> addr = 0x004c
        //-----------------------
        //#--> addr = 0x0050
        .SARCH0_sa_o(SARCH0_sa_o),
        //-----------------------
        //#--> addr = 0x0054
        .DARCH0_da_o(DARCH0_da_o),
        //-----------------------
        //#--> addr = 0x0060
        .CRCH1_sw_reset_o(CRCH1_sw_reset_o),
        .CRCH1_ch_pri_o(CRCH1_ch_pri_o),
        .CRCH1_mode_o(CRCH1_mode_o),
        .CRCH1_inc_des_o(CRCH1_inc_des_o),
        .CRCH1_inc_src_o(CRCH1_inc_src_o),
        .CRCH1_done_int_en_o(CRCH1_done_int_en_o),
        .CRCH1_stop_err_int_en_o(CRCH1_stop_err_int_en_o),
        .CRCH1_wtt_err_int_en_o(CRCH1_wtt_err_int_en_o),
        .CRCH1_ch_en_o(CRCH1_ch_en_o),
        //-----------------------
        //#--> addr = 0x0064
        //-----------------------
        //#--> addr = 0x0068
        .TSRCH1_size_o(TSRCH1_size_o),
        //-----------------------
        //#--> addr = 0x006c
        //-----------------------
        //#--> addr = 0x0070
        .SARCH1_sa_o(SARCH1_sa_o),
        //-----------------------
        //#--> addr = 0x0074
        .DARCH1_da_o(DARCH1_da_o),
        //-----------------------
        //#--> addr = 0x0080
        .CRCH2_sw_reset_o(CRCH2_sw_reset_o),
        .CRCH2_ch_pri_o(CRCH2_ch_pri_o),
        .CRCH2_mode_o(CRCH2_mode_o),
        .CRCH2_inc_des_o(CRCH2_inc_des_o),
        .CRCH2_inc_src_o(CRCH2_inc_src_o),
        .CRCH2_done_int_en_o(CRCH2_done_int_en_o),
        .CRCH2_stop_err_int_en_o(CRCH2_stop_err_int_en_o),
        .CRCH2_wtt_err_int_en_o(CRCH2_wtt_err_int_en_o),
        .CRCH2_ch_en_o(CRCH2_ch_en_o),
        //-----------------------
        //#--> addr = 0x0084
        //-----------------------
        //#--> addr = 0x0088
        .TSRCH2_size_o(TSRCH2_size_o),
        //-----------------------
        //#--> addr = 0x008c
        //-----------------------
        //#--> addr = 0x0090
        .SARCH2_sa_o(SARCH2_sa_o),
        //-----------------------
        //#--> addr = 0x0094
        .DARCH2_da_o(DARCH2_da_o),
        //-----------------------
        //#--> addr = 0x00a0
        .CRCH3_sw_reset_o(CRCH3_sw_reset_o),
        .CRCH3_ch_pri_o(CRCH3_ch_pri_o),
        .CRCH3_mode_o(CRCH3_mode_o),
        .CRCH3_inc_des_o(CRCH3_inc_des_o),
        .CRCH3_inc_src_o(CRCH3_inc_src_o),
        .CRCH3_done_int_en_o(CRCH3_done_int_en_o),
        .CRCH3_stop_err_int_en_o(CRCH3_stop_err_int_en_o),
        .CRCH3_wtt_err_int_en_o(CRCH3_wtt_err_int_en_o),
        .CRCH3_ch_en_o(CRCH3_ch_en_o),
        //-----------------------
        //#--> addr = 0x00a4
        //-----------------------
        //#--> addr = 0x00a8
        .TSRCH3_size_o(TSRCH3_size_o),
        //-----------------------
        //#--> addr = 0x00ac
        //-----------------------
        //#--> addr = 0x00b0
        .SARCH3_sa_o(SARCH3_sa_o),
        //-----------------------
        //#--> addr = 0x00b4
        .DARCH3_da_o(DARCH3_da_o),
        //-----------------------
        //#--> addr = 0x00a0
        .CRCH4_sw_reset_o(CRCH4_sw_reset_o),
        .CRCH4_ch_pri_o(CRCH4_ch_pri_o),
        .CRCH4_mode_o(CRCH4_mode_o),
        .CRCH4_inc_des_o(CRCH4_inc_des_o),
        .CRCH4_inc_src_o(CRCH4_inc_src_o),
        .CRCH4_done_int_en_o(CRCH4_done_int_en_o),
        .CRCH4_stop_err_int_en_o(CRCH4_stop_err_int_en_o),
        .CRCH4_wtt_err_int_en_o(CRCH4_wtt_err_int_en_o),
        .CRCH4_ch_en_o(CRCH4_ch_en_o),
        //-----------------------
        //#--> addr = 0x00a4
        //-----------------------
        //#--> addr = 0x00a8
        .TSRCH4_size_o(TSRCH4_size_o),
        //-----------------------
        //#--> addr = 0x00ac
        //-----------------------
        //#--> addr = 0x00b0
        .SARCH4_sa_o(SARCH4_sa_o),
        //-----------------------
        //#--> addr = 0x00b4
        .DARCH4_da_o(DARCH4_da_o),
        //-----------------------
        //#--> addr = 0x00c0
        .CRCH5_sw_reset_o(CRCH5_sw_reset_o),
        .CRCH5_ch_pri_o(CRCH5_ch_pri_o),
        .CRCH5_mode_o(CRCH5_mode_o),
        .CRCH5_inc_des_o(CRCH5_inc_des_o),
        .CRCH5_inc_src_o(CRCH5_inc_src_o),
        .CRCH5_done_int_en_o(CRCH5_done_int_en_o),
        .CRCH5_stop_err_int_en_o(CRCH5_stop_err_int_en_o),
        .CRCH5_wtt_err_int_en_o(CRCH5_wtt_err_int_en_o),
        .CRCH5_ch_en_o(CRCH5_ch_en_o),
        //-----------------------
        //#--> addr = 0x00c4
        //-----------------------
        //#--> addr = 0x00c8
        .TSRCH5_size_o(TSRCH5_size_o),
        //-----------------------
        //#--> addr = 0x00cc
        //-----------------------
        //#--> addr = 0x00d0
        .SARCH5_sa_o(SARCH5_sa_o),
        //-----------------------
        //#--> addr = 0x00d4
        .DARCH5_da_o(DARCH5_da_o),
        //-----------------------
        //#--> addr = 0x00e0
        .CRCH6_sw_reset_o(CRCH6_sw_reset_o),
        .CRCH6_ch_pri_o(CRCH6_ch_pri_o),
        .CRCH6_mode_o(CRCH6_mode_o),
        .CRCH6_inc_des_o(CRCH6_inc_des_o),
        .CRCH6_inc_src_o(CRCH6_inc_src_o),
        .CRCH6_done_int_en_o(CRCH6_done_int_en_o),
        .CRCH6_stop_err_int_en_o(CRCH6_stop_err_int_en_o),
        .CRCH6_wtt_err_int_en_o(CRCH6_wtt_err_int_en_o),
        .CRCH6_ch_en_o(CRCH6_ch_en_o),
        //-----------------------
        //#--> addr = 0x00e4
        //-----------------------
        //#--> addr = 0x00e8
        .TSRCH6_size_o(TSRCH6_size_o),
        //-----------------------
        //#--> addr = 0x00ec
        //-----------------------
        //#--> addr = 0x00f0
        .SARCH6_sa_o(SARCH6_sa_o),
        //-----------------------
        //#--> addr = 0x00f4
        .DARCH6_da_o(DARCH6_da_o),
        //-----------------------
        //#--> addr = 0x0100
        .CRCH7_sw_reset_o(CRCH7_sw_reset_o),
        .CRCH7_ch_pri_o(CRCH7_ch_pri_o),
        .CRCH7_mode_o(CRCH7_mode_o),
        .CRCH7_inc_des_o(CRCH7_inc_des_o),
        .CRCH7_inc_src_o(CRCH7_inc_src_o),
        .CRCH7_done_int_en_o(CRCH7_done_int_en_o),
        .CRCH7_stop_err_int_en_o(CRCH7_stop_err_int_en_o),
        .CRCH7_wtt_err_int_en_o(CRCH7_wtt_err_int_en_o),
        .CRCH7_ch_en_o(CRCH7_ch_en_o),
        //-----------------------
        //#--> addr = 0x0104
        //-----------------------
        //#--> addr = 0x0108
        .TSRCH7_size_o(TSRCH7_size_o),
        //-----------------------
        //#--> addr = 0x010c
        //-----------------------
        //#--> addr = 0x0110
        .SARCH7_sa_o(SARCH7_sa_o),
        //-----------------------
        //#--> addr = 0x0114
        .DARCH7_da_o(DARCH7_da_o)
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
        
        //-----------------------
        //write path
        //#--> addr = 0000
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0000;
        reg_wr_data_i = 32'b11001110011010000011000000000110;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0004
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0004;
        reg_wr_data_i = 32'b00000000000000010111000000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0008
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0008;
        reg_wr_data_i = 32'b10111110011010101010110000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 000c
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h000c;
        reg_wr_data_i = 32'b0;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0010
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0010;
        reg_wr_data_i = 32'b00101111010110010010111011000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0014
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0014;
        reg_wr_data_i = 32'b10000101100100111000011101111001;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0018
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0018;
        reg_wr_data_i = 32'b10100001110000000101001010000100;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 001c
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h001c;
        reg_wr_data_i = 32'b01100111100110101101101010101101;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0020
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0020;
        reg_wr_data_i = 32'b00000000000000000000000000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0024
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0024;
        reg_wr_data_i = 32'b00000000000000000000000000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0028
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0028;
        reg_wr_data_i = 32'b00000010010111100111001011110010;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 002c
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h002c;
        reg_wr_data_i = 32'b00000000000000000000000000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0030
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0030;
        reg_wr_data_i = 32'b00000000000000000000000011111011;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0034
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0034;
        reg_wr_data_i = 32'b00000000000000000000000000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0038
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0038;
        reg_wr_data_i = 32'b00000000000000000000000000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 003c
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h003c;
        reg_wr_data_i = 32'b00000000000000000000000000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0040
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0040;
        reg_wr_data_i = 32'b00000000000000000000001101001010;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0044
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0044;
        reg_wr_data_i = 32'b00000000000000000000000000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0048
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0048;
        reg_wr_data_i = 32'b00000000000000000000000000100110;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 004c
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h004c;
        reg_wr_data_i = 32'b00000000000000000000000000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0050
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0050;
        reg_wr_data_i = 32'b00011100110110011011111001101001;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0054
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0054;
        reg_wr_data_i = 32'b11011100111011001000000001001011;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0060
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0060;
        reg_wr_data_i = 32'b00000000000000000000001011101000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0064
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0064;
        reg_wr_data_i = 32'b00000000000000000000000000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0068
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0068;
        reg_wr_data_i = 32'b00000000000000000000000010111000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 006c
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h006c;
        reg_wr_data_i = 32'b00000000000000000000000000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0070
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0070;
        reg_wr_data_i = 32'b10001100100011110001111011011001;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0074
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0074;
        reg_wr_data_i = 32'b11001010001001101100101001000011;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0080
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0080;
        reg_wr_data_i = 32'b00000000000000000000000010011000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0084
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0084;
        reg_wr_data_i = 32'b00000000000000000000000000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0088
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0088;
        reg_wr_data_i = 32'b00000000000000000000000000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 008c
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h008c;
        reg_wr_data_i = 32'b00000000000000000000000000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0090
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0090;
        reg_wr_data_i = 32'b11111110100111100010100011101011;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0094
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0094;
        reg_wr_data_i = 32'b11010000010001111000110011110100;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 00a0
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00a0;
        reg_wr_data_i = 32'b00000000000000000000011111010110;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 00a4
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00a4;
        reg_wr_data_i = 32'b00000000000000000000000000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 00a8
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00a8;
        reg_wr_data_i = 32'b00000000000000000000000001110100;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 00ac
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00ac;
        reg_wr_data_i = 32'b00000000000000000000000000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 00b0
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00b0;
        reg_wr_data_i = 32'b01011101100100001101110010101111;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 00b4
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00b4;
        reg_wr_data_i = 32'b01101110100001010000110000100101;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 00a0
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00a0;
        reg_wr_data_i = 32'b00000000000000000000011111010110;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 00a4
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00a4;
        reg_wr_data_i = 32'b00000000000000000000000000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 00a8
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00a8;
        reg_wr_data_i = 32'b00000000000000000000000001110100;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 00ac
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00ac;
        reg_wr_data_i = 32'b00000000000000000000000000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 00b0
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00b0;
        reg_wr_data_i = 32'b01011101100100001101110010101111;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 00b4
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00b4;
        reg_wr_data_i = 32'b01101110100001010000110000100101;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 00c0
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00c0;
        reg_wr_data_i = 32'b00000000000000000000011100100111;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 00c4
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00c4;
        reg_wr_data_i = 32'b00000000000000000000000000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 00c8
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00c8;
        reg_wr_data_i = 32'b00000000000000000000000001101010;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 00cc
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00cc;
        reg_wr_data_i = 32'b00000000000000000000000000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 00d0
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00d0;
        reg_wr_data_i = 32'b10111000000100111101110011010111;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 00d4
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00d4;
        reg_wr_data_i = 32'b11101101110111110110110000110011;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 00e0
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00e0;
        reg_wr_data_i = 32'b00000000000000000000001001011100;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 00e4
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00e4;
        reg_wr_data_i = 32'b00000000000000000000000000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 00e8
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00e8;
        reg_wr_data_i = 32'b00000000000000000000000000010001;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 00ec
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00ec;
        reg_wr_data_i = 32'b00000000000000000000000000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 00f0
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00f0;
        reg_wr_data_i = 32'b11001000111111000110010110010110;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 00f4
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00f4;
        reg_wr_data_i = 32'b11000110011101111010000001111100;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0100
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0100;
        reg_wr_data_i = 32'b00000000000000000000000101101100;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0104
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0104;
        reg_wr_data_i = 32'b00000000000000000000000000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0108
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0108;
        reg_wr_data_i = 32'b00000000000000000000000000000011;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 010c
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h010c;
        reg_wr_data_i = 32'b00000000000000000000000000000000;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0110
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0110;
        reg_wr_data_i = 32'b11100111100110111101001100000001;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //write path
        //#--> addr = 0114
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0114;
        reg_wr_data_i = 32'b10001101100110010000001001100111;
        #(0.5*CLK_PERIOD) reg_wr_en_i = 1'b1;
        #(1*CLK_PERIOD) reg_wr_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0000
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0000;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CDMAControl(reg_rd_data_o, 32'b11001110011010000011000000000110, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0004
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0004;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CDMAStatus(reg_rd_data_o, 32'b00000000000000010111000000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0008
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0008;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CDMACurDescPntr(reg_rd_data_o, 32'b10111110011010101010110000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 000c
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h000c;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CDMACurDescPntrMSB(reg_rd_data_o, 32'b0, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0010
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0010;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CDMATailDescPntr(reg_rd_data_o, 32'b00101111010110010010111011000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0014
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0014;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CDMATailDescPntrMSB(reg_rd_data_o, 32'b10000101100100111000011101111001, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0018
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0018;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CDMASA(reg_rd_data_o, 32'b10100001110000000101001010000100, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 001c
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h001c;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CDMASAMSB(reg_rd_data_o, 32'b01100111100110101101101010101101, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0020
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0020;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CDMADA(reg_rd_data_o, 32'b00000000000000000000000000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0024
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0024;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CDMADAMSB(reg_rd_data_o, 32'b00000000000000000000000000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0028
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0028;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CDMABTT(reg_rd_data_o, 32'b00000010010111100111001011110010, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 002c
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h002c;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CDMARSV(reg_rd_data_o, 32'b00000000000000000000000000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0030
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0030;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_MAINCFG(reg_rd_data_o, 32'b00000000000000000000000011111011, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0034
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0034;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_MAINDMASTT(reg_rd_data_o, 32'b00000000000000000000000000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0038
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0038;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_MAINRSV0(reg_rd_data_o, 32'b00000000000000000000000000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 003c
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h003c;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_MAINRSV1(reg_rd_data_o, 32'b00000000000000000000000000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0040
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0040;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CRCH0(reg_rd_data_o, 32'b00000000000000000000001101001010, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0044
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0044;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_SRCH0(reg_rd_data_o, 32'b00000000000000000000000000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0048
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0048;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_TSRCH0(reg_rd_data_o, 32'b00000000000000000000000000100110, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 004c
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h004c;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CDPRCH0(reg_rd_data_o, 32'b00000000000000000000000000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0050
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0050;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_SARCH0(reg_rd_data_o, 32'b00011100110110011011111001101001, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0054
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0054;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_DARCH0(reg_rd_data_o, 32'b11011100111011001000000001001011, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0060
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0060;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CRCH1(reg_rd_data_o, 32'b00000000000000000000001011101000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0064
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0064;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_SRCH1(reg_rd_data_o, 32'b00000000000000000000000000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0068
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0068;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_TSRCH1(reg_rd_data_o, 32'b00000000000000000000000010111000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 006c
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h006c;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CDPRCH1(reg_rd_data_o, 32'b00000000000000000000000000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0070
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0070;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_SARCH1(reg_rd_data_o, 32'b10001100100011110001111011011001, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0074
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0074;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_DARCH1(reg_rd_data_o, 32'b11001010001001101100101001000011, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0080
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0080;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CRCH2(reg_rd_data_o, 32'b00000000000000000000000010011000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0084
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0084;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_SRCH2(reg_rd_data_o, 32'b00000000000000000000000000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0088
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0088;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_TSRCH2(reg_rd_data_o, 32'b00000000000000000000000000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 008c
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h008c;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CDPRCH2(reg_rd_data_o, 32'b00000000000000000000000000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0090
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0090;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_SARCH2(reg_rd_data_o, 32'b11111110100111100010100011101011, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0094
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0094;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_DARCH2(reg_rd_data_o, 32'b11010000010001111000110011110100, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 00a0
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00a0;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CRCH3(reg_rd_data_o, 32'b00000000000000000000011111010110, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 00a4
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00a4;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_SRCH3(reg_rd_data_o, 32'b00000000000000000000000000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 00a8
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00a8;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_TSRCH3(reg_rd_data_o, 32'b00000000000000000000000001110100, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 00ac
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00ac;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CDPRCH3(reg_rd_data_o, 32'b00000000000000000000000000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 00b0
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00b0;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_SARCH3(reg_rd_data_o, 32'b01011101100100001101110010101111, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 00b4
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00b4;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_DARCH3(reg_rd_data_o, 32'b01101110100001010000110000100101, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 00a0
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00a0;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CRCH4(reg_rd_data_o, 32'b00000000000000000000011111010110, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 00a4
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00a4;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_SRCH4(reg_rd_data_o, 32'b00000000000000000000000000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 00a8
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00a8;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_TSRCH4(reg_rd_data_o, 32'b00000000000000000000000001110100, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 00ac
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00ac;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CDPRCH4(reg_rd_data_o, 32'b00000000000000000000000000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 00b0
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00b0;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_SARCH4(reg_rd_data_o, 32'b01011101100100001101110010101111, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 00b4
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00b4;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_DARCH4(reg_rd_data_o, 32'b01101110100001010000110000100101, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 00c0
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00c0;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CRCH5(reg_rd_data_o, 32'b00000000000000000000011100100111, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 00c4
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00c4;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_SRCH5(reg_rd_data_o, 32'b00000000000000000000000000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 00c8
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00c8;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_TSRCH5(reg_rd_data_o, 32'b00000000000000000000000001101010, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 00cc
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00cc;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CDPRCH5(reg_rd_data_o, 32'b00000000000000000000000000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 00d0
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00d0;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_SARCH5(reg_rd_data_o, 32'b10111000000100111101110011010111, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 00d4
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00d4;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_DARCH5(reg_rd_data_o, 32'b11101101110111110110110000110011, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 00e0
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00e0;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CRCH6(reg_rd_data_o, 32'b00000000000000000000001001011100, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 00e4
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00e4;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_SRCH6(reg_rd_data_o, 32'b00000000000000000000000000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 00e8
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00e8;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_TSRCH6(reg_rd_data_o, 32'b00000000000000000000000000010001, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 00ec
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00ec;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CDPRCH6(reg_rd_data_o, 32'b00000000000000000000000000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 00f0
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00f0;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_SARCH6(reg_rd_data_o, 32'b11001000111111000110010110010110, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 00f4
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h00f4;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_DARCH6(reg_rd_data_o, 32'b11000110011101111010000001111100, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0100
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0100;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CRCH7(reg_rd_data_o, 32'b00000000000000000000000101101100, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0104
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0104;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_SRCH7(reg_rd_data_o, 32'b00000000000000000000000000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0108
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0108;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_TSRCH7(reg_rd_data_o, 32'b00000000000000000000000000000011, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 010c
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h010c;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_CDPRCH7(reg_rd_data_o, 32'b00000000000000000000000000000000, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0110
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0110;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_SARCH7(reg_rd_data_o, 32'b11100111100110111101001100000001, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

        //-----------------------
        //read path
        //#--> addr = 0114
        #(0.5*CLK_PERIOD);
        reg_addr_i = 16'h0114;
        #(0.5*CLK_PERIOD) reg_rd_en_i = 1'b1;
        #(1*CLK_PERIOD);
        report_DARCH7(reg_rd_data_o, 32'b10001101100110010000001001100111, false_enable);
        reg_rd_en_i = 1'b0;
        #(1*CLK_PERIOD);

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
    //-----------------------
    //report path
    //#--> addr = 0000
    task report_CDMAControl;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0000 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0000 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0004
    task report_CDMAStatus;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0004 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0004 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0008
    task report_CDMACurDescPntr;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0008 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0008 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 000c
    task report_CDMACurDescPntrMSB;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 000c %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 000c %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0010
    task report_CDMATailDescPntr;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0010 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0010 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0014
    task report_CDMATailDescPntrMSB;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0014 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0014 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0018
    task report_CDMASA;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0018 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0018 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 001c
    task report_CDMASAMSB;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 001c %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 001c %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0020
    task report_CDMADA;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0020 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0020 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0024
    task report_CDMADAMSB;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0024 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0024 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0028
    task report_CDMABTT;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0028 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0028 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 002c
    task report_CDMARSV;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 002c %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 002c %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0030
    task report_MAINCFG;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0030 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0030 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0034
    task report_MAINDMASTT;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0034 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0034 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0038
    task report_MAINRSV0;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0038 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0038 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 003c
    task report_MAINRSV1;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 003c %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 003c %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0040
    task report_CRCH0;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0040 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0040 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0044
    task report_SRCH0;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0044 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0044 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0048
    task report_TSRCH0;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0048 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0048 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 004c
    task report_CDPRCH0;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 004c %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 004c %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0050
    task report_SARCH0;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0050 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0050 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0054
    task report_DARCH0;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0054 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0054 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0060
    task report_CRCH1;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0060 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0060 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0064
    task report_SRCH1;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0064 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0064 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0068
    task report_TSRCH1;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0068 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0068 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 006c
    task report_CDPRCH1;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 006c %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 006c %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0070
    task report_SARCH1;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0070 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0070 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0074
    task report_DARCH1;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0074 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0074 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0080
    task report_CRCH2;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0080 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0080 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0084
    task report_SRCH2;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0084 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0084 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0088
    task report_TSRCH2;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0088 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0088 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 008c
    task report_CDPRCH2;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 008c %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 008c %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0090
    task report_SARCH2;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0090 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0090 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0094
    task report_DARCH2;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0094 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0094 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 00a0
    task report_CRCH3;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 00a0 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 00a0 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 00a4
    task report_SRCH3;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 00a4 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 00a4 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 00a8
    task report_TSRCH3;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 00a8 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 00a8 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 00ac
    task report_CDPRCH3;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 00ac %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 00ac %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 00b0
    task report_SARCH3;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 00b0 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 00b0 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 00b4
    task report_DARCH3;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 00b4 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 00b4 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 00a0
    task report_CRCH4;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 00a0 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 00a0 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 00a4
    task report_SRCH4;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 00a4 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 00a4 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 00a8
    task report_TSRCH4;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 00a8 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 00a8 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 00ac
    task report_CDPRCH4;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 00ac %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 00ac %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 00b0
    task report_SARCH4;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 00b0 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 00b0 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 00b4
    task report_DARCH4;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 00b4 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 00b4 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 00c0
    task report_CRCH5;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 00c0 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 00c0 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 00c4
    task report_SRCH5;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 00c4 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 00c4 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 00c8
    task report_TSRCH5;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 00c8 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 00c8 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 00cc
    task report_CDPRCH5;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 00cc %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 00cc %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 00d0
    task report_SARCH5;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 00d0 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 00d0 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 00d4
    task report_DARCH5;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 00d4 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 00d4 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 00e0
    task report_CRCH6;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 00e0 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 00e0 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 00e4
    task report_SRCH6;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 00e4 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 00e4 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 00e8
    task report_TSRCH6;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 00e8 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 00e8 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 00ec
    task report_CDPRCH6;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 00ec %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 00ec %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 00f0
    task report_SARCH6;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 00f0 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 00f0 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 00f4
    task report_DARCH6;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 00f4 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 00f4 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0100
    task report_CRCH7;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0100 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0100 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0104
    task report_SRCH7;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0104 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0104 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0108
    task report_TSRCH7;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0108 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0108 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 010c
    task report_CDPRCH7;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 010c %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 010c %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0110
    task report_SARCH7;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0110 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0110 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

    //-----------------------
    //report path
    //#--> addr = 0114
    task report_DARCH7;
        input [DATA_WIDTH-1:0] reg_rd_data_o;
        input [DATA_WIDTH-1:0] written_data;
        output false_enable;
        begin
            //tag addr reg_rd_data_o written_data checker
            if(reg_rd_data_o == written_data) begin
                $display("all_reg 0114 %h %h TRUE", reg_rd_data_o, written_data);
                false_enable = 1'b0;
            end else begin
                $display("all_reg 0114 %h %h FALSE", reg_rd_data_o, written_data);
                false_enable = 1'b1;
            end
        end
    endtask

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