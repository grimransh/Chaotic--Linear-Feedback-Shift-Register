`include "opamp.v"
`timescale 1ps/1ps

module tb_opamp;
    
    reg signed [15:0] chaotic_value;

    wire chaos_bit;

    opamp uut (
        chaotic_value,
        chaos_bit
    );

    initial begin
        $display("Time\tChaotic\tBit");
        $monitor("%0dns\t%h\t%b", $time, chaotic_value, chaos_bit);

        chaotic_value = 16'h4000;
        #10;

        chaotic_value =  16'h2000;
        #10;

        chaotic_value = 16'h8288;
        #10;

        chaotic_value = 16'hE667;
        #10;

        $finish;
    end

endmodule



    
