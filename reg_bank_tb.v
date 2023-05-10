
module reg_bank_tb;

reg [3:0] from_addr;
reg [3:0] to_addr;
wire [15:0] alu_x;
wire [15:0] alu_y;
wire [15:0] alu_ans;
reg [15:0] input_reg;
reg enable;
wire clk;

//always @(*) alu_ans = alu_x + alu_y;

clk_gen C1(.clk(clk));
reg_bank RB1(
    .from_addr(from_addr),
    .to_addr(to_addr),
    .enable(enable),
    .alu_x(alu_x),
    .alu_y(alu_y),
    .alu_ans(alu_ans),
    .input_reg(input_reg),
    .clk(clk)
);
alu A1(
    .x(alu_x),
    .y(alu_y),
    .ans(alu_ans),
    .operation(16'd0)
);

initial begin
    //$dumpfile("dump.vcd");
    //$dumpvars;
    #2;
    input_reg = 1;
    from_addr = 4'ha;
    to_addr = 4'hb;
    enable = 1;
    #2;

    input_reg = 1;
    to_addr = 4'hc;
    #2;

    from_addr = 4'hd;
    to_addr = 4'hc;
    #2; 

    
    #1000;

    $finish;
end
endmodule