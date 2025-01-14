module strt_check (
    input  wire       CLK,
    input  wire       RST,
    input  wire       strt_chk_en,
    input  wire       sampled_bit,
    output reg        strt_glitch
);
    always @(posedge CLK or negedge RST) begin
        if (~RST) begin
            strt_glitch <= 1'd0;
        end
        else begin
            if (strt_chk_en) begin
                strt_glitch <= (sampled_bit != 1'd0);
            end
        end
    end
endmodule
