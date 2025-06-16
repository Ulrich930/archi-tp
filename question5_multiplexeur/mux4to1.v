`timescale 1ns/1ps  // Unité de temps pour la simulation (1 ns)

/// Module multiplexeur 4:1 
module mux4to1(
    input  wire d0,    // Entrée de données 0
    input  wire d1,    // Entrée de données 1
    input  wire d2,    // Entrée de données 2
    input  wire d3,    // Entrée de données 3
    input  wire s0,    // Bit de sélection 0 (poids faible)
    input  wire s1,    // Bit de sélection 1 (poids fort)
    output wire y      // Sortie du multiplexeur
);
    // La sortie y prend l'une des données d0-d3 en fonction de s1s0
    // Combinaisons : 00->d0, 01->d1, 10->d2, 11->d3
    assign y = s1 ? (s0 ? d3 : d2)    // si s1=1 : choisir d2 ou d3 selon s0
               : (s0 ? d1 : d0) ;    // si s1=0 : choisir d0 ou d1 selon s0

endmodule
