module Serializer (
    input  wire       CLK,
    input  wire       RST,
    input  wire       ser_en,
    input  wire       Data_Valid,
    input  wire       busy,
    input  wire [7:0] P_DATA,
    output wire       ser_done,
    output reg        ser_data
);
    reg [7:0] registered_data;
    integer i;

    Counter counter (
        .CLK(CLK),
        .RST(RST),
        .en(ser_en & ~(Data_Valid & ~busy)),
        .done(ser_done)
    );

    always @(posedge CLK or negedge RST) begin
        if (~RST) begin
            ser_data <= 1'b1;
            registered_data <= 8'hFF;
        end
        else if (Data_Valid & ~busy) begin
            ser_data <= 1'b1;
            registered_data <= P_DATA;
        end
        else begin
            ser_data <= 1'b1;
            if (ser_en) begin
                ser_data <= registered_data[0];
                for (i = 0; i < 7; i = i + 1) begin
                    registered_data[i] <= registered_data[i + 1];
                end
                registered_data[7] <= 1'b1;
            end
            else if (ser_done) begin
                ser_data <= 1'b1;
            end
        end
    end
endmodule
