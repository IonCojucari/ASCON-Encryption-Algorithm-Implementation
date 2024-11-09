`timescale 1ns / 1ps
import ascon_pack::*;

module top_level
(
    input logic start_i,
    input logic data_valid_i,
    input logic [63:0] data_i,
    input logic [127:0] key_i,
    input logic [127:0] nonce_i,
    input logic clock_i,
    input logic resetb_i,
    output logic [127:0] tag_o,
    output type_state cipher_o,
    output logic cypher_valid_o,
    output logic end_o,
    output type_state state_o,
    //pour debug
    output type_state state_o_mux,
    output type_state state_o_xor_begin,
    output type_state state_o_add_const,
    output type_state state_o_substitution,
    output type_state state_o_diffusion,
    output type_state state_o_xor_end
    //output [3:0] counter_block_s

);

    // Declare signals
    logic [3:0] counter_block_s;
    logic [3:0] counter_clock_s;
    logic start_s;
    logic data_valid_s;
    logic end_o_s;
    logic cypher_valid_o_s;
    logic data_valid_o_s;
    logic data_sel_o_s;
    logic en_reg_state_o_s;
    logic en_xor_key_o_s;
    logic en_xor_key_end_o_s;
    logic en_xor_lsb_o_s;
    logic en_xor_data_o_s;
    logic en_cipher_o_s;
    logic en_tag_o_s;
    logic [127:0] key_s;
    logic [127:0] tag_o_s;
    wire init_a_s;
    wire init_b_s;
    wire enable_clock_counter_s;
    wire enable_block_counter_s;
    type_state state_i_s= {64'h80400C0600000000, 64'h0001020304050607, 64'h08090a0b0c0d0e0f, 64'h0011223344556677, 64'h8899aabbccddeeff};
    logic [63:0] data_s;
    logic init_block_counter_s;
    //Link different state_o signals for debugging
    /*
    type_state state_o_add_const_s;
    type_state state_o_diffusion_s;
    type_state state_o_substitution_s;
    type_state state_o_xor_begin_s;
    */

    

    // Instantiate permutation_simple_controller
    state_machine u_controller (
        .resetb_i(resetb_i),
        .clock_i(clock_i),
        .counter_block_i(counter_block_s),
        .counter_clock_i(counter_clock_s),
        .start_i(start_i),
        .data_valid_i(data_valid_i),
        .end_o(end_o),
        .cypher_valid_o(cypher_valid_o),
        .data_sel_o(data_sel_o_s),
        .en_reg_state_o(en_reg_state_o_s),
        .en_xor_key_o(en_xor_key_o_s),
        .en_xor_key_end_o(en_xor_key_end_o_s),
        .en_xor_lsb_o(en_xor_lsb_o_s),
        .en_xor_data_o(en_xor_data_o_s),
        .en_cipher_o(en_cipher_o_s),
        .en_tag_o(en_tag_o_s),
        .init_a_o(init_a_s),
        .init_b_o(init_b_s),
        .enable_clock_counter_o(enable_clock_counter_s),
        .enable_block_counter_o(enable_block_counter_s)
    );

    // Instantiate permutation_simple
    permutation_simple u_permutation_simple (
        .resetb_i(resetb_i),
        .clock_i(clock_i),
        .data_sel_i(data_sel_o_s),
        .en_reg_state_i(en_reg_state_o_s),
        .en_cipher_i(en_cipher_o_s),
        .en_tag_i(en_tag_o_s),
        .en_xor_key_i(en_xor_key_o_s),
        .en_xor_lsb_i(en_xor_lsb_o_s),
        .en_xor_data_i(en_xor_data_o_s),
        .en_xor_key_end_i(en_xor_key_end_o_s),
        .key_i(key_i),
        .data_i(data_i),
        .counter_i(counter_clock_s),
        .state_i(state_i_s),
        .state_o(state_o),
        .cipher_o(cipher_o),
        .tag_o(tag_o),
        .state_o_add_const(state_o_add_const),
        .state_o_diffusion(state_o_diffusion),
        .state_o_substitution(state_o_substitution)
        //Link to different state_o's signals for debugging
        /*
        .state_o_add_const(state_o_add_const_s),
        .state_o_diffusion(state_o_diffusion_s),
        .state_o_substitution(state_o_substitution_s),
        .state_o_xor_begin(state_o_xor_begin_s)
        */
    );

     // Instantiate counter_clock
    counter_clock u_counter_clock (
        .clock_i(clock_i),
        .resetb_i(resetb_i),
        .enable_i(enable_clock_counter_s),
        .init_a_i(init_a_s),
        .init_b_i(init_b_s),
        .counter_o(counter_clock_s)
    );

    // Instantiate counter_block
    counter_block u_counter_block (
        .clock_i(clock_i),
        .resetb_i(resetb_i),
        .enable_i(enable_block_counter_s),
        .init_i(init_block_counter_s),
        .counter_o(counter_block_s)
    );



endmodule : top_level