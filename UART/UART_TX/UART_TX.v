module UART_TX (
    input  wire [7:0] P_DATA,
    input  wire       CLK,
    input  wire       RST,
    input  wire       Data_Valid,
    input  wire       PAR_EN,
    input  wire       PAR_TYP,
    output wire       TX_OUT,
    output wire       busy
);
    wire [1:0] mux_sel;
    wire       ser_done;
    wire       ser_en;
    wire       ser_data;
    wire       par_bit;

    Serializer serializer (
        .CLK(CLK),
        .RST(RST),
        .ser_en(ser_en),
        .Data_Valid(Data_Valid),
        .ser_done(ser_done),
        .P_DATA(P_DATA),
        .ser_data(ser_data),
        .busy(busy)
    );

    TX_FSM fsm (
        .CLK(CLK),
        .RST(RST),
        .ser_done(ser_done),
        .PAR_EN(PAR_EN),
        .Data_Valid(Data_Valid),
        .mux_sel(mux_sel),
        .ser_en(ser_en),
        .busy(busy)
    );

    parity_calc par_calc (
        .CLK(CLK),
        .RST(RST),
        .Data_Valid(Data_Valid),
        .PAR_TYP(PAR_TYP),
        .P_DATA(P_DATA),
        .par_bit(par_bit),
        .busy(busy)
    );

    Mux mux (
        .mux_sel(mux_sel),
        .out(TX_OUT),
        .ser_data(ser_data),
        .par_bit(par_bit)
    );
endmodule
