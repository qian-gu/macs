module baseline #(
  parameter int unsigned DW = 8
)(
  input  logic [DW-1 : 0] A,
  input  logic            Asigned,
  input  logic [DW-1 : 0] W,
  input  logic            Wsigned,
  output logic [DW*2 : 0] Q
);

  logic [DW : 0] Aext;
  logic [DW : 0] Wext;

  assign Aext = {(Asigned ? A[7] : 1'b0), A};
  assign Wext = {(Wsigned ? W[7] : 1'b0), W};

  assign Q = $signed(Aext) * $signed(Wext);

endmodule  // baseline

