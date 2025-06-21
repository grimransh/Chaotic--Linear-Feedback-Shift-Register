module opamp(in_P,in_N, out);
    input signed [15:0] in_P,ref_val;
    output reg out;

    always @(*) begin
        if (in_P > ref_val) begin
            out <= 1'b1;
        end
        else begin
            out <= 0;
        end
    end
    
endmodule

