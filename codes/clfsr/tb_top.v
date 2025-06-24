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
        $writememh("R_encrypted.mem", uut.u_encrypt.R_encrypt);
        $writememh("G_encrypted.mem", uut.u_encrypt.G_encrypt);
        $writememh("B_encrypted.mem", uut.u_encrypt.B_encrypt);
        $display("Saved to R_encrypted.mem, G_encrypted.mem, B_encrypted.mem.");
        $stop;
    end

    initial begin
        
        rst = 1;
        #20;
        rst = 0;

        #1000000; 
        $display("Simulation finished.");
        $stop;
    end
endmodule