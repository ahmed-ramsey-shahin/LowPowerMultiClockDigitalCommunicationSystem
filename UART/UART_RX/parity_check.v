module parity_check (
    input  wire       CLK,
    input  wire       RST,
    input  wire       par_chk_en,
    input  wire       PAR_TYP,
    input  wire       sampled_bit,
    input  wire [7:0] P_DATA,
    output reg        par_err
);
    always @(posedge CLK or negedge RST) begin
        if (~RST) begin
            par_err <= 1'd0;
        end
        else begin
            if (par_chk_en) begin
                if (~PAR_TYP) begin
                    par_err <= (^P_DATA != sampled_bit);
                end
                else begin
                    par_err <= (~^P_DATA != sampled_bit);
                end
            end
        end
    end
endmodule
