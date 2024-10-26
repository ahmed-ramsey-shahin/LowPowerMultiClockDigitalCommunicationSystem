module DATA_SYNC #(parameter NUM_STAGES=2, parameter BUS_WIDTH=8) (
    input  wire                 CLK,
    input  wire                 RST,
    input  wire                 bus_enable,
    input  wire [BUS_WIDTH-1:0] unsync_bus,
    output reg  [BUS_WIDTH-1:0] sync_bus,
    output reg                  enable_pulse
);
    integer                i;
    wire                   pulse_generator_output;
    reg     [NUM_STAGES-1:0] synchronizer;

    Pulse_Gen pulse_generator (
        .CLK(CLK),
        .RST(RST),
        .x(synchronizer[NUM_STAGES-1]),
        .y(pulse_generator_output)
    );

    always @(posedge CLK or negedge RST) begin
        if (~RST) begin
            synchronizer <= 'b0;
            enable_pulse <= 1'b0;
            sync_bus     <= 1'b0;
        end
        else begin
            sync_bus        <= (pulse_generator_output ? unsync_bus : sync_bus);
            enable_pulse    <= pulse_generator_output;
            synchronizer[0] <= bus_enable;
            for (i = 1; i < BUS_WIDTH; i = i + 1) begin
                synchronizer[i] <= synchronizer[i - 1];
            end
        end
    end
endmodule
