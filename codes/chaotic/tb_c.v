module tb_c;

    reg clk;
    reg rst;
    wire chaos_bit;

    c uut (
        .clk(clk),
        .rst(rst),
        .out(chaos_bit)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        #10;
        rst = 0;
    end

    initial begin
        $monitor("%b", chaos_bit);
        #200 $finish;
    end

    initial begin
        $dumpfile("c.vcd");   
        $dumpvars(0, tb_c);   
    end

endmodule
