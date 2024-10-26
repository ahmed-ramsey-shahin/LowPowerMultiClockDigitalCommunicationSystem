module TX_FSM (
    input  wire      CLK,
    input  wire      RST,
    input  wire      ser_done,
    input  wire      PAR_EN,
    input  wire      Data_Valid,
    output reg [1:0] mux_sel,
    output reg       ser_en,
    output reg       busy
);
    typedef enum bit [2:0] {
        IDLE = 3'b000,
        STR  = 3'b001,
        DATA = 3'b011,
        P    = 3'b010,
        STP  = 3'b110
    } state_e;

    state_e current_state;
    state_e next_state;

    always @(posedge CLK or negedge RST) begin
        if (~RST) begin
            current_state <= IDLE;
        end
        else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = IDLE;
        mux_sel    = 2'b01;
        ser_en     = 1'b0;
        busy       = 1'b0;
        
        case (current_state)
            IDLE: begin
                busy    = 1'b0;
                mux_sel = 2'b01;
                ser_en  = 1'b0;

                if(Data_Valid) begin
                    next_state = STR;
                end
            end
            STR: begin
                busy       = 1'b1;
                mux_sel    = 2'b11;
                ser_en     = 1'b1;
                next_state = DATA;
            end
            DATA: begin
                busy    = 1'b1;
                mux_sel = 2'b01;
                ser_en  = 1'b0;

                if(ser_done & PAR_EN) begin
                    next_state = P;
                end
                else if(ser_done & ~PAR_EN) begin
                    next_state = STP;
                end
                else begin
                    next_state = DATA;
                    ser_en     = 1'b1;
                end
            end
            P: begin
                busy    = 1'b1;
                mux_sel = 2'b00;
                ser_en  = 1'b0;
                next_state = STP;
            end
            STP: begin
                busy    = 1'b1;
                mux_sel = 2'b10;
                ser_en  = 1'b0;
                next_state = IDLE;
            end
        endcase
    end
endmodule
