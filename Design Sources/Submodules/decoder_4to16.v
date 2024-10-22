module decoder_4to16(
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
