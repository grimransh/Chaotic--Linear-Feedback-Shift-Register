module top (
    input clk,
    input rst
);
    wire [7:0] R_random;
    wire [7:0] G_random;
    wire [7:0] B_random;
    wire Key_ready;
    wire done;

    // Instantiate main module (LFSR + chaotic)
    main u_main (
        .clk(clk),
        .rst(rst),
        .Rout(R_random),
        .Gout(G_random),
        .Bout(B_random),
        .Key_ready(Key_ready)
    );

    // Instantiate encrypt module
    encrypt u_encrypt (
        .clk(clk),
        .rst(rst),
        .Key_ready(Key_ready),
        .R_random(R_random),
        .G_random(G_random),
        .B_random(B_random),
        .done(done)
    );
endmodule
