module imem(input logic [31:0] pc, output logic [31:0] instr);

logic [31:0] memory [0:255]; //1kb of space for tetsing
assign instr = memory[pc[9:2]];


endmodule