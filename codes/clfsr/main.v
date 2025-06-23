module main(clk, rst, out);
    input wire clk;
    input wire rst;
    output wire out;

    reg[15:0] lfsr;
    wire feedback_lfsr;
    wire out_lfsr;

    reg signed [15:0] x; 
    reg signed [31:0] x_square; 
    reg signed [31:0] x_mult;  
    reg signed [15:0] x_next;
    wire out_chaotic;
    
    
    assign feedback_lfsr = lfsr[15] ^ lfsr[13] ^ lfsr[12] ^ lfsr[10]; 
    assign out_lfsr = lfsr[15];


    assign out_chaotic = x_next[15];
    
    assign out = out_lfsr ^ out_chaotic;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            lfsr <= 16'b0000000000000001;
            x <= 16'sh7EF0;                         // x=0.9917;

            x_square <= 0;
            x_next <= 0;
            x_mult <= 0;
        end
        else begin
            lfsr <= {lfsr[14:0], feedback_lfsr};
            
            x_square <= x * x;                       // Q2.30
            x_mult <= x_square <<< 1;
            x_next <= 16'sh7FFF - x_mult[30:15];     // 16'h7FFF ~ +0.99997
            x <= x_next;
        end
    end


endmodule