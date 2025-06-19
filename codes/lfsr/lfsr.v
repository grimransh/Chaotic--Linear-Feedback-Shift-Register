module lfsr(clk, rst, out);
    
    input wire clk;
    input wire rst;
    output wire out;
    
    reg [7:0] lfsr;
    wire feedback;

    assign feedback = lfsr[7] ^ lfsr[5] ^ lfsr[4] ^ lfsr[3];
    assign out = lfsr[0];

    always @(posedge clk or posedge rst) begin
        if (rst)
            lfsr <= 8'b00000001;
        else
            lfsr <= {lfsr[6:0], feedback};
    end

endmodule
