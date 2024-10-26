module BitSync (
    input  wire       CLK,
    input  wire       RST,
    input  wire [4:0] unsync_bit,
    output reg  [4:0] sync_bit
);
    reg [4:0] Q;

    always @(posedge CLK or negedge RST) begin
        if (~RST) begin
            Q        <= 5'b0;
            sync_bit <= 5'b0;
        end
        else begin
            Q        <= unsync_bit;
            sync_bit <= Q;
        end
    end
endmodule
