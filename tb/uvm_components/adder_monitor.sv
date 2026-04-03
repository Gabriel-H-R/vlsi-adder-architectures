class adder_monitor extends uvm_monitor;
  `uvm_component_utils(adder_monitor)

  virtual adder_if vif;
  uvm_analysis_port #(adder_seq_item) item_collected_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual adder_if)::get(this, "", "vif", vif))
      `uvm_fatal("MON", "Could not get virtual interface")
  endfunction

  task run_phase(uvm_phase phase);
    adder_seq_item pkt;
    forever begin
      @(posedge vif.clk);
      #1; // Pequeno atraso para garantir que a lógica combinacional do somador estabilizou
      
      pkt = adder_seq_item::type_id::create("pkt");
      
      // Captura os sinais da interface
      pkt.a    = vif.a;
      pkt.b    = vif.b;
      pkt.cin  = vif.cin;
      pkt.sum  = vif.sum;
      pkt.cout = vif.cout;

      // Envia a transação para o Scoreboard (via porta de análise)
      item_collected_port.write(pkt);
    end
  endtask
endclass