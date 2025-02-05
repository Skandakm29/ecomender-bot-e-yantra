// Verilog code for Test bench
// Define module
module tb_ripple_carry_adder;
reg [1:0] a; // Define all I/O ports
reg [1:0] b;
reg c_in;
wire [1:0] sum;
wire c_out;
// Map all th I/O ports with DUT
Ripple_carry_adder uut (.a(a), .b(b), .c_in(c_in), .sum(sum), .c_out(c_out));

initial begin
     a = 2'b01; b = 2'b11; c_in = 1'b1; #100;
     a = 2'b11; b = 2'b11; c_in = 1'b1; #100;
     a = 2'b10; b = 2'b01; c_in = 1'b0; #100;
     a = 2'b00; b = 2'b11; c_in = 1'b0; #100;
   end
endmodule
