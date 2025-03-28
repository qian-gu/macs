module test_top;

  localparam DW = 8;
  localparam MAX = 100;

  logic signed [DW-1 : 0] A;
  logic signed [DW-1 : 0] W;
  logic        [DW*2 : 0] Q;
  logic                   Asigned;
  logic                   Wsigned;

  logic clk;
  logic rst_n;
  integer cnt;

  mac_top #(
    .DW(DW)
  ) MAC_TOP (
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .A      (A      ),
    .Asigned(Asigned),
    .W      (W      ),
    .Wsigned(Wsigned),
    .Q      (Q      )
  );

  always @(posedge clk) begin
    if (MAC_TOP.Q_baseline != MAC_TOP.Q_mm) begin
      #0.1;
      $display("[ERROR] cnt = %0d: A * W = %0d * %0d = %0d != %0d",
        cnt, $signed(MAC_TOP.A_q), $signed(MAC_TOP.W_q),
        $signed(MAC_TOP.Q_baseline), $signed(MAC_TOP.Q_mm));
      $finish;
    end else begin
      #0.1;
      //$display("cnt = %0d: A * W = %0d * %0d = %0d = %0d",
        //cnt, $signed(MAC_TOP.A_q), $signed(MAC_TOP.W_q),
        //$signed(MAC_TOP.Q_baseline), $signed(MAC_TOP.Q_mm));
    end
    if (cnt == MAX) begin
      $display("Success!");
      $finish;
    end
  end

  // simulation flow control.
  initial begin
    clk = 0;
    rst_n = 0;
    cnt = 0;
    Asigned = 1;  // signed * sigend
    Wsigned = 1;
    #20;
    rst_n = 1;
  end

  always #5 clk = ~clk;

  always_ff @(posedge clk) begin
    if (!rst_n) begin
      cnt <= 0;
    end
      cnt <= cnt + 1;
      A <= $random;
      W <= $random;
  end

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
  end

  function int get_gaussian(int seed, real mean, real std_dev);

    real raw_value;
    int result;

    do begin
      raw_value = $dist_normal(seed, mean, std_dev);
      result = int'(raw_value);
    end while (result < -128 || result > 127);

    return result;

  endfunction  // get_gaussian

  int seed;
  int value;
  real mean;
  real std_dev;
  real histgram[-128:127];

  initial begin
    mean = 0;
    std_dev = 42.7;

    for (int i = -128; i <= 127; i++) begin
      histgram[i] = 0;
    end

    repeat (1000) begin
      seed= $time + $urandom;
      value = get_gaussian(seed, mean, std_dev);
      histgram[value]++;
    end

    for (int i = -128; i <= 127; i++) begin
      $display("Value %4d: %4d occurence", i, histgram[i]);
    end
  end

endmodule  // test_top;


