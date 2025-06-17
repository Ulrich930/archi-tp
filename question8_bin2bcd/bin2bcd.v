module bin2bcd8(
    input  [7:0] bin,
    output reg [3:0] centaines,
    output reg [3:0] dizaines,
    output reg [3:0] unites
);
    reg [19:0] bcd;
    integer i;

    always @(*) begin
        bcd      = 20'd0;
        bcd[7:0] = bin;

        for (i = 0; i < 8; i = i + 1) begin
            if (bcd[11:8]  >= 5) bcd[11:8]  = bcd[11:8]  + 3;
            if (bcd[15:12] >= 5) bcd[15:12] = bcd[15:12] + 3;
            if (bcd[19:16] >= 5) bcd[19:16] = bcd[19:16] + 3;
            bcd = bcd << 1;
        end

        centaines = bcd[19:16];
        dizaines  = bcd[15:12];
        unites   = bcd[11:8];
    end
endmodule