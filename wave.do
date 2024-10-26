onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group SYS_TOP_Tb -radix unsigned /SYS_TOP_Tb/REF_CLK_tb
add wave -noupdate -group SYS_TOP_Tb -radix unsigned /SYS_TOP_Tb/UART_CLK_tb
add wave -noupdate -group SYS_TOP_Tb -radix unsigned /SYS_TOP_Tb/prescale_tb
add wave -noupdate -group SYS_TOP_Tb -radix unsigned /SYS_TOP_Tb/RST_tb
add wave -noupdate -group SYS_TOP_Tb -radix unsigned /SYS_TOP_Tb/RX_IN_tb
add wave -noupdate -group SYS_TOP_Tb -radix unsigned /SYS_TOP_Tb/frame
add wave -noupdate -group SYS_TOP_Tb -radix unsigned /SYS_TOP_Tb/pure_data
add wave -noupdate -group SYS_TOP_Tb -radix unsigned /SYS_TOP_Tb/outputs
add wave -noupdate -group SYS_TOP_Tb -radix unsigned /SYS_TOP_Tb/TX_OUT_tb
add wave -noupdate -group SYS_TOP_Tb -radix unsigned /SYS_TOP_Tb/TX_CLK
add wave -noupdate -group SYS_TOP_Tb -radix unsigned /SYS_TOP_Tb/RX_CLK
add wave -noupdate -group SYS_TOP_Tb -radix unsigned /SYS_TOP_Tb/loop_index
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/REF_CLK
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/UART_CLK
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/RST
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/RX_IN
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/TX_OUT
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/reference_rst
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/uart_rst
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/ALU_A
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/ALU_B
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/ALU_OUT
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/ALU_OUT_Valid
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/RF_RdData
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/RF_RdData_Valid
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/RX_P_DATA
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/RX_D_VLD
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/RX_P_DATA_synced
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/RX_D_VLD_synced
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/FIFO_FULL
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/ALU_FUN
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/ALU_EN
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/ALU_CLK_EN
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/Address
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/RF_WrEn
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/RF_RdEn
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/RF_WrData
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/TX_P_DATA
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/TX_D_VLD
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/clk_div_en
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/FIFO_Wr_Data
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/FIFO_Wr_INC
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/FIFO_Rd_INC
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/Parity_Enable
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/Parity_Type
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/prescale
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/tx_division_ratio
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/rx_division_ratio
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/ALU_CLK
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/FIFO_EMPTY
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/FIFO_Rd_Data
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/TX_busy
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/RX_CLK
add wave -noupdate -group SYS_TOP -radix unsigned /SYS_TOP_Tb/top/TX_CLK
add wave -noupdate -group reference_rst_synchronizer /SYS_TOP_Tb/top/reference_rst_synchronizer/CLK
add wave -noupdate -group reference_rst_synchronizer /SYS_TOP_Tb/top/reference_rst_synchronizer/RST
add wave -noupdate -group reference_rst_synchronizer /SYS_TOP_Tb/top/reference_rst_synchronizer/SYNC_RST
add wave -noupdate -group reference_rst_synchronizer /SYS_TOP_Tb/top/reference_rst_synchronizer/Q
add wave -noupdate -group UART_rst_synchronizer /SYS_TOP_Tb/top/UART_rst_synchronizer/CLK
add wave -noupdate -group UART_rst_synchronizer /SYS_TOP_Tb/top/UART_rst_synchronizer/RST
add wave -noupdate -group UART_rst_synchronizer /SYS_TOP_Tb/top/UART_rst_synchronizer/SYNC_RST
add wave -noupdate -group UART_rst_synchronizer /SYS_TOP_Tb/top/UART_rst_synchronizer/Q
add wave -noupdate -group alu_clock_gate /SYS_TOP_Tb/top/ALU_clk_gate/CLK
add wave -noupdate -group alu_clock_gate /SYS_TOP_Tb/top/ALU_clk_gate/CLK_EN
add wave -noupdate -group alu_clock_gate /SYS_TOP_Tb/top/ALU_clk_gate/GATED_CLK
add wave -noupdate -group alu_clock_gate /SYS_TOP_Tb/top/ALU_clk_gate/latch_out
add wave -noupdate -group prescale_mux -radix unsigned /SYS_TOP_Tb/top/prescale_mux/prescale
add wave -noupdate -group prescale_mux -radix unsigned /SYS_TOP_Tb/top/prescale_mux/division_ratio
add wave -noupdate -group RX_CLK_generator -radix unsigned /SYS_TOP_Tb/top/RX_CLK_generator/i_ref_clk
add wave -noupdate -group RX_CLK_generator -radix unsigned /SYS_TOP_Tb/top/RX_CLK_generator/i_rst_n
add wave -noupdate -group RX_CLK_generator -radix unsigned /SYS_TOP_Tb/top/RX_CLK_generator/i_clk_en
add wave -noupdate -group RX_CLK_generator -radix unsigned /SYS_TOP_Tb/top/RX_CLK_generator/i_div_ratio
add wave -noupdate -group RX_CLK_generator -radix unsigned /SYS_TOP_Tb/top/RX_CLK_generator/o_div_clk
add wave -noupdate -group RX_CLK_generator -radix unsigned /SYS_TOP_Tb/top/RX_CLK_generator/counter
add wave -noupdate -group RX_CLK_generator -radix unsigned /SYS_TOP_Tb/top/RX_CLK_generator/divided_clk
add wave -noupdate -group RX_CLK_generator -radix unsigned /SYS_TOP_Tb/top/RX_CLK_generator/is_clk_low
add wave -noupdate -group TX_CLK_generator -radix unsigned /SYS_TOP_Tb/top/TX_CLK_generator/i_ref_clk
add wave -noupdate -group TX_CLK_generator -radix unsigned /SYS_TOP_Tb/top/TX_CLK_generator/i_rst_n
add wave -noupdate -group TX_CLK_generator -radix unsigned /SYS_TOP_Tb/top/TX_CLK_generator/i_clk_en
add wave -noupdate -group TX_CLK_generator -radix unsigned /SYS_TOP_Tb/top/TX_CLK_generator/i_div_ratio
add wave -noupdate -group TX_CLK_generator -radix unsigned /SYS_TOP_Tb/top/TX_CLK_generator/o_div_clk
add wave -noupdate -group TX_CLK_generator -radix unsigned /SYS_TOP_Tb/top/TX_CLK_generator/counter
add wave -noupdate -group TX_CLK_generator -radix unsigned /SYS_TOP_Tb/top/TX_CLK_generator/divided_clk
add wave -noupdate -group TX_CLK_generator -radix unsigned /SYS_TOP_Tb/top/TX_CLK_generator/is_clk_low
add wave -noupdate -group register_file -radix unsigned /SYS_TOP_Tb/top/register_file/CLK
add wave -noupdate -group register_file -radix unsigned /SYS_TOP_Tb/top/register_file/RST
add wave -noupdate -group register_file -radix unsigned /SYS_TOP_Tb/top/register_file/WrData
add wave -noupdate -group register_file -radix unsigned /SYS_TOP_Tb/top/register_file/Address
add wave -noupdate -group register_file -radix unsigned /SYS_TOP_Tb/top/register_file/WrEn
add wave -noupdate -group register_file -radix unsigned /SYS_TOP_Tb/top/register_file/RdEn
add wave -noupdate -group register_file -radix unsigned /SYS_TOP_Tb/top/register_file/RdData
add wave -noupdate -group register_file -radix unsigned /SYS_TOP_Tb/top/register_file/RdData_Valid
add wave -noupdate -group register_file -radix unsigned /SYS_TOP_Tb/top/register_file/REG0
add wave -noupdate -group register_file -radix unsigned /SYS_TOP_Tb/top/register_file/REG1
add wave -noupdate -group register_file -radix unsigned /SYS_TOP_Tb/top/register_file/REG2
add wave -noupdate -group register_file -radix unsigned /SYS_TOP_Tb/top/register_file/REG3
add wave -noupdate -group register_file -radix unsigned /SYS_TOP_Tb/top/register_file/i
add wave -noupdate -group register_file -radix unsigned -childformat {{{/SYS_TOP_Tb/top/register_file/register_file[0]} -radix unsigned} {{/SYS_TOP_Tb/top/register_file/register_file[1]} -radix unsigned} {{/SYS_TOP_Tb/top/register_file/register_file[2]} -radix unsigned} {{/SYS_TOP_Tb/top/register_file/register_file[3]} -radix unsigned} {{/SYS_TOP_Tb/top/register_file/register_file[4]} -radix unsigned} {{/SYS_TOP_Tb/top/register_file/register_file[5]} -radix unsigned} {{/SYS_TOP_Tb/top/register_file/register_file[6]} -radix unsigned} {{/SYS_TOP_Tb/top/register_file/register_file[7]} -radix unsigned} {{/SYS_TOP_Tb/top/register_file/register_file[8]} -radix unsigned} {{/SYS_TOP_Tb/top/register_file/register_file[9]} -radix unsigned} {{/SYS_TOP_Tb/top/register_file/register_file[10]} -radix unsigned} {{/SYS_TOP_Tb/top/register_file/register_file[11]} -radix unsigned} {{/SYS_TOP_Tb/top/register_file/register_file[12]} -radix unsigned} {{/SYS_TOP_Tb/top/register_file/register_file[13]} -radix unsigned} {{/SYS_TOP_Tb/top/register_file/register_file[14]} -radix unsigned} {{/SYS_TOP_Tb/top/register_file/register_file[15]} -radix unsigned}} -subitemconfig {{/SYS_TOP_Tb/top/register_file/register_file[0]} {-height 15 -radix unsigned} {/SYS_TOP_Tb/top/register_file/register_file[1]} {-height 15 -radix unsigned} {/SYS_TOP_Tb/top/register_file/register_file[2]} {-height 15 -radix unsigned} {/SYS_TOP_Tb/top/register_file/register_file[3]} {-height 15 -radix unsigned} {/SYS_TOP_Tb/top/register_file/register_file[4]} {-height 15 -radix unsigned} {/SYS_TOP_Tb/top/register_file/register_file[5]} {-height 15 -radix unsigned} {/SYS_TOP_Tb/top/register_file/register_file[6]} {-height 15 -radix unsigned} {/SYS_TOP_Tb/top/register_file/register_file[7]} {-height 15 -radix unsigned} {/SYS_TOP_Tb/top/register_file/register_file[8]} {-height 15 -radix unsigned} {/SYS_TOP_Tb/top/register_file/register_file[9]} {-height 15 -radix unsigned} {/SYS_TOP_Tb/top/register_file/register_file[10]} {-height 15 -radix unsigned} {/SYS_TOP_Tb/top/register_file/register_file[11]} {-height 15 -radix unsigned} {/SYS_TOP_Tb/top/register_file/register_file[12]} {-height 15 -radix unsigned} {/SYS_TOP_Tb/top/register_file/register_file[13]} {-height 15 -radix unsigned} {/SYS_TOP_Tb/top/register_file/register_file[14]} {-height 15 -radix unsigned} {/SYS_TOP_Tb/top/register_file/register_file[15]} {-height 15 -radix unsigned}} /SYS_TOP_Tb/top/register_file/register_file
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/CLK
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/RST
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/ALU_OUT
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/OUT_Valid
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/RdData
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/RdData_Valid
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/RX_P_DATA
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/RX_D_VLD
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/FIFO_FULL
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/ALU_FUN
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/ALU_EN
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/CLK_EN
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/Address
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/WrEn
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/RdEn
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/WrData
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/clk_div_en
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/FIFO_Wr_Data
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/FIFO_Wr_INC
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/current_state
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/next_state
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/operand1_d
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/operand2_d
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/operand1_q
add wave -noupdate -group system_control -radix unsigned /SYS_TOP_Tb/top/system_control/operand2_q
add wave -noupdate -group ALU -radix unsigned /SYS_TOP_Tb/top/alu/CLK
add wave -noupdate -group ALU -radix unsigned /SYS_TOP_Tb/top/alu/RST
add wave -noupdate -group ALU -radix unsigned /SYS_TOP_Tb/top/alu/A
add wave -noupdate -group ALU -radix unsigned /SYS_TOP_Tb/top/alu/B
add wave -noupdate -group ALU -radix unsigned /SYS_TOP_Tb/top/alu/EN
add wave -noupdate -group ALU -radix unsigned /SYS_TOP_Tb/top/alu/ALU_FUN
add wave -noupdate -group ALU -radix unsigned /SYS_TOP_Tb/top/alu/ALU_OUT
add wave -noupdate -group ALU -radix unsigned /SYS_TOP_Tb/top/alu/OUT_VALID
add wave -noupdate -group RX -radix unsigned /SYS_TOP_Tb/top/rx/CLK
add wave -noupdate -group RX -radix unsigned /SYS_TOP_Tb/top/rx/RST
add wave -noupdate -group RX -radix unsigned /SYS_TOP_Tb/top/rx/RX_IN
add wave -noupdate -group RX -radix unsigned /SYS_TOP_Tb/top/rx/PAR_EN
add wave -noupdate -group RX -radix unsigned /SYS_TOP_Tb/top/rx/PAR_TYP
add wave -noupdate -group RX -radix unsigned /SYS_TOP_Tb/top/rx/prescale
add wave -noupdate -group RX -radix unsigned /SYS_TOP_Tb/top/rx/P_DATA
add wave -noupdate -group RX -radix unsigned /SYS_TOP_Tb/top/rx/data_valid
add wave -noupdate -group RX -radix unsigned /SYS_TOP_Tb/top/rx/PAR_ERR
add wave -noupdate -group RX -radix unsigned /SYS_TOP_Tb/top/rx/STP_ERR
add wave -noupdate -group RX -radix unsigned /SYS_TOP_Tb/top/rx/par_err
add wave -noupdate -group RX -radix unsigned /SYS_TOP_Tb/top/rx/strt_glitch
add wave -noupdate -group RX -radix unsigned /SYS_TOP_Tb/top/rx/stp_err
add wave -noupdate -group RX -radix unsigned /SYS_TOP_Tb/top/rx/edge_bit_cnt_en
add wave -noupdate -group RX -radix unsigned /SYS_TOP_Tb/top/rx/dat_samp_en
add wave -noupdate -group RX -radix unsigned /SYS_TOP_Tb/top/rx/par_chk_en
add wave -noupdate -group RX -radix unsigned /SYS_TOP_Tb/top/rx/strt_chk_en
add wave -noupdate -group RX -radix unsigned /SYS_TOP_Tb/top/rx/stp_chk_en
add wave -noupdate -group RX -radix unsigned /SYS_TOP_Tb/top/rx/deser_en
add wave -noupdate -group RX -radix unsigned /SYS_TOP_Tb/top/rx/sampled_bit
add wave -noupdate -group RX -radix unsigned /SYS_TOP_Tb/top/rx/edge_cnt
add wave -noupdate -group RX -radix unsigned /SYS_TOP_Tb/top/rx/bit_cnt
add wave -noupdate -group RX_data_synchronizer -radix unsigned /SYS_TOP_Tb/top/rx_data_synchronizer/NUM_STAGES
add wave -noupdate -group RX_data_synchronizer -radix unsigned /SYS_TOP_Tb/top/rx_data_synchronizer/BUS_WIDTH
add wave -noupdate -group RX_data_synchronizer -radix unsigned /SYS_TOP_Tb/top/rx_data_synchronizer/CLK
add wave -noupdate -group RX_data_synchronizer -radix unsigned /SYS_TOP_Tb/top/rx_data_synchronizer/RST
add wave -noupdate -group RX_data_synchronizer -radix unsigned /SYS_TOP_Tb/top/rx_data_synchronizer/bus_enable
add wave -noupdate -group RX_data_synchronizer -radix unsigned /SYS_TOP_Tb/top/rx_data_synchronizer/unsync_bus
add wave -noupdate -group RX_data_synchronizer -radix unsigned /SYS_TOP_Tb/top/rx_data_synchronizer/sync_bus
add wave -noupdate -group RX_data_synchronizer -radix unsigned /SYS_TOP_Tb/top/rx_data_synchronizer/enable_pulse
add wave -noupdate -group RX_data_synchronizer -radix unsigned /SYS_TOP_Tb/top/rx_data_synchronizer/i
add wave -noupdate -group RX_data_synchronizer -radix unsigned /SYS_TOP_Tb/top/rx_data_synchronizer/pulse_generator_output
add wave -noupdate -group RX_data_synchronizer -radix unsigned /SYS_TOP_Tb/top/rx_data_synchronizer/synchronizer
add wave -noupdate -group busy_pulse_generator /SYS_TOP_Tb/top/pulse_generator/CLK
add wave -noupdate -group busy_pulse_generator /SYS_TOP_Tb/top/pulse_generator/RST
add wave -noupdate -group busy_pulse_generator /SYS_TOP_Tb/top/pulse_generator/LVL_SIG
add wave -noupdate -group busy_pulse_generator /SYS_TOP_Tb/top/pulse_generator/PULSE_SIG
add wave -noupdate -group busy_pulse_generator /SYS_TOP_Tb/top/pulse_generator/receive_flop
add wave -noupdate -group busy_pulse_generator /SYS_TOP_Tb/top/pulse_generator/pulse_flop
add wave -noupdate -group TX -radix unsigned /SYS_TOP_Tb/top/tx/P_DATA
add wave -noupdate -group TX -radix unsigned /SYS_TOP_Tb/top/tx/CLK
add wave -noupdate -group TX -radix unsigned /SYS_TOP_Tb/top/tx/RST
add wave -noupdate -group TX -radix unsigned /SYS_TOP_Tb/top/tx/Data_Valid
add wave -noupdate -group TX -radix unsigned /SYS_TOP_Tb/top/tx/PAR_EN
add wave -noupdate -group TX -radix unsigned /SYS_TOP_Tb/top/tx/PAR_TYP
add wave -noupdate -group TX -radix unsigned /SYS_TOP_Tb/top/tx/TX_OUT
add wave -noupdate -group TX -radix unsigned /SYS_TOP_Tb/top/tx/busy
add wave -noupdate -group TX -radix unsigned /SYS_TOP_Tb/top/tx/mux_sel
add wave -noupdate -group TX -radix unsigned /SYS_TOP_Tb/top/tx/ser_done
add wave -noupdate -group TX -radix unsigned /SYS_TOP_Tb/top/tx/ser_en
add wave -noupdate -group TX -radix unsigned /SYS_TOP_Tb/top/tx/ser_data
add wave -noupdate -group TX -radix unsigned /SYS_TOP_Tb/top/tx/par_bit
add wave -noupdate -group FIFO -radix unsigned /SYS_TOP_Tb/top/FIFO/WR_DATA
add wave -noupdate -group FIFO -radix unsigned /SYS_TOP_Tb/top/FIFO/W_CLK
add wave -noupdate -group FIFO -radix unsigned /SYS_TOP_Tb/top/FIFO/W_RST
add wave -noupdate -group FIFO -radix unsigned /SYS_TOP_Tb/top/FIFO/W_INC
add wave -noupdate -group FIFO -radix unsigned /SYS_TOP_Tb/top/FIFO/R_CLK
add wave -noupdate -group FIFO -radix unsigned /SYS_TOP_Tb/top/FIFO/R_RST
add wave -noupdate -group FIFO -radix unsigned /SYS_TOP_Tb/top/FIFO/R_INC
add wave -noupdate -group FIFO -radix unsigned /SYS_TOP_Tb/top/FIFO/FULL
add wave -noupdate -group FIFO -radix unsigned /SYS_TOP_Tb/top/FIFO/EMPTY
add wave -noupdate -group FIFO -radix unsigned /SYS_TOP_Tb/top/FIFO/RD_DATA
add wave -noupdate -group FIFO -radix unsigned /SYS_TOP_Tb/top/FIFO/memory
add wave -noupdate -group FIFO -radix unsigned /SYS_TOP_Tb/top/FIFO/W_PTR
add wave -noupdate -group FIFO -radix unsigned /SYS_TOP_Tb/top/FIFO/R_PTR
add wave -noupdate -group FIFO -radix unsigned /SYS_TOP_Tb/top/FIFO/rq2_wptr
add wave -noupdate -group FIFO -radix unsigned /SYS_TOP_Tb/top/FIFO/wq2_rptr
add wave -noupdate -group FIFO -radix unsigned /SYS_TOP_Tb/top/FIFO/R_PTR_GRAY_CODE
add wave -noupdate -group FIFO -radix unsigned /SYS_TOP_Tb/top/FIFO/W_PTR_GRAY_CODE
add wave -noupdate -group FIFO -radix unsigned /SYS_TOP_Tb/top/FIFO/W_ADDRESS
add wave -noupdate -group FIFO -radix unsigned /SYS_TOP_Tb/top/FIFO/R_ADDRESS
add wave -noupdate -group FIFO -radix unsigned /SYS_TOP_Tb/top/FIFO/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {997094641 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 188
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {2415797519 ps}
