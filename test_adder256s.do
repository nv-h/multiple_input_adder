vlib work
vmap work work


vcom \
"adder256_256.vhd" \
"adder256_2.vhd" \
"adder256_3.vhd" \
"adder256_4.vhd" \
"test_adder256s.vhd" \


vsim -t 1ps test_adder256s


add wave sim:/test_adder256s/*
add wave -divider "256"
add wave sim:/test_adder256s/adder256_256_inst/*
add wave -divider "2"
add wave sim:/test_adder256s/adder256_2_inst/*
add wave -divider "3"
add wave sim:/test_adder256s/adder256_3_inst/*
add wave -divider "4"
add wave sim:/test_adder256s/adder256_4_inst/*


run -all
