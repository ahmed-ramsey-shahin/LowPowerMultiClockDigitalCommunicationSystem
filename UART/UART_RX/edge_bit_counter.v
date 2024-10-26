module edge_bit_counter (
    input  wire       CLK,
    input  wire       RST,
    input  wire       enable,
    input  wire [5:0] prescale,
    output reg  [4:0] edge_cnt,
    output reg  [3:0] bit_cnt
);
    always @(posedge CLK or negedge RST) begin
        if (~RST) begin
            edge_cnt <= 32'h0;
            bit_cnt  <= 16'h0;
        end
        else begin
            if (enable) begin
                edge_cnt <= edge_cnt + 'b1;
                case (prescale)
                    6'd4: begin
                        if (edge_cnt == 5'd3) begin
                            bit_cnt  <= bit_cnt + 4'd1;
                            edge_cnt <= 5'd0;
                        end
                    end
                    6'd8: begin
                        if (edge_cnt == 5'd7) begin
                            bit_cnt  <= bit_cnt + 4'd1;
                            edge_cnt <= 5'd0;
                        end
                    end
                    6'd16: begin
                        if (edge_cnt == 5'd15) begin
                            bit_cnt  <= bit_cnt + 4'd1;
                            edge_cnt <= 5'd0;
                        end
                    end
                    6'd32: begin
                        if (edge_cnt == 5'd31) begin
                            bit_cnt  <= bit_cnt + 4'd1;
                            edge_cnt <= 5'd0;
                        end
                    end
                    default: begin
                        if (edge_cnt == 5'd7) begin
                            bit_cnt  <= bit_cnt + 4'd1;
                            edge_cnt <= 5'd0;
                        end
                    end
                endcase
            end
            else begin
                edge_cnt <= 5'd0;
                bit_cnt  <= 4'd0;
            end
        end
    end
endmodule
