`include "tb_c.v"

module c (
    input wire clk,
    input wire rst,
    output wire out
);

    reg [15:0] x;
    wire [31:0] x_base; //x * (1 - x)
    wire [31:0] x_mult; //4 * x * (1 - x)
    wire [15:0] x_next;

    assign x_base = x * (16'h7FFF - x);
    assign x_mult = x_base << 2;
    assign x_next = x_mult[30:15];
    assign out = x_next[15];

    always @(posedge clk or posedge rst) begin
        if (rst)
            x <= 16'd16384;
        else
            x <= x_next;
    end

endmodule
