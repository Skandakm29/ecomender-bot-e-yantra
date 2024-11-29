module tb;

// Declare testbench signals
reg clk_50MHz;
reg [3:0] pulse_width;
wire pwm_signal;
wire clk_500Hz;
wire clk_1MHz;

// Instantiate the top-level module (Unit Under Test)
t1a_fs_pwm_bdf UUT (
    .clk_50MHz(clk_50MHz),
    .pulse_width(pulse_width),
    .pwm_signal(pwm_signal),
    .clk_500Hz(clk_500Hz),
    .clk_1MHz(clk_1MHz)
);

// Clock Generation for 50 MHz
initial begin
    clk_50MHz = 0;
    forever #10 clk_50MHz = ~clk_50MHz;  // Toggle every 10ns => 50 MHz clock
end

// Testbench logic to apply stimulus to pulse_width
initial begin
    // Initialize pulse width to 0
    pulse_width = 4'd0;

    // Wait for global reset to finish
    #100;

    // Apply different pulse_width values and observe PWM behavior
    pulse_width = 4'd4;   // 25% duty cycle
    #1000000;             // Run simulation for 1ms
    
    pulse_width = 4'd8;   // 50% duty cycle
    #1000000;             // Run simulation for 1ms
    
    pulse_width = 4'd12;  // 75% duty cycle
    #1000000;             // Run simulation for 1ms
    
    pulse_width = 4'd15;  // 100% duty cycle
    #1000000;             // Run simulation for 1ms

    // End simulation
    $stop;
end

endmodule
