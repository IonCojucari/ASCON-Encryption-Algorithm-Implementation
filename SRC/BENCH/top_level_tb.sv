`timescale 1ns / 1ps
import ascon_pack::*;


module top_level_tb;


    // Declare signals and variables here
    logic start_s;
    logic data_valid_s;
    logic [63:0] data_s;
    logic [127:0] key_s;
    logic [127:0] nonce_s;
    logic [127:0] tag_o_s;
    type_state cipher_o_s;
    logic cypher_valid_o_s;
    logic end_o_s;
    logic clock_s=1'b0;
    logic resetb_s;
    logic [3:0] counter_block_s;
    logic [3:0] counter_clock_s;
    type_state state_o_s;

    //pour debug 
    type_state state_o_mux;
    type_state state_o_xor_begin;
    type_state state_o_add_const;
    type_state state_o_substitution;
    type_state state_o_diffusion;
    type_state state_o_xor_end;

    // Instantiate the DUT (Design Under Test)
    top_level dut(
        .start_i(start_s),
        .data_valid_i(data_valid_s),
        .data_i(data_s),
        .key_i(key_s),
        .nonce_i(nonce_s),
        .tag_o(tag_o_s),
        .cipher_o(cipher_o_s),
        .cypher_valid_o(cypher_valid_o_s),
        .end_o(end_o_s),
        .clock_i(clock_s),
        .resetb_i(resetb_s),
        //pour debug
        .state_o(state_o_s),
        .state_o_add_const(state_o_add_const),
        .state_o_diffusion(state_o_diffusion),
        .state_o_substitution(state_o_substitution)
    );

    // Add clock and reset signals
    always  begin
       assign  clock_s = ~clock_s;
       #10;
    end
    
    initial begin
        data_s = 64'h3230323380000000;
        key_s = 128'h000102030405060708090A0B0C0D0E0F;
        nonce_s = 128'h000102030405060708090A0B0C0D0E0F;
        start_s = 1'b1;
        resetb_s = 1'b1;
        #20
        resetb_s = 1'b0;
        #20
        resetb_s = 1'b1;
        #550
        data_s = 64'h436F6E636576657A; 
        #200 
        data_s = 64'h204153434F4E2065;
        #200
        data_s = 64'h6E2053797374656D;
        #200
        data_s = 64'h566572696C6F6780;
    end

    endmodule
