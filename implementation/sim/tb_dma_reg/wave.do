onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_dma_reg/rstn
add wave -noupdate /tb_dma_reg/clk
add wave -noupdate /tb_dma_reg/reg_addr_i
add wave -noupdate /tb_dma_reg/reg_wr_en_i
add wave -noupdate /tb_dma_reg/reg_wr_data_i
add wave -noupdate /tb_dma_reg/reg_rd_en_i
add wave -noupdate /tb_dma_reg/reg_rd_data_o
add wave -noupdate /tb_dma_reg/inst_dma_reg/reg_rd_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {17000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {33600 ps}
