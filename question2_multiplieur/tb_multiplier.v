`timescale 1ns/1ps
module tb_multiplier_4x4_structural;
  reg  [3:0] a, b;
  wire [7:0] p;

  // Instanciation du module corrigé
  multiplier_4x4_structural dut (
    .a(a),
    .b(b),
    .p(p)
  );

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_multiplier_4x4_structural);

    $monitor("a=%d b=%d -> p=%d (0b%b)", a, b, p, p);

    // Tests ciblés
    a=0;  b=0;  #10;
    a=1;  b=1;  #10;
    a=3;  b=5;  #10;
    a=4;  b=4;  #10;
    a=8;  b=2;  #10;
    a=15; b=15; #10;

    // Test exhaustif
    for (integer i = 0; i < 16; i++) begin
      for (integer j = 0; j < 16; j++) begin
        a = i; b = j; #10;
        if (p !== i * j) begin
          $error("ERREUR: %0d * %0d = %0d mais obtenu %0d", i, j, i * j, p);
          $finish;
        end
      end
    end

    $display("Tous les tests sont OK !");
    $finish;
  end
endmodule