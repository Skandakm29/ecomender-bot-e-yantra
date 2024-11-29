// EcoMender Bot : Task 1A : Frequency Scaling
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design a module which will scale down the 50MHz Clock Frequency to 1MHz.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/
//Frequency Scaling
//Inputs : clk_50MHz
//Output : clk_1MHz
// Team ID: < 1135 >
//Theme:< EcoMender Bot >
//Author List:< K M Skanda,Sanjana WG >
//file name:frequency_scaler



module frequency_scaler (
    input clk_50MHz,
    output reg clk_1MHz
);


initial begin
    clk_1MHz =0;//starting the clock from low 
end

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE //////////////////


reg [5:0]counter = 0; // 6-bit counter size that counts from 0 to 63 (50Mhz/1Mhz=50 )
//always at the postive edge of the clock start 
always@(posedge clk_50MHz) begin
    if (counter == 24) begin //one half is from 0 to 24 (25 counts) 
		  counter<=0;//reset the counter at 24
    end
    else begin
        counter <= counter + 1'b1;
    end
	 if (counter==0) 
	    clk_1MHz<=~clk_1MHz;// Toggle the clock after every 25 cycles
	
end


//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE //////////////////

endmodule