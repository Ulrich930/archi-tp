`timescale 1ns/1ps  // Échelle de temps pour la simulation

module tb_mux4to1;
    // Déclaration des signaux de test
    reg s0, s1;                   // lignes de sélection (bits de contrôle)
    reg d0, d1, d2, d3;           // entrées de données du multiplexeur
    wire y;                       // sortie connectée au multiplexeur

    // Instanciation du module multiplexeur sous test (Unit Under Test : UUT)
    mux4to1 uut (
        .s0(s0),
        .s1(s1),
        .d0(d0),
        .d1(d1),
        .d2(d2),
        .d3(d3),
        .y(y)
    );

    // Moniteur pour afficher les changements (console)
    initial begin
        $display("Time\t S1 S0 \t d3 d2 d1 d0 \t Y");
        $monitor("%g\t   %b  %b   \t %b  %b  %b  %b   \t %b",
                 $time, s1, s0,    d3, d2, d1, d0,    y);
    end

    // Scénario de test principal
    initial begin
        // Cas 1 : première configuration des entrées
        d0 = 0; d1 = 1; d2 = 0; d3 = 1;   // attribuer certaines valeurs aux entrées
        // Tester toutes les combinaisons de selecteurs pour ce jeu de données
        s1 = 0; s0 = 0; #10;  // attente de 10 ns
        s0 = 1;        #10;
        s1 = 1; s0 = 0; #10;
        s0 = 1;        #10;

        // Cas 2 : changer la configuration des entrées
        d0 = 1; d1 = 0; d2 = 1; d3 = 0;   // nouveau jeu de valeurs pour les entrées
        // Tester à nouveau toutes les combinaisons de s1,s0
        s1 = 0; s0 = 0; #10;
        s0 = 1;        #10;
        s1 = 1; s0 = 0; #10;
        s0 = 1;        #10;

        $finish;  // Fin de la simulation
    end

    // Génération du fichier de formes d'onde (dump VCD)
    initial begin
        $dumpfile("mux4to1.vcd");       // nom du fichier de dump
        $dumpvars(0, tb_mux4to1);       // enregistre toutes les variables du testbench
    end
endmodule
