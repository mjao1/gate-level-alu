module divider(
    input [3:0] A,
    input [3:0] B,
    output [7:0] quotient
    );

    // Division by zero check
    wire B_zero;
    nor (B_zero, B[0], B[1], B[2], B[3]); // B_zero is 1 if B is zero

    // Implementing division using subtractors and comparators
    // Quotient is calculated by subtracting B from A as many times as possible

    // Initialize variables
    wire [3:0] rem0 = A;
    wire [3:0] rem1, rem2, rem3, rem4;
    wire borrow1, borrow2, borrow3, borrow4;
    wire q0, q1, q2, q3;

    // First subtraction: rem1 = rem0 - B
    subtractor_4bit sub1 (.A(rem0), .B(B), .Diff(rem1), .Borrow(borrow1));
    assign q0 = ~borrow1; // If borrow1 is 0, then rem0 >= B, so q0 = 1

    // Second subtraction: rem2 = rem1 - B
    subtractor_4bit sub2 (.A(rem1), .B(B), .Diff(rem2), .Borrow(borrow2));
    assign q1 = ~borrow2 & q0; // q1 is valid only if q0 is 1

    // Third subtraction: rem3 = rem2 - B
    subtractor_4bit sub3 (.A(rem2), .B(B), .Diff(rem3), .Borrow(borrow3));
    assign q2 = ~borrow3 & q1; // q2 is valid only if q1 is 1

    // Fourth subtraction: rem4 = rem3 - B
    subtractor_4bit sub4 (.A(rem3), .B(B), .Diff(rem4), .Borrow(borrow4));
    assign q3 = ~borrow4 & q2; // q3 is valid only if q2 is 1

    // Sum q0 + q1 + q2 + q3 to get correct quotient
    wire [2:0] s1;
    wire [2:0] s2;
    wire [2:0] sum;
    wire c1, c2, c3;

    // Sum q0 and q1
    full_adder fa_s1_0 (.a(q0), .b(q1), .cin(1'b0), .sum(s1[0]), .cout(c1));
    assign s1[1] = c1;
    assign s1[2] = 1'b0;

    // Sum q2 and q3
    full_adder fa_s2_0 (.a(q2), .b(q3), .cin(1'b0), .sum(s2[0]), .cout(c2));
    assign s2[1] = c2;
    assign s2[2] = 1'b0;

    // Sum s1 and s2
    full_adder fa_sum0 (.a(s1[0]), .b(s2[0]), .cin(1'b0), .sum(sum[0]), .cout(c3));
    full_adder fa_sum1 (.a(s1[1]), .b(s2[1]), .cin(c3),   .sum(sum[1]), .cout(sum[2]));

    // Quotient is sum[2:0]
    assign quotient = B_zero ? 8'b00000000 : {5'b00000, sum};
endmodule
