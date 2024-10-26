module parity_calc (
    input  wire       CLK,
    input  wire       RST,
    input  wire       Data_Valid,
    input  wire       PAR_TYP,
    input  wire [7:0] P_DATA,
    input  wire       busy,
    output reg        par_bit
);
    reg [7:0] registered_data;
    reg       registered_type;

    always @(posedge CLK or negedge RST) begin
        if (~RST) begin
            par_bit         <= 1'b0;
            registered_data <= 8'b0;
            registered_type <= 1'b0;
        end
        else begin
            if (Data_Valid && ~busy) begin
                registered_data <= P_DATA;
                registered_type <= PAR_TYP;
            end
            if (~registered_type) begin
                par_bit <= ^registered_data;
            end
            else begin
                par_bit <= ~^registered_data;
            end
        end
    end
endmodule
