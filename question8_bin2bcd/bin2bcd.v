`timescale 1ns/1ps

// Module corrigé : Conversion binaire 8 bits vers 3 chiffres BCD
module bin2bcd8(
    input  [7:0] bin,
    output reg [3:0] centaines,
    output reg [3:0] dizaines,
    output reg [3:0] unites
);
    reg [19:0] bcd;  // Registre plus large pour le traitement
    integer i;

    always @(*) begin
        bcd = 20'd0;  // Initialisation complète à zéro
        bcd[7:0] = bin;  // Copie de l'entrée binaire
        
        // Traitement des 8 bits (LSB en premier)
        for (i = 0; i < 8; i = i + 1) begin
            // Vérification et ajustement des digits
            if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;
            if (bcd[15:12] >= 5) bcd[15:12] = bcd[15:12] + 3;
            if (bcd[19:16] >= 5) bcd[19:16] = bcd[19:16] + 3;
            
            // Décalage à gauche de tout le registre
            bcd = bcd << 1;
        end
        
        // Assignation des sorties
        centaines = bcd[19:16];
        dizaines = bcd[15:12];
        unites = bcd[11:8];
    end
endmodule

