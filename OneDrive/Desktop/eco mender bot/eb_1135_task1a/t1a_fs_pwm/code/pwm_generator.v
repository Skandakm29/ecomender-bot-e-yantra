// EcoMender Bot : Task 1A : PWM Generator
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design a module which will scale down the 100KHz Clock Frequency to 500Hz and perform Pulse Width Modulation on it.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//PWM Generator
//Inputs : clk_1MHz, pulse_width
//Output : clk_500Hz, pwm_signal
// Team ID:          < 1135 >
//Theme:            < EcoMender Bot >
//Author List:      < K M Skanda,Sanjana WG >
//file name:pwm_generator




module pwm_generator(
    input clk_1MHz,
    input [3:0] pulse_width,
    output reg clk_500Hz, pwm_signal
);


initial begin
    clk_500Hz = 0; pwm_signal = 0;
end



// 10-bit counter for clock division (0 to 999)
reg [9:0] counter = 0;

// Clock division logic: Divide the 1 MHz clock to generate a 500 Hz clock
// always at the postive edge of the clock execute this statement 
always @(posedge clk_1MHz) begin
    if (counter==0) begin
	   clk_500Hz <= ~clk_500Hz;
	 end
    if (counter ==999 ) begin
        counter <= 0;
    end else begin
        counter <= counter + 1'b1;  // Increment counter
    end
end

// PWM signal generation logic
reg [10:0] pwm_counter = 0;//11 bit counter to count from 0-2047

// always at the postive edge of the clock execute this statement 
always @(posedge clk_1MHz) begin
    // Increment PWM counter
    if (pwm_counter == 1999) begin // Reset the PWM counter after reaching 1999
        pwm_counter <= 0;
    end else begin
        pwm_counter <= pwm_counter + 1;
    end
    
    // Generate PWM signal based on scaled pulse width
    if (pwm_counter < (pulse_width * 100)) begin     // Compare the current PWM counter value with the scaled pulse width (pulse_width * 100). 
        pwm_signal <= 1;  // High for the part of the cycle proportional to the pulse width
    end else begin
        pwm_signal <= 0;  // Low for the remaining part of the cycle
    end
end

//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////

endmodule
