module counter_top (
    input logic sysclk,
    output logic [3:0] led
);
  logic clksel, clkpulse, clkout, rst_n, load, up_down, enable;
  logic [3:0] d_in, count;

  // Select the clock
  assign clkout = (clksel) ? sysclk : clkpulse;
  assign led = count;

  // Instantiate DUT
  updown_counter dut0 (
      .clk    (clkout),
      .rst_n  (rst_n),
      .load   (load),     // Load enable
      .up_down(up_down),  // Direction control (1 = up, 0 = down)
      .enable (enable),   // Counter enable
      .d_in   (d_in),     // Input data for loading
      .count  (count)     // Counter output
  );

  // VIO for control signals
  top_vio vio0 (
      .clk(sysclk),  // Use actual clock
      .probe_out0(clksel),
      .probe_out1(clkpulse),
      .probe_out2(rst_n),
      .probe_out3(load),
      .probe_out4(up_down),
      .probe_out5(enable),
      .probe_out6(d_in),
      .probe_in0(count)
  );

    // ILA to monitor counter output in free running mode
    // Also takes in the enable so triggering can be demonstrated
    top_ila ila0 (
        .clk(sysclk), // Actual system clock
        .probe0(enable),
        .probe1(count)
    );

endmodule
