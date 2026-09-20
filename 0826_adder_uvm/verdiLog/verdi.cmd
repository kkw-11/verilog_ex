simSetSimulator "-vcssv" -exec "./simv" -args
debImport "-dbdir" "./simv.daidir"
wvCreateWindow
wvOpenFile -win $_nWave2 {/home/aedu01/verilog/0826_adder_uvm/wavefsdb}
verdiSetActWin -win $_nWave2
verdiWindowResize -win $_Verdi_1 "693" "352" "1084" "760"
srcHBSelect "uvm_custom_install_recording" -win $_nTrace1
verdiWindowResize -win $_Verdi_1 "693" "352" "1084" "760"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcHBSelect "tb_adder_uvm.a_if" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBDrag -win $_nTrace1
srcHBDrag -win $_nTrace1
srcHBDrag -win $_nTrace1
verdiWindowResize -win $_Verdi_1 "693" "352" "1415" "970"
srcHBDrag -win $_nTrace1
srcTBInvokeSim
verdiSetActWin -dock widgetDock_<Member>
srcTBRunSim
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
verdiSetActWin -dock widgetDock_<Inst._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Local>
verdiDockWidgetSetCurTab -dock widgetDock_<Member>
verdiSetActWin -dock widgetDock_<Member>
verdiDockWidgetSetCurTab -dock widgetDock_<Local>
verdiSetActWin -dock widgetDock_<Local>
verdiWindowResize -win $_Verdi_1 "330" "154" "1802" "1079"
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiSetActWin -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
verdiSetActWin -dock widgetDock_<Inst._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Stack>
verdiSetActWin -dock widgetDock_<Stack>
verdiDockWidgetSetCurTab -dock widgetDock_<Class._Tree>
verdiSetActWin -dock widgetDock_<Class._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Object._Tree>
verdiSetActWin -dock widgetDock_<Object._Tree>
srcTBAddBrkPnt -line 525 -file \
           /tools/synopsys/vcs/W-2024.09-SP1/etc/uvm-1.2/base/uvm_root.svh
srcSelect -win $_nTrace1 -range {521 521 1 6 1 1}
srcTBAddBrkPnt -line 521 -file \
           /tools/synopsys/vcs/W-2024.09-SP1/etc/uvm-1.2/base/uvm_root.svh
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcSelect -win $_nTrace1 -range {520 520 1 3 1 1}
srcTBAddBrkPnt -line 520 -file \
           /tools/synopsys/vcs/W-2024.09-SP1/etc/uvm-1.2/base/uvm_root.svh
srcSelect -win $_nTrace1 -range {520 520 1 3 1 1}
srcTBAddBrkPnt -line 520 -file \
           /tools/synopsys/vcs/W-2024.09-SP1/etc/uvm-1.2/base/uvm_root.svh
srcSelect -win $_nTrace1 -range {518 518 1 12 1 1}
srcTBAddBrkPnt -line 518 -file \
           /tools/synopsys/vcs/W-2024.09-SP1/etc/uvm-1.2/base/uvm_root.svh
srcSelect -win $_nTrace1 -range {515 515 1 3 1 1}
srcTBAddBrkPnt -line 515 -file \
           /tools/synopsys/vcs/W-2024.09-SP1/etc/uvm-1.2/base/uvm_root.svh
