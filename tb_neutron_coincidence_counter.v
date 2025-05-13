`timescale 1us/1ns
module tb_cc();
	
    reg clk, inp, rst;
    wire [23:0]racc, acc, tc;
    coin_count cc1(clk, inp, rst, racc, acc, tc);
    
    always
    #0.5 clk = ~clk;
    
    initial begin
        clk = 1'b0;
        rst = 1'b1;
        inp = 1'b0;
    #10 rst = 1'b0;
    #100  inp = 1'b1;
    #5 inp = 1'b0;
    #1000 inp = 1'b1;
    #5 inp = 1'b0;
    end             
endmodule