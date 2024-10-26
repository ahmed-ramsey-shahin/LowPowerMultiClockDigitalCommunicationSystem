module ASYC_FIFO #(parameter DATA_WIDTH=8) (
    input  wire [DATA_WIDTH-1:0] WR_DATA,
    input  wire                  W_CLK,
    input  wire                  W_RST,
    input  wire                  W_INC,
    input  wire                  R_CLK,
    input  wire                  R_RST,
    input  wire                  R_INC,
    output wire                  FULL,
    output wire                  EMPTY,
    output reg  [DATA_WIDTH-1:0] RD_DATA
);
    reg  [DATA_WIDTH-1:0] memory [0:15];
    reg  [4:0] W_PTR;
    reg  [4:0] R_PTR;
    
    wire [4:0] rq2_wptr;
    wire [4:0] wq2_rptr;
    wire [4:0] R_PTR_GRAY_CODE;
    wire [4:0] W_PTR_GRAY_CODE;
    wire [3:0] W_ADDRESS;
    wire [3:0] R_ADDRESS;

    integer i;

    assign W_ADDRESS = W_PTR[3:0];
    assign R_ADDRESS = R_PTR[3:0];

    GrayCodeEncoder R_PTR_GRAY_CODE_ENCODER (
        .x(R_PTR),
        .y(R_PTR_GRAY_CODE)
    );

    GrayCodeEncoder W_PTR_GRAY_CODE_ENCODER (
        .x(W_PTR),
        .y(W_PTR_GRAY_CODE)
    );

    BitSync sync_w2r (
        .CLK(R_CLK),
        .RST(R_RST),
        .unsync_bit(W_PTR_GRAY_CODE),
        .sync_bit(rq2_wptr)
    );

    BitSync sync_r2w (
        .CLK(W_CLK),
        .RST(W_RST),
        .unsync_bit(R_PTR_GRAY_CODE),
        .sync_bit(wq2_rptr)
    );

    always @(posedge W_CLK or negedge W_RST) begin
        if (~W_RST) begin
            W_PTR <= 'b0;
            // Reset the memory
            for (i = 0; i < 16; i = i + 1) begin
                memory[i] <= 'd0;
            end
        end
        else if (W_INC && ~FULL) begin
            memory[W_ADDRESS] <= WR_DATA;
            W_PTR             <= W_PTR + 1'd1;
        end
    end

    always @(posedge R_CLK or negedge R_RST) begin
        if (~R_RST) begin
            RD_DATA <= 'b0;
        end
        else begin
            RD_DATA <= memory[R_ADDRESS];
        end
    end

    always @(posedge R_CLK or negedge R_RST) begin
        if (~R_RST) begin
            R_PTR   <= 'b0;
        end
        else if (R_INC & ~EMPTY) begin
            R_PTR   <= R_PTR + 1'd1;
        end
    end

    assign FULL  = (rq2_wptr[4] != wq2_rptr[4]) && (rq2_wptr[3] != wq2_rptr[3]) && (rq2_wptr[2:0] == wq2_rptr[2:0]);
    assign EMPTY = (rq2_wptr == wq2_rptr);
endmodule
