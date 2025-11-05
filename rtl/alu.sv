module ALU(input logic [31:0] a, input logic [31:0] b, input logic [3:0] ALU_Sel, output logic [31:0] ALU_Out);
    always_comb begin
        unique case(ALU_Sel)
            4'd0: ALU_Out = a + b; //ADD
            4'd1: ALU_Out = a - b; //SUB
            4'd2: ALU_Out = a & b; //AND
            4'd3: ALU_Out = a | b; //OR
            4'd4: ALU_Out = a ^ b; //XOR
            4'd5: ALU_Out = ($signed(a) < $signed(b)) ? 32'b1 : 32'b0; //SLT
            4'd6: ALU_Out = (a < b) ? 32'b1 : 32'b0; //SLTU
            4'd7: ALU_Out = a << b[4:0]; //SLL
            4'd8: ALU_Out = a >> b[4:0]; //SRL
            4'd9: ALU_Out = $signed(a) >>> b[4:0]; //SRA
            default: ALU_Out = 32'hDEADBEEF; //Default case for undefined operations
        endcase
    end
endmodule

