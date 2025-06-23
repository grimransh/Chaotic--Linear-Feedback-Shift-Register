module quadratic(clk, rst, out);
    input wire clk;
    input wire rst;
    output wire [15:0]out;

    reg signed [15:0] x; 
    wire signed [31:0] x_square;  // x(1-x)
    wire signed [31:0] x_mult;  // 4 * x * (1 - x)
    wire signed [15:0] x_next;


    assign x_square = x * x;        // Q2.30
    assign x_mult = x_square <<< 2;
    assign x_next = 16'sh7FFF - x_mult[30:15];  // 16'h7FFF ~ +0.99997
    assign out = x_next;
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            x <= 16'sh7EF0;      // x=0.9917;
        end
        else begin
            x <= x_next;
        end
    end


endmodule