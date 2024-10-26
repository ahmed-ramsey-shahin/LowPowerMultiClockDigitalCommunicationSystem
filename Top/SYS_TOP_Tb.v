`timescale 1ns/1ps
module SYS_TOP_Tb;
    reg         REF_CLK_tb  = 1'b00;
    reg         UART_CLK_tb = 1'b00;
    reg  [5:0]  prescale_tb = 6'd32;
    reg         RST_tb;
    reg         RX_IN_tb;
    reg  [10:0] frame;
    reg  [7:0]  pure_data;
    reg  [10:0] outputs;
    wire        TX_OUT_tb;
    wire        TX_CLK;
    wire        RX_CLK;

    always #20      REF_CLK_tb  = ~REF_CLK_tb;
    always #135.634 UART_CLK_tb = ~UART_CLK_tb;

    integer loop_index;

    SYS_TOP top (
        .REF_CLK(REF_CLK_tb),
        .UART_CLK(UART_CLK_tb),
        .RST(RST_tb),
        .RX_IN(RX_IN_tb),
        .TX_OUT(TX_OUT_tb)
    );

    task reset;
        begin
            RX_IN_tb =  1'b1;
            RST_tb   =  1'b0;
            frame    = 11'b0;
            outputs  = 11'b0;
            #2;
            RST_tb   =  1'b1;
        end
    endtask

    task generate_data;
        input       parity_enabled;
        input       parity_type;
        input       is_random_data;
        input [7:0] input_data;
        reg   [7:0] reversed_data;
        reg   [7:0] transmitted_data;
        begin
            frame[10]       = 1'b0;
            reversed_data   = (is_random_data) ? $random % 2**8 : input_data;
            pure_data       = reversed_data;
            for (loop_index = 0; loop_index < 8; loop_index = loop_index + 1) begin
                transmitted_data[loop_index] = reversed_data[7-loop_index];
            end
            frame[9:2] = transmitted_data;
            frame[0]   = 1'b1;
            
            if (parity_enabled) begin
                if (parity_type) begin
                    frame[1] = ~^frame[9:2];
                end
                else begin
                    frame[1] = ^frame[9:2];
                end
            end
            else begin
                frame[1] = 1'b1;
            end
        end
    endtask

    task transmit_test_data;
        input parity_enabled;
        begin
            for (loop_index = 10; loop_index >= (parity_enabled ? 0 : 1); loop_index = loop_index - 1) begin
                @(negedge TX_CLK) RX_IN_tb = frame[loop_index];
            end
        end
    endtask
    
    task register_file_write_command;
        input [7:0] address;
        input       is_random_data;
        input [7:0] data;
        begin
            generate_data(1'b1, 1'b0, 1'b0, 8'hAA);
            transmit_test_data(1'b1);
            generate_data(1'b1, 1'b0, 1'b0, address);
            transmit_test_data(1'b1);
            generate_data(1'b1, 1'b0, is_random_data, is_random_data ? $random % 2**8 : data);
            transmit_test_data(1'b1);
        end
    endtask

    task register_file_read_command;
        input [7:0] address;
        begin
            generate_data(1'b1, 1'b0, 1'b0, 8'hBB);
            transmit_test_data(1'b1);
            generate_data(1'b1, 1'b0, 1'b0, address);
            transmit_test_data(1'b1);
        end
    endtask

    task ALU_command_operand;
        input       is_random_data;
        input [7:0] A;
        input [7:0] B;
        input [7:0] ALU_FUN;
        begin
            generate_data(1'b1, 1'b0, 1'b0, 8'hCC);
            transmit_test_data(1'b1);
            generate_data(1'b1, 1'b0, is_random_data, is_random_data ? $random % 2**8 : A);
            transmit_test_data(1'b1);
            generate_data(1'b1, 1'b0, is_random_data, is_random_data ? $random % 2**8 : B);
            transmit_test_data(1'b1);
            generate_data(1'b1, 1'b0, 1'b0, ALU_FUN);
            transmit_test_data(1'b1);
        end
    endtask

    task ALU_command_no_operand;
        input [7:0] ALU_FUN;
        begin
            generate_data(1'b1, 1'b0, 1'b0, 8'hDD);
            transmit_test_data(1'b1);
            generate_data(1'b1, 1'b0, 1'b0, ALU_FUN);
            transmit_test_data(1'b1);
        end
    endtask

    task save_outputs;
        input is_parity_included;
        integer i;
        integer iterations;
        begin
            iterations = 10;

            if (is_parity_included) begin
                iterations = 11;
            end

            @(negedge TX_CLK) outputs[10] = TX_OUT_tb;

            for (i = 2; i < 10; i = i + 1) begin
                @(negedge TX_CLK) outputs[i] = TX_OUT_tb;
            end

            if (is_parity_included) begin
                @(negedge TX_CLK) outputs[1] = TX_OUT_tb;
                @(negedge TX_CLK) outputs[0] = TX_OUT_tb;
            end
            else begin
                @(negedge TX_CLK) outputs[1] = TX_OUT_tb;
            end
        end
    endtask

    task validate_output_and_print;
        input [10:0]  actual_output;
        input [10:0]  expected_output;
        input integer test_case_number;
        input         ten_bit_flag;
        reg           error_flag;
        begin
            error_flag = ~((ten_bit_flag ? actual_output[10:1] : actual_output) == (ten_bit_flag ? expected_output[10:1] : expected_output));
            $display(
                "Test Case %2d %s Actual Output = %11b, Expected Output = %11b",
                test_case_number, (error_flag ? "Failed" : "Passed"),
                (ten_bit_flag ? actual_output[10:1] : actual_output),
                (ten_bit_flag ? expected_output[10:1] : expected_output)
            );
        end
    endtask

    initial begin
        reset();
        register_file_write_command(8'd6, 1'b0, 8'd40);
        // Test Case 1 (Reading from the memory)
        register_file_read_command(8'd6);
        @(negedge TX_OUT_tb);
        save_outputs(1'b1);
        validate_output_and_print(outputs, {1'b0, 8'd40, ^(8'd40), 1'b1}, 1, 1'b0);
        // Test Case 2 (Performing ALU operation with operands)
        ALU_command_operand(1'b0, 8'd7, 8'd2, 8'd0);
        @(negedge TX_OUT_tb);
        save_outputs(1'b1);
        validate_output_and_print(outputs, {1'b0, 8'd9, ^(8'd9), 1'b1}, 2, 1'b0);
        // Test Case 3 (Performing ALU operation without operands)
        ALU_command_no_operand(8'd1);
        @(negedge TX_OUT_tb);
        save_outputs(1'b1);
        validate_output_and_print(outputs, {1'b0, 8'd5, ^(8'd5), 1'b1}, 3, 1'b0);
        // Test Case 4 (Performing ALU operation without operands)
        ALU_command_no_operand(8'd2);
        @(negedge TX_OUT_tb);
        save_outputs(1'b1);
        validate_output_and_print(outputs, {1'b0, 8'd14, ^(8'd14), 1'b1}, 4, 1'b0);
        // Test Case 5 (Performing ALU operation without operands)
        ALU_command_no_operand(8'd3);
        @(negedge TX_OUT_tb);
        save_outputs(1'b1);
        validate_output_and_print(outputs, {1'b0, 8'd3, ^(8'd3), 1'b1}, 5, 1'b0);
        // Stopping the simulation
        repeat(30) @(negedge TX_CLK);
        $stop;
    end

    assign TX_CLK = top.TX_CLK_generator.o_div_clk;
    assign RX_CLK = top.RX_CLK_generator.o_div_clk;
endmodule
