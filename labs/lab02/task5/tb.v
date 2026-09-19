module tb;
  reg [3:0] t_a, t_b;
  reg t_op;
  wire [3:0] t_result;
  reg [3:0] t_exp_result;

  alu DUT (
    .a (t_a),
    .b (t_b),
    .op (t_op),
    .result (t_result)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  integer i, j, k, errors;

  initial begin
    errors = 0;
    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        for (k = 0; k < 2; k = k + 1) begin
            t_a = i; t_b = j; t_op = k;
            #5;
            if (t_op == 0)
                t_exp_result = t_a + t_b;
            else
                t_exp_result = t_a - t_b;
            if (t_exp_result !== t_result) begin
                $display("FAIL at time %0t: a=%b b=%b op=%b  got result=%b  expected result=%b", $time, t_a, t_b, t_op, t_result, t_exp_result);
                errors = errors + 1;
            end
        end
      end
    end

    if (errors == 0) $display("PASS: all cases correct");
    else $display("FAIL: %0d errors", errors);
    $finish;
  end

endmodule
