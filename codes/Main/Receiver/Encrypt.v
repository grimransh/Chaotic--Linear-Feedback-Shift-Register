module encrypt (
    input clk,
    input rst,
    input Key_ready,
    input [7:0] R_random,
    input [7:0] G_random,
    input [7:0] B_random,
    output reg done
);
    (* ram_style = "block" *) reg [7:0] R_bytes [0:16383];  // Internal memory Block block
    (* ram_style = "block" *) reg [7:0] G_bytes [0:16383];  // Internal memory Block block
    (* ram_style = "block" *) reg [7:0] B_bytes [0:16383];  // Internal memory Block block
    reg [14:0] addr;

    (* ram_style = "block" *) reg [7:0] R_decrypt  [0:16383];
    (* ram_style = "block" *) reg [7:0] G_decrypt  [0:16383];
    (* ram_style = "block" *) reg [7:0] B_decrypt  [0:16383];
    

    // only for Simulation 
    initial begin
        $readmemh("R_encrypted.mem", R_bytes);
        $readmemh("G_encrypted.mem", G_bytes);
        $readmemh("B_encrypted.mem", B_bytes);
    end


    // always @(posedge done) begin
    //     $writememh("R_decrypted.mem", R_encrypt);
    //     $writememh("G_decrypted.mem", G_encrypt);
    //     $writememh("B_decrypted.mem", B_encrypt);
    // end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            addr <= 0;
            done <= 0;
        end 
        else if (Key_ready && !done) begin
            R_decrypt[addr] <= R_bytes[addr] ^ R_random;
            G_decrypt[addr] <= G_bytes[addr] ^ G_random;
            B_decrypt[addr] <= B_bytes[addr] ^ B_random;
            addr <= addr + 1;

            if (addr == 15'd16383) begin
                done <= 1;  // Finished updating memory
            end
        end
    end
endmodule
