package adder_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // The order of inclusion is from bottom to top in the UVM hierarchy
  `include "adder_seq_item.sv"
  `include "adder_sequence.sv"
  `include "adder_driver.sv"
  `include "adder_monitor.sv"
  `include "adder_agent.sv"
  `include "adder_scoreboard.sv"
  `include "adder_env.sv"
  `include "adder_test.sv"
endpackage