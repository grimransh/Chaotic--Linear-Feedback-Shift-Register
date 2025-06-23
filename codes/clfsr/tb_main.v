`include "main.v"
`timescale 1ps/1ps

module tb_main;
    reg clk;
    reg rst;
    wire out;
    
    main uut( .clk(clk), .rst(rst), .out(out));

    initial clk = 0;
    always #5 clk = ~clk;
    initial begin
        $dumpfile("main.vcd");
        $dumpvars(0,tb_main);
        $monitor("Time=%0t | out=%b", $time, out);
        rst = 1;
        #10;
        rst = 0;
        #1000;
        $finish;
    end

endmodule