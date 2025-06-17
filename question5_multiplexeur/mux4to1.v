module mux4to1 (
    input       I0, I1, I2, I3,   // 4 entrées du multiplexeur (1 bit chacune)
    input [1:0] S,               // ligne de sélection sur 2 bits (00,01,10,11)
    output reg  Y                // sortie du multiplexeur (1 bit)
);
    always @(*) begin
        case (S)
            2'b00: Y = I0;
            2'b01: Y = I1;
            2'b10: Y = I2;
            2'b11: Y = I3;
        endcase
    end
endmodule