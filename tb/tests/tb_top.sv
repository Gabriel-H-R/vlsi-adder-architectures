module tb_top;
  import uvm_pkg::*;
  import adder_pkg::*; //Compiled package with all UVM components

  logic clk;
  logic rst_n;

  // Interface instance
  adder_if vif(clk, rst_n);

  // Design Under Test (DUT) Instantiation
  kogge_stone_adder32 dut (
    .a(vif.a),
    .b(vif.b),
    .c0(vif.cin),
    .s(vif.sum),
    .cout(vif.cout)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Reset generation and UVM start
  initial begin
    rst_n = 0;
    #20 rst_n = 1;
    
    // Register interface in UVM config DB
    uvm_config_db#(virtual adder_if)::set(null, "*", "vif", vif);
    
    // Run the UVM test
    run_test("adder_test");
  end
endmodule