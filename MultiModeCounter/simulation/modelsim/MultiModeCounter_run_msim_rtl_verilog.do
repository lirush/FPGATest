transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/projects/training/fpga/AIlearning/MultiModeCounter {D:/projects/training/fpga/AIlearning/MultiModeCounter/MultiModeCounter.v}

