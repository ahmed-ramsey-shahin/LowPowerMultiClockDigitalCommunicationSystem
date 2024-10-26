module RegFile #(parameter WIDTH=8, DEPTH=16, ADDRESS=4) (
    input  wire               CLK,
    input  wire               RST,
    input  wire [WIDTH-1:0]   WrData,
    input  wire [ADDRESS-1:0] Address,
    input  wire               WrEn,
    input  wire               RdEn,
    output reg  [WIDTH-1:0]   RdData,
    output reg                RdData_Valid,
    output wire [WIDTH-1:0]   REG0,
    output wire [WIDTH-1:0]   REG1,
    output wire [WIDTH-1:0]   REG2,
    output wire [WIDTH-1:0]   REG3
);
    integer i;
    reg [WIDTH-1:0] register_file [0:DEPTH-1];

    always @(posedge CLK or negedge RST) begin
        if (~RST) begin
            RdData_Valid <= 1'b0;
            RdData       <= 1'b0;
            for (i = 0; i < DEPTH; i = i + 1) begin
                if (i == 2) begin
                    register_file[i] <= {WIDTH{8'b1000_0001}};
                end
                else if (i == 3) begin
                    register_file[i] <= {WIDTH{8'b0010_0000}};
                end
                else begin
                    register_file[i] <= {WIDTH{1'b0}};
                end
            end
        end
        else if (WrEn && ~RdEn) begin
            register_file[Address] <= WrData;
        end
        else if (RdEn && ~WrEn) begin
            RdData       <= register_file[Address];
            RdData_Valid <= 1'b1;
        end
        else begin
            RdData_Valid <= 1'b0;
        end
    end

    assign REG0 = register_file[0];
    assign REG1 = register_file[1];
    assign REG2 = register_file[2];
    assign REG3 = register_file[3];
endmodule
