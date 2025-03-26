module mac_top #(
  parameter int unsigned DW = 8
)(
  input  logic            clk,
  input  logic            rst_n,
  input  logic [DW-1 : 0] A,
  input  logic            Asigned,
  input  logic [DW-1 : 0] W,
  input  logic            Wsigned,
  output logic [DW*2 : 0] Q
);

  logic [DW-1 : 0] A_q;
  logic [DW-1 : 0] W_q;
  logic [DW*2 : 0] Q_baseline;
  logic [DW*2 : 0] Q_mm;
  logic [DW*2 : 0] Q_tm;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      A_q <= 0;
      W_q <= 0;
    end else begin
      A_q <= A;
      W_q <= W;
    end
  end

  assign Q = Q_baseline | Q_mm | Q_tm;

  baseline #(
    .DW(DW)
  ) BASELINE (
    .A      (A_q),
    .Asigned(Asigned),
    .W      (W_q),
    .Wsigned(Wsigned),
    .Q      (Q_baseline)
  );

  mm_top #(
    .DW(DW)
  ) MM_TOP (
    .A      (A_q),
    .Asigned(Asigned),
    .W      (W_q),
    .Wsigned(Wsigned),
    .Q      (Q_mm)
  );

  tm_top #(
    .DW(DW)
  ) TM_TOP (
    .A      (A_q),
    .Asigned(Asigned),
    .W      (W_q),
    .Wsigned(Wsigned),
    .Q      (Q_tm)
  );

endmodule  // mac_top
