`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Michael Jao
// 
// Create Date: 10/10/2024 12:20:09 PM
// Design Name: 4-bit ALU (gate level)
// Module Name: alu_gatelvl
// Project Name: 4-bit ALU implemented on Basys 3 Artix-7 FPGA
// Target Devices: xc7a35tcpg236-1
// Tool Versions: Vivado 2024.1 
// Description: A 4-bit Arithmetic Logic Unit (ALU) built at gate level abstraction. 
//              The 4-bit ALU is developed and implemented using Verilog in Xilinx Vivado, 
//              deploying it on the Basys 3 Artix-7 FPGA. The ALU features 16 arithmetic 
//              and logic operation selections and accepts two 4-bit inputs from switches 
//              0-7 and a 4-bit operation selector from switches 8-11 on the Basys 3. The 
//              results are outputted via onboard LEDs as a binary representation.
//
//////////////////////////////////////////////////////////////////////////////////


module alu_gatelvl(
    input [15:0] sw, // Switches
    output [4:0] led // LEDs including carry out
    );

    // Extract operands and operation code from switches
    wire [3:0] A = sw[3:0];      
    wire [3:0] B = sw[7:4];      
    wire [3:0] Op = sw[11:8];    

    // Define wires for results of each operation
    wire [4:0] result0; // Addition
    wire [4:0] result1; // Subtraction
    wire [4:0] result2; // Multiplication
    wire [4:0] result3; // Division
    wire [4:0] result4; // Bitwise AND
    wire [4:0] result5; // Bitwise OR
    wire [4:0] result6; // Bitwise XOR
    wire [4:0] result7; // Bitwise NAND
    wire [4:0] result8; // Bitwise NOR
    wire [4:0] result9; // Bitwise XNOR
    wire [4:0] result10; // Left shift A by B positions
    wire [4:0] result11; // Right shift A by B positions
    wire [4:0] result12; // A > B comparison
    wire [4:0] result13; // A < B comparison
    wire [4:0] result14; // A == B comparison
    wire [4:0] result15; // Increment A

    //Operation 0: Addition (A + B)
    wire c0, c1, c2, c3;
    wire [3:0] sum;
    full_adder fa0 (.a(A[0]), .b(B[0]), .cin(1'b0), .sum(sum[0]), .cout(c0));
    full_adder fa1 (.a(A[1]), .b(B[1]), .cin(c0),  .sum(sum[1]), .cout(c1));
    full_adder fa2 (.a(A[2]), .b(B[2]), .cin(c1),  .sum(sum[2]), .cout(c2));
    full_adder fa3 (.a(A[3]), .b(B[3]), .cin(c2),  .sum(sum[3]), .cout(c3));
    assign result0 = {c3, sum};

    // Operation 1: Subtraction (A - B)
    wire [3:0] notB;
    wire c0_sub, c1_sub, c2_sub, c3_sub;
    wire [3:0] diff;
    not (notB[0], B[0]);
    not (notB[1], B[1]);
    not (notB[2], B[2]);
    not (notB[3], B[3]);
    full_adder fa_sub0 (.a(A[0]), .b(notB[0]), .cin(1'b1), .sum(diff[0]), .cout(c0_sub));
    full_adder fa_sub1 (.a(A[1]), .b(notB[1]), .cin(c0_sub), .sum(diff[1]), .cout(c1_sub));
    full_adder fa_sub2 (.a(A[2]), .b(notB[2]), .cin(c1_sub), .sum(diff[2]), .cout(c2_sub));
    full_adder fa_sub3 (.a(A[3]), .b(notB[3]), .cin(c2_sub), .sum(diff[3]), .cout(c3_sub));
    assign result1 = {c3_sub, diff};
    
    // Operation 2: Multiplication (A * B)
    wire [7:0] mult_result;
    assign mult_result = {4'b0000, A} * {4'b0000, B};
    assign result2 = {mult_result[4], mult_result[3:0]};

    // Operation 3: Division (A / B)
    wire [7:0] div_result;
    assign div_result = {4'b0000, A} / {4'b0000, B};
    assign result3 = {div_result[4], div_result[3:0]};
    
    // Operation 4: Bitwise AND (A & B) 
    wire [3:0] and_out;
    and (and_out[0], A[0], B[0]);
    and (and_out[1], A[1], B[1]);
    and (and_out[2], A[2], B[2]);
    and (and_out[3], A[3], B[3]);
    assign result4 = {1'b0, and_out};

    // Operation 5: Bitwise OR (A | B)
    wire [3:0] or_out;
    or (or_out[0], A[0], B[0]);
    or (or_out[1], A[1], B[1]);
    or (or_out[2], A[2], B[2]);
    or (or_out[3], A[3], B[3]);
    assign result5 = {1'b0, or_out};

    // Operation 6: Bitwise XOR (A ^ B)
    wire [3:0] xor_out;
    xor (xor_out[0], A[0], B[0]);
    xor (xor_out[1], A[1], B[1]);
    xor (xor_out[2], A[2], B[2]);
    xor (xor_out[3], A[3], B[3]);
    assign result6 = {1'b0, xor_out};

    // Operation 7: Bitwise NAND ~(A & B)
    wire [3:0] nand_out;
    nand (nand_out[0], A[0], B[0]);
    nand (nand_out[1], A[1], B[1]);
    nand (nand_out[2], A[2], B[2]);
    nand (nand_out[3], A[3], B[3]);
    assign result7 = {1'b0, nand_out};

    // Operation 8: Bitwise NOR ~(A | B)
    wire [3:0] nor_out;
    nor (nor_out[0], A[0], B[0]);
    nor (nor_out[1], A[1], B[1]);
    nor (nor_out[2], A[2], B[2]);
    nor (nor_out[3], A[3], B[3]);
    assign result8 = {1'b0, nor_out};

    // Operation 9: Bitwise XNOR ~(A ^ B)
    wire [3:0] xnor_out;
    xnor (xnor_out[0], A[0], B[0]);
    xnor (xnor_out[1], A[1], B[1]);
    xnor (xnor_out[2], A[2], B[2]);
    xnor (xnor_out[3], A[3], B[3]);
    assign result9 = {1'b0, xnor_out};

    // Operation 10: Left shift A by B positions
    wire [1:0] shift_amt = B[1:0]; // Using lower 2 bits of B for shift amount
    wire [3:0] A_shift0 = A;                 // Shift by 0
    wire [3:0] A_shift1 = {A[2:0], 1'b0};    // Shift by 1
    wire [3:0] A_shift2 = {A[1:0], 2'b00};   // Shift by 2
    wire [3:0] A_shift3 = {A[0], 3'b000};    // Shift by 3
    wire [3:0] shift_out;
    // Multiplexers for shifting
    mux4_1 mux_shift3 (.d0(A_shift0[3]), .d1(A_shift1[3]), .d2(A_shift2[3]), .d3(A_shift3[3]), .sel(shift_amt), .y(shift_out[3]));
    mux4_1 mux_shift2 (.d0(A_shift0[2]), .d1(A_shift1[2]), .d2(A_shift2[2]), .d3(A_shift3[2]), .sel(shift_amt), .y(shift_out[2]));
    mux4_1 mux_shift1 (.d0(A_shift0[1]), .d1(A_shift1[1]), .d2(A_shift2[1]), .d3(A_shift3[1]), .sel(shift_amt), .y(shift_out[1]));
    mux4_1 mux_shift0 (.d0(A_shift0[0]), .d1(A_shift1[0]), .d2(A_shift2[0]), .d3(A_shift3[0]), .sel(shift_amt), .y(shift_out[0]));
    // Carry out for shift
    wire c_shift1 = A[3]; //Shifting by 1
    wire c_shift2 = A[3] | A[2]; // Shifting by 2
    wire c_shift3 = A[3] | A[2] | A[1]; // Shifting by 3
    mux4_1 mux_shift_co (.d0(1'b0), .d1(c_shift1), .d2(c_shift2), .d3(c_shift3), .sel(shift_amt), .y(shift_co));
    assign result10 = {shift_co, shift_out};

    // Operation 11: Right shift A by B positions
    wire [3:0] A_rshift0 = A;                  // Shift by 0
    wire [3:0] A_rshift1 = {1'b0, A[3:1]};     // Shift by 1
    wire [3:0] A_rshift2 = {2'b00, A[3:2]};    // Shift by 2
    wire [3:0] A_rshift3 = {3'b000, A[3]};     // Shift by 3
    wire [3:0] rshift_out;
    mux4_1 mux_rshift3 (.d0(A_rshift0[3]), .d1(A_rshift1[3]), .d2(A_rshift2[3]), .d3(A_rshift3[3]), .sel(shift_amt), .y(rshift_out[3]));
    mux4_1 mux_rshift2 (.d0(A_rshift0[2]), .d1(A_rshift1[2]), .d2(A_rshift2[2]), .d3(A_rshift3[2]), .sel(shift_amt), .y(rshift_out[2]));
    mux4_1 mux_rshift1 (.d0(A_rshift0[1]), .d1(A_rshift1[1]), .d2(A_rshift2[1]), .d3(A_rshift3[1]), .sel(shift_amt), .y(rshift_out[1]));
    mux4_1 mux_rshift0 (.d0(A_rshift0[0]), .d1(A_rshift1[0]), .d2(A_rshift2[0]), .d3(A_rshift3[0]), .sel(shift_amt), .y(rshift_out[0]));
    // Carry out for right shift
    wire c_rshift1 = A[0];
    wire c_rshift2 = A[0] | A[1];
    wire c_rshift3 = A[0] | A[1] | A[2];
    mux4_1 mux_rshift_co (.d0(1'b0), .d1(c_rshift1), .d2(c_rshift2), .d3(c_rshift3), .sel(shift_amt), .y(rshift_co));
    assign result11 = {rshift_co, rshift_out};

    // Operation 12, 13, 14: Comparisons
    wire A_gt_B, A_eq_B, A_lt_B;
    comparator_4bit comp (.A(A), .B(B), .A_gt_B(A_gt_B), .A_eq_B(A_eq_B), .A_lt_B(A_lt_B));
    assign result12 = {4'b0000, A_gt_B}; // A > B
    assign result13 = {4'b0000, A_lt_B}; // A < B
    assign result14 = {4'b0000, A_eq_B}; // A == B

    // Operation 15: Increment A
    wire c0_inc, c1_inc, c2_inc, c3_inc;
    wire [3:0] inc;
    full_adder fa_inc0 (.a(A[0]), .b(1'b0), .cin(1'b1), .sum(inc[0]), .cout(c0_inc));
    full_adder fa_inc1 (.a(A[1]), .b(1'b0), .cin(c0_inc), .sum(inc[1]), .cout(c1_inc));
    full_adder fa_inc2 (.a(A[2]), .b(1'b0), .cin(c1_inc), .sum(inc[2]), .cout(c2_inc));
    full_adder fa_inc3 (.a(A[3]), .b(1'b0), .cin(c2_inc), .sum(inc[3]), .cout(c3_inc));
    assign result15 = {c3_inc, inc};

    // Multiplexer to select final result based on Op
    wire [15:0] sel;
    decoder4to16 dec (.in(Op), .out(sel));

    // Generate final output by combining results
    genvar i;
    generate
        for (i = 0; i < 5; i = i + 1) begin : result_mux
            wire [15:0] temp_bits;
            and (temp_bits[0],  result0[i],  sel[0]);
            and (temp_bits[1],  result1[i],  sel[1]);
            and (temp_bits[2],  result2[i],  sel[2]);
            and (temp_bits[3],  result3[i],  sel[3]);
            and (temp_bits[4],  result4[i],  sel[4]);
            and (temp_bits[5],  result5[i],  sel[5]);
            and (temp_bits[6],  result6[i],  sel[6]);
            and (temp_bits[7],  result7[i],  sel[7]);
            and (temp_bits[8],  result8[i],  sel[8]);
            and (temp_bits[9],  result9[i],  sel[9]);
            and (temp_bits[10], result10[i], sel[10]);
            and (temp_bits[11], result11[i], sel[11]);
            and (temp_bits[12], result12[i], sel[12]);
            and (temp_bits[13], result13[i], sel[13]);
            and (temp_bits[14], result14[i], sel[14]);
            and (temp_bits[15], result15[i], sel[15]);
            or (led[i], temp_bits[0], temp_bits[1], temp_bits[2], temp_bits[3], temp_bits[4], temp_bits[5], temp_bits[6], temp_bits[7], temp_bits[8], temp_bits[9], temp_bits[10], temp_bits[11], temp_bits[12], temp_bits[13], temp_bits[14], temp_bits[15]);
        end        
    endgenerate

endmodule

module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
    );
    
    wire axorb, aandb, b_and_cin, a_and_cin;
    xor (axorb, a, b);
    xor (sum, axorb, cin);
    and (aandb, a, b);
    and (b_and_cin, b, cin);
    and (a_and_cin, a, cin);
    or (cout, aandb, b_and_cin, a_and_cin);
    
endmodule

module mux4_1(
    input d0,
    input d1,
    input d2,
    input d3,
    input [1:0] sel,
    output y
    );
    
    wire s0_n, s1_n;
    wire and0, and1, and2, and3;
    not (s0_n, sel[0]);
    not (s1_n, sel[1]);
    and (and0, d0, s1_n, s0_n);       // sel == 00
    and (and1, d1, s1_n, sel[0]);     // sel == 01
    and (and2, d2, sel[1], s0_n);     // sel == 10
    and (and3, d3, sel[1], sel[0]);   // sel == 11
    or (y, and0, and1, and2, and3);
    
endmodule

module comparator_4bit(
    input [3:0] A,
    input [3:0] B,
    output A_gt_B,
    output A_eq_B,
    output A_lt_B
    );
    
    wire eq0, eq1, eq2, eq3;
    wire gt0, gt1, gt2, gt3;
    wire lt0, lt1, lt2, lt3;
    wire nA0, nA1, nA2, nA3;
    wire nB0, nB1, nB2, nB3;

    // Equality checks
    xnor (eq0, A[0], B[0]);
    xnor (eq1, A[1], B[1]);
    xnor (eq2, A[2], B[2]);
    xnor (eq3, A[3], B[3]);
    and (A_eq_B, eq0, eq1, eq2, eq3);

    // Greater than checks
    not (nA0, A[0]);
    not (nA1, A[1]);
    not (nA2, A[2]);
    not (nA3, A[3]);
    not (nB0, B[0]);
    not (nB1, B[1]);
    not (nB2, B[2]);
    not (nB3, B[3]);

    wire gt_bit3, gt_bit2, gt_bit1, gt_bit0;
    and (gt_bit3, A[3], nB3);
    and (gt_bit2, eq3, A[2], nB2);
    and (gt_bit1, eq3, eq2, A[1], nB1);
    and (gt_bit0, eq3, eq2, eq1, A[0], nB0);
    or (A_gt_B, gt_bit3, gt_bit2, gt_bit1, gt_bit0);

    // Less than checks
    and (lt_bit3, nA3, B[3]);
    and (lt_bit2, eq3, nA2, B[2]);
    and (lt_bit1, eq3, eq2, nA1, B[1]);
    and (lt_bit0, eq3, eq2, eq1, nA0, B[0]);
    or (A_lt_B, lt_bit3, lt_bit2, lt_bit1, lt_bit0);
    
endmodule

module decoder4to16(
    input [3:0] in,
    output [15:0] out
    );
        
    wire n0, n1, n2, n3;
    not (n0, in[0]);
    not (n1, in[1]);
    not (n2, in[2]);
    not (n3, in[3]);

    and (out[0],  n3, n2, n1, n0);
    and (out[1],  n3, n2, n1, in[0]);
    and (out[2],  n3, n2, in[1], n0);
    and (out[3],  n3, n2, in[1], in[0]);
    and (out[4],  n3, in[2], n1, n0);
    and (out[5],  n3, in[2], n1, in[0]);
    and (out[6],  n3, in[2], in[1], n0);
    and (out[7],  n3, in[2], in[1], in[0]);
    and (out[8],  in[3], n2, n1, n0);
    and (out[9],  in[3], n2, n1, in[0]);
    and (out[10], in[3], n2, in[1], n0);
    and (out[11], in[3], n2, in[1], in[0]);
    and (out[12], in[3], in[2], n1, n0);
    and (out[13], in[3], in[2], n1, in[0]);
    and (out[14], in[3], in[2], in[1], n0);
    and (out[15], in[3], in[2], in[1], in[0]);
    
endmodule
