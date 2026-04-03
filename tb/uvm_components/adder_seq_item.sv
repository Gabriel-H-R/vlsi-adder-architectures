import uvm_pkg::*;
`include "uvm_macros.svh"

class adder_seq_item extends uvm_sequence_item;
  // Randomize inputs for Constrained Random Verification (CRV)
  rand bit [31:0] a;
  rand bit [31:0] b;
  rand bit        cin;
  
  // Outputs (not randomized, captured by monitor)
  bit [31:0] sum;
  bit        cout;

  `uvm_object_utils_begin(adder_seq_item)
    `uvm_field_int(a, UVM_ALL_ON)
    `uvm_field_int(b, UVM_ALL_ON)
    `uvm_field_int(cin, UVM_ALL_ON)
    `uvm_field_int(sum, UVM_ALL_ON)
    `uvm_field_int(cout, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "adder_seq_item");
    super.new(name);
  endfunction
endclass