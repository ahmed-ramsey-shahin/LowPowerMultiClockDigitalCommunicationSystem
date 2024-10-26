module RX_FSM (
    input  wire        CLK,
    input  wire        RST,
    input  wire        PAR_EN,
    input  wire        RX_IN,
    input  wire        par_err,
    input  wire        strt_glitch,
    input  wire        stp_err,
    input  wire [5:0] prescale,
    input  wire [4:0] edge_cnt,
    input  wire [3:0] bit_cnt,
    output reg         edge_bit_cnt_en,
    output reg         dat_samp_en,
    output reg         par_chk_en,
    output reg         strt_chk_en,
    output reg         stp_chk_en,
    output reg         deser_en,
    output reg         data_valid
);
    typedef enum bit [2:0] {
        IDLE     = 3'b000,
        STRT     = 3'b001,
        STRT_CHK = 3'b011,
        DATA     = 3'b010,
        PAR      = 3'b110,
        PAR_CHK  = 3'b111,
        STP      = 3'b101,
        STP_CHK  = 3'b100
    } state_e;

    state_e current_state;
    state_e next_state;
    reg       edge_cnt_condition;
    reg [4:0] previous_bit_cnt;

    always @(posedge CLK or negedge RST) begin
        if (~RST) begin
            current_state    <= IDLE;
            previous_bit_cnt <= 5'h0;
        end
        else begin
            current_state    <= next_state;
            previous_bit_cnt <= bit_cnt;
        end
    end

    always @(*) begin
	next_state        = current_state;
        edge_bit_cnt_en   = 1'd0;
        dat_samp_en       = 1'd0;
        par_chk_en        = 1'd0;
        strt_chk_en       = 1'd0;
        stp_chk_en        = 1'd0;
        deser_en          = 1'd0;
        data_valid        = 1'd0;

        case (current_state)
            IDLE: begin
                if (~RX_IN) begin
                    next_state      = STRT;
                    edge_bit_cnt_en = 1'd1;
                    dat_samp_en     = 1'd1;
                end
            end
            STRT: begin
                if (edge_cnt_condition) begin
                    next_state      = STRT_CHK;
                    edge_bit_cnt_en = 1'd1;
                    dat_samp_en     = 1'd1;
                    strt_chk_en     = 1'd1;
                end
                else begin
                    edge_bit_cnt_en = 1'd1;
                    dat_samp_en     = 1'd1;
                end
            end
            STRT_CHK: begin
                if (bit_cnt == 4'd0 & edge_cnt == prescale - 1'd1) begin
                    if (strt_glitch) begin
                        next_state = IDLE;
                    end
                    else begin
                        next_state      = DATA;
                        edge_bit_cnt_en = 1'd1;
                        dat_samp_en     = 1'd1;
                        deser_en        = 1'd1;
                    end
                end
                else begin
                    edge_bit_cnt_en = 1'd1;
                    dat_samp_en     = 1'd1;
                    strt_chk_en     = 1'd1;
                end
            end
            DATA: begin
                if (bit_cnt == 4'd8 & edge_cnt == prescale - 1'd1) begin
                    if (PAR_EN) begin
                        next_state      = PAR;
                        edge_bit_cnt_en = 1'd1;
                        dat_samp_en     = 1'd1;
                        deser_en        = 1'd1;
                    end
                    else begin
                        next_state      = STP;
                        edge_bit_cnt_en = 1'd1;
                        dat_samp_en     = 1'd1;
                        deser_en        = 1'd1;
                    end
                end
                else begin
                    edge_bit_cnt_en = 1'd1;
                    dat_samp_en     = 1'd1;

                    if (bit_cnt == previous_bit_cnt) begin
                        deser_en = 1'd0;
                    end
                    else begin
                        deser_en = 1'd1;
                    end
                end
            end
            PAR: begin
                if (edge_cnt_condition) begin
                    next_state      = PAR_CHK;
                    edge_bit_cnt_en = 1'd1;
                    dat_samp_en     = 1'd1;
                    par_chk_en      = 1'd1;
                end
                else begin
                    edge_bit_cnt_en = 1'd1;
                    dat_samp_en     = 1'd1;
                end
            end
            PAR_CHK: begin
                if (bit_cnt == 4'd9 & edge_cnt == prescale - 1'd1) begin
                    if (par_err) begin
                        next_state = IDLE;
                    end
                    else begin
                        next_state = STP;
                        edge_bit_cnt_en = 1'd1;
                        dat_samp_en     = 1'd1;
                    end
                end
                else begin
                    edge_bit_cnt_en = 1'd1;
                    dat_samp_en     = 1'd1;
                    par_chk_en      = 1'd1;
                end
            end
            STP: begin
                if (edge_cnt_condition) begin
                    edge_bit_cnt_en = 1'd1;
                    dat_samp_en     = 1'd1;
                    stp_chk_en      = 1'd1;
                    next_state      = STP_CHK;
                end
                else begin
                    edge_bit_cnt_en = 1'd1;
                    dat_samp_en     = 1'd1;
                end
            end
            STP_CHK: begin
                if ((bit_cnt == 4'd9 & edge_cnt == prescale - 1'd1) | (bit_cnt == 4'd10 & edge_cnt == prescale - 1'd1)) begin
                    if (stp_err) begin
                        next_state = IDLE;
                    end
                    else if (~RX_IN) begin
                        next_state      = STRT;
                        edge_bit_cnt_en = 1'd1;
                        dat_samp_en     = 1'd1;
                    end
                    else begin
                        next_state = IDLE;
                        data_valid = 1'd1;
                    end
                end
                else begin
                    edge_bit_cnt_en = 1'd1;
                    dat_samp_en     = 1'd1;
                    stp_chk_en      = 1'd1;
                end
            end
        endcase
    end

    always @(*) begin
        case (prescale)
            6'd4: begin
                edge_cnt_condition = (edge_cnt == 5'd2);
            end
            6'd8: begin
                edge_cnt_condition = (edge_cnt == 5'd4);
            end
            6'd16: begin
                edge_cnt_condition = (edge_cnt == 5'd8);
            end
            6'd32: begin
                edge_cnt_condition = (edge_cnt == 5'd15);
            end
            default: begin
                edge_cnt_condition = (edge_cnt == 5'd4);
            end
        endcase
    end
endmodule
