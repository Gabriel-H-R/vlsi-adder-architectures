class adder_driver extends uvm_driver #(adder_seq_item);
  `uvm_component_utils(adder_driver)
  
  virtual adder_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual adder_if)::get(this, "", "vif", vif))
      `uvm_fatal("DRV", "Could not get virtual interface")
  endfunction

  task run_phase(uvm_phase phase);
    vif.a <= 0; vif.b <= 0; vif.cin <= 0;
    @(posedge vif.rst_n); // Wait for reset to clear

    forever begin
      seq_item_port.get_next_item(req);
      @(posedge vif.clk);
      vif.a   <= req.a;
      vif.b   <= req.b;
      vif.cin <= req.cin;
      seq_item_port.item_done();
    end
  endtask
endclass