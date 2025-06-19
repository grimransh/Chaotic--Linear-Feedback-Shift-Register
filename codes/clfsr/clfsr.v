module clfsr (
    input wire clk,
    input wire rst,
    output wire out
);
    reg [7:0] lfsr;
    wire feedback;
    wire lfsr_out;

    assign feedback = lfsr[7] ^ lfsr[5] ^ lfsr[4] ^ lfsr[3];
    assign lfsr_out = lfsr[0];

    always @(posedge clk or posedge rst) begin
        if (rst)
            lfsr <= 8'b00000001;
        else
            lfsr <= {lfsr[6:0], feedback};
    end




    reg [15:0] x; 
    wire [31:0] x_base;  // x(1-x)
    wire [31:0] x_mult;  // 4 * x * (1 - x)
    wire [15:0] x_next;
    wire chaos_bit;

    assign x_base = x * (16'h7FFF - x);
    assign x_mult = x_base << 2; 
    assign x_next = x_mult[30:15];      
    assign chaos_bit = x_next[15];      

    always @(posedge clk or posedge rst) begin
        if (rst)
            x <= 16'd16384; 
            
        else
            x <= x_next;
    end

    assign out = lfsr_out ^ chaos_bit;
endmodule
