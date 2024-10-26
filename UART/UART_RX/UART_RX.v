module UART_RX (
    input  wire       CLK,
    input  wire       RST,
    input  wire       RX_IN,
    input  wire       PAR_EN,
    input  wire       PAR_TYP,
    input  wire [5:0] prescale,
    output wire [7:0] P_DATA,
    output wire       data_valid,
    output wire       PAR_ERR,
    output wire       STP_ERR
);
    wire       par_err;
    wire       strt_glitch;
    wire       stp_err;
    wire       edge_bit_cnt_en;
    wire       dat_samp_en;
    wire       par_chk_en;
    wire       strt_chk_en;
    wire       stp_chk_en;
    wire       deser_en;
    wire       sampled_bit;
    wire [4:0] edge_cnt;
    wire [3:0] bit_cnt;

    assign PAR_ERR = par_err;
    assign STP_ERR = stp_err;

    RX_FSM fsm (
        .CLK(CLK),
        .RST(RST),
        .PAR_EN(PAR_EN),
        .RX_IN(RX_IN),
        .par_err(par_err),
        .strt_glitch(strt_glitch),
        .stp_err(stp_err),
        .edge_cnt(edge_cnt),
        .bit_cnt(bit_cnt),
        .edge_bit_cnt_en(edge_bit_cnt_en),
        .dat_samp_en(dat_samp_en),
        .par_chk_en(par_chk_en),
        .strt_chk_en(strt_chk_en),
        .stp_chk_en(stp_chk_en),
        .deser_en(deser_en),
        .data_valid(data_valid),
        .prescale(prescale)
    );

    data_sampling ds (
        .CLK(CLK),
        .RST(RST),
        .dat_samp_en(dat_samp_en),
        .edge_cnt(edge_cnt),
        .RX_IN(RX_IN),
        .prescale(prescale),
        .sampled_bit(sampled_bit)
    );

    deserializer des (
        .CLK(CLK),
        .RST(RST),
        .deser_en(deser_en),
        .sampled_bit(sampled_bit),
        .P_DATA(P_DATA)
    );

    edge_bit_counter ebc (
        .CLK(CLK),
        .RST(RST),
        .enable(edge_bit_cnt_en),
        .prescale(prescale),
        .edge_cnt(edge_cnt),
        .bit_cnt(bit_cnt)
    );

    parity_check pc (
        .CLK(CLK),
        .RST(RST),
        .par_chk_en(par_chk_en),
        .PAR_TYP(PAR_TYP),
        .sampled_bit(sampled_bit),
        .P_DATA(P_DATA),
        .par_err(par_err)
    );

    stop_check stpc (
        .CLK(CLK),
        .RST(RST),
        .stp_chk_en(stp_chk_en),
        .sampled_bit(sampled_bit),
        .stp_err(stp_err)
    );

    strt_check strtc (
        .CLK(CLK),
        .RST(RST),
        .strt_chk_en(strt_chk_en),
        .sampled_bit(sampled_bit),
        .strt_glitch(strt_glitch)
    );
endmodule
