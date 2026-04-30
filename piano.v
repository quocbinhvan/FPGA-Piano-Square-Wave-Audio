// File: piano.v
// This is the top level design for EE178 Lab #4.
// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).
`timescale 1 ns / 1 ps
// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module piano (
    input wire clk,
    input wire hush, // 0 - make noise, 1 - no sound
    input wire [3:0] note,
    output reg speaker
);
// Describe the actual circuit for the assignment.
// We use tone variable to divide the 100 MHz clock
// Divide the clock into our desired frequency output
// tone = 100MHz / (2*frequency)
reg [16:0] tone;
reg [16:0] counter;

always @(*) begin
    case (note)
        4'b0000: tone = 17'd113635; // 400 Hz
        4'b0001: tone = 17'd107257; // 466.16 Hz
        4'b0010: tone = 17'd101237; // 493.88
        4'b0011: tone = 17'd95555;  // 523.25
        4'b0100: tone = 17'd90192;  // 554.37
        4'b0101: tone = 17'd85130;  // 587.33
        4'b0110: tone = 17'd80352;  // 622.25
        4'b0111: tone = 17'd75842;  // 659.26
        4'b1000: tone = 17'd71585;  // 698.46
        4'b1001: tone = 17'd67568;  // 739.99
        4'b1010: tone = 17'd63775;  // 783.99
        4'b1011: tone = 17'd60196;  // 830.61
        4'b1100: tone = 17'd56817;  // 880.00
        4'b1101: tone = 17'd53628;  // 932.33
        4'b1110: tone = 17'd50618;  // 987.77
        4'b1111: tone = 17'd47777;  // 1046.50
        default: tone = 17'd113635; // 400 Hz default
    endcase
end

// Clock divider - 100 Mhz / tone
// Each toggle cycle high->low = 1 Hz
always @(posedge clk)
    begin
        if (counter >= tone) begin
            counter <= 17'd0;   // reset counter
            if (!hush)  // hush == 0 make noise
                speaker <= ~speaker;    // toggle
        end
        else 
            begin
                counter <= counter + 17'd1; // add 1 to counter
            end
    end

endmodule
