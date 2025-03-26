module tm_top #(
  parameter int unsigned DW = 8
)(
  input  logic [DW-1 : 0] A,
  input  logic            Asigned,
  input  logic [DW-1 : 0] W,
  input  logic            Wsigned,
  output logic [DW*2 : 0] Q
);

  logic [DW*2-1 : 0] W_A;
  logic [DW*2-1 : 0] W_B;
  logic [DW*2-1 : 0] W_compensation;
  logic [DW*2   : 0] Q_tm;

  assign W_A = (W << DW);
  assign W_B = W_A - W;
  assign W_compensation = W[DW-1] ? W_B : W_A;
  assign Q = Q_tm - W_compensation;

  tm #(
    .DW(DW)
  ) TM (
    .A      (A      ),
    .Asigned(Asigned),
    .Wmag   (abs(W) ),
    .Wsign  (W[DW-1]),
    .Q      (Q_tm   )
  );

  function logic [DW-1 : 0] abs(logic [DW-1 : 0] din);
    logic [DW-1 : 0] abs;
    abs = din[DW-1] ? ((1'b1<<DW) - din) : din;
    return abs;
  endfunction  // abs

endmodule  // tm_top
