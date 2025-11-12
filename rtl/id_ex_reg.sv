module id_ex_reg(input logic clk, input logic reset, input logic [31:0] pc_plus_4_in, input flush, input stall,
input logic [31:0] rd1_in, input logic [31:0] rd2_in, input logic [31:0] imm_in, input logic [31:0] pc_plus_4_in, input logic [4:0] rs1_in,input logic [4:0] rs2_in, input logic [4:0] rd_in, input logic [2:0] funct3_in,  );

    always_ff @(posedge clk or posedge reset) begin
        if (reset)begin

        end
        else if (flush) begin
            
        end
        else if (!stall) begin 
            

        end
    end




endmodule
