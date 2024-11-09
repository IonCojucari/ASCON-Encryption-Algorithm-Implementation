`timescale 1ns / 1ps

import ascon_pack::*;

module registre_selection (
  input wire clock_i,
  input wire resetb_i,
  input wire en_reg_state_i,
  input type_state state_i,
  output type_state state_o
);

  type_state data_s;

  // Sequential logic for registering state_i
  always_ff @(posedge clock_i or negedge resetb_i) begin
    if (resetb_i == 1'b0) begin
      // Reset data_s to zero
      data_s <= { 64'h0, 64'h0, 64'h0, 64'h0, 64'h0};
    end
    else begin
      if (en_reg_state_i == 1'b1) 
        // Assign state_i to data_s if en_reg_state_i is active
        data_s <= state_i;
    end
  end

  // Output assignment
  assign state_o = data_s;

endmodule : registre_selection
