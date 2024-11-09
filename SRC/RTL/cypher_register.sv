`timescale 1ns / 1ps

import ascon_pack::*;

module cypher_registre_selection (
  input wire clock_i,
  input wire resetb_i,
  input wire en_cypher_i,
  input type_state state_i,
  output type_state cypher_o
);

  // Always block for clocked logic
  always_ff @(posedge clock_i or negedge resetb_i) begin
    if (resetb_i == 1'b0) begin
      cypher_o <= {64'h0, 64'h0, 64'h0, 64'h0, 64'h0};
    end
    else begin
      if (en_cypher_i == 1'b1)
      begin 
        if(cypher_o[0] == 64'h0) 
          cypher_o[0] <= state_i[0];
        else if(cypher_o[1] == 64'h0)
          cypher_o[1] <= state_i[0];
        else if(cypher_o[2] == 64'h0)
          cypher_o[2] <= state_i[0];
        else if(cypher_o[3] == 64'h0)
        begin
          cypher_o[3] <= state_i[0];
          //cypher_o <= {cypher_o[0], cypher_o[1], cypher_o[2], cypher_o[3][63:8], cypher_o[4][63:8]};
        end
      end
    end
    
  end

endmodule : cypher_registre_selection
