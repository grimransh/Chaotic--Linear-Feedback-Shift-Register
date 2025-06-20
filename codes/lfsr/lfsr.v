module lfsr(clk, rst, out);
    
    input wire clk;
    input wire rst;
    output wire out;
    
    reg [15:0] lfsr;
    wire feedback;
    
    assign feedback = lfsr[15] ^ lfsr[13] ^ lfsr[12] ^ lfsr[10]; 
    assign out = lfsr[15];

    always @(posedge clk or posedge rst) begin
        if (rst)
            lfsr <= 16'b0000000000000001;
        else begin
            lfsr <= {lfsr[14:0], feedback};
        end
    end

endmodule
