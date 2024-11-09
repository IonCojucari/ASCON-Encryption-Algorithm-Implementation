`timescale 1 ns /1 ps;

import ascon_pack::*; 

module add_const_tb;  //module sans port pour un test bench

//signaux intermediaires pour realiser la simulation
type_state state_i_s;
type_state state_o_s;
logic [3:0] round_s;

int i;  // pour la boucle for dans le process initial 

//instanciation du circuit sous test
add_const DUT (
	.state_i(state_i_s),
	.state_o(state_o_s),
	.round_i(round_s)
);

initial
	begin 
		round_s = 0;
		state_i_s = {'0, '0, '0, 64'h0};

		for (i=0; i<12; i++)
			begin 
				round_s = i;
				#20;
			end
	end

endmodule : add_const_tb
