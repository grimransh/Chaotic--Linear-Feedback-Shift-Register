module cmap_1(input clk,reset,
    input [15:0] x_init,r,
    output reg [15:0] out);

    reg [15:0] xn;
    reg [31:0] temp1,temp2;

    always @(posedge clk or reset) begin
        if( reset ) begin
            xn<=x_init;
        end

        else begin
            temp1<= xn*(16'd256-xn);      // 16'd256 = 00000001.00000000 = 1.0
            temp2<= (r*temp1) >> 8;       // HERE RS by 8 bits because 8bits ka fractional part hai
            xn<=temp2[15:0];
        end
        out <=xn;
    end

endmodule
