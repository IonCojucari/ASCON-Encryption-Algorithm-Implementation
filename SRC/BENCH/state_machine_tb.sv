`timescale 1ns / 1ps
import ascon_pack::*;

module state_machine_tb;



    // Declare signals
    logic resetb_s;
    logic clock_s=1'b0;
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
    type_state cipher_o_s;
    wire init_a_s;
    wire init_b_s;
    wire enable_clock_counter_s;
    wire enable_block_counter_s;
    type_state state_o_s;
    type_state state_i_s;
    logic [63:0] data_s;
    //Link different state_o signals for debugging
    /*
    type_state state_o_add_const_s;
    type_state state_o_diffusion_s;
    type_state state_o_substitution_s;
    type_state state_o_xor_begin_s;
    */
    
 

    // Instantiate permutation_simple_controller
    state_machine u_controller (
        .resetb_i(resetb_s),
        .clock_i(clock_s),
        .counter_block_i(counter_block_s),
        .counter_clock_i(counter_clock_s),
        .start_i(start_s),
        .data_valid_i(data_valid_s),
        .end_o(end_o_s),
        .cypher_valid_o(cypher_valid_o_s),
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
        .resetb_i(resetb_s),
        .clock_i(clock_s),
        .data_sel_i(data_sel_o_s),
        .en_reg_state_i(en_reg_state_o_s),
        .en_cipher_i(en_cipher_o_s),
        .en_tag_i(en_tag_o_s),
        .en_xor_key_i(en_xor_key_o_s),
        .en_xor_lsb_i(en_xor_lsb_o_s),
        .en_xor_data_i(en_xor_data_o_s),
        .en_xor_key_end_i(en_xor_key_end_o_s),
        .key_i(key_s),
        .data_i(data_s),
        .counter_i(counter_clock_s),
        .state_i(state_i_s),
        .state_o(state_o_s),
        .cipher_o(cipher_o_s),
        .tag_o(tag_o_s)
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
        .clock_i(clock_s),
        .resetb_i(resetb_s),
        .enable_i(enable_clock_counter_s),
        .init_a_i(init_a_s),
        .init_b_i(init_b_s),
        .counter_o(counter_clock_s)
    );
    



    //clock generation
    always  begin
       assign  clock_s = ~clock_s;
       #10;
    end

   initial begin
   state_i_s[0] = 64'h80400C0600000000; 
   state_i_s[1] = 64'h0001020304050607; 
   state_i_s[2] = 64'h08090a0b0c0d0e0f; 
   state_i_s[3] = 64'h0011223344556677; 
   state_i_s[4] = 64'h8899aabbccddeeff;
   key_s	 = 128'h000102030405060708090A0B0C0D0E0F;
   data_s = 64'h3230323380000000;
   counter_block_s = 3'b0; 
   start_s = 1'b1;
   resetb_s = 1'b1;
   #20
   resetb_s = 1'b0;
   #20
   resetb_s = 1'b1;
   #300;
   counter_block_s = 3'b001;
   #300;
   counter_block_s = 3'b010;
   data_s = 64'h436F6E636576657A; 
   #300 
   counter_block_s = 3'b011;
   data_s = 64'h204153434F4E2065;
   #300
   counter_block_s = 3'b100;
   data_s = 64'h6E2053797374656D;
   #300
   counter_block_s = 3'b101;
   data_s = 64'h566572696C6F6780;

   end

endmodule: state_machine_tb
