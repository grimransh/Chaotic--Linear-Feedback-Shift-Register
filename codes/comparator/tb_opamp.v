`include "opamp.v"
`timescale 1ps/1ps

module tb_opamp;

    reg signed [15:0] in;
    reg clk;
    wire out;
    opamp uut(
        .in(in),
        .out(out)
    );
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("opamp.vcd");
        $dumpvars(0,tb_opamp);

        // Q1.15: -1.0 = 16'h8000, +0.99997 = 16'h7FFF
        repeat (40) begin
            in = ($random % 65536) - 32768; // Generates -32768 to 32767
            #5;
            $display("in = %d, out = %b, as float = %f", in, out, in / 32768.0);
        end
        in = -1;
        #5;
        $display("in (Q1.15) = %d, out = %b, as float = %f", in, out, in / 32768.0);
        $finish;
    end
endmodule