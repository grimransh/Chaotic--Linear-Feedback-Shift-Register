module opamp(in, out);
    input signed [15:0] in;
    output reg out;

    always @(*) begin
        if (in > 0) begin
            out <= 1'b1;
        end
        else begin
            out <= 0;
        end
    end
    
endmodule

