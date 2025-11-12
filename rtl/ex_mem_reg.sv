module ex_mem_reg (
    input  logic        clk,
    input  logic        reset,
    input  logic        stall,
    input  logic        flush,
    input  logic [31:0] ALU_res_in,
    input  logic [31:0] store_data_in,
    input  logic [4:0]  rd_in,
    input  logic        RegWrite_in,
    input  logic        MemRead_in,
    input  logic        MemWrite_in,
    input  logic        MemToReg_in,
    input  logic [6:0]  opcode_in,
    input  logic [31:0] pc_plus_4_in,
    input  logic [31:0] instr_in,
    output logic [31:0] ALU_res_out,
    output logic [31:0] store_data_out,
    output logic [4:0]  rd_out,
    output logic        RegWrite_out,
    output logic        MemRead_out,
    output logic        MemWrite_out,
    output logic        MemToReg_out,
    output logic [6:0]  opcode_out,
    output logic [31:0] pc_plus_4_out,
    output logic [31:0] instr_out
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            ALU_res_out    <= 32'b0;
            store_data_out <= 32'b0;
            rd_out         <= 5'b0;
            RegWrite_out   <= 1'b0;
            MemRead_out    <= 1'b0;
            MemWrite_out   <= 1'b0;
            MemToReg_out   <= 1'b0;
            opcode_out     <= 7'b0;
            pc_plus_4_out  <= 32'b0;
            instr_out      <= 32'b0;
        end
        else if (flush) begin
            ALU_res_out    <= 32'b0;
            store_data_out <= 32'b0;
            rd_out         <= 5'b0;
            RegWrite_out   <= 1'b0;
            MemRead_out    <= 1'b0;
            MemWrite_out   <= 1'b0;
            MemToReg_out   <= 1'b0;
            opcode_out     <= 7'b0;
            pc_plus_4_out  <= 32'b0;
            instr_out      <= 32'b0;
        end
        else if (!stall) begin
            ALU_res_out    <= ALU_res_in;
            store_data_out <= store_data_in;
            rd_out         <= rd_in;
            RegWrite_out   <= RegWrite_in;
            MemRead_out    <= MemRead_in;
            MemWrite_out   <= MemWrite_in;
            MemToReg_out   <= MemToReg_in;
            opcode_out     <= opcode_in;
            pc_plus_4_out  <= pc_plus_4_in;
            instr_out      <= instr_in;
        end
    end

endmodule
