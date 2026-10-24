module ALU_8bit(
input  [7:0] A, B,
input  [3:0] opcode, //selector of operation
output reg [7:0] result,
output reg carry_out,
output reg zero_flag,
output reg negative_flag,
output reg overflow_flag
);

reg [15:0] mult_temp;

always @(*) begin
// this is for my flag. I set them initially at 0

result = 8'b0;
carry_out = 0;
zero_flag = 0;
negative_flag = 0;
overflow_flag = 0;

case(opcode)

4'b0000: result = A & B;  // and gate
4'b0001: result = A | B; // or gate
4'b0010: result = ~A; // invert
4'b0011: result = A ^ B; // xor gate
4'b0100: result = ~(A & B); // nand gate
4'b0101: result = ~(A | B); // nor gate
4'b0110: result = ~(A ^ B); // xnor gate

4'b0111: begin
{carry_out, result} = A + B; // addition
overflow_flag = (A[7] == B[7]) && (result[7] != A[7]);
end

4'b1000: begin
{carry_out, result} = A - B; // subtraction cout = 1 no borrow cout = 0 yes borrow
overflow_flag = (A[7] != B[7]) && (result[7] != A[7]);
end


4'b1001: result = A << 1; // shift left A by 1, lsb add 0 to the lsb then shift
4'b1010: result = A >> 1; // shift right A by 1, msb add 0 to the msb then shift
4'b1011: result = B << 1; // shift left B by 1
4'b1100: result = B >> 1; // shift right B by 1
4'b1101: result = A << B[2:0]; // shift A to left depending on value of B.
4'b1110: result = A >> B[2:0]; // shift A right depending on value of B.

4'b1111: begin
mult_temp = A * B;         
result = mult_temp[7:0];    
carry_out = |mult_temp[15:8]; 
overflow_flag = |mult_temp[15:8]; 
end
 

default: begin
result = 0;
carry_out = 0;
end

endcase

zero_flag = (result == 0);
negative_flag = result[7];

end

endmodule

