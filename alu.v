module Alu (
    input  wire [3:0]  ALU_OP_i,
    input  wire [31:0] ALU_RS1_i,
    input  wire [31:0] ALU_RS2_i,
    output reg  [31:0] ALU_RD_o,
    output wire        ALU_ZR_o
);

    // OpCodes
    localparam AND             = 4'b0000;
    localparam OR              = 4'b0001;
    localparam XOR             = 4'b1000;
    localparam NOR             = 4'b1001;
    localparam SUM             = 4'b0010;
    localparam SUB             = 4'b1010;
    localparam EQUAL           = 4'b0011;
    localparam GREATER_EQUAL   = 4'b1100;
    localparam GREATER_EQUAL_U = 4'b1101;
    localparam SLT             = 4'b1110;
    localparam SLT_U           = 4'b1111;
    localparam SHIFT_LEFT      = 4'b0100;
    localparam SHIFT_RIGHT     = 4'b0101;
    localparam SHIFT_RIGHT_A   = 4'b0111;

    always @(*) begin
        case (ALU_OP_i)
            AND: begin
                ALU_RD_o = ALU_RS1_i & ALU_RS2_i;
            end
            OR: begin
                ALU_RD_o = ALU_RS1_i | ALU_RS2_i;
            end
            XOR: begin
                ALU_RD_o = ALU_RS1_i ^ ALU_RS2_i;
            end
            NOR: begin
                ALU_RD_o = ~(ALU_RS1_i | ALU_RS2_i);
            end
            SUM: begin
                ALU_RD_o = ALU_RS1_i + ALU_RS2_i;
            end
            SUB: begin
                ALU_RD_o = ALU_RS1_i - ALU_RS2_i;
            end
            EQUAL: begin
                if (ALU_RS1_i == ALU_RS2_i) begin
                    ALU_RD_o = 32'd1;
                end else begin
                    ALU_RD_o = 32'd0;
                end
            end
            GREATER_EQUAL: begin
                if ($signed(ALU_RS1_i) >= $signed(ALU_RS2_i)) begin
                    ALU_RD_o = 32'd1;
                end else begin
                    ALU_RD_o = 32'd0;
                end
            end
            GREATER_EQUAL_U: begin
                if (ALU_RS1_i >= ALU_RS2_i) begin
                    ALU_RD_o = 32'd1;
                end else begin
                    ALU_RD_o = 32'd0;
                end
            end
            SLT: begin
                if ($signed(ALU_RS1_i) < $signed(ALU_RS2_i)) begin
                    ALU_RD_o = 32'd1;
                end else begin
                    ALU_RD_o = 32'd0;
                end
            end
            SLT_U: begin
                if (ALU_RS1_i < ALU_RS2_i) begin
                    ALU_RD_o = 32'd1;
                end else begin
                    ALU_RD_o = 32'd0;
                end
            end
            SHIFT_LEFT: begin
                ALU_RD_o = ALU_RS1_i << ALU_RS2_i[4:0];
            end
            SHIFT_RIGHT: begin
                ALU_RD_o = ALU_RS1_i >> ALU_RS2_i[4:0];
            end
            SHIFT_RIGHT_A: begin
                ALU_RD_o = $signed(ALU_RS1_i) >>> ALU_RS2_i[4:0];
            end
            default: begin
                ALU_RD_o = 32'd0;
            end
        endcase
    end

    // Geração do sinal de zero
    assign ALU_ZR_o = (ALU_RD_o == 32'd0);

endmodule
