# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7z007sclg400-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/MOMIJI/Documents/VIVADO_FPGA_Project/FW/FW.cache/wt [current_project]
set_property parent.project_path C:/Users/MOMIJI/Documents/VIVADO_FPGA_Project/FW/FW.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part digilentinc.com:cora-z7-07s:part0:1.1 [current_project]
set_property ip_output_repo c:/Users/MOMIJI/Documents/VIVADO_FPGA_Project/FW/FW.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  C:/Users/MOMIJI/Documents/VIVADO_FPGA_Project/FW/FW.srcs/sources_1/imports/lib/timer1us.vhd
  C:/Users/MOMIJI/Documents/VIVADO_FPGA_Project/FW/FW.srcs/sources_1/new/FW.vhd
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/MOMIJI/Documents/VIVADO_FPGA_Project/FW/FW.srcs/constrs_1/imports/lib/Cora_Z7_07S.xdc
set_property used_in_implementation false [get_files C:/Users/MOMIJI/Documents/VIVADO_FPGA_Project/FW/FW.srcs/constrs_1/imports/lib/Cora_Z7_07S.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top FW -part xc7z007sclg400-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef FW.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file FW_utilization_synth.rpt -pb FW_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
