`timescale 1ns / 1ps

module counter_block (
    input logic clock_i,
    input logic resetb_i,
    input logic enable_i,
    input logic init_i,
    output logic [3:0] counter_o
);

    logic [3:0] count_s;
    logic delay = 0; //its goal is to stop incrementing 2 times when enable_i is activated for 2 clocks #bricolage

    always_ff @(posedge clock_i or negedge resetb_i) begin
        if (resetb_i == 1'b0) begin
            count_s <= 0;
        end
        else begin
                delay <= delay -1;
                if (init_i == 1'b1) begin
                    count_s <= 0;
                end
                else if (enable_i == 1'b1 && delay == 0) begin
                    count_s <= count_s + 1;
                    delay = 2;
                end
            end
        end

    assign counter_o = count_s;

endmodule : counter_block
