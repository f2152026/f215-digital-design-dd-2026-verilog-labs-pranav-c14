// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // TODO: declare the inputs and outputs
  reg [2:0] t_sel;
  wire [7:0] t_dout;
  reg [7:0] t_exp_dout;

  // TODO: instantiate DUT here
  lut #(.WIDTH(8), .DEPTH(8)) DUT (
    .sel (t_sel),
    .dout (t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  integer i, errors;

  initial begin
    // TODO: apply different input combinations
    errors = 0;
    for (i = 0; i < 8; i = i + 1) begin
      t_sel = i;
      #5;
      t_exp_dout = i*i;
      if (t_exp_dout !== t_dout) begin
        $display("FAIL at time %0t: sel=%b  got dout=%0d  expected dout=%0d", $time, t_sel, t_dout, t_exp_dout);
        errors = errors + 1;
      end
    end

    if (errors == 0) $display("PASS: all cases correct");
    else $display("FAIL: %0d errors", errors);
    $finish;
  end

  initial
    $monitor($time, " sel=%b | dout=%b", t_sel, t_dout); // change as required

endmodule
