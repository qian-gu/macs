module tm #(
  parameter int unsigned DW = 8
)(
  input  logic [DW-1 : 0] A,       // TC
  input  logic            Asigned, // 0 = unsigned, 1 = signed
  input  logic [DW-1 : 0] Wmag,    // W.magnitude
  input  logic            Wsign,   // W.sign
  output logic [DW*2 : 0] Q
);

endmodule  // tm
