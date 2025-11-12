module id_ex_reg (
    input  logic        clk,
    input  logic        reset,
    input  logic        stall,      
    input  logic        flush,      
    input  logic [31:0] rd1_in,
    input  logic [31:0] rd2_in,
    input  logic [31:0] imm_in,
    input  logic [31:0] pc_plus_4_in,
    input  logic [4:0]  rs1_in,
    input  logic [4:0]  rs2_in,
    input  logic [4:0]  rd_in,
    input  logic [2:0]  funct3_in,
    input  logic [6:0]  funct7_in,
    input  logic [6:0]  opcode_in,
    input  logic        RegWrite_in,
    input  logic        MemRead_in,
    input  logic        MemWrite_in,
    input  logic        MemToReg_in,
    input  logic        ALU_Src_in,
    input  logic        Branch_in,
    input  logic [1:0]  ALU_Op_in,
    input  logic [31:0] instr_in,
    output logic [31:0] rd1_out,
    output logic [31:0] rd2_out,
    output logic [31:0] imm_out,
    output logic [31:0] pc_plus_4_out,
    output logic [4:0]  rs1_out,
    output logic [4:0]  rs2_out,
    output logic [4:0]  rd_out,
    output logic [2:0]  funct3_out,
    output logic [6:0]  funct7_out,
    output logic [6:0]  opcode_out,
    output logic        RegWrite_out,
    output logic        MemRead_out,
    output logic        MemWrite_out,
    output logic        MemToReg_out,
    output logic        ALU_Src_out,
    output logic        Branch_out,
    output logic [1:0]  ALU_Op_out,
    output logic [31:0] instr_out
);
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            rd1_out       <= 32'b0;
            rd2_out       <= 32'b0;
            imm_out       <= 32'b0;
            pc_plus_4_out <= 32'b0;
            rs1_out       <= 5'b0;
            rs2_out       <= 5'b0;
            rd_out        <= 5'b0;
            funct3_out    <= 3'b0;
            funct7_out    <= 7'b0;
            opcode_out    <= 7'b0;
            RegWrite_out  <= 1'b0;
            MemRead_out   <= 1'b0;
            MemWrite_out  <= 1'b0;
            MemToReg_out  <= 1'b0;
            ALU_Src_out   <= 1'b0;
            Branch_out    <= 1'b0;
            ALU_Op_out    <= 2'b0;
            instr_out     <= 32'b0;
        end
        else if (flush) begin
            rd1_out       <= 32'b0;
            rd2_out       <= 32'b0;
            imm_out       <= 32'b0;
            pc_plus_4_out <= 32'b0;
            rs1_out       <= 5'b0;
            rs2_out       <= 5'b0;
            rd_out        <= 5'b0;
            funct3_out    <= 3'b0;
            funct7_out    <= 7'b0;
            opcode_out    <= 7'b0;
            RegWrite_out  <= 1'b0;
            MemRead_out   <= 1'b0;
            MemWrite_out  <= 1'b0;
            MemToReg_out  <= 1'b0;
            ALU_Src_out   <= 1'b0;
            Branch_out    <= 1'b0;
            ALU_Op_out    <= 2'b0;
            instr_out     <= 32'b0;
        end
        else if (!stall) begin
            rd1_out       <= rd1_in;
            rd2_out       <= rd2_in;
            imm_out       <= imm_in;
            pc_plus_4_out <= pc_plus_4_in;
            rs1_out       <= rs1_in;
            rs2_out       <= rs2_in;
            rd_out        <= rd_in;
            funct3_out    <= funct3_in;
            funct7_out    <= funct7_in;
            opcode_out    <= opcode_in;
            RegWrite_out  <= RegWrite_in;
            MemRead_out   <= MemRead_in;
            MemWrite_out  <= MemWrite_in;
            MemToReg_out  <= MemToReg_in;
            ALU_Src_out   <= ALU_Src_in;
            Branch_out    <= Branch_in;
            ALU_Op_out    <= ALU_Op_in;

            instr_out     <= instr_in;
        end
    end

endmodule
