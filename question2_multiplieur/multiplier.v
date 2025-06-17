//-----------------------------------------------------------------------------
// 1) Modules de base : demi‐additionneur et additionneur complet
//-----------------------------------------------------------------------------

module half_adder (
    input  wire a,
    input  wire b,
    output wire sum,
    output wire cout
);
    assign sum  = a ^ b;
    assign cout = a & b;
endmodule

module full_adder (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire cout
);
    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);
endmodule


//-----------------------------------------------------------------------------
// 2) Ripple‐carry adder générique de largeur W
//-----------------------------------------------------------------------------
module ripple_adder #(
    parameter integer W = 4
)(
    input  wire [W-1:0] A,
    input  wire [W-1:0] B,
    input  wire         Cin,
    output wire [W-1:0] Sum,
    output wire         Cout
);
    wire [W:0] carry;
    assign carry[0] = Cin;

    genvar i;
    generate
      for (i = 0; i < W; i = i + 1) begin : FA_GEN
        full_adder fa (
          .a   (A[i]),
          .b   (B[i]),
          .cin (carry[i]),
          .sum (Sum[i]),
          .cout(carry[i+1])
        );
      end
    endgenerate

    assign Cout = carry[W];
endmodule


//-----------------------------------------------------------------------------
// 3) Multiplieur « array » générique N×N → 2N bits
//-----------------------------------------------------------------------------
module multiplier_array #(
    parameter integer N = 8
)(
    input  wire [N-1:0] A,
    input  wire [N-1:0] B,
    output wire [2*N-1:0] P
);
    // Déclaration du tableau de produits partiels
    wire [2*N-1:0] partial_products [N-1:0];

    genvar k;
    generate
      for (k = 0; k < N; k = k + 1) begin : GEN_PP
        // Génère A & B[k], puis décale de k bits
        assign partial_products[k] = (A & {N{B[k]}}) << k;
      end
    endgenerate

    // Sommation de tous les produits partiels
    // On peut réutiliser ripple_adder pour faire l'addition progressive
    // Ici, on réalise une accumulation séquentielle
    reg [2*N-1:0] acc;
    integer j;
    always @(*) begin
        acc = {2*N{1'b0}};
        for (j = 0; j < N; j = j + 1)
            acc = acc + partial_products[j];
    end

    assign P = acc;
endmodule

