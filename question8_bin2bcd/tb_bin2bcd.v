// Testbench corrigé
module tb_bin2bcd8;
    reg  [7:0] bin;
    wire [3:0] centaines, dizaines, unites;
    integer i;
    reg [7:0] expected;

    bin2bcd8 uut (
        .bin(bin),
        .centaines(centaines),
        .dizaines(dizaines),
        .unites(unites)
    );

    initial begin
        $dumpfile("bin2bcd.vcd");
        $dumpvars(0, tb_bin2bcd8);

        // Tests spécifiques critiques
        bin = 8'd0; #1; if ({centaines, dizaines, unites} !== 12'h000) $error("0 failed");
        bin = 8'd1; #1; if ({centaines, dizaines, unites} !== 12'h001) $error("1 failed");
        bin = 8'd9; #1; if ({centaines, dizaines, unites} !== 12'h009) $error("9 failed");
        bin = 8'd10; #1; if ({centaines, dizaines, unites} !== 12'h010) $error("10 failed");
        bin = 8'd99; #1; if ({centaines, dizaines, unites} !== 12'h099) $error("99 failed");
        bin = 8'd100; #1; if ({centaines, dizaines, unites} !== 12'h100) $error("100 failed");
        bin = 8'd255; #1; if ({centaines, dizaines, unites} !== 12'h255) $error("255 failed");
        
        // Test exhaustif
        for (i = 0; i < 256; i = i + 1) begin
            bin = i;
            #1;
            expected = i;
            
            // Vérification
            if ((centaines*100 + dizaines*10 + unites) !== i) begin
                $display("ERREUR: Bin=%0d | Centaines=%0d, Dizaines=%0d, Unites=%0d | Valeur=%0d (Attendu=%0d)",
                         bin, centaines, dizaines, unites, 
                         (centaines*100 + dizaines*10 + unites), i);
                $finish;
            end
        end
        
        $display("Tous les tests passés avec succès!");
        $finish;
    end
endmodule