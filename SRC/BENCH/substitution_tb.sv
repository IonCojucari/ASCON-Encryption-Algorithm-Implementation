`timescale 1ns/1ns
import ascon_pack::*;
module substitution_tb;



  // Declare signals
  type_state state_i;
  type_state state_o;
  
  // Instantiate the module
  substitution uut (
    .state_i(state_i),
    .state_o(state_o)
  );

  // Initial block to apply test vectors
  initial begin
    // Initialize input state
    state_i[0] = 64'heeea8c8972cc93fd;
    state_i[1] = 64'hff9e7f5bbb51cb2a;
    state_i[2] = 64'hd043ab88a97926c5;
    state_i[3] = 64'hf8bda5cbfdf4f6b4;
    state_i[4] = 64'h221f7efb7af94591;

    #10;
  end

endmodule : substitution_tb



