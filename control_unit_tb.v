module control_unit_tb;
    wire clk;
    wire[15:0] operand;
    wire[15:0] mem_addr;
    wire[15:0] mem_data;
    wire mem_enable;
    wire mem_write;
    wire [3:0] reg_addr_from;
    wire [3:0] reg_addr_to;
    wire mov_enable;

    wire [15:0] reg_a;
    wire [15:0] reg_b;
    wire [15:0] reg_ans;

    clk_gen C1(.clk(clk));
    memory_module M1(
        .addr(mem_addr),
        .data(mem_data),
        .enable(mem_enable),
        .write(mem_write)
    );
    control_unit CU1(
        .clk(clk), 
        .operand(operand),
        .mem_addr(mem_addr),
        .mem_data(mem_data),
        .mem_enable(mem_enable),
        .mem_write(mem_write),
        .mov_enable(mov_enable),
        .reg_addr_from(reg_addr_from),
        .reg_addr_to(reg_addr_to)
    );
    alu A1(
        .operation(operand),
        .x(reg_a),
        .y(reg_b),
        .ans(reg_ans)
    );
    reg_bank RB1(
        .from_addr(reg_addr_from),
        .to_addr(reg_addr_to),
        .enable(mov_enable),
        .clk(clk),
        .alu_ans(reg_ans),
        .alu_x(reg_a),
        .alu_y(reg_b),
        .input_reg(operand)
    );
        initial begin
            $dumpfile("dump.vcd");
            $dumpvars;
            #50;

            $finish;
        end
    endmodule

    module memory_module (
        input [15:0] addr,
        inout [15:0] data,
        input enable, write
    );
        reg [15:0] memory [0:15];
        initial begin
            for (integer i=0; i<100; i=i+1) begin
                 memory[i] = 'hff;
            end
            memory[0] = 0;  // do nothing
            memory[1] = {8'd2, 4'd3, 4'd6}; // move data from reg 3 to reg 6
            memory[2] = {8'd1, 8'h0b};  // input data into reg_x
            memory[3] = 16'h1;      // input 'this' data
            memory[4] = {8'd1, 8'h0c};    // input data into reg_y
            memory[5] = 16'h1;      // input 'this' data
            memory[6] = {8'h10, 8'h0b};  // add contents of reg_x and reg_y to stated register(reg_x) in this line)
            //memory[7] = {8'h10, 8'h0b};
            //memory[8] = {8'h10, 8'h0b};
        end
        assign data = (enable)? memory[addr] : 'bz;
endmodule