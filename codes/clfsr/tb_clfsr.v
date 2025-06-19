`timescale 1ns / 1ps

module tb_clfsr;

    reg clk;
    reg rst;
    wire out;

    clfsr uut (
        .clk(clk),
        .rst(rst),
        .out(out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end
    initial begin
        rst = 1;
        #20;
        rst = 0;

        #500; 
        $stop;

        $dumpfile("clfsr_tb.vcd");
        $dumpvars(0, tb_clfsr);
    end

    always @(posedge clk) begin
        $display(out);
        // $display("Time=%0t | rst=%b | out=%b", $time, rst, out);
        
        // $finish;
    end

endmodule
