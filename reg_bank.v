module reg_bank #(
  parameter word_len = 16,
  parameter addr_len = 4
  //parameter num_of_regs = 16
) (
  input [addr_len-1:0] from_addr,
  input [addr_len-1:0] to_addr,
  input enable,
  input clk,

  //imag
  output [15:0] alu_x,
  output [15:0] alu_y,
  input [15:0] alu_ans,
  input [15:0] input_reg
);
  reg [15:0] register [0:15];

  assign alu_x = register[4'hb];
  assign alu_y = register[4'hc];
  assign alu_ans = register[4'hd];
  assign input_reg = register[4'ha];

  initial begin
    for (integer i=0; i<16; i=i+1) begin
      register[i] = 'hz;
    end
  end

  always @(clk) begin
    if (enable) begin
      case (from_addr)
        4'ha: register[to_addr] = input_reg;
        4'hd: register[to_addr] = alu_ans;
        default: register[to_addr] = register[from_addr];
      endcase
    end 
  end
endmodule

// info
/*
- imaginary registers have restrictions eg only readable or only writable
eg alu_x & alu_y are only writable and alu_ans is only readable
*/

// register assignments
/*
0:
1:
2: 
3:

a: input  (imag)(read_only)
b: alu_x  (imag)(write_only)
c: alu_y  (imag)(write_only)
d: alu_ans  (imag)(read_only)
*/