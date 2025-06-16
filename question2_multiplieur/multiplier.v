// --------------------------------------------------
// 1) Modules de base : full_adder, half_adder
// --------------------------------------------------
module full_adder(
  input  wire a, b, cin,
  output wire sum, cout
);
  assign sum  = a ^ b ^ cin;
  assign cout = (a & b) | (a & cin) | (b & cin);
endmodule

module half_adder(
  input  wire a, b,
  output wire sum, cout
);
  assign sum  = a ^ b;
  assign cout = a & b;
endmodule

// --------------------------------------------------
// 2) Ripple‐carry adder générique
// --------------------------------------------------
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

// --------------------------------------------------
// 3) Multiplieur structural 4×4, pipeline en 3 stades
// --------------------------------------------------
module multiplier_4x4_structural(
  input  wire [3:0] a,
  input  wire [3:0] b,
  output wire [7:0] p
);
  // 1) Génération des produits partiels
  wire [3:0] pp0 = a & {4{b[0]}};
  wire [3:0] pp1 = a & {4{b[1]}};
  wire [3:0] pp2 = a & {4{b[2]}};
  wire [3:0] pp3 = a & {4{b[3]}};

  // 2) Addition pp0 + (pp1 << 1)
  wire [4:0] sum1;
  wire       c1;
  ripple_adder #(.W(5)) ad1 (
    .A   ({1'b0,    pp0    }), // étendre à 5 bits
    .B   ({pp1,     1'b0   }), // décalage <<1
    .Cin (1'b0),
    .Sum (sum1),
    .Cout(c1)
  );

  // 3) Addition sum1 + (pp2 << 2)
  wire [5:0] sum2;
  wire       c2;
  ripple_adder #(.W(6)) ad2 (
    .A   ({c1,      sum1    }), // somme 5 bits + retenue
    .B   ({pp2,     2'b00   }), // décalage <<2
    .Cin (1'b0),
    .Sum (sum2),
    .Cout(c2)
  );

  // 4) Addition sum2 + (pp3 << 3)
  wire [6:0] sum3;
  wire       c3;
  ripple_adder #(.W(7)) ad3 (
    .A   ({c2,      sum2    }), // somme 6 bits + retenue
    .B   ({pp3,     3'b000  }), // décalage <<3
    .Cin (1'b0),
    .Sum (sum3),
    .Cout(c3)
  );

  // Résultat final
  assign p = {c3, sum3};
endmodule
