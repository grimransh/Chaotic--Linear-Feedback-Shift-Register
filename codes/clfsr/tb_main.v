`include "main.v"
`timescale 1ps/1ps

module tb_main;
    reg clk;
    reg rst;
    wire [7:0] Rout;
    wire [7:0] Gout;
    wire [7:0] Bout;
    wire Key_ready;
    
    integer file;      // Declare file handle
    integer count = 0; // Declare and initialize count
    
    main uut( .clk(clk), .rst(rst), .Rout(Rout), .Gout(Gout), .Bout(Bout), .Key_ready(Key_ready));

    initial clk = 0;
    always #5 clk = ~clk;
    initial begin
        $dumpfile("main.vcd");
        $dumpvars(0,tb_main);
        // $monitor("Time=%0t | out=%b", $time, out);
        rst = 1;
        #10;
        rst = 0;
        file = $fopen("output_bits.txt", "w");
        #4000000;
        $fclose(file);
        $finish;
    end

    always @(posedge clk) begin
        if (Key_ready) begin
            // Write Rout, Gout, Bout to file in binary format
            $fwrite(file, "%b%b%b\n", Rout, Gout, Bout);
            count = count + 1;
        end
    end

endmodule