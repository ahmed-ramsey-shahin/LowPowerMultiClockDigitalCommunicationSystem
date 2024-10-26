module Counter (
    input  wire      CLK,
    input  wire      RST,
    input  wire      en,
    output reg       done
);
    reg [2:0] counter;

    always @(posedge CLK or negedge RST) begin
        if (~RST) begin
            counter <= 3'h0;
            done    <= 1'b0;
        end
        else begin
            done <= 1'b0;
            if (en) begin
                counter <= counter + 1'b1;
                if (counter == 3'b111) begin
                    done    <= 1'b1;
                end
            end
        end
    end
endmodule
