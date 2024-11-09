`timescale 1 ns/1 ps

import ascon_pack::*;

module xor_begin (
	input type_state state_i,
	input logic[63:0] data_i,
	input logic[127:0] key_i,
	input logic en_xor_data_i,
	input logic en_xor_key_i,
	output type_state state_o
);

	always_comb 
	begin 
	    state_o = state_i;
	    if(en_xor_data_i == 1'b1)
	    begin
		state_o[0] = data_i^state_i[0];
	    end 
	
	    if(en_xor_key_i == 1'b1)
	    begin
		state_o[1] =  key_i[123:64]^state_i[1];
		state_o[2] =  key_i[63:0]^state_i[2];
		state_o[3] =  state_i[3];
		state_o[4] = state_i[4];
	    end
	end


endmodule : xor_begin
