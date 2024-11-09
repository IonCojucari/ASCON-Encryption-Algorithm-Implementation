`timescale 1ns / 1ps

import ascon_pack::*;

module mux_tb;

  reg data_sel_i_s;
  type_state state_i_s;
  type_state state_o_i_s;
  wire [63:0] data_o_s;

  // Instantiate the mux module
  mux mux_inst (
    .data_sel_i(data_sel_i_s),
    .state_i(state_i_s),
    .state_o_i(state_o_i_s),
    .state_o(data_o_s)
  );

  // Initialization
  initial begin
    state_i_s = 64'h0123456789ABCDEF; // Replace with your data
    state_o_i_s = 64'hFEDCBA9876543210; // Replace with your data

    data_sel_i_s = 1'b0; // Select data0
    
    // Wait for 10 ns
    #10

    data_sel_i_s = 1'b1; // Select data1

    // Wait for 10 ns

    // Simulation finished
    $finish;
  end

endmodule : mux_tb
