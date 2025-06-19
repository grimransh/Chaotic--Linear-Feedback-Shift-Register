`timescale 1ns / 1ps

module tb_lfsr;
    reg clk;
    reg rst;
    wire out;

    lfsr uut (
        .clk(clk),
        .rst(rst),
        .out(out)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin

        $dumpfile("lfsr.vcd");
        $dumpvars(0, tb_lfsr);
        $monitor(out);
        clk = 0;
        rst = 1;
        #10;
        rst = 0;

        #1000;
        $finish;
    end
endmodule
