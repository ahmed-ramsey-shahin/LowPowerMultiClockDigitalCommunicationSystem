module SYS_TOP (
    input  wire REF_CLK,
    input  wire UART_CLK,
    input  wire RST,
    input  wire RX_IN,
    output wire TX_OUT
);
    wire        reference_rst;
    wire        uart_rst;
    wire [7:0]  ALU_A;
    wire [7:0]  ALU_B;
    wire [15:0] ALU_OUT;
    wire        ALU_OUT_Valid;
    wire [7:0]  RF_RdData;
    wire        RF_RdData_Valid;
    wire [7:0]  RX_P_DATA;
    wire        RX_D_VLD;
    wire [7:0]  RX_P_DATA_synced;
    wire        RX_D_VLD_synced;
    wire        FIFO_FULL;
    wire [3:0]  ALU_FUN;
    wire        ALU_EN;
    wire        ALU_CLK_EN;
    wire [3:0]  Address;
    wire        RF_WrEn;
    wire        RF_RdEn;
    wire [7:0]  RF_WrData;
    wire [7:0]  TX_P_DATA;
    wire        TX_D_VLD;
    wire        clk_div_en;
    wire [7:0]  FIFO_Wr_Data;
    wire        FIFO_Wr_INC;
    wire        FIFO_Rd_INC;
    wire        Parity_Enable;
    wire        Parity_Type;
    wire [5:0]  prescale;
    wire [7:0]  tx_division_ratio;
    wire [7:0]  rx_division_ratio;
    wire        ALU_CLK;
    wire        FIFO_EMPTY;
    wire [7:0]  FIFO_Rd_Data;
    wire        TX_busy;
    wire        TX_CLK;
    wire        RX_CLK;

    RST_SYNC reference_rst_synchronizer (
        .CLK(REF_CLK),
        .RST(RST),
        .SYNC_RST(reference_rst)
    );

    RST_SYNC UART_rst_synchronizer (
        .CLK(UART_CLK),
        .RST(RST),
        .SYNC_RST(uart_rst)
    );

    CLK_GATE ALU_clk_gate (
        .CLK(REF_CLK),
        .CLK_EN(ALU_CLK_EN),
        .GATED_CLK(ALU_CLK)
    );

    PrescaleMux prescale_mux (
        .prescale(prescale),
        .division_ratio(rx_division_ratio)
    );

    Integer_Clock_Divider RX_CLK_generator (
        .i_ref_clk(UART_CLK),
        .i_rst_n(uart_rst),
        .i_clk_en(clk_div_en),
        .i_div_ratio(rx_division_ratio),
        .o_div_clk(RX_CLK)
    );

    Integer_Clock_Divider TX_CLK_generator (
        .i_ref_clk(UART_CLK),
        .i_rst_n(uart_rst),
        .i_clk_en(clk_div_en),
        .i_div_ratio(tx_division_ratio),
        .o_div_clk(TX_CLK)
    );

    RegFile register_file (
        .CLK(REF_CLK),
        .RST(reference_rst),
        .WrData(RF_WrData),
        .Address(Address),
        .WrEn(RF_WrEn),
        .RdEn(RF_RdEn),
        .RdData(RF_RdData),
        .RdData_Valid(RF_RdData_Valid),
        .REG0(ALU_A),
        .REG1(ALU_B),
        .REG2({prescale, Parity_Type, Parity_Enable}),
        .REG3(tx_division_ratio)
    );

    SYS_CTRL system_control (
        .CLK(REF_CLK),
        .RST(reference_rst),
        .ALU_OUT(ALU_OUT),
        .OUT_Valid(ALU_OUT_Valid),
        .RdData(RF_RdData),
        .RdData_Valid(RF_RdData_Valid),
        .RX_P_DATA(RX_P_DATA_synced),
        .RX_D_VLD(RX_D_VLD_synced),
        .FIFO_FULL(FIFO_FULL),
        .ALU_FUN(ALU_FUN),
        .ALU_EN(ALU_EN),
        .CLK_EN(ALU_CLK_EN),
        .Address(Address),
        .WrEn(RF_WrEn),
        .RdEn(RF_RdEn),
        .WrData(RF_WrData),
        .clk_div_en(clk_div_en),
        .FIFO_Wr_Data(FIFO_Wr_Data),
        .FIFO_Wr_INC(FIFO_Wr_INC)
    );
    
    ALU alu (
        .CLK(ALU_CLK),
        .RST(reference_rst),
        .A(ALU_A),
        .B(ALU_B),
        .EN(ALU_EN),
        .ALU_FUN(ALU_FUN),
        .ALU_OUT(ALU_OUT),
        .OUT_VALID(ALU_OUT_Valid)
    );

    UART_RX rx (
        .CLK(RX_CLK),
        .RST(uart_rst),
        .RX_IN(RX_IN),
        .PAR_EN(Parity_Enable),
        .PAR_TYP(Parity_Type),
        .prescale(prescale),
        .P_DATA(RX_P_DATA),
        .data_valid(RX_D_VLD)
    );

    DATA_SYNC rx_data_synchronizer (
        .CLK(REF_CLK),
        .RST(reference_rst),
        .bus_enable(RX_D_VLD),
        .unsync_bus(RX_P_DATA),
        .sync_bus(RX_P_DATA_synced),
        .enable_pulse(RX_D_VLD_synced)
    );

    PULSE_GEN pulse_generator (
        .CLK(TX_CLK),
        .RST(uart_rst),
        .LVL_SIG(TX_busy),
        .PULSE_SIG(FIFO_Rd_INC)
    );

    UART_TX tx (
        .P_DATA(FIFO_Rd_Data),
        .CLK(TX_CLK),
        .RST(uart_rst),
        .Data_Valid(~FIFO_EMPTY),
        .PAR_EN(Parity_Enable),
        .PAR_TYP(Parity_Type),
        .TX_OUT(TX_OUT),
        .busy(TX_busy)
    );

    ASYC_FIFO FIFO (
        .WR_DATA(FIFO_Wr_Data),
        .W_CLK(REF_CLK),
        .W_RST(reference_rst),
        .W_INC(FIFO_Wr_INC),
        .R_CLK(TX_CLK),
        .R_RST(uart_rst),
        .R_INC(FIFO_Rd_INC),
        .FULL(FIFO_FULL),
        .EMPTY(FIFO_EMPTY),
        .RD_DATA(FIFO_Rd_Data)
    );
endmodule
