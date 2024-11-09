`timescale 1ns / 1ps

import ascon_pack::*;

module xor_end_tb;

  reg en_xor_key_end_i_s;
  reg en_xor_lsb_i_s;
  reg [127:0] key_i_s;
  type_state state_i_s;
  type_state state_o_s;

  // Instantiate the xor_end module
  xor_end xor_end_inst (
    .en_xor_key_end_i(en_xor_key_end_i_s),
    .en_xor_lsb_i(en_xor_lsb_i_s),
    .key_i(key_i_s),
    .state_i(state_i_s),
    .state_o(state_o_s)
  );

  // Initialization
  initial begin
    // Set initial state values
    state_i_s[0] = 64'h1b1354db77e0dbb4; 
    state_i_s[1] = 64'h6f140401cfa0873c; 
    state_i_s[2] = 64'hd7e8abaf45f2885a; 
    state_i_s[3] = 64'hc0c4757ca2646459; 
    state_i_s[4] = 64'hf44a7ed98e1d9c83;
	
    en_xor_key_end_i_s = 0;
    en_xor_lsb_i_s = 0;
    key_i_s = 128'h000102030405060708090A0B0C0D0E0F; 

    // Initialize state_i data (64 bits per block)
    #100
    en_xor_key_end_i_s = 1;
    #100

    en_xor_key_end_i_s = 0;
    en_xor_lsb_i_s = 1;
    #100

    en_xor_lsb_i_s = 0;
    #100

    // Simulation finished
    $finish;
  end

endmodule : xor_end_tb
