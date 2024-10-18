`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2024 01:50:53 AM
// Design Name: 
// Module Name: alu_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module alu_tb;

    reg [15:0] sw;     
    wire [4:0] led;   

    alu_gatelvl uut (
        .sw(sw),
        .led(led)
    );

    initial begin
        sw = 16'b0;
        #100;

        // Test Case 0: Addition (4 + 3)
        sw[3:0] = 4'd4;     // A = 4
        sw[7:4] = 4'd3;     // B = 3
        sw[11:8] = 4'd0;    // Op = 0 (Addition)
        #10;
        $display("Addition: %d + %d = %d, Carry Out: %b", sw[3:0], sw[7:4], led[3:0], led[4]);

        // Test Case 1: Subtraction (3 - 5)
        sw[3:0] = 4'd3;     // A = 3
        sw[7:4] = 4'd5;     // B = 5
        sw[11:8] = 4'd1;    // Op = 1 (Subtraction)
        #10;
        $display("Subtraction: %d - %d = %d, Carry Out: %b", sw[3:0], sw[7:4], $signed({led[4], led[3:0]}), led[4]);

        // Test Case 2: Multiplication (7 * 3)
        sw[3:0] = 4'd7;     // A = 7
        sw[7:4] = 4'd3;     // B = 3
        sw[11:8] = 4'd2;   // Op = 2 (Multiplication)
        #10;
        $display("Multiplication: %d * %d = %d, Carry Out: %b", sw[3:0], sw[7:4], led[3:0], led[4]);
        
        // Test Case 3: Division (6 / 2)
        sw[3:0] = 4'd6;     // A = 6
        sw[7:4] = 4'd2;     // B = 2
        sw[11:8] = 4'd3;   // Op = 3 (Division)
        #10;
        $display("Division: %d / %d = %d, Carry Out: %b", sw[3:0], sw[7:4], led[3:0], led[4]);

        // Test Case 4: Bitwise AND (10 & 10)
        sw[3:0] = 4'd10;     // A = 10
        sw[7:4] = 4'd10;     // B = 10
        sw[11:8] = 4'd4;    // Op = 4 (AND)
        #10;
        $display("AND: %b & %b = %b", sw[3:0], sw[7:4], led[3:0]);
        
        // Test Case 5: Bitwise OR (7 | 8)
        sw[3:0] = 4'd7;     // A = 7
        sw[7:4] = 4'd8;     // B = 8
        sw[11:8] = 4'd5;    // Op = 5 (OR)
        #10;
        $display("OR: %b | %b = %b", sw[3:0], sw[7:4], led[3:0]);
        
        // Test Case 6: Bitwise XOR (15 ^ 6)
        sw[3:0] = 4'd15;     // A = 15
        sw[7:4] = 4'd6;     // B = 6
        sw[11:8] = 4'd6;    // Op = 6 (XOR)
        #10;
        $display("XOR: %b ^ %b = %b", sw[3:0], sw[7:4], led[3:0]);
        
        // Test Case 7: Bitwise NAND ~(6 & 3)
        sw[3:0] = 4'd6;     // A = 6
        sw[7:4] = 4'd3;     // B = 3
        sw[11:8] = 4'd7;    // Op = 7 (NAND)
        #10;
        $display("NAND: ~(%b & %b) = %b", sw[3:0], sw[7:4], led[3:0]);
        
        // Test Case 8: Bitwise NOR ~(5 | 0)
        sw[3:0] = 4'd5;     // A = 5
        sw[7:4] = 4'd0;     // B = 0
        sw[11:8] = 4'd8;    // Op = 8 (NOR)
        #10;
        $display("NOR: ~(%b | %b) = %b", sw[3:0], sw[7:4], led[3:0]);

        // Test Case 9: Bitwise XNOR ~(6 ^ 8)
        sw[3:0] = 4'd6;     // A = 6
        sw[7:4] = 4'd8;     // B = 8
        sw[11:8] = 4'd9;    // Op = 9 (XNOR)
        #10;
        $display("XNOR: ~(%b ^ %b) = %b", sw[3:0], sw[7:4], led[3:0]);
        
        // Test Case 10: Left shift A by B postions (3 << 2)
        sw[3:0] = 4'd3;     // A = 3
        sw[7:4] = 4'd2;     // B = 2
        sw[11:8] = 4'd10;    // Op = 10 (Left shift)
        #10;
        $display("Left shift: %b << %b = %b", sw[3:0], sw[7:4], led[3:0]);
        
        // Test Case 11: Right shift A by B postions (12 >> 2)
        sw[3:0] = 4'd12;     // A = 12
        sw[7:4] = 4'd2;     // B = 2
        sw[11:8] = 4'd11;    // Op = 11 (Right shift)
        #10;
        $display("Right shift: %b >> %b = %b", sw[3:0], sw[7:4], led[3:0]);
        
        // Test Case 12: A > B comparison (8 > 2)
        sw[3:0] = 4'd8;     // A = 8
        sw[7:4] = 4'd2;     // B = 2
        sw[11:8] = 4'd12;    // Op = 12 (A > B)
        #10;
        $display("A > B: %b > %b = %b", sw[3:0], sw[7:4], led[3:0]);
        
        // Test Case 13: A < B comparison (8 < 2)
        sw[3:0] = 4'd8;     // A = 8
        sw[7:4] = 4'd2;     // B = 2
        sw[11:8] = 4'd13;    // Op = 13 (A < B)
        #10;
        $display("A < B: %b < %b = %b", sw[3:0], sw[7:4], led[3:0]);
        
        // Test Case 14: A == B comparison (5 == 5)
        sw[3:0] = 4'd5;     // A = 5
        sw[7:4] = 4'd5;     // B = 5
        sw[11:8] = 4'd14;    // Op = 14 (A == B)
        #10;
        $display("A == B: %b & %b = %b", sw[3:0], sw[7:4], led[3:0]);
        
        // Test Case 15: Increment A (6 + 1)
        sw[3:0] = 4'd6;     // A = 6
        sw[11:8] = 4'd15;    // Op = 15 (Increment A)
        #10;
        $display("Increment A: %b + 1 = %b", sw[3:0], led[3:0]);
        
        #100;
        $finish;
    end

endmodule
