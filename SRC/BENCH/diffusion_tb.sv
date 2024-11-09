`timescale 1 ns / 1 ps

import ascon_pack::*;

type_state state_i_s;
type_state state_o_s;

module diffusion_tb;


type_state state_i_s;
type_state state_o_s;

diffusion DUT (
	.state_i(state_i_s),
	.state_o(state_o_s)
);

initial 
	begin

	state_i_s[0] = 64'h8859263f4c5d6e8f;
	state_i_s[1] = 64'h00c18e8584858607;
	state_i_s[2] = 64'h7f7f7f7f7f7f7f8f;
	state_i_s[3] = 64'h7f7f7f7f7f7f7f8f;
	state_i_s[4] = 64'h8888888a88888888;
	end;

endmodule : diffusion_tb
