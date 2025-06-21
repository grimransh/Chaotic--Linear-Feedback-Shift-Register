`include "opamp.v"
`timescale 1ps/1ps

module tb_opamp;
    
    reg [15:0] chaotic_value;

    wire out;

    opamp uut (
        chaotic_value,
        chaos_bit
    );

    initial begin
        $display("Time\tChaotic\tRef\tBit");
        $monitor("%0dns\t%h\t%h\t%b", $time, chaotic_value, ref_value, chaos_bit);

        chaotic_value = 16'h0200;   // 2.0 in Q8.8
        #10;

        chaotic_value = 16'h0080;   // 0.5 in Q8.8
        #10;

        chaotic_value = 16'h0040;   // 0.25 in Q8.8
        #10;

        chaotic_value = 16'h0133;   // ~1.199
        #10;

        $finish;
    end

endmodule



    
