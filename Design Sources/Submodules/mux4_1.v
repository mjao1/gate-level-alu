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
