`timescale 1ns / 1ps

import ascon_pack::*;

module mux (
  input type_state state_i,
  input type_state state_o_i,
  input wire data_sel_i,
  output type_state state_o
);

  always_comb begin
    if (data_sel_i == 1'b0) begin
      state_o = state_i;
    end
    else begin
      state_o = state_o_i;
    end
  end

endmodule : mux

