class adder_agent extends uvm_agent;
  `uvm_component_utils(adder_agent)

  adder_driver    driver;
  adder_monitor   monitor;
  uvm_sequencer #(adder_seq_item) sequencer;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    monitor = adder_monitor::type_id::create("monitor", this);
    
    // O driver e o sequencer só são criados se o agent for "ativo" (padrão)
    if (get_is_active() == UVM_ACTIVE) begin
      driver    = adder_driver::type_id::create("driver", this);
      sequencer = uvm_sequencer#(adder_seq_item)::type_id::create("sequencer", this);
    end
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    // Conecta a porta do Driver à exportação do Sequencer
    if (get_is_active() == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
  endfunction
endclass