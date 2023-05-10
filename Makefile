MODULES:= alu.v reg_bank.v control_unit.v
TEST_BENCHES:= alu_tb.v reg_bank_tb.v clk_gen.v control_unit_tb.v

.PHONY: run build
run: $(MODULES) $(TEST_BENCHES)
	iverilog $^
	vvp a.out
	open -a gtkwave dump.vcd

build: $(MODULES)
	iverilog $^
	vvp a.out