srcSelect -win $_nTrace1 -range {518 518 1 12 1 1}
srcTBSetBrkPnt -disable -index 2
srcSelect -win $_nTrace1 -range {521 521 1 6 1 1}
srcTBSetBrkPnt -disable -index 1
verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_adder_uvm.a_if" -win $_nTrace1
srcHBSelect "tb_adder_uvm.a_if" -win $_nTrace1
srcHBSelect "tb_adder_uvm.a_if" -win $_nTrace1
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiSetActWin -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Stack>
verdiSetActWin -dock widgetDock_<Stack>
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
verdiSetActWin -dock widgetDock_<Inst._Tree>
verdiDockWidgetSetCurTab -dock windowDock_OneSearch
verdiSetActWin -win $_OneSearch
verdiDockWidgetSetCurTab -dock widgetDock_<Message>
verdiSetActWin -dock widgetDock_<Message>
verdiDockWidgetSetCurTab -dock windowDock_nWave_2
verdiDockWidgetSetCurTab -dock windowDock_InteractiveConsole_3
verdiSetActWin -win $_InteractiveConsole_3
verdiDockWidgetSetCurTab -dock windowDock_nWave_2
verdiSetActWin -win $_nWave2
wvScrollDown -win $_nWave2 0
srcHBDrag -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
wvDumpScope "tb_adder_uvm.a_if"
wvSetPosition -win $_nWave2 {("a_if(adder_if)" 0)}
wvRenameGroup -win $_nWave2 {G1} {a_if(adder_if)}
wvAddSignal -win $_nWave2 "/tb_adder_uvm/a_if/clk" "/tb_adder_uvm/a_if/a\[7:0\]" \
           "/tb_adder_uvm/a_if/b\[7:0\]" "/tb_adder_uvm/a_if/y\[8:0\]"
