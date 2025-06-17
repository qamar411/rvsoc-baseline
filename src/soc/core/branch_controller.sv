typedef enum logic [2:0] {
    BEQ = 0, 
    BNE = 1, 
    BLT = 4, 
    BGE = 5, 
    BLTU = 6, 
    BGEU = 7
} branch_t;

module branch_controller (
    input branch_t fun3,
    input logic branch, 
    input logic jump, 
    input logic zero,
    output logic pc_sel
);


    logic comp_result;
    logic do_branch;
    
    always @(*) begin 
        case(fun3)
            BEQ: comp_result = zero;
            BNE: comp_result = ~zero;
            BLT: comp_result = ~zero;
            BGE: comp_result = zero;
            BLTU: comp_result = ~zero;
            BGEU: comp_result = zero;
            default: comp_result = 1'b0;
        endcase
    end

    assign do_branch = comp_result & branch;
    assign pc_sel = do_branch | jump;

endmodule 