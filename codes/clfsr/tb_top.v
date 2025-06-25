`include "Encrypt.v"
`include "main.v"
`include"top.v"

`timescale 1ns/1ps

module tb_top;

    reg clk;
    reg rst;

    wire done;

    top uut (
        .clk(clk),
        .rst(rst)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_top);
        rst = 1;
        #20;
        rst = 0;

        # 13107200 ; 
        $display("Simulation finished.");
        $finish;
    end
endmodule