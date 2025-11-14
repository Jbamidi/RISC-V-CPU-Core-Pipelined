module if_id_reg(input logic clk, input logic reset, input logic [31:0] pc_plus_4_in, input logic [31:0] instr_in, input logic flush, input logic stall, input logic if_id_en,
output logic [31:0] pc_plus_4_out, output logic [31:0] instr_out);

    always_ff @(posedge clk or posedge reset) begin
        if (reset)begin
            pc_plus_4_out <= 32'b0;
            instr_out <= 32'b0;
        end
        else if (flush) begin
            pc_plus_4_out <= 32'b0;
            instr_out <= 32'b0;
        end
        else if (!stall && if_id_en) begin 
            pc_plus_4_out <= pc_plus_4_in;
            instr_out <= instr_in;

        end
    end




endmodule
