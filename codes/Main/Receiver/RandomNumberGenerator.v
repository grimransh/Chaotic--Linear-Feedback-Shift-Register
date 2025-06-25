module RandomNumberGenerator(clk, rst, Rout, Gout, Bout, Key_ready);
    input wire clk;
    input wire rst;
    output reg [7:0] Rout;
    output reg [7:0] Gout;
    output reg [7:0] Bout;

    output reg Key_ready;

    wire Rout_bit;
    wire Gout_bit;
    wire Bout_bit;


    reg[15:0] Rlfsr;
    reg[15:0] Glfsr;
    reg[15:0] Blfsr;

    reg [2:0] bit_count;

    wire Rfeedback_lfsr;
    wire Gfeedback_lfsr;
    wire Bfeedback_lfsr;
    wire Rout_lfsr;
    wire Gout_lfsr;
    wire Bout_lfsr;

    reg signed [15:0] x; 
    reg signed [31:0] x_square; 
    reg signed [31:0] x_mult;  
    reg signed [15:0] x_next;
    wire out_chaotic;
    
    
    assign Rfeedback_lfsr = Rlfsr[15] ^ Rlfsr[13] ^ Rlfsr[12] ^ Rlfsr[10]; 
    assign Gfeedback_lfsr = Glfsr[15] ^ Glfsr[13] ^ Glfsr[12] ^ Glfsr[10]; 
    assign Bfeedback_lfsr = Blfsr[15] ^ Blfsr[13] ^ Blfsr[12] ^ Blfsr[10]; 
    assign Rout_lfsr = Rlfsr[15];
    assign Gout_lfsr = Glfsr[15];
    assign Bout_lfsr = Blfsr[15];


    assign out_chaotic = x_next[15];
    
    assign Rout_bit = Rout_lfsr ^ out_chaotic;
    assign Gout_bit = Gout_lfsr ^ out_chaotic;
    assign Bout_bit = Bout_lfsr ^ out_chaotic;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            Rlfsr <= 16'b0000000000000001;
            Glfsr <= 16'b0000000000000010;
            Blfsr <= 16'b0000000000000011;
            x <= 16'sh7EF0;                         // x=0.9917;

            Rout <= 8'b0;
            Gout <= 8'b0;
            Bout <= 8'b0;
            Key_ready <= 0;
            bit_count <=0;

            x_square <= 0;
            x_next <= 0;
            x_mult <= 0;
        end
        else begin
            Rlfsr <= {Rlfsr[14:0], Rfeedback_lfsr};
            Glfsr <= {Glfsr[14:0], Gfeedback_lfsr};
            Blfsr <= {Blfsr[14:0], Bfeedback_lfsr};
            
            Rout <= {Rout[6:0], Rout_bit};
            Gout <= {Gout[6:0], Gout_bit};
            Bout <= {Bout[6:0], Bout_bit};

            if (bit_count == 3'd7) begin
                // Rout <= {Rout[6:0], Rout_bit};
                // Gout <= {Gout[6:0], Gout_bit};
                // Bout <= {Bout[6:0], Bout_bit};
            

                Key_ready <= 1;  // Byte is ready
                bit_count <= 0;
            end 
            else begin
                Key_ready <= 0;
                bit_count <= bit_count + 1;
            end



            x_square <= x * x;                       // Q2.30
            x_mult <= x_square <<< 1;                // Multiply by 2
            x_next <= 16'sh7FFF - x_mult[30:15];     // 16'h7FFF ~ +0.99997
            x <= x_next;
        end
    end


endmodule
