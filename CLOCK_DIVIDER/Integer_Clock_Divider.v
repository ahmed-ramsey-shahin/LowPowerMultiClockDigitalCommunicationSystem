module Integer_Clock_Divider (
    input  wire       i_ref_clk,
    input  wire       i_rst_n,
    input  wire       i_clk_en,
    input  wire [7:0] i_div_ratio,
    output wire       o_div_clk
);
    reg [7:0] counter;
    reg       divided_clk;
    reg       is_clk_low;
    
    always @(posedge i_ref_clk or negedge i_rst_n) begin
        if (~i_rst_n) begin
            counter     <= 8'b0;
            divided_clk <= 1'b0;
            is_clk_low  <= 1'b1;
        end
        else if (i_clk_en & (i_div_ratio != 1'b0 & i_div_ratio != 1'b1)) begin
            counter <= counter + 1'b1;
            
            if (i_div_ratio == 1'b0 | i_div_ratio == 1'b1) begin
                counter <= 8'b0;
            end
            else if (i_div_ratio[0] == 1'b0) begin
                // Division by even number
                if (counter == (i_div_ratio >> 1) - 1'd1) begin
                    counter     <= 8'b0;
                    divided_clk <= ~divided_clk;
                end
            end
            else if (i_div_ratio[0] == 1'b1) begin
                // Division by odd number
                if (is_clk_low) begin
                    if (counter == (i_div_ratio >> 1) - 1'd1) begin
                        counter     <= 8'b0;
                        divided_clk <= 1'b0;
                        is_clk_low  <= ~is_clk_low;
                    end
                end
                else begin
                    if (counter == (i_div_ratio >> 1)) begin
                        counter     <= 8'b0;
                        divided_clk <= 1'b1;
                        is_clk_low  <= ~is_clk_low;
                    end
                end
            end
        end
    end

    assign o_div_clk = (i_clk_en & (i_div_ratio != 1'b0 & i_div_ratio != 1'b1)) ? divided_clk : i_ref_clk;
endmodule

