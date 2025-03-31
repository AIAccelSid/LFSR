module lfsr #(
    parameter WIDTH = 32,
    parameter TAPS  = 32'h80200003  // Example for 32-bit LFSR
) (
    input         clk,
    input         rst,
    output [WIDTH-1:0] lfsr_out
);

reg [WIDTH-1:0] lfsr_reg;

always @(posedge clk or posedge rst) begin
    if (rst)
        lfsr_reg <= 32'h1;  // Seed
    else
        lfsr_reg <= {lfsr_reg[WIDTH-2:0], ^(lfsr_reg & TAPS)};
end

assign lfsr_out = lfsr_reg;

endmodule
`timescale 1ns/1ps

`timescale 1ns/1ps

module lfsr_tb;
    // Parameter declaration
    parameter WIDTH = 32;

    // Signal declarations
    reg clk;
    reg rst;
    wire [WIDTH-1:0] lfsr_out;

    // Instantiate the LFSR module
    lfsr #(
        .WIDTH(WIDTH),
        .TAPS(32'h80200003)
    ) uut (
        .clk(clk),
        .rst(rst),
        .lfsr_out(lfsr_out)
    );

    // Clock generation: 10 ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Dump waveforms and monitor signals
    initial begin
        $dumpfile("lfsr_tb.vcd");
        $dumpvars(0, lfsr_tb);
        $monitor("Time: %0t | rst: %b | lfsr_out: %h", $time, rst, lfsr_out);
    end

    // Test sequence
    initial begin
        rst = 1;         // Assert reset
        #10;
        rst = 0;         // De-assert reset

        // Run simulation for enough time to observe behavior
        #500;
        $display("Simulation complete at time %0t", $time);
        $finish;
    end
endmodule