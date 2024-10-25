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
