onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /deserializer_tb/clk_i
add wave -noupdate /deserializer_tb/srst_i
add wave -noupdate -divider Serializer
add wave -noupdate /deserializer_tb/ser_data_val
add wave -noupdate /deserializer_tb/ser_data_mod
add wave -noupdate /deserializer_tb/ser_data
add wave -noupdate /deserializer_tb/ser_busy
add wave -noupdate -divider Deserializer
add wave -noupdate /deserializer_tb/des_data_val
add wave -noupdate /deserializer_tb/des_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {115000 ps} 0}
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
WaveRestoreZoom {18750 ps} {392814 ps}
