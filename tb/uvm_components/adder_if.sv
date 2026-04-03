interface adder_if(input logic clk, input logic rst_n);
  // Signals
  logic [31:0] a;
  logic [31:0] b;
  logic        cin;
  logic [31:0] sum;
  logic        cout;

  // SVA: Ensure no inputs are X or Z when reset is inactive
  property p_no_x_z_inputs;
    @(posedge clk) disable iff (!rst_n)
      (!$isunknown(a) && !$isunknown(b) && !$isunknown(cin));
  endproperty
  assert property (p_no_x_z_inputs) else $error("SVA ERROR: Inputs have X or Z values!");

  // SVA: Ensure outputs are stable/known after inputs are applied (combinational)
  property p_no_x_z_outputs;
    @(posedge clk) disable iff (!rst_n)
      (!$isunknown(sum) && !$isunknown(cout));
  endproperty
  assert property (p_no_x_z_outputs) else $error("SVA ERROR: Outputs have X or Z values!");

endinterface