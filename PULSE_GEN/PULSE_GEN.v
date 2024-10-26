module PULSE_GEN (
    input  wire CLK,
    input  wire RST,
    input  wire LVL_SIG,
    output wire PULSE_SIG
);
    reg receive_flop;
    reg pulse_flop;

    always @(posedge CLK or negedge RST) begin
        if (~RST) begin
            receive_flop <= 1'b0;
            pulse_flop   <= 1'b0;
        end
        else begin
            receive_flop <= LVL_SIG;
            pulse_flop   <= receive_flop;
        end
    end

    assign PULSE_SIG = receive_flop & ~pulse_flop;
endmodule
