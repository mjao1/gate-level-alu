module subtractor_4bit(
    input [3:0] A,
    input [3:0] B,
    output [3:0] Diff,
    output Borrow
    );

    wire b0, b1, b2, b3;

    full_subtractor fs0 (.A(A[0]), .B(B[0]), .Bin(1'b0),  .Diff(Diff[0]), .Bout(b0));
    full_subtractor fs1 (.A(A[1]), .B(B[1]), .Bin(b0),    .Diff(Diff[1]), .Bout(b1));
    full_subtractor fs2 (.A(A[2]), .B(B[2]), .Bin(b1),    .Diff(Diff[2]), .Bout(b2));
    full_subtractor fs3 (.A(A[3]), .B(B[3]), .Bin(b2),    .Diff(Diff[3]), .Bout(b3));

    assign Borrow = b3;
endmodule
