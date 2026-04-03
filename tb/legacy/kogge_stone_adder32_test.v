module kogge_stone_adder32_test;

  reg  [31:0] a, b;
  reg        cin;
  wire [31:0] s;
  wire        cout;
  reg  [31:0] expected_sum;
  reg         expected_cout;
  integer     errors = 0;
  integer     i;

  kogge_stone_adder32 dut (
    .a(a), .b(b), .c0(cin), .s(s), .cout(cout)
  );

  task run_test(input [31:0] in_a, input [31:0] in_b, input in_cin);
    begin
      a = in_a;
      b = in_b;
      cin = in_cin;
      {expected_cout, expected_sum} = in_a + in_b + in_cin;
      #1;
      if (s !== expected_sum || cout !== expected_cout) begin
        $display("[ERRO] a=%h b=%h cin=%b -> sum=%h cout=%b | Esperado: sum=%h cout=%b",
                 a, b, cin, s, cout, expected_sum, expected_cout);
        errors = errors + 1;
      end else begin
        $display("[OK]   a=%h b=%h cin=%b -> sum=%h cout=%b",
                 a, b, cin, s, cout);
      end
    end
  endtask

  initial begin
    $display("Testbench: Somador Kogge-Stone - Testes Fixos\n");

    // Casos fixos
    run_test(32'h00000000, 32'h00000000, 0); // zero
    run_test(32'hFFFFFFFF, 32'h00000000, 0); // max + 0
    run_test(32'hFFFFFFFF, 32'h00000001, 0); // overflow
    run_test(32'hAAAAAAAA, 32'h55555555, 0); // padrão alternado
    run_test(32'hAAAAAAAA, 32'h55555555, 1); // padrão alternado + cin
    run_test(32'h80000000, 32'h80000000, 0); // MSB somado
    run_test(32'h7FFFFFFF, 32'h00000001, 0); // limiar de overflow positivo
    run_test(32'hDEADBEEF, 32'h12345678, 1); // valores arbitrários
    run_test(32'h0000FFFF, 32'hFFFF0000, 1); // mistura alto e baixo
    run_test(32'h13579BDF, 32'h2468ACE0, 0); // padrão decimal
    run_test(32'h00000001, 32'h00000001, 1); // carry de LSB

    $display("\nTestbench: Testes Aleatórios");
    for (i = 0; i < 1000; i = i + 1) begin
      run_test($random, $random, $random % 2);
    end

    if (errors == 0)
      $display("\nv Todos os testes passaram com sucesso!");
    else
      $display("\nx Total de erros: %0d", errors);

    $finish;
  end

endmodule
