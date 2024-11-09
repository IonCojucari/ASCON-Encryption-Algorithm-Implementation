`timescale 1ns / 1ps

// The clock will start 2 periods before to properly initialize the permutations
module counter_clock (
    input logic clock_i,
    input logic resetb_i,
    input logic enable_i,
    input logic init_a_i,
    input logic init_b_i,
    output logic [3:0] counter_o
);

    logic [3:0] count_s;

    always_ff @(posedge clock_i or negedge resetb_i) begin
        if (resetb_i == 1'b0) begin
            count_s <= 14;
        end
        else begin
            if (enable_i == 1'b1) begin
                if (init_a_i == 1'b1) begin
                    count_s <= 14;
                end
                else if (init_b_i == 1'b1) begin
                    count_s <= 4;
                end
                else begin
                    count_s <= count_s + 1;
                end
            end
        end
    end

    assign counter_o = count_s;

endmodule : counter_clock
