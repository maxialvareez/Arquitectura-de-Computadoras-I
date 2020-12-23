@echo off
set xv_path=D:\\Xilinx\\Vivado\\2014.4\\bin
call %xv_path%/xelab  -wto d3a969695a764d2bb57a1bc34f501c5b -m64 --debug typical --relax -L xil_defaultlib -L secureip --snapshot MultiCycle_MIPS_tb_behav xil_defaultlib.MultiCycle_MIPS_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
