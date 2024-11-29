transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/skand/OneDrive/Desktop/Ripple_Carry_Adder {C:/Users/skand/OneDrive/Desktop/Ripple_Carry_Adder/full_adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/skand/OneDrive/Desktop/Ripple_Carry_Adder {C:/Users/skand/OneDrive/Desktop/Ripple_Carry_Adder/Ripple_carry_adder.v}

vlog -vlog01compat -work work +incdir+C:/Users/skand/OneDrive/Desktop/Ripple_Carry_Adder {C:/Users/skand/OneDrive/Desktop/Ripple_Carry_Adder/tb_ripple_carry_adder.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_ripple_carry_adder

add wave *
view structure
view signals
run -all
