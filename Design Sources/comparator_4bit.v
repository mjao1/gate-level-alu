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
    wire lt_bit3, lt_bit2, lt_bit1, lt_bit0;
    and (lt_bit3, nA3, B[3]);
    and (lt_bit2, eq3, nA2, B[2]);
    and (lt_bit1, eq3, eq2, nA1, B[1]);
    and (lt_bit0, eq3, eq2, eq1, nA0, B[0]);
    or (A_lt_B, lt_bit3, lt_bit2, lt_bit1, lt_bit0);
endmodule
