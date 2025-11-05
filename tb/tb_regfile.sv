// tb_regfile.sv
`timescale 1ns/1ps

module tb_regfile();

  logic clk;
  logic wenable;
  logic [4:0] rs1, rs2, rd;
  logic [31:0] wdata;
  logic [31:0] rd1, rd2;

  regfile dut(clk, wenable, rs1, rs2, rd, wdata, rd1, rd2);

  // clock
  initial clk = 0;
  always #5 clk = ~clk;

  // keep track of how many tests passed/failed
  int pass = 0;
  int fail = 0;

  // simple check
  task check(string name, logic [31:0] got, logic [31:0] exp);
    if (got === exp) begin
      $display("PASS %s", name);
      pass++;
    end else begin
      $display("FAIL %s (got=%h, exp=%h)", name, got, exp);
      fail++;
    end
  endtask

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_regfile);

    // init
    wenable = 0;
    rs1 = 0; rs2 = 0; rd = 0; wdata = 0;
    #10;

    // write to x5
    rd = 5'd5;
    wdata = 32'hAAAA5555;
    wenable = 1;
    #10;
    wenable = 0;

    // read from x5
    rs1 = 5'd5;
    rs2 = 5'd5;
    #1;
    check("x5 read rd1", rd1, 32'hAAAA5555);
    check("x5 read rd2", rd2, 32'hAAAA5555);

    // x0 should always be 0
    rs1 = 5'd0;
    rs2 = 5'd0;
    #1;
    check("x0 read rd1", rd1, 32'h0000_0000);
    check("x0 read rd2", rd2, 32'h0000_0000);

    // try to write to x0 (should ignore)
    rd = 5'd0;
    wdata = 32'hFFFFFFFF;
    wenable = 1;
    #10;
    wenable = 0;

    rs1 = 5'd0;
    #1;
    check("x0 write ignored", rd1, 32'h0000_0000);

    // write to x10 and x11, then read them both
    rd = 5'd10;
    wdata = 32'h11112222;
    wenable = 1;
    #10;
    rd = 5'd11;
    wdata = 32'h33334444;
    #10;
    wenable = 0;

    rs1 = 5'd10;
    rs2 = 5'd11;
    #1;
    check("x10 read", rd1, 32'h11112222);
    check("x11 read", rd2, 32'h33334444);

    // summary
    $display("----- SUMMARY -----");
    $display("Passed: %0d", pass);
    $display("Failed: %0d", fail);
    if (fail == 0)
      $display("PASS");
    else
      $display("FAIL");

    $finish;
  end

endmodule
