module PrescaleMux (
    input  wire [5:0] prescale,
    output reg  [7:0] division_ratio
);
    always @(*) begin
        case (prescale)
            6'd32  : division_ratio = 8'd1;
            6'd16  : division_ratio = 8'd2;
            6'd8   : division_ratio = 8'd4;
            6'd4   : division_ratio = 8'd8;
            default: division_ratio = 8'd1;
        endcase
    end
endmodule

