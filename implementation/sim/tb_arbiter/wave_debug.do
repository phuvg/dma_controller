onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_arbiter/clk
add wave -noupdate /tb_arbiter/rstn
add wave -noupdate -expand /tb_arbiter/arbiter00/req_i
add wave -noupdate -expand /tb_arbiter/arbiter00/grant_o
add wave -noupdate {/tb_arbiter/arbiter00/\priority_selection__GEN[6]\/decoder_4to16/en_i}
add wave -noupdate {/tb_arbiter/arbiter00/\priority_selection__GEN[6]\/decoder_4to16/in_i}
add wave -noupdate {/tb_arbiter/arbiter00/\priority_selection__GEN[6]\/decoder_4to16/out_o}
add wave -noupdate /tb_arbiter/arbiter00/req_with_priority_level
add wave -noupdate /tb_arbiter/arbiter00/or_priority_result
add wave -noupdate /tb_arbiter/arbiter00/req_en
add wave -noupdate /tb_arbiter/arbiter00/grant_mask
add wave -noupdate /tb_arbiter/arbiter00/set_grant
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {11000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 413
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {42525 ps}
