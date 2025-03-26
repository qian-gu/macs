module mm_top #(
  parameter int unsigned DW = 8
)(
  input  logic [DW-1 : 0] A,
  input  logic            Asigned,
  input  logic [DW-1 : 0] W,
  input  logic            Wsigned,
  output logic [DW*2 : 0] Q
);

  // NOTE: mm only support signed mode for now.
  mm #(
    .DW(DW)
  ) MM (
    .Amag (abs(A)),
    .Asign(A[DW-1]),
    .Wmag (abs(W)),
    .Wsign(W[DW-1]),
    .Q    (Q)
  );

  function logic [DW-1 : 0] abs(logic [DW-1 : 0] din);
    logic [DW-1 : 0] abs;
    abs = din[DW-1] ? ((1'b1<<DW) - din) : din;
    return abs;
  endfunction  // abs

endmodule  // mm_top
