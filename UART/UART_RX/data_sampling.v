module data_sampling (
    input  wire        CLK,
    input  wire        RST,
    input  wire        dat_samp_en,
    input  wire [4:0]  edge_cnt,
    input  wire        RX_IN,
    input  wire [5:0]  prescale,
    output reg         sampled_bit
);
    reg first_bit;
    reg second_bit;
    reg third_bit;

    always @(posedge CLK or negedge RST) begin
        if (~RST) begin
            first_bit   <= 1'd0;
            second_bit  <= 1'd0;
            third_bit   <= 1'd0;
        end
        else begin
            if (dat_samp_en) begin
                case (prescale)
                    6'd4: begin
                        if (edge_cnt == 5'd0) begin
                            first_bit  <= RX_IN;
                        end
                        else if (edge_cnt == 5'd1) begin
                            second_bit <= RX_IN;
                        end
                        else if (edge_cnt == 5'd2) begin
                            third_bit  <= RX_IN;
                        end
                    end
                    6'd8: begin
                        if (edge_cnt == 5'd2) begin
                            first_bit  <= RX_IN;
                        end
                        else if (edge_cnt == 5'd3) begin
                            second_bit <= RX_IN;
                        end
                        else if (edge_cnt == 5'd4) begin
                            third_bit  <= RX_IN;
                        end
                    end
                    6'd16: begin
                        if (edge_cnt == 5'd6) begin
                            first_bit  <= RX_IN;
                        end
                        else if (edge_cnt == 5'd7) begin
                            second_bit <= RX_IN;
                        end
                        else if (edge_cnt == 5'd8) begin
                            third_bit  <= RX_IN;
                        end
                    end
                    6'd32: begin
                        if (edge_cnt == 5'd14) begin
                            first_bit  <= RX_IN;
                        end
                        else if (edge_cnt == 5'd15) begin
                            second_bit <= RX_IN;
                        end
                        else if (edge_cnt == 5'd16) begin
                            third_bit  <= RX_IN;
                        end
                    end
                    default: begin
                        if (edge_cnt == 5'd2) begin
                            first_bit  <= RX_IN;
                        end
                        else if (edge_cnt == 5'd3) begin
                            second_bit <= RX_IN;
                        end
                        else if (edge_cnt == 5'd4) begin
                            third_bit  <= RX_IN;
                        end
                    end
                endcase
            end
        end
    end

    always @(*) begin
        case ({first_bit, second_bit, third_bit})
            3'b000: sampled_bit = 1'd0;
            3'b001: sampled_bit = 1'd0;
            3'b010: sampled_bit = 1'd0;
            3'b011: sampled_bit = 1'd1;
            3'b100: sampled_bit = 1'd0;
            3'b101: sampled_bit = 1'd1;
            3'b110: sampled_bit = 1'd1;
            3'b111: sampled_bit = 1'd1;
        endcase
    end
endmodule
