`include "Encrypt.v"
`include "RandomNumberGenerator.v"
`include "main.v"

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
       wait (uut.done == 1);

        // Save encrypted output after done signal
        $display("Saving encrypted data to memory files...");
        $writememh("R_encrypted.mem", uut.uut2.R_encrypt);
        $writememh("G_encrypted.mem", uut.uut2.G_encrypt);
        $writememh("B_encrypted.mem", uut.uut2.B_encrypt);

        $display("Encryption done. Simulation finished.");
        $finish;
    end
endmodule