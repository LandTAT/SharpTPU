// Simple Dual Port RAM
module z_sdpram
#(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 128,
    parameter DEPTH = 192,              // ADDR_WIDTH >= $clog2(DEPTH)
    parameter LATENCY = 2,              // read latency
    parameter RAMTYPE = "auto"          // auto, block, distributed, register
)
(
    input   clk,

    input   ena_w,
    input   wea,
    input   [ADDR_WIDTH-1: 0]    addr_w,
    input   [DATA_WIDTH-1: 0]    din,

    input   ena_r,
    input   [ADDR_WIDTH-1: 0]    addr_r,
    output  [DATA_WIDTH-1: 0]    dout
);

(* ram_style = RAMTYPE *)
reg  [DATA_WIDTH-1: 0]   ram [DEPTH-1: 0];

reg  [DATA_WIDTH-1: 0] o_reg [LATENCY-1: 0];

assign dout = o_reg[LATENCY-1];

always @(posedge clk)
begin
    if (ena_r)
        o_reg[0] <= ram[addr_r];
end

genvar i;
generate
    for (i = 0; i < LATENCY - 1; i = i + 1)
    begin
        always @(posedge clk)
        begin
            if (ena_r)
                o_reg[i + 1] <= o_reg[i];
        end
    end
endgenerate

always @(posedge clk)
begin
    if (ena_w & wea)
        ram[addr_w] <= din;
end

endmodule
