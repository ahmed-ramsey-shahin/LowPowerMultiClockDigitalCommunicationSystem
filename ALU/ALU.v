module ALU #(parameter OPER_WIDTH=8, OUT_WIDTH=2*OPER_WIDTH) (
    input  wire                  CLK,
    input  wire                  RST,
    input  wire [OPER_WIDTH-1:0] A,
    input  wire [OPER_WIDTH-1:0] B,
    input  wire                  EN,
    input  wire [3:0]            ALU_FUN,
    output reg  [OUT_WIDTH-1:0]  ALU_OUT,
    output reg                   OUT_VALID
);
    always @(posedge CLK or negedge RST) begin
        if (~RST) begin
            ALU_OUT   <= 'b0;
            OUT_VALID <= 1'b0;
        end
        else if (EN) begin
            OUT_VALID <= 1'b1;
            case (ALU_FUN)
            4'b0000: begin
                ALU_OUT <= A + B;
            end
            4'b0001: begin
                ALU_OUT <= A - B;
            end
            4'b0010: begin
                ALU_OUT <= A * B;
            end
            4'b0011: begin
                ALU_OUT <= A / B;
            end
            4'b0100: begin
                ALU_OUT <= A & B;
            end
            4'b0101: begin
                ALU_OUT <= A | B;
            end
            4'b0110: begin
                ALU_OUT <= ~(A & B);
            end
            4'b0111: begin
                ALU_OUT <= ~(A | B);
            end
            4'b1000: begin
                ALU_OUT <= A ^ B;
            end
            4'b1001: begin
                ALU_OUT <= ~(A ^ B);
            end
            4'b1010: begin
                if (A == B) begin
                    ALU_OUT <= 'b1;
                end
                else begin
                    ALU_OUT <= 'b0;
                end
            end
            4'b1011: begin
                if (A > B) begin
                    ALU_OUT <= 'b10;
                end
                else begin
                    ALU_OUT <= 'b0;
                end
            end
            4'b1100: begin
                if (A < B) begin
                    ALU_OUT <= 'b11;
                end
                else begin
                    ALU_OUT <= 'b0;
                end
            end
            4'b1101: begin
                ALU_OUT <= A >> 1;
            end
            4'b1110: begin
                ALU_OUT <= A << 1;
            end
            default: begin
                ALU_OUT <= 'b0;
            end
            endcase
        end
        else begin
            OUT_VALID <= 1'b0;
        end
    end
endmodule
