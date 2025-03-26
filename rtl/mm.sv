module mm #(
  parameter int unsigned DW = 8
)(
  input  logic [DW-1 : 0] Amag,  // A.magnitude
  input  logic            Asign, // A.sign
  input  logic [DW-1 : 0] Wmag,  // W.magnitude
  input  logic            Wsign, // W.sign
  output logic [DW*2 : 0] Q
);

  logic [DW*2-1 : 0] mult_;
  logic [DW*2   : 0] Q_A;
  logic [DW*2   : 0] Q_B;
  logic              sign;

  assign mult_ = Amag * Wmag;
  assign Q_A = {1'b0, mult_};
  assign Q_B = ~mult_ + 1'b1;
  assign sign = Asign ^ Wsign;
  assign Q = sign ? Q_B : Q_A;

endmodule  // mm

