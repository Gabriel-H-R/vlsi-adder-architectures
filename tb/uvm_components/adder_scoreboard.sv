class adder_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(adder_scoreboard)
  
  uvm_analysis_imp #(adder_seq_item, adder_scoreboard) item_collected_export;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_export = new("item_collected_export", this);
  endfunction

  // This function is called every time the monitor broadcasts a transaction
  virtual function void write(adder_seq_item pkt);
    bit [31:0] exp_sum;
    bit        exp_cout;
    
    // Golden Reference Model calculation
    {exp_cout, exp_sum} = pkt.a + pkt.b + pkt.cin;

    // Compare DUT output with Golden Reference
    if (pkt.sum !== exp_sum || pkt.cout !== exp_cout) begin
      `uvm_error("SCBD", $sformatf("MISMATCH! A:%0h B:%0h Cin:%0b | Expected Sum:%0h Cout:%0b | Actual Sum:%0h Cout:%0b", 
                                   pkt.a, pkt.b, pkt.cin, exp_sum, exp_cout, pkt.sum, pkt.cout))
    end else begin
      `uvm_info("SCBD", "MATCH: DUT output matches expected value.", UVM_HIGH)
    end
  endfunction
endclass