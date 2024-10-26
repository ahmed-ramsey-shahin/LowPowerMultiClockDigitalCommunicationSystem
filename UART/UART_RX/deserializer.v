module deserializer (
    input  wire       CLK,
    input  wire       RST,
    input  wire       deser_en,
    input  wire       sampled_bit,
    output reg  [7:0] P_DATA
);
    always @(posedge CLK or negedge RST) begin
        if (~RST) begin
            P_DATA <= 8'h0;
        end
        else begin
            if (deser_en) begin
                P_DATA <= {sampled_bit, P_DATA[7:1]};
            end
        end
    end
endmodule
