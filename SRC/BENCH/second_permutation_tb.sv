

`timescale 1 ns/ 1 ps

module second_permutation_tb import ascon_pack::*;
   (
    ) ;

   type_state state_i_s;
   type_state state_o_s;

   logic       resetb_s;
   logic       clock_s =1'b0;
   logic       data_sel_s;
   logic       en_reg_state_s;
   logic       en_xor_key_s;
   logic       en_xor_key_end_s;
   logic       en_xor_lsb_s;
   logic       en_xor_data_s;
   type_state state_o_mux;
   type_state state_o_xor_begin;
   type_state state_o_add_const;
   type_state state_o_substitution; 
   type_state state_o_diffusion;
   type_state state_o_xor_end;
 
   logic [127:0] key_s;
   logic [63:0]  data_s;
   logic [3:0] round_s;
   logic [63:0] cipher_s;  
   logic [127:0] tag_s;
   
   
  
   
   
   permutation_simple DUT (
					.clock_i(clock_s),
					.resetb_i(resetb_s),
					.data_sel_i(data_sel_s),
					.en_reg_state_i(en_reg_state_s),
					.en_xor_key_i(en_xor_key_s),
					.en_xor_lsb_i(en_xor_lsb_s),
					.en_xor_data_i(en_xor_data_s),
					.en_xor_key_end_i(en_xor_key_end_s),
					.key_i(key_s),
					.data_i(data_s),
					.counter_i(round_s),
					.state_i(state_i_s),
					.state_o(state_o_s),
               //Link to different state_o's signals for debugging
               .state_o_mux(state_o_mux),
               .state_o_xor_begin(state_o_xor_begin),
               .state_o_add_const(state_o_add_const),
               .state_o_substitution(state_o_substitution),
               .state_o_diffusion(state_o_diffusion),
               .state_o_xor_end(state_o_xor_end)
					);
   
   always  begin
       assign  clock_s = ~clock_s;
      #10;
      
   end
   
   initial begin
      int i;
      state_i_s[0] = 64'h1b1354dbf7e0dbb4; 
      state_i_s[1] = 64'h6f140401cfa0873c; 
      state_i_s[2] = 64'hd7e8abaf45f2885a; 
      state_i_s[3] = 64'hc0c5777fa661625e; 
      state_i_s[4] = 64'hfc4374d28210928c;
      data_s = 64'h3230323300000000;
      	
      resetb_s   = 1'b0;
      data_sel_s = 1'b0;
      en_xor_data_s      = 1'b1;
      en_xor_key_s  = 1'b0;
      en_xor_lsb_s       = 1'b0;
      en_xor_key_end_s = 1'b0;
      en_reg_state_s     = 1'b1;
      round_s = 4'b0110;
      #105;
      resetb_s   = 1'b1;
      #20;
      en_xor_data_s      = 1'b0;
      data_sel_s = 1'b1;
      round_s = 4'b0111;
      #20;
      round_s = 4'b1000;
      
      #20;
      round_s = 4'b1001;
      
      #20;
      round_s = 4'b1010;
      
      #20;
      round_s = 4'b1011;
      en_xor_lsb_s = 1'b1;
      #20;
   end
endmodule: second_permutation_tb


