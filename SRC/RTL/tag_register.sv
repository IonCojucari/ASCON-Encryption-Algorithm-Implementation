`timescale 1ns / 1ps

import ascon_pack::*;

module tag_registre_selection (
  input wire clock_i,
  input wire resetb_i,
  input wire en_tag_i,
  input type_state state_i,
  output logic [127:0] tag_o
);

  type_state data_s;

  always_ff @(posedge clock_i or negedge resetb_i) begin
    if (resetb_i == 1'b0) begin
      // Reset data_s to zero
      data_s <= {64'h0, 64'h0, 64'h0, 64'h0, 64'h0};
    end
    else begin
      if (en_tag_i == 1'b1) 
        // Assign state_i to data_s if en_tag_i is active
        data_s <= state_i;
    end
  end

  // Output data_s
  assign tag_o = {data_s[3], data_s[4]};

endmodule : tag_registre_selection
