module multiplier(
    input [3:0] A,
    input [3:0] B,
    output [7:0] product
    );

    // Partial products
    wire pp0_0, pp0_1, pp0_2, pp0_3;
    wire pp1_0, pp1_1, pp1_2, pp1_3;
    wire pp2_0, pp2_1, pp2_2, pp2_3;
    wire pp3_0, pp3_1, pp3_2, pp3_3;

    and (pp0_0, A[0], B[0]);
    and (pp0_1, A[1], B[0]);
    and (pp0_2, A[2], B[0]);
    and (pp0_3, A[3], B[0]);

    and (pp1_0, A[0], B[1]);
    and (pp1_1, A[1], B[1]);
    and (pp1_2, A[2], B[1]);
    and (pp1_3, A[3], B[1]);

    and (pp2_0, A[0], B[2]);
    and (pp2_1, A[1], B[2]);
    and (pp2_2, A[2], B[2]);
    and (pp2_3, A[3], B[2]);

    and (pp3_0, A[0], B[3]);
    and (pp3_1, A[1], B[3]);
    and (pp3_2, A[2], B[3]);
    and (pp3_3, A[3], B[3]);

    // Stage 1
    wire [7:0] mult_result;
    assign mult_result[0] = pp0_0;

    // Stage 2
    wire s1, c1_mul;
    xor (s1, pp0_1, pp1_0);
    and (c1_mul, pp0_1, pp1_0);
    assign mult_result[1] = s1;

    // Stage 3
    wire sum1, carry1, s2, c2_temp, c2_mul;
    xor (sum1, pp0_2, pp1_1, pp2_0);
    assign carry1 = (pp0_2 & pp1_1) | (pp1_1 & pp2_0) | (pp0_2 & pp2_0);
    xor (s2, sum1, c1_mul);
    and (c2_temp, sum1, c1_mul);
    or  (c2_mul, carry1, c2_temp);
    assign mult_result[2] = s2;

    // Stage 4
    wire sum3, carry3, sum4, carry4, c3_mul;
    xor (sum3, pp0_3, pp1_2, pp2_1);
    assign carry3 = (pp0_3 & pp1_2) | (pp1_2 & pp2_1) | (pp0_3 & pp2_1);
    xor (sum4, sum3, pp3_0, c2_mul);
    assign carry4 = (sum3 & pp3_0) | (pp3_0 & c2_mul) | (sum3 & c2_mul);
    assign mult_result[3] = sum4;
    or  (c3_mul, carry3, carry4);

    // Stage 5
    wire sum5, carry5, s4, c4_temp, c4_mul;
    xor (sum5, pp1_3, pp2_2, pp3_1);
    assign carry5 = (pp1_3 & pp2_2) | (pp2_2 & pp3_1) | (pp1_3 & pp3_1);
    xor (s4, sum5, c3_mul);
    and (c4_temp, sum5, c3_mul);
    or  (c4_mul, carry5, c4_temp);
    assign mult_result[4] = s4;

    // Stage 6
    wire sum6, carry6, c5_mul;
    xor (sum6, pp2_3, pp3_2, c4_mul);
    assign carry6 = (pp2_3 & pp3_2) | (pp3_2 & c4_mul) | (pp2_3 & c4_mul);
    assign mult_result[5] = sum6;
    assign c5_mul = carry6;

    // Stage 7
    wire c6_mul;
    xor (mult_result[6], pp3_3, c5_mul);
    and (c6_mul, pp3_3, c5_mul);
    assign mult_result[7] = c6_mul;

    assign product = mult_result;
endmodule
