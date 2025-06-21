module quadratic_Map ( input clk,reset,              
		      input signed [15:0] x_in , r, 					// It is (-)1.15
                      output reg signed [15:0] x_out);
    reg signed [15:0] xn;
	reg signed [31:0] xn_sq, r_ext, temp;

	always @(posedge clk) begin
		
		if(reset) begin
			x_out<=xn;
		end

		else begin
			xn_sq<= xn * xn;
			r_ext <= r <<<15;   // 1.15 into 2.30
			temp <= r_ext * xn_sq;   // r * xn^2 into 4.60 (need to downscale)
			xn <= (16'sh7FFF - (temp >>> 30)); // Scaling back to 1.15
		end

		x_out <= xn;
	end
endmodule
			
			
  
  