wvSetPosition -win $_nWave2 {("a_if(adder_if)" 0)}
wvSetPosition -win $_nWave2 {("a_if(adder_if)" 4)}
wvSetPosition -win $_nWave2 {("a_if(adder_if)" 4)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetCursor -win $_nWave2 995000.772517 -snap {("G2" 0)}
verdiSetActWin -win $_nWave2
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
verdiSetActWin -dock widgetDock_<Watch>
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 994998.319744 -snap {("G2" 0)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSelectSignal -win $_nWave2 {( "a_if(adder_if)" 1 )} 
wvSelectSignal -win $_nWave2 {( "a_if(adder_if)" 1 2 3 4 )} 
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvAddGroup -win $_nWave2 {G3}
verdiDockWidgetSetCurTab -dock windowDock_InteractiveConsole_3
verdiSetActWin -win $_InteractiveConsole_3
verdiDockWidgetSetCurTab -dock windowDock_nWave_2
verdiSetActWin -win $_nWave2
verdiDockWidgetSetCurTab -dock windowDock_InteractiveConsole_3
verdiSetActWin -win $_InteractiveConsole_3
verdiDockWidgetSetCurTab -dock widgetDock_<Member>
verdiSetActWin -dock widgetDock_<Member>
verdiDockWidgetSetCurTab -dock widgetDock_<Local>
verdiSetActWin -dock widgetDock_<Local>
verdiDockWidgetSetCurTab -dock widgetDock_<Class._Tree>
verdiSetActWin -dock widgetDock_<Class._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Stack>
verdiSetActWin -dock widgetDock_<Stack>
verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
verdiSetActWin -dock widgetDock_<Inst._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiSetActWin -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Stack>
verdiDockWidgetSetCurTab -dock widgetDock_<Class._Tree>
verdiSetActWin -dock widgetDock_<Class._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Object._Tree>
verdiSetActWin -dock widgetDock_<Object._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Class._Tree>
verdiSetActWin -dock widgetDock_<Class._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiSetActWin -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Stack>
verdiSetActWin -dock widgetDock_<Stack>
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiSetActWin -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
verdiSetActWin -dock widgetDock_<Inst._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiSetActWin -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
verdiSetActWin -dock widgetDock_<Inst._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiSetActWin -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Stack>
verdiSetActWin -dock widgetDock_<Stack>
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiSetActWin -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
verdiSetActWin -dock widgetDock_<Inst._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Member>
verdiSetActWin -dock widgetDock_<Member>
verdiDockWidgetSetCurTab -dock widgetDock_<Local>
verdiSetActWin -dock widgetDock_<Local>
verdiDockWidgetSetCurTab -dock widgetDock_<Class._Tree>
verdiSetActWin -dock widgetDock_<Class._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Object._Tree>
verdiSetActWin -dock widgetDock_<Object._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
verdiSetActWin -dock widgetDock_<Inst._Tree>
verdiSetActWin -win $_InteractiveConsole_3
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcHBSelect "tb_adder_uvm.a_if" -win $_nTrace1
srcSetScope "tb_adder_uvm.a_if" -delim "." -win $_nTrace1
srcHBSelect "tb_adder_uvm.a_if" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcSelect -win $_nTrace1 -range {241 241 1 6 1 1}
srcTBAddBrkPnt -line 241 -file \
           /home/aedu01/verilog/0826_adder_uvm/testbench/tb_adder_uvm.sv
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcTBAddBrkPnt -line 242 -file \
           /home/aedu01/verilog/0826_adder_uvm/testbench/tb_adder_uvm.sv
srcSelect -win $_nTrace1 -range {243 243 1 24 1 1}
srcTBAddBrkPnt -line 243 -file \
           /home/aedu01/verilog/0826_adder_uvm/testbench/tb_adder_uvm.sv
srcSelect -win $_nTrace1 -range {244 244 1 10 1 1}
srcTBAddBrkPnt -line 244 -file \
           /home/aedu01/verilog/0826_adder_uvm/testbench/tb_adder_uvm.sv
srcTBSimReset
srcSelect -win $_nTrace1 -range {28 28 1 6 1 1}
srcTBAddBrkPnt -line 28 -file \
           /tools/synopsys/vcs/W-2024.09-SP1/etc/uvm-1.2/uvm_pkg.sv
srcSelect -win $_nTrace1 -range {28 28 1 6 1 1}
srcTBAddBrkPnt -line 28 -file \
           /tools/synopsys/vcs/W-2024.09-SP1/etc/uvm-1.2/uvm_pkg.sv
srcSelect -win $_nTrace1 -range {28 28 1 6 1 1}
srcTBAddBrkPnt -line 28 -file \
           /tools/synopsys/vcs/W-2024.09-SP1/etc/uvm-1.2/uvm_pkg.sv
srcSelect -win $_nTrace1 -range {28 28 1 6 1 1}
srcTBAddBrkPnt -line 28 -file \
           /tools/synopsys/vcs/W-2024.09-SP1/etc/uvm-1.2/uvm_pkg.sv
srcSelect -win $_nTrace1 -range {28 28 1 6 1 1}
srcTBAddBrkPnt -line 28 -file \
           /tools/synopsys/vcs/W-2024.09-SP1/etc/uvm-1.2/uvm_pkg.sv
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcHBSelect "tb_adder_uvm.a_if" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_adder_uvm.a_if" -win $_nTrace1
srcSetScope "tb_adder_uvm.a_if" -delim "." -win $_nTrace1
srcHBSelect "tb_adder_uvm.a_if" -win $_nTrace1
srcHBSelect "tb_adder_uvm.a_if" -win $_nTrace1
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiDockWidgetSetCurTab -dock windowDock_nWave_2
verdiSetActWin -win $_nWave2
verdiDockWidgetSetCurTab -dock windowDock_OneSearch
verdiSetActWin -win $_OneSearch
verdiDockWidgetSetCurTab -dock windowDock_nWave_2
verdiSetActWin -win $_nWave2
srcTBRunSim
srcSelect -win $_nTrace1 -range {244 244 1 10 1 1}
srcTBSetBrkPnt -disable -index 4
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcSelect -win $_nTrace1 -range {243 243 1 24 1 1}
srcTBSetBrkPnt -disable -index 3
srcSelect -win $_nTrace1 -range {243 243 1 24 1 1}
srcTBSetBrkPnt -delete -index 3
srcSelect -win $_nTrace1 -range {244 244 1 10 1 1}
srcTBSetBrkPnt -delete -index 4
srcSelect -win $_nTrace1 -range {244 244 1 10 1 1}
srcTBAddBrkPnt -line 244 -file \
           /home/aedu01/verilog/0826_adder_uvm/testbench/tb_adder_uvm.sv
srcSelect -win $_nTrace1 -range {244 244 1 10 1 1}
srcTBSetBrkPnt -disable -index 5
srcTBRunSim
verdiSetActWin -win $_nWave2
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_adder_uvm.a_if" -win $_nTrace1
srcSetScope "tb_adder_uvm.a_if" -delim "." -win $_nTrace1
srcHBSelect "tb_adder_uvm.a_if" -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcTBAddBrkPnt -line 269 -file \
           /home/aedu01/verilog/0826_adder_uvm/testbench/tb_adder_uvm.sv
srcTBAddBrkPnt -line 269 -file \
           /home/aedu01/verilog/0826_adder_uvm/testbench/tb_adder_uvm.sv
srcTBAddBrkPnt -line 269 -file \
           /home/aedu01/verilog/0826_adder_uvm/testbench/tb_adder_uvm.sv
srcTBAddBrkPnt -line 269 -file \
           /home/aedu01/verilog/0826_adder_uvm/testbench/tb_adder_uvm.sv
srcTBAddBrkPnt -line 269 -file \
           /home/aedu01/verilog/0826_adder_uvm/testbench/tb_adder_uvm.sv
srcDeselectAll -win $_nTrace1
verdiWindowResize -win $_Verdi_1 "330" "154" "1802" "1079"
verdiWindowResize -win $_Verdi_1 "1181" "31" "951" "1360"
verdiWindowResize -win $_Verdi_1 "1292" "51" "1802" "1079"
verdiWindowResize -win $_Verdi_1 "1292" "51" "1802" "1318"
verdiSetActWin -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Stack>
verdiSetActWin -dock widgetDock_<Stack>
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiSetActWin -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Stack>
verdiSetActWin -dock widgetDock_<Stack>
verdiDockWidgetSetCurTab -dock widgetDock_<Class._Tree>
verdiSetActWin -dock widgetDock_<Class._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Object._Tree>
verdiSetActWin -dock widgetDock_<Object._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Class._Tree>
verdiSetActWin -dock widgetDock_<Class._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Stack>
verdiSetActWin -dock widgetDock_<Stack>
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiSetActWin -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
verdiSetActWin -dock widgetDock_<Inst._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Member>
verdiSetActWin -dock widgetDock_<Member>
verdiDockWidgetSetCurTab -dock widgetDock_<Local>
verdiSetActWin -dock widgetDock_<Local>
verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiSetActWin -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
verdiSetActWin -dock widgetDock_<Inst._Tree>
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_<Watch>
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Stack>
verdiSetActWin -dock widgetDock_<Stack>
verdiDockWidgetSetCurTab -dock widgetDock_<Class._Tree>
verdiSetActWin -dock widgetDock_<Class._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Object._Tree>
verdiSetActWin -dock widgetDock_<Object._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiSetActWin -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Stack>
verdiSetActWin -dock widgetDock_<Stack>
verdiDockWidgetSetCurTab -dock widgetDock_<Class._Tree>
verdiSetActWin -dock widgetDock_<Class._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_adder_uvm.a_if" -win $_nTrace1
srcHBSelect "tb_adder_uvm.a_if" -win $_nTrace1
srcSetScope "tb_adder_uvm.a_if" -delim "." -win $_nTrace1
srcHBSelect "tb_adder_uvm.a_if" -win $_nTrace1
srcSelect -win $_nTrace1 -range {37 37 1 7 1 1}
srcTBAddBrkPnt -line 37 -file \
           /home/aedu01/verilog/0826_adder_uvm/testbench/tb_adder_uvm.sv
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("a_if(adder_if)" 0)}
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {41 41 1 7 1 1}
srcTBAddBrkPnt -line 41 -file \
           /home/aedu01/verilog/0826_adder_uvm/testbench/tb_adder_uvm.sv
srcSelect -win $_nTrace1 -range {37 37 1 7 1 1}
srcTBSetBrkPnt -disable -index 6
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {47 47 1 17 1 1}
srcTBAddBrkPnt -line 47 -file \
           /home/aedu01/verilog/0826_adder_uvm/testbench/tb_adder_uvm.sv
srcSelect -win $_nTrace1 -range {48 48 1 7 1 1}
srcTBAddBrkPnt -line 48 -file \
           /home/aedu01/verilog/0826_adder_uvm/testbench/tb_adder_uvm.sv
srcSelect -win $_nTrace1 -range {41 41 1 7 1 1}
srcTBSetBrkPnt -disable -index 7
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {47 47 1 17 1 1}
srcTBSetBrkPnt -disable -index 8
srcSelect -win $_nTrace1 -range {47 47 1 17 1 1}
srcTBSetBrkPnt -delete -index 8
srcSelect -win $_nTrace1 -range {47 47 1 17 1 1}
srcTBAddBrkPnt -line 47 -file \
           /home/aedu01/verilog/0826_adder_uvm/testbench/tb_adder_uvm.sv
srcTBSimReset
srcHBSelect "uvm_pkg.run_test" -win $_nTrace1 -lib "work"
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "uvm_pkg.run_test" -win $_nTrace1 -lib "work"
srcSetScope "uvm_pkg.run_test" -delim "." -win $_nTrace1 -lib "work"
srcHBSelect "uvm_pkg.run_test" -win $_nTrace1 -lib "work"
srcTBDelAllBrkPnt
srcHBSelect "tb_adder_uvm.a_if" -win $_nTrace1
srcSetScope "tb_adder_uvm.a_if" -delim "." -win $_nTrace1
srcHBSelect "tb_adder_uvm.a_if" -win $_nTrace1
srcSelect -win $_nTrace1 -range {138 138 1 8 1 1}
srcTBAddBrkPnt -line 138 -file \
           /home/aedu01/verilog/0826_adder_uvm/testbench/tb_adder_uvm.sv
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcSelect -win $_nTrace1 -range {139 139 1 8 1 1}
srcTBAddBrkPnt -line 139 -file \
           /home/aedu01/verilog/0826_adder_uvm/testbench/tb_adder_uvm.sv
srcSelect -win $_nTrace1 -range {140 140 1 8 1 1}
srcTBAddBrkPnt -line 140 -file \
           /home/aedu01/verilog/0826_adder_uvm/testbench/tb_adder_uvm.sv
srcTBRunSim
verdiDockWidgetSetCurTab -dock windowDock_InteractiveConsole_3
verdiSetActWin -win $_InteractiveConsole_3
srcTBRunSim
srcTBRunSim
srcTBRunSim
srcTBRunSim
srcTBRunSim
srcDeselectAll -win $_nTrace1
srcSelect -signal "adder_seq_item.a" -line 138 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcTBInsertDataTree -win $_nTrace1 -tab 1 -tree \
           "adder_test.adder_env.adder_agt.adder_mon.adder_seq_item.a\[7:0\]"
srcDeselectAll -win $_nTrace1
srcSelect -word -line 137 -pos 5 -win $_nTrace1
srcTBInsertDataTree -win $_nTrace1 -tab 1 -tree "adder_if.a\[7:0\]"
srcTBDVSelect -tab 1 -range {1-1} 
verdiSetActWin -dock widgetDock_<Watch>
srcDeselectAll -win $_nTrace1
srcSelect -signal "adder_seq_item.b" -line 139 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcSelect -win $_nTrace1 -range {139 140 2 2 12 11}
srcDeselectAll -win $_nTrace1
srcSelect -signal "adder_seq_item.b" -line 139 -pos 1 -win $_nTrace1
srcTBInsertDataTree -win $_nTrace1 -tab 1 -tree \
           "adder_test.adder_env.adder_agt.adder_mon.adder_seq_item.b\[7:0\]"
srcDeselectAll -win $_nTrace1
srcSelect -word -line 138 -pos 5 -win $_nTrace1
srcSelect -win $_nTrace1 -range {139 139 6 6 4 6}
srcDeselectAll -win $_nTrace1
srcSelect -word -line 138 -pos 5 -win $_nTrace1
srcTBInsertDataTree -win $_nTrace1 -tab 1 -tree "adder_if.b\[7:0\]"
srcTBDVSelect -tab 1 -range {0-0} 
verdiSetActWin -dock widgetDock_<Watch>
srcTBRunSim
srcTBRunSim
srcTBRunSim
verdiDockWidgetSetCurTab -dock windowDock_nWave_2
verdiSetActWin -win $_nWave2
verdiSetActWin -dock widgetDock_<Watch>
