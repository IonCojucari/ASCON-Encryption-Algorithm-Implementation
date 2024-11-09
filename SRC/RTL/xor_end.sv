`timescale 1 ns/1 ps

import ascon_pack::*;



module xor_end (
  input wire en_xor_key_end_i,
  input wire en_xor_lsb_i,
  input wire [127:0] key_i,
  input type_state state_i,
  output type_state state_o
);



  always_comb begin 

    for (int i = 0; i < 5; i = i + 1) begin
        state_o[i] = state_i[i];
    end
    if (en_xor_key_end_i == 1'b1) begin
        state_o[3] = state_i[3] ^ key_i[127:64];
	      state_o[4] = state_i[4] ^ key_i[63:0];
    end 
    if (en_xor_lsb_i == 1'b1) begin
      for (int i = 0; i < 4; i = i + 1) begin
        state_o[i] = state_i[i] ^ {64'h0};
      end
        state_o[4] = state_i[4] ^ {63'h0, 1'h1};      
    end
  end 

endmodule : xor_end

