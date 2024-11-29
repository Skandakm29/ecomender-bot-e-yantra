transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/skand/OneDrive/Desktop/eb_1135_task0/AND_GATE {C:/Users/skand/OneDrive/Desktop/eb_1135_task0/AND_GATE/and_gate.v}

