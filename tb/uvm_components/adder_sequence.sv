class adder_sequence extends uvm_sequence #(adder_seq_item);
  `uvm_object_utils(adder_sequence)

  function new(string name = "adder_sequence");
    super.new(name);
  endfunction

  task body();
    adder_seq_item req;
    
    // Generate 1000 random transactions
    repeat(1000) begin
      req = adder_seq_item::type_id::create("req");
      start_item(req);
      if (!req.randomize()) begin
        `uvm_error("SEQ", "Randomization failed!")
      end
      finish_item(req);
    end
  endtask
endclass