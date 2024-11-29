// EcoMender Bot : Task 1B : Color Detection using State Machines
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design a module which will detect colors red, green, and blue using state machine and frequency detection.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be|t1b_cd_fd
 entertained.
-------------------
*/

//Color Detection
//Inputs : clk_1MHz, cs_out
//Output : filter, color

// Module Declaration
module t1b_cd_fd (
    input  clk_1MHz, cs_out,
    output reg [1:0] filter, color
);

// red   -> color = 1;
// green -> color = 2;
// blue  -> color = 3;

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE //////////////////
// Define state encoding for the filters
// Define state encoding for the filters
parameter ST_3 = 2'b11, ST_0 = 2'b00, ST_1 = 2'b01, ST_2 = 2'b10;  // Correct filter states

// Define color values
parameter RED = 2'b01, GREEN = 2'b10, BLUE = 2'b11;  // Correct color values

// Registers for FSM
reg [8:0] counter;           // 9-bit counter for 500 cycles (500 µs at 1 MHz)
reg [1:0] filter_count;      // To track number of filter transitions
reg in_st2;                  // To track if we are in ST_2 for one cycle
reg [1:0] next_filter;       // New register to hold next filter state
reg [1:0] next_color;

// cs_out Frequency Counters
reg [15:0] red_freq;         // To store cs_out frequency for red filter
reg [15:0] green_freq;       // To store cs_out frequency for green filter
reg [15:0] blue_freq;        // To store cs_out frequency for blue filter
reg [15:0] cs_counter;       // To count cs_out edges in each period

// Initial values
initial begin
    filter = ST_3;           // Start with filter state 11 (red)
    next_filter = ST_3;      // Next filter is initially ST_3
    color = 0;               // Start with no color (initial)
    counter = 0;             // Initialize counter
    filter_count = 0;        // Initialize filter transition count
    red_freq = 0;
    green_freq = 0;
    blue_freq = 0;
    cs_counter = 0;
    in_st2 = 0;              // Start outside ST_2
    next_color = 0;          // Initialize next_color
end

// Frequency Counting Logic and Filter Transitions (sequential)
always @(posedge clk_1MHz) begin
    // Count rising edges of cs_out
    if (cs_out)
        cs_counter <= cs_counter + 1'b1;

    // If in ST_2, immediately move to ST_3 on the next cycle
    if (in_st2) begin
        next_filter <= ST_3;
        in_st2 <= 0;  // Reset flag after exiting ST_2
    end else begin
        // Increment the counter for filter period (500 µs)
        counter <= counter + 1'b1;

        // If counter reaches 500 or 499 cycles
        if ((counter == 499 && next_filter == ST_3) || (counter == 499 && (next_filter == ST_0 || next_filter == ST_1))) begin
            counter <= 0;  // Reset period counter

            // Immediate state transition based on current filter state
            case (filter)
                ST_3: begin
                    next_filter <= ST_0;  // Transition to ST_0 (blue)
                    red_freq <= cs_counter;   // Store frequency for red filter
                end
                ST_0: begin
                    next_filter <= ST_1;  // Immediate transition to ST_1 (green)
                    blue_freq <= cs_counter;  // Store frequency for blue filter
                end
                ST_1: begin
                    next_filter <= ST_2;  // Immediate transition to ST_2 (for one cycle)
                    green_freq <= cs_counter; // Store frequency for green filter
                    in_st2 <= 1;     // Set flag to track ST_2 for one cycle
                end
                default: next_filter <= ST_3;  // Fallback to ST_3 (red)
            endcase

            // Reset cs_out counter for next period
            cs_counter <= 0;

  
           
                // Determine the next color
                if (red_freq > green_freq && red_freq > blue_freq)
                    next_color <= RED;    // RED has the highest frequency
                else if (green_freq > red_freq && green_freq > blue_freq)
                    next_color <= GREEN;  // GREEN has the highest frequency
                else
                    next_color <= BLUE;   // BLUE has the highest frequency
            end
        end
 

    // Update the filter and color states with the next values
    filter <= next_filter;
    color <= next_color;  // Assign the precomputed next_color without delay
end


//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE //////////////////

endmodule
