`timescale 1ns / 1ps

import ascon_pack::*;

module registre_selection_tb;

  reg clock_i;
  reg resetb_i;
  reg en_i;
  type_state state_i;
  type_state state_o;

  // Instantiate the registre_selection module
  registre_selection registre_selection_inst (
    .clock_i(clock_i),
    .resetb_i(resetb_i),
    .en_reg_state_i(en_i),
    .state_i(state_i),
    .state_o(state_o)
  );

  // Generate a clock
  always begin
    #5 clock_i = ~clock_i;
  end

  // Initialization
  initial begin
    clock_i = 0;
    resetb_i = 0;
    en_i = 0;

    // Initialize the data
    for (int i = 0; i < 5; i = i + 1) begin
      state_i[i] = 'h0123456789ABCDEF0123456789ABCDEF;
    end

    // Disable reset
    resetb_i = 1;

    // Activate registre_selection with en_i = 1
    en_i = 1;
    #20; // Wait for 10 ns

    // Deactivate registre_selection
    resetb_i = 0;
    en_i = 0;
    #20; // Wait for 10 ns

    en_i = 1;
    #20; // Wait for 10 ns

    en_i = 1;
	
    #20;
    resetb_i = 1;

    #20
    $finish;
  end

endmodule : registre_selection_tb
