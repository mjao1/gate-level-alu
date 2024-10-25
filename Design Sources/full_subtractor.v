module full_subtractor(
    input A,
    input B,
    input Bin,
    output Diff,
    output Bout
    );

    wire w1, w2, w3;
    xor (w1, A, B);
    xor (Diff, w1, Bin);
    not (w2, A);
    and (w3, w2, B);
    wire w4;
    and (w4, w2, Bin);
    wire w5;
    and (w5, B, Bin);
    or (Bout, w3, w4, w5);
endmodule
