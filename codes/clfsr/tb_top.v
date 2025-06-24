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


    always @(posedge uut.u_encrypt.done) begin
        $display("Encryption done. Saving output...");
        $writememh("R.mem", uut.u_encrypt.R_encrypt);
        $writememh("G.mem", uut.u_encrypt.G_encrypt);
        $writememh("B.mem", uut.u_encrypt.B_encrypt);
        $display("Saved to R_out.mem, G_out.mem, B _out.mem.");
        $finish;
    end

    initial begin
        
        rst = 1;
        #20;
        rst = 0;

        # 13107200 ; 
        $display("Simulation finished.");
        $finish;
    end
endmodule