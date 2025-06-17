`timescale 1ns/1ps
module mux4to1_tb;
    // Déclaration des signaux de test
    reg  I0, I1, I2, I3;      // entrées de test (1 bit chacune)
    reg  [1:0] S;             // sélecteur de test sur 2 bits
    wire Y;                   // fil pour la sortie du multiplexeur

    // Instanciation du module multiplexeur 4:1 (Unité sous test UUT)
    mux4to1 uut (
        .I0(I0),
        .I1(I1),
        .I2(I2),
        .I3(I3),
        .S(S),
        .Y(Y)
    );

    // Procédure de test initiale
    initial begin
        $display("I0 I1 I2 I3 | S  | Y");             // en-tête de affichage
        $display("------------------------");

        // Scénario 1 : affecter des valeurs spécifiques aux entrées, puis balayer S
        {I3, I2, I1, I0} = 4'b0110;  // I3=0, I2=1, I1=1, I0=0
        S = 2'b00; #10; $display("%b  %b  %b  %b | %b  | %b", I0, I1, I2, I3, S, Y);
        S = 2'b01; #10; $display("%b  %b  %b  %b | %b  | %b", I0, I1, I2, I3, S, Y);
        S = 2'b10; #10; $display("%b  %b  %b  %b | %b  | %b", I0, I1, I2, I3, S, Y);
        S = 2'b11; #10; $display("%b  %b  %b  %b | %b  | %b", I0, I1, I2, I3, S, Y);

        // Scénario 2 : changer les entrées et recommencer le balayage
        {I3, I2, I1, I0} = 4'b1001;  // I3=1, I2=0, I1=0, I0=1
        S = 2'b00; #10; $display("%b  %b  %b  %b | %b  | %b", I0, I1, I2, I3, S, Y);
        S = 2'b01; #10; $display("%b  %b  %b  %b | %b  | %b", I0, I1, I2, I3, S, Y);
        S = 2'b10; #10; $display("%b  %b  %b  %b | %b  | %b", I0, I1, I2, I3, S, Y);
        S = 2'b11; #10; $display("%b  %b  %b  %b | %b  | %b", I0, I1, I2, I3, S, Y);

        $finish;  // fin de la simulation
    end
endmodule