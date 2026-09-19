module tb;
  reg [1:0] t_A; reg [1:0] t_B;
  wire t_GT; wire t_LT; wire t_EQ;
  reg t_exp_GT; reg t_exp_LT; reg t_exp_EQ;

  comp2 DUT (
    .A (t_A),
    .B (t_B),
    .GT (t_GT),
    .LT (t_LT),
    .EQ (t_EQ)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  integer i, j, errors;

  initial begin
    errors = 0;
    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        t_A = i; t_B = j;
        #5;

        t_exp_GT = t_A > t_B; t_exp_LT = t_A < t_B; t_exp_EQ = t_A == t_B;
        if ({t_exp_GT, t_exp_LT, t_exp_EQ} !== {t_GT, t_LT, t_EQ}) begin
          $display("FAIL at time %0t: A=%b B=%b  got GT=%b LT=%b EQ=%b  expected GT=%b LT=%b EQ=%b", $time, t_A, t_B, t_GT, t_LT, t_EQ, t_exp_GT, t_exp_LT, t_exp_EQ);
          errors = errors + 1;
        end
      end
    end

    $write("SUMMARY: %0d/16 passed", 16 - errors);
    if (errors == 0) $write(" -- PASS");
    else $write(" -- FAIL (%0d errors)", errors);
    $display;
    $finish;
  end

endmodule
