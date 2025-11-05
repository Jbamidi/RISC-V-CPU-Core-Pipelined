// testbench.sv
`timescale 1ns/1ps

module tb_ALU;

  // DUT signals
  logic [31:0] a, b;
  logic [3:0]  sel;
  logic [31:0] y;

  // DUT
  ALU dut (.a(a), .b(b), .ALU_Sel(sel), .ALU_Out(y));

  // For EPWave
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_ALU);
  end

  // tiny helper to print result
  task check(input [31:0] exp, input string name);
    if (y !== exp) $display("FAIL %-8s  got=%h  exp=%h", name, y, exp);
    else           $display("PASS %-8s", name);
  endtask

  initial begin
    // ADD
    a=32'h00000001; b=32'h00000002; sel=4'd0; #1;
    check(a+b, "ADD");

    // SUB
    a=32'h80000000; b=32'h00000001; sel=4'd1; #1;
    check(a-b, "SUB");

    // AND / OR / XOR
    a=32'hAAAA5555; b=32'h0F0FF0F0; sel=4'd2; #1; check(a & b, "AND");
    sel=4'd3; #1; check(a | b, "OR");
    sel=4'd4; #1; check(a ^ b, "XOR");

    // SLT (signed) – true case, then false case
    a=32'hFFFFFFFF; b=32'h00000001; sel=4'd5; #1;
    check(($signed(a) < $signed(b)) ? 32'd1 : 32'd0, "SLT_T");
    a=32'h00000005; b=32'hFFFFFFFE; sel=4'd5; #1;
    check(($signed(a) < $signed(b)) ? 32'd1 : 32'd0, "SLT_F");

    // SLTU (unsigned) – true/false
    a=32'h00000001; b=32'hFFFFFFFF; sel=4'd6; #1;
    check((a < b) ? 32'd1 : 32'd0, "SLTU_T");
    a=32'hFFFFFFFF; b=32'h00000001; sel=4'd6; #1;
    check((a < b) ? 32'd1 : 32'd0, "SLTU_F");

    // Shifts (uses only b[4:0])
    a=32'h0000F0F0; b=32'h00000004; sel=4'd7; #1; check(a << b[4:0], "SLL");
    a=32'hF0000000; b=32'h00000004; sel=4'd8; #1; check(a >> b[4:0], "SRL");
    a=32'hF0000000; b=32'h00000004; sel=4'd9; #1; check($signed(a) >>> b[4:0], "SRA");

    $display("Done.");
    $finish;
  end

endmodule
