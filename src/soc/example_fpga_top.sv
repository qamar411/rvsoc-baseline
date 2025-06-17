
module rv32i_soc_fpag_top (

    // ...

    input logic [15:0] SW,
    output logic [15:0] LED
);  


    // clock and reset 
    logic reset_n;
    logic clk;

    assign reset_n = CPU_RESETN;

    clk_div_by_2 gen_core_clk (
        .clk_i(CLK100MHZ),
        .clk_o(clk),
        .reset_n(CPU_RESETN)
    );

    // Example connection of io_data with leds, switches and seven segment contorller 
    wire [31:0] io_data6

    assign LED           = io_data[15:0]; // TODO: if using lower 16 bits as outputs 
    assign io_data[31:16] = SW;            // TODO: if using upper 16 bits as outputs 

    assign digits[0] = io_data[3 :0 ];
    assign digits[1] = io_data[7 :4 ];
    assign digits[2] = io_data[11:8 ];
    assign digits[3] = io_data[15:12];
    assign digits[4] = io_data[19:16];
    assign digits[5] = io_data[23:20];
    assign digits[6] = io_data[27:24];
    assign digits[7] = io_data[31:28];


    sev_seg_controller ssc(
        .clk(clk),
        .resetn(reset_n),
        .digits(digits),
        .Seg(Seg),
        .AN(AN)
    );


    // soc instance ... 
    rv32i_soc #(
        .DMEM_DEPTH(DMEM_DEPTH),
        .IMEM_DEPTH(IMEM_DEPTH)
    ) soc_inst (
        .*,     // don't normall use .* as although its easy but it will be diff to debug
        .io_data(io_data)
    );

endmodule : rv32i_soc_fpag_top

module clk_div_by_2 (
    input logic reset_n,
    input logic clk_i, 
    output logic clk_o
);
    always @(posedge clk_i, negedge reset_n)
    begin 
        if(~reset_n)    clk_o <= 0;
        else            clk_o <= ~clk_o;
    end
endmodule 