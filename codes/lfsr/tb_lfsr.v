`timescale 1ns / 1ps
`include"lfsr.v"
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
        $monitor("time=%0t out=%b", $time, out);

        rst = 1;
        #5;
        rst = 0;

        #1000;
        $finish;
    end
endmodule
