module ALU_testbench;

reg [7:0] A_tb, B_tb;
reg [3:0] opcode_tb;
wire [7:0] result_tb;
wire carry_out_tb;
wire zero_flag;
wire negative_flag;
wire overflow_flag;

// Instantiate yung main module
ALU_8bit uut(
.A(A_tb), 
.B(B_tb), 
.opcode(opcode_tb), 
.result(result_tb),
.carry_out(carry_out_tb),
.zero_flag(zero_flag),
.negative_flag(negative_flag),
.overflow_flag(overflow_flag));

// Eto yung function to return opcode name instead na number
function [16*8:0] op_name;
  input [3:0] opcode;
    begin
      case(opcode)
4'b0000: op_name = "AND";
4'b0001: op_name = "OR";
4'b0010: op_name = "NOT_A";
4'b0011: op_name = "XOR";
4'b0100: op_name = "NAND";
4'b0101: op_name = "NOR";
4'b0110: op_name = "XNOR";
4'b0111: op_name = "ADD";
4'b1000: op_name = "SUB";
4'b1001: op_name = "A<<1";
4'b1010: op_name = "A>>1";
4'b1011: op_name = "B<<1";
4'b1100: op_name = "B>>1";
4'b1101: op_name = "A<<B";
4'b1110: op_name = "A>>B";
4'b1111: op_name = "MULTIPLY";
default: op_name = "UNKNOWN";
  endcase
 end
endfunction

initial begin
// Set inputs
A_tb = 8'b00000000;  // input what you want
B_tb = 8'b00000000;  // input what you want
opcode_tb = 4'b0111; // choose operation here

#10; 

// This is for add subtract and multiply so the result is decimal
if (opcode_tb == 4'b0111 || opcode_tb == 4'b1000 || opcode_tb == 4'b1111) begin

// For ADD or SUB or MULTIPLY? decimal
$display("Operation:%0s A=%d B=%d Result=%d Carry_out=%b OF = %b",op_name(opcode_tb), A_tb, B_tb, result_tb, carry_out_tb,overflow_flag);

end 

else begin
// This is for the basic gates and shifters binary so its not decimal
$display("Operation:%0s A=%b B=%b Result=%b",op_name(opcode_tb), A_tb, B_tb, result_tb);

end

$display("ZF = %b NF = %b OF = %b",zero_flag,negative_flag,overflow_flag);

$stop;

end

endmodule

