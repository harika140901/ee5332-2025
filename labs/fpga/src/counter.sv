module updown_counter(
    input logic clk,       // Clock input
    input logic rst_n,     // Active-low reset
    input logic load,      // Load enable
    input logic up_down,   // Direction control (1 = up, 0 = down)
    input logic enable,    // Counter enable
    input logic [3:0] d_in,// Input data for loading
    output logic [3:0] count // Counter output
);

    // Sequential logic for the counter
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Asynchronous reset
            count <= 4'h0;
        end
        else if (load) begin
            // Load operation takes precedence over counting
            count <= d_in;
        end
        else if (enable) begin
            // Counter operation when enabled
            if (up_down)
                // Count up
                count <= count + 4'h1;
            else
                // Count down
                count <= count - 4'h1;
        end
        // When not enabled, hold the current value
    end

endmodule


