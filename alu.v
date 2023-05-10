module alu 
  #(
    parameter integer word_len = 16,
    parameter integer op_len = 16
    ) (
    input [(word_len-1):0] x, y,
    input [op_len-1:0] operation,
    output reg [word_len-1:0] ans,
    output reg did_overflow,
    is_negative,
    is_zero
);
    initial begin
        ans = 0;
        did_overflow  = 0;
    end
    always @(*) begin
        case (operation)
          0: begin // +
            {did_overflow,ans} = x+y;
          end
          1: begin // -
            {did_overflow,ans} = x-y;
          end
          2: begin // &
            ans = x & y;
          end
          3: begin // |
            ans = x | y;
          end
          4: begin // ^
            ans = x ^ y;
          end
          5: begin // ~a
            ans = ~ x;
          end
          default: begin
            ans = x ^ y;
          end
        endcase
      is_zero = (ans == ({word_len{1'b0}}))? 1'b1: 1'b0;
      is_negative = (ans[word_len-1] == 1)? 1'b1: 1'b0;
    end
endmodule