module SYS_CTRL (
    input  wire        CLK,
    input  wire        RST,
    input  wire [15:0] ALU_OUT,
    input  wire        OUT_Valid,
    input  wire [7:0]  RdData,
    input  wire        RdData_Valid,
    input  wire [7:0]  RX_P_DATA,
    input  wire        RX_D_VLD,
    input  wire        FIFO_FULL,
    output reg  [3:0]  ALU_FUN,
    output reg         ALU_EN,
    output reg         CLK_EN,
    output reg  [3:0]  Address,
    output reg         WrEn,
    output reg         RdEn,
    output reg  [7:0]  WrData,
    output reg         clk_div_en,
    output reg  [7:0]  FIFO_Wr_Data,
    output reg         FIFO_Wr_INC
);
    typedef enum bit [3:0] {
        IDLE               = 4'b0000,
        RF_Wr_Addr         = 4'b0001,
        RF_Wr_Data         = 4'b0011,
        Perform_Write      = 4'b0010,
        RF_Rd_Addr         = 4'b0110,
        Perform_Read       = 4'b0111,
        Transmit_Read_Data = 4'b0101,
        OperandA           = 4'b0100,
        OperandB           = 4'b1100,
        OP_ALU_FUN         = 4'b1101,
        Perform_OP_ALU     = 4'b1111,
        Transmit_Result    = 4'b1110,
        NOP_ALU_FUN        = 4'b1010,
        Perform_NOP_ALU    = 4'b1011
    } state_e;

    state_e       current_state;
    state_e       next_state;
    reg     [7:0] operand1_q;
    reg     [7:0] operand2_q;
    reg     [7:0] result_q;
    reg     [7:0] operand1_d;
    reg     [7:0] operand2_d;
    reg     [7:0] result_d;

    always @(posedge CLK or negedge RST) begin
        if (~RST) begin
            current_state <= IDLE;
            operand1_q    <= 8'b0;
            operand2_q    <= 8'b0;
            result_q      <= 8'd0;
        end
        else begin
            current_state <= next_state;
            operand1_q    <= operand1_d;
            operand2_q    <= operand2_d;
            result_q      <= result_d;
        end
    end

    always @(*) begin
        next_state   = current_state;
        operand1_d   = operand1_q;
        operand2_d   = operand2_q;
        result_d     = result_q;
        FIFO_Wr_Data = 8'd0;
        WrData       = 8'd0;
        ALU_FUN      = 4'd0;
        Address      = 4'd0;
        FIFO_Wr_INC  = 1'b0;
        clk_div_en   = 1'b1;
        ALU_EN       = 1'b0;
        CLK_EN       = 1'b0;
        WrEn         = 1'b0;
        RdEn         = 1'b0;

        case (current_state)
            IDLE: begin
                if (RX_D_VLD) begin
                    if (RX_P_DATA == 8'hAA) begin
                        next_state = RF_Wr_Addr;
                    end
                    else if (RX_P_DATA == 8'hBB) begin
                        next_state = RF_Rd_Addr;
                    end
                    else if (RX_P_DATA == 8'hCC) begin
                        next_state = OperandA;
                    end
                    else if (RX_P_DATA == 8'hDD) begin
                        next_state = NOP_ALU_FUN;
                    end
                end
            end
            RF_Wr_Addr: begin
                if (RX_D_VLD) begin
                    next_state = RF_Wr_Data;
                    operand1_d = RX_P_DATA;
                end
            end
            RF_Wr_Data: begin
                if (RX_D_VLD) begin
                    next_state = Perform_Write;
                    operand2_d = RX_P_DATA;
                end
            end
            Perform_Write: begin
                next_state = IDLE;
                WrData     = operand2_q;
                Address    = operand1_q;
                WrEn       = 1'b1;
            end
            RF_Rd_Addr: begin
                if (RX_D_VLD) begin
                    next_state = Perform_Read;
                end
            end
            Perform_Read: begin
                next_state = Transmit_Read_Data;
                operand1_d = RX_P_DATA;
                Address    = RX_P_DATA;
                RdEn       = 1'b1;
            end
            Transmit_Read_Data: begin
                if (~RdData_Valid) begin
                    Address = operand1_q;
                    RdEn    = 1'b1;
                end
                else if (~FIFO_FULL) begin
                    next_state   = IDLE;
                    FIFO_Wr_Data = RdData;
                    FIFO_Wr_INC  = 1'b1;
                end
            end
            OperandA: begin
                if (RX_D_VLD) begin
                    next_state = OperandB;
                end
            end
            OperandB: begin
                if (RX_D_VLD) begin
                    next_state = OP_ALU_FUN;
                end
                else begin
                    WrData     = RX_P_DATA;
                    Address    = 4'd0;
                    WrEn       = 1'b1;
                end
            end
            OP_ALU_FUN: begin
                if (RX_D_VLD) begin
                    next_state = Perform_OP_ALU;
                end
                else begin
                    WrData     = RX_P_DATA;
                    Address    = 4'd1;
                    WrEn       = 1'b1;
                end
            end
            Perform_OP_ALU: begin
                next_state = Transmit_Result;
                operand2_d = RX_P_DATA;
                ALU_FUN    = RX_P_DATA[3:0];
                CLK_EN     = 1'b1;
                ALU_EN     = 1'b1;
            end
            NOP_ALU_FUN: begin
                if (RX_D_VLD) begin
                    next_state = Perform_NOP_ALU;
                end
            end
            Perform_NOP_ALU: begin
                next_state = Transmit_Result;
                operand2_d = RX_P_DATA;
                ALU_FUN    = RX_P_DATA[3:0];
                CLK_EN     = 1'b1;
                ALU_EN     = 1'b1;
            end
            Transmit_Result: begin
                if (~OUT_Valid) begin
                    ALU_FUN = operand2_q[3:0];
                    CLK_EN  = 1'b1;
                    ALU_EN  = 1'b1;
                end
                else begin
                    result_d = ALU_OUT[7:0];
                    if (~FIFO_FULL) begin
                        next_state   = IDLE;
                        FIFO_Wr_Data = ALU_OUT[7:0];
                        FIFO_Wr_INC  = 1'b1;
                    end
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
