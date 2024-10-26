vlib work
vlog Top/*.*v
vlog ALU/*.*v
vlog ASYNC_FIFO/*.*v
vlog CLK_GATE/*.*v
vlog CLOCK_DIVIDER/*.*v
vlog Data_Sync/*.*v
vlog PULSE_GEN/*.*v
vlog RegFile/*.*v
vlog Reset_Sync/*.*v
vlog SYS_CTRL/*.*v
vlog UART/UART_RX/*.*v
vlog UART/UART_TX/*.*v
vsim -voptargs=+acc work.SYS_TOP_Tb
do wave.do
run -all
