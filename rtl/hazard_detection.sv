module hazard_detection(input logic       Mem_Read, 
                        input logic [4:0] rs1, 
                        input logic [4:0] rs2, 
                        input logic [4:0] rd, 
                        output logic      pc_en, 
                        output logic      if_id_en, 
                        output logic      id_ex_flush);

    always_comb begin
        if (Mem_Read && (rd != 5'd0) && ((rd == rs1) || (rd == rs2)))begin
            pc_en = 1'b0;
            if_id_en = 1'b0;
            id_ex_flush = 1'b1;
        end
        else begin
            pc_en = 1'b1;
            if_id_en = 1'b1;
            id_ex_flush = 1'b0;

        end
    end

endmodule
