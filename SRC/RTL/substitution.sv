`timescale 1 ns / 1 ps
/*

ATTENTION : CE MODULE N'EST

 PAS FINI 
 
 
 */




import ascon_pack::*;

module substitution
(
    input  type_state state_i,
    output type_state state_o
);

    always_comb begin
            for (int i = 0; i < 64; i = i + 1) begin
                // Extract the 8-bit chunk from state_i[4:0][i]
                logic [4:0] chunk;
                chunk = {state_i[0][i], state_i[1][i], state_i[2][i], state_i[3][i], state_i[4][i]};

                // Perform substitutions
                case (chunk)
                    5'h00: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h04;
                    5'h01: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h0B;
                    5'h02: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h1F;
                    5'h03: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h14;
                    5'h04: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h1A;
                    5'h05: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h15;
                    5'h06: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h09;
                    5'h07: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h02;
                    5'h08: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h1B;
                    5'h09: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h05;
                    5'h0A: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h08;
                    5'h0B: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h12;
                    5'h0C: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h1D;
                    5'h0D: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h03;
                    5'h0E: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h06;
                    5'h0F: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h1C;
                    5'h10: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h1E;
                    5'h11: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h13;
                    5'h12: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h07;
                    5'h13: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h0E;
                    5'h14: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h00;
                    5'h15: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h0D;
                    5'h16: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h11;
                    5'h17: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h18;
                    5'h18: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h10;
                    5'h19: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h0C;
                    5'h1A: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h01;
                    5'h1B: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h19;
                    5'h1C: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h16;
                    5'h1D: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h0A;
                    5'h1E: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h0F;
                    5'h1F: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h17;
                    default: {state_o[0][i], state_o[1][i], state_o[2][i], state_o[3][i], state_o[4][i]} = 5'h00; // Default case(should never happen)
                endcase
            end
    end

endmodule : substitution
