module Pulse_Gen (
    input  wire CLK,
    input  wire RST,
    input  wire x,
    output wire y
);
    reg Q;

    always @(posedge CLK or negedge RST) begin
        if (~RST) begin
            Q <= 1'b0;
        end
        else begin
            Q <= x;
        end
    end

    assign y = ~Q & x;
endmodule
