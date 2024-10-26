module RST_SYNC (
    input  wire CLK,
    input  wire RST,
    output reg  SYNC_RST
);
    reg Q;
    always @(posedge CLK or negedge RST) begin
        if (~RST) begin
            Q        <= 1'b0;
            SYNC_RST <= 1'b0;
        end
        else begin
            Q        <= 1'b1;
            SYNC_RST <= Q;
        end
    end
endmodule
