`timescale 1ns/1ps
module tb_bin2bcd8;
    reg  [7:0] bin;
    wire [3:0] centaines, dizaines, unites;
    integer i;

    bin2bcd8 uut (
        .bin(bin),
        .centaines(centaines),
        .dizaines(dizaines),
        .unites(unites)
    );

    initial begin
        $dumpfile("bin2bcd.vcd");
        $dumpvars(0, tb_bin2bcd8);

        for (i = 0; i < 256; i = i + 1) begin
            bin = i;
            #1;
            if ((centaines*100 + dizaines*10 + unites) !== i) begin
                $display("Erreur: %0d attendu, obtenu %0d%0d%0d",
                         i, centaines, dizaines, unites);
                $finish;
            end
        end

        $display("Tous les tests passés avec succès!");
        $finish;
    end
endmodule