`include"quadratic.v"
`timescale 1ps/1ps
module tb_quadratic;
    reg clk;
    reg rst;
    wire signed [15:0] out;
    
    quadratic uut (
        .clk(clk),
        .rst(rst),
        .out(out)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("quadratic.vcd");
        $dumpvars(0, tb_quadratic);
        $monitor("time=%0t out=%b", $time, out);
        
        rst = 5;
        #5;
        rst = 0;

        #10000;
        $finish;
    end

endmodule