onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /deserializer_tb/clk_i
add wave -noupdate /deserializer_tb/srst_i
add wave -noupdate /deserializer_tb/data_val_i
add wave -noupdate /deserializer_tb/data_i
add wave -noupdate /deserializer_tb/deser_data_val_o
add wave -noupdate -radix hexadecimal /deserializer_tb/deser_data_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {361686 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue right
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
WaveRestoreZoom {0 ps} {383250 ps}
