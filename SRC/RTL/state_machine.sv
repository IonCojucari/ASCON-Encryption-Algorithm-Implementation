module state_machine (
    input wire resetb_i,
    input wire clock_i,
    input logic [3:0] counter_block_i,
    input logic [3:0] counter_clock_i,
    input logic start_i,
    input logic data_valid_i,
    output logic end_o,
    output logic cypher_valid_o,
    output logic data_sel_o,
    output logic en_reg_state_o,
    output logic en_xor_key_o,
    output logic en_xor_key_end_o,
    output logic en_xor_lsb_o,
    output logic en_xor_data_o,
    output logic en_cipher_o,
    output logic en_tag_o,
    output logic init_a_o,
    output logic init_b_o,
    output logic enable_clock_counter_o,
    output logic enable_block_counter_o,
    output logic init_block_counter_o
);

    logic [3:0] block_counter_before = 4'b1111;

    always_ff @(posedge clock_i or negedge resetb_i) begin
        while(start_i == 1'b0) begin
            // Wait for start signal
        end
        while(end_o == 1'b1) begin
            enable_block_counter_o <= 1'b0;
            enable_clock_counter_o <= 1'b0;
            en_reg_state_o <= 1'b0;
            // Stop
        end
        if (counter_block_i != block_counter_before) begin
            // If the block counter changes, reset the state machine
            block_counter_before <= counter_block_i;
            enable_block_counter_o <= 1'b0;
            enable_clock_counter_o <= 1'b1;
            data_sel_o <= 1'b1;
            en_xor_key_o <= 1'b0;
            en_xor_key_end_o <= 1'b0;
            en_xor_lsb_o <= 1'b0;
            en_xor_data_o <= 1'b0;
            en_cipher_o <= 1'b0;
            en_tag_o <= 1'b0;
            init_b_o <= 1'b0;
            init_a_o <= 1'b0;
        end
      
        case (counter_block_i)
            0: begin
                case (counter_clock_i)
                    15: begin
                        // Shift by 1
                        data_sel_o <= 1'b0;
                        en_reg_state_o <= 1'b1;
                    end
                    0: begin
                        data_sel_o <= 1'b1;
                    end
                    10: en_xor_key_end_o <= 1'b1;
                    11: begin
                        en_xor_key_end_o <= 1'b0;
                        en_reg_state_o = 1'b0;
                        init_b_o <= 1'b1;
                        enable_block_counter_o <= 1'b1;
                    end
                endcase
            end

            1: begin
                case (counter_clock_i)
                    5: begin
                        // Shift by 1
                        en_xor_data_o <= 1'b1;
                        en_reg_state_o <= 1'b1;
                    end
                    6: en_xor_data_o <= 1'b0; 
                    10: en_xor_lsb_o <= 1'b1;
                    11: begin
                        en_xor_lsb_o <= 1'b0;
                        en_reg_state_o <= 1'b0;
                        init_b_o <= 1'b1;
                        enable_block_counter_o <= 1'b1;
                    end
                endcase
            end
            2: begin
                case (counter_clock_i)
                    5: begin
                        // Shift by 1
                        en_xor_data_o <= 1'b1;
                        en_reg_state_o <= 1'b1;
                        en_cipher_o <= 1'b1;
                    end
                    6: begin
                        en_xor_data_o <= 1'b0;
                        en_cipher_o = 1'b0;
                    end 
                    11: begin
                        en_reg_state_o <= 1'b0;
                        init_b_o <= 1'b1;
                        enable_block_counter_o <= 1'b1;
                    end
                endcase
            end
            3: begin
                case (counter_clock_i)
                    5: begin
                        // Shift by 1
                        en_xor_data_o <= 1'b1;
                        en_reg_state_o <= 1'b1;
                        en_cipher_o <= 1'b1;
                    end
                    6: begin
                        en_xor_data_o <= 1'b0;
                        en_cipher_o = 1'b0;
                    end 
                    11: begin
                        en_reg_state_o <= 1'b0;
                        init_b_o <= 1'b1;
                        enable_block_counter_o <= 1'b1;
                    end
                endcase
            end
            4: begin
                case (counter_clock_i)
                    5: begin
                        // Shift by 1
                        en_xor_data_o <= 1'b1;
                        en_reg_state_o <= 1'b1;
                        en_cipher_o <= 1'b1;
                    end
                    6: begin
                        en_xor_data_o <= 1'b0;
                        en_cipher_o = 1'b0;
                        cypher_valid_o <= 1'b1;
                    end 
                    11: begin
                        en_reg_state_o <= 1'b0;
                        init_a_o <= 1'b1;
                        enable_block_counter_o <= 1'b1;
                    end
                endcase
            end
            5: begin
                case (counter_clock_i)
                    15: begin
                        // Shift by 1
                        en_xor_data_o <= 1'b1;
                        en_xor_key_o <= 1'b1;
                        en_reg_state_o <= 1'b1;
                        en_cipher_o <= 1'b1;
                    end
                    0: begin
                        en_xor_data_o <= 1'b0;
                        en_xor_key_o <= 1'b0;
                        en_cipher_o <= 1'b0;
                    end 
                    10: begin
                        en_xor_key_end_o <= 1'b1;
                        en_tag_o <= 1'b1;
                    end
                    11: begin
                        en_reg_state_o <= 1'b0;
                        en_xor_key_end_o <= 1'b0;
                        end_o <= 1'b1;
                        en_tag_o <= 1'b0;
                    end
                endcase
            end
        endcase
    end
endmodule: state_machine