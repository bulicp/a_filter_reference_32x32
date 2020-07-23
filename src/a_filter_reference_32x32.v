
module a_filter_reference_32x32(
    input [31:0] x_in,
    input clk,
    input [5:0] reset,
    output [31:0] y_out);

    wire [31:0] a1_1;
    wire [31:0] a1_2;
    wire [31:0] a1_3;
    wire [31:0] a1_4;
    wire [31:0] b1;
    // update coefficent
    // h_fixp(i) = sign(h_fixp(i))*floor(abs(h_fixp(i))/M)*M;

    assign a1_1 = -32'sd208;
    assign a1_2 = -32'sd1021;
    assign a1_3 = -32'sd930;
    assign a1_4 = -32'sd1010;
    assign b1 = 32'sd307;

    wire [31:0] y_1;
    wire [31:0] y_2;
    wire [31:0] y_3;
    wire [31:0] y_4;
    wire [31:0] y_5;

    //First stage
    fos_exact_v4 first_stage(x_in,a1_4,clk,reset[0],y_1);
    //Second stage
    fos_exact_v3 second_stage(y_1,a1_3,b1,clk,reset[1],y_2);
    //Third stage
    fos_exact_v2 third_stage(y_2,a1_2,clk,reset[2],y_3);
    //Fourth stage
    fos_exact_v2 fourth_stage(y_3,a1_2,clk,reset[3],y_4);
    //Fifth stage
    fos_exact_v1 fifth_stage(y_4,a1_1,clk,reset[4],y_5);
    //Sixth stage
    fos_exact_v1 sixth_stage(y_5,a1_1,clk,reset[5],y_out);

endmodule
