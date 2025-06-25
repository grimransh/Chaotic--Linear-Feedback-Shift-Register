`include "Decrypt.v"
`include "RandomNumberGenerator.v"
`include"main.v"

`timescale 1ns/1ps

module tb_main;

    reg clk;
    reg rst;

    wire done;

    main uut (
        .clk(clk),
        .rst(rst)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("main.vcd");
        $dumpvars(0, tb_main);
        rst = 1;
        #20;
        rst = 0;

        // Wait for decryption to finish
        wait(uut.uut2.done == 1);

        $display("Saving encrypted data to memory files...");
        $writememh("R_decrypted.mem", uut.uut2.R_decrypt);
        $writememh("G_decrypted.mem", uut.uut2.G_decrypt);
        $writememh("B_decrypted.mem", uut.uut2.B_decrypt);

        $display("Decryption done. Simulation finished.");
        $finish;
    end
endmodule