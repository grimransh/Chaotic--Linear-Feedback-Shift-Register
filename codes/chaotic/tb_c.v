module testb;
    
    reg clk;
    reg reset;
    reg [15:0] x_init;   // Q8.8 format input
    reg [15:0] r;        // Q8.8 format control parameter or Bifurcation parameter

    
    wire [15:0] x_out;   // Q8.8 format output

    
    cmap_1 uut (
        .clk(clk),
        .reset(reset),
        .x_init(x_init),
        .r(r),
        .out(x_out)
    );

    
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        
        $monitor("Time: %0t | clk=%b | reset=%b | x_init=%0d | r=%0d | x_out=%0d", 
                 $time, clk, reset, x_init[15:0], r[15:0], x_out[15:7]);

        reset = 1;
        x_init = 16'd128;  // 0.5 in Q8.8
        r = 16'd998;       // 3.9 in Q8.8 (3.9 * 256)
        
        #20 reset = 0;
        
        #500;
        
        $finish;
    end

endmodule
