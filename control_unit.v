module control_unit #(
    parameter addr_len = 16
) (
    input clk,
    output reg [addr_len-1:0] mem_addr,
    output reg mem_enable, mem_write,
    input [15:0] mem_data,
    output reg mov_enable,
    output reg [3:0] reg_addr_from,
    output reg [3:0] reg_addr_to,
    output reg [15:0] operand   // connect to (input_reg)
);
    reg [15:0] current_addr;
    reg [15:0] hold[4:0];
    integer state;

    initial begin
        operand = 0;
        mem_addr = 0;
        mem_enable = 1;
        mem_write = 0;
        mov_enable = 0;
        state = 0;
        for (integer i=0; i<4; i=i+1) begin 
            hold[i] = 8'h0;
        end
    end

    always @(posedge clk) begin
        mov_enable = 0;
        operand = 0;

        if (state) begin // read next 2byte
            case (state)
                1: begin // input data
                    operand <= mem_data;
                    mov_enable <= 1;
                    state <= 0;
                    mem_addr <= mem_addr + 1;
                end
            endcase
        end else begin
            case (mem_data[15:8]) 
                1: begin // input
                    reg_addr_from <= 4'ha;
                    reg_addr_to <= mem_data[3:0];
                    state <= 1;
                    mem_addr <= mem_addr + 1;
                end
                2: begin // mov
                    reg_addr_from <= mem_data[7:4]; // source
                    reg_addr_to <= mem_data[3:0]; // destination
                    mov_enable <= 1;
                    mem_addr <= mem_addr + 1;
                end
                8'h10,
                8'h11,
                8'h12,
                8'h13,
                8'h14,
                8'h15: begin // alu operation
                    reg_addr_from <= 4'hd;
                    reg_addr_to <= mem_data[3:0]; // calculation destination
                    mov_enable <= 1;
                    operand = mem_data[11:8]; // set operation: + - etc
                    mem_addr <= mem_addr + 1;
                end
                8'h3: begin // load
                end
                8'h4: begin // store
                end
                8'h5: begin // push
                end
                8'h6: begin // pull
                end
                
                default: begin
                    mem_addr <= mem_addr + 1;
                end
            endcase
        end
    end
endmodule