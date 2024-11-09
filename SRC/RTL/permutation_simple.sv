`timescale 1 ns/ 1 ps
import ascon_pack::*;

module permutation_simple (
  input type_state state_i,
  input wire data_sel_i,
  input logic [63:0] data_i,
  input logic en_xor_data_i,
  input logic en_xor_key_i,
  input logic [127:0] key_i,
  input logic [3:0] counter_i,
  //input logic [127:0] key_end_i,
  input wire en_xor_key_end_i,
  input logic en_xor_lsb_i,
  input wire en_reg_state_i,
  input logic clock_i,
  input wire resetb_i,
  //next are inputs for tag and cipher
  input wire en_cipher_i,
  input wire en_tag_i,
  output type_state state_o,
  //Link to different state_o's signals for debugging
  output type_state state_o_reg_select,
  output type_state state_o_mux,
  output type_state state_o_xor_begin,
  output type_state state_o_add_const,
  output type_state state_o_substitution,
  output type_state state_o_diffusion,
  output type_state state_o_xor_end,
  
  //next are outputs for tag and cipher
  output type_state cipher_o,
  output logic [127:0] tag_o
);

  // Declare type_state signals
  /*
  type_state state_o_reg_select;
  type_state state_o_mux;
  type_state state_o_xor_begin;
  type_state state_o_add_const;
  type_state state_o_substitution;
  type_state state_o_diffusion;
  type_state state_o_xor_end;*/

  // Instantiate mux module
  mux u_mux (
    .state_i(state_i),
    .state_o_i(state_o_reg_select),
    .data_sel_i(data_sel_i),
    .state_o(state_o_mux)
  );

  // Instantiate xor_begin module
  xor_begin u_xor_begin (
    .state_i(state_o_mux),
    .data_i(data_i),
    .key_i(key_i),
    .en_xor_data_i(en_xor_data_i),
    .en_xor_key_i(en_xor_key_i),
    .state_o(state_o_xor_begin)
  );

  //Instantiate cipher_registre_selection module
  cypher_registre_selection u_cypher_reg_select (
    .clock_i(clock_i),
    .resetb_i(resetb_i),
    .en_cypher_i(en_cipher_i),
    .state_i(state_o_xor_begin),
    .cypher_o(cipher_o)
  );

  // Instantiate add_const module
  add_const u_add_const (
    .state_i(state_o_xor_begin),
    .counter_i(counter_i),
    .state_o(state_o_add_const)
  );

  // Instantiate substitution module
  substitution u_substitution (
    .state_i(state_o_add_const),
    .state_o(state_o_substitution)
  );

  // Instantiate diffusion module
  diffusion u_diffusion (
    .state_i(state_o_substitution),
    .state_o(state_o_diffusion)
  );

  // Instantiate xor_end module
  xor_end u_xor_end (
    .en_xor_key_end_i(en_xor_key_end_i),
    .en_xor_lsb_i(en_xor_lsb_i),
    .key_i(key_i),
    .state_i(state_o_diffusion),
    .state_o(state_o_xor_end)
  );

  // Instantiate tag_registre_selection module
  tag_registre_selection u_tag_reg_select (
    .clock_i(clock_i),
    .resetb_i(resetb_i),
    .en_tag_i(en_tag_i),
    .state_i(state_o_xor_end),
    .tag_o(tag_o)
  );

  // Instantiate registre_selection module
  registre_selection u_reg_select (
    .clock_i(clock_i),
    .resetb_i(resetb_i),
    .en_reg_state_i(en_reg_state_i),
    .state_i(state_o_xor_end),
    .state_o(state_o_reg_select)
  );

  assign state_o = state_o_reg_select; // Assign output

endmodule : permutation_simple
