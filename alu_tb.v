`timescale 1ns/1ns
module alu_tb;
    parameter word_len = 32;
    parameter op_len = 8;
    reg [word_len-1: 0] a;
    reg [word_len-1: 0] b;
    wire [word_len-1: 0] c;
    reg [op_len-1: 0] op;
    wire ovf;
    wire neg;
    wire zer;
    integer i;
    integer j;
    integer k;

    alu #(
        .word_len(word_len),
         .op_len(op_len)
         ) A1 (
            .x(a),
            .y(b),
            .ans(c),
            .did_overflow(ovf),
            .is_negative(neg),
            .is_zero(zer),
            .operation(op)
            );

    initial begin
        //$dumpfile("dump.vcd");
        //$dumpvars;

        for (i=-10; i<10; i=i+1) begin
            for (j=-10; j<10; j=j+1) begin
                for (k=0; k<5; k=k+1) begin
                    a = i;
                    b = j;
                    op = k;
                    #1;
                end
            end
        end

        $finish;
    end
endmodule


