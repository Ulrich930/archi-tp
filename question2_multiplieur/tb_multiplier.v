`timescale 1ns/1ps

//-----------------------------------------------------------------------------
// Banc multi‐largeur pour multiplier_array (2, 4, 8, 16, 64 bits)
// Génère transcript + VCD pour la forme d'ondes.
//-----------------------------------------------------------------------------

module tb_multiplier_multiwidth;

  //---------------------------------------------------------------------------- 
  // Dump VCD global 
  //---------------------------------------------------------------------------- 
  initial begin
    $dumpfile("multiplier_multiwidth.vcd");
    $dumpvars(0, tb_multiplier_multiwidth);
  end

  //----------------------------------------------------------------------------  
  // Tests N = 2 bits  
  //----------------------------------------------------------------------------  
  generate if (1) begin : TEST_2
    localparam integer N = 2;
    reg  [N-1:0] A2, B2;
    wire [2*N-1:0] P2;
    multiplier_array #(.N(N)) dut2 (.A(A2), .B(B2), .P(P2));

    initial begin
      $display("\n--- Tests multiplieur %0d×%0d bits ---", N, N);
      A2=0; B2=0;    #5; $display("0×0       = %0d", P2);
      A2=1; B2=1;    #5; $display("1×1       = %0d", P2);
      A2=2; B2=1;    #5; $display("2×1       = %0d", P2);
      A2=3; B2=2;    #5; $display("3×2       = %0d", P2);
      A2={N{1'b1}}; B2={N{1'b1}}; #5; $display("max×max   = %0d", P2);
      $display("-> Fin tests %0d bits\n", N);
    end
  end endgenerate

  //----------------------------------------------------------------------------  
  // Tests N = 4 bits  
  //----------------------------------------------------------------------------  
  generate if (1) begin : TEST_4
    localparam integer N = 4;
    reg  [N-1:0] A4, B4;
    wire [2*N-1:0] P4;
    multiplier_array #(.N(N)) dut4 (.A(A4), .B(B4), .P(P4));

    initial begin
      $display("\n--- Tests multiplieur %0d×%0d bits ---", N, N);
      A4=0;   B4=0;   #5; $display("0×0       = %0d", P4);
      A4=1;   B4=1;   #5; $display("1×1       = %0d", P4);
      A4=8;   B4=2;   #5; $display("8×2       = %0d", P4);
      A4=11;  B4=5;   #5; $display("11×5      = %0d", P4);
      A4=15;  B4=15;  #5; $display("15×15     = %0d", P4);
      $display("-> Fin tests %0d bits\n", N);
    end
  end endgenerate

  //----------------------------------------------------------------------------  
  // Tests N = 8 bits  
  //----------------------------------------------------------------------------  
  generate if (1) begin : TEST_8
    localparam integer N = 8;
    reg  [N-1:0] A8, B8;
    wire [2*N-1:0] P8;
    multiplier_array #(.N(N)) dut8 (.A(A8), .B(B8), .P(P8));

    initial begin
      $display("\n--- Tests multiplieur %0d×%0d bits ---", N, N);
      A8=0;    B8=0;    #5; $display("0×0        = %0d", P8);
      A8=1;    B8=1;    #5; $display("1×1        = %0d", P8);
      A8=128;  B8=2;    #5; $display("128×2      = %0d", P8);
      A8=184;  B8=38;   #5; $display("184×38     = %0d", P8);
      A8=255;  B8=255;  #5; $display("255×255    = %0d", P8);
      $display("-> Fin tests %0d bits\n", N);
    end
  end endgenerate

  //----------------------------------------------------------------------------  
  // Tests N = 16 bits  
  //----------------------------------------------------------------------------  
  generate if (1) begin : TEST_16
    localparam integer N = 16;
    reg  [N-1:0] A16, B16;
    wire [2*N-1:0] P16;
    multiplier_array #(.N(N)) dut16 (.A(A16), .B(B16), .P(P16));

    initial begin
      $display("\n--- Tests multiplieur %0d×%0d bits ---", N, N);
      A16=0;      B16=0;      #5; $display("0×0         = %0d", P16);
      A16=1;      B16=1;      #5; $display("1×1         = %0d", P16);
      A16=32768;  B16=2;      #5; $display("32768×2     = %0d", P16);
      A16=12345;  B16=54321;  #5; $display("12345×54321 = %0d", P16);
      A16=65535;  B16=65535;  #5; $display("65535×65535 = %0d", P16);
      $display("-> Fin tests %0d bits\n", N);
    end
  end endgenerate

  //----------------------------------------------------------------------------  
  // Tests N = 64 bits  
  //----------------------------------------------------------------------------  
  generate if (1) begin : TEST_64
    localparam integer N = 64;
    reg  [N-1:0] A64, B64;
    wire [2*N-1:0] P64;
    multiplier_array #(.N(N)) dut64 (.A(A64), .B(B64), .P(P64));

    initial begin
      $display("\n--- Tests multiplieur %0d×%0d bits ---", N, N);
      A64=0;                      B64=0;                      #5; $display("0×0                         = %0d", P64);
      A64=1;                      B64=1;                      #5; $display("1×1                         = %0d", P64);
      A64=(64'h1 << 63);          B64=64'd2;                  #5; $display("2^63×2                      = %0d", P64);
      A64=64'd12345678;           B64=64'd87654321;           #5; $display("12345678×87654321          = %0d", P64);
      A64={64{1'b1}};             B64={64{1'b1}};             #5; $display("max×max                     = %0d", P64);
      $display("-> Fin tests %0d bits\n", N);
    end
  end endgenerate

endmodule
