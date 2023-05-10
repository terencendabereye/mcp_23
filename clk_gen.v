//`timescale 1ns/100ps
module clk_gen 
#(parameter period = 2) (
    output reg clk
);
    initial begin
        clk = 0;
        forever begin
            clk = #(period/2) ~clk;
        end
    end
endmodule