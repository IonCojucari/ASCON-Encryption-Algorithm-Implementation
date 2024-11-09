`timescale 1ns / 1ps

import ascon_pack::*;

module xor_begin_tb;

  reg en_xor_data_i_s;
  reg en_xor_key_i_s;
  reg [63:0] data_i_s;
  reg [127:0] key_i_s;
  type_state state_i_s;
  type_state state_o_s;

  // Instantiate the xor_begin module
  xor_begin xor_begin_inst (
    .en_xor_key_i(en_xor_key_i_s),
    .en_xor_data_i(en_xor_data_i_s),
    .key_i(key_i_s),
    .state_i(state_i_s),
    .state_o(state_o_s),
    .data_i(data_i_s)
  );

  // Initialization
  initial begin
    // Set initial state values
    state_i_s[0] = 64'h1fc9a149abfd3af5; 
    state_i_s[1] = 64'hdbf2eef89f61a7c5; 
    state_i_s[2] = 64'h7d53f3d9dd22530a; 
    state_i_s[3] = 64'h6654c154e6e248f1; 
    state_i_s[4] = 64'h169557420d2a6714;
    
    // Set initial data value
    data_i_s = 64'h436F6E636576657A;
    
    // Set initial enable signals
    en_xor_data_i_s = 0;
    en_xor_key_i_s = 0;
    
    // Set initial key value
    key_i_s = 128'h000102030405060708090A0B0C0D0E0F; 
    
    #100
    
    // Enable key XOR
    en_xor_key_i_s = 1;
    #100
    
    // Update state values
    state_i_s[0] = 64'h4608da0e76fcee25; 
    state_i_s[1] = 64'h876f2d998dd3ed21; 
    state_i_s[2] = 64'h5d5b8b59b7ac16ee; 
    state_i_s[3] = 64'he23c656f97f63dc8; 
    state_i_s[4] = 64'h3e09499302483746;
    
    // Disable key XOR
    en_xor_key_i_s = 0;
    
    // Enable data XOR
    en_xor_data_i_s = 1;
    #100

    // Disable data XOR
    en_xor_data_i_s = 0;
    #100
    
    $finish;
  end

endmodule : xor_begin_tb
