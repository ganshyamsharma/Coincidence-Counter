module NWCC(
    input clk_1mhz, pulse_ip, reset_ip,
    output [12:0] ra_count_op, a_count_op, total_count_op
);
    wire [12:0] CNT1, CNT2, SUB, ADD1, ADD2;
    wire a, b, c;                                                   //a--->8us delay    b--->128us delay   c--->1024us delay
    
    assign total_count_op = CNT1; 
     
    delay8 d1(clk_1mhz, reset_ip, pulse_ip, a);
    delay128 d2(clk_1mhz, reset_ip, a, b);
    delay1024 d3(clk_1mhz, reset_ip, pulse_ip, c);
         
    counter_13bit c1(a, reset_ip, CNT1);
    counter_13bit c2(b, reset_ip, CNT2);
    subtractor_13bit sub1(CNT1, CNT2, SUB);
    adder_13bit add1(SUB, ra_count_op, ADD1);                     // R+A adder
    adder_13bit add2(SUB, a_count_op, ADD2);                      // A adder
    register_13bit reg1(pulse_ip, reset_ip, ADD1, ra_count_op);      // R+A register
    register_13bit reg2(c, reset_ip, ADD2, a_count_op);  			//A register   
	
endmodule

///////////////////////////////////////////////////////////// Counter Unit

module counter_13bit(
    input clk, reset_ip,
    output reg [12:0] count
);
    always @(posedge clk, posedge reset_ip) begin
    if (reset_ip)
        count <= 13'd0;
    else
        count <= count + 1'b1;
    end 
endmodule

///////////////////////////////////////////////////////////// Subtractor Unit

module subtractor_13bit(
    input [12:0] num1, num2,
    output [12:0] result
);
    assign result = num1 - num2;   
endmodule

//////////////////////////////////////////////////////////// Adder Unit
module adder_13bit(
    input [12:0] num1, num2,
    output [12:0] result
);
    assign result = num1 + num2;   
endmodule

//////////////////////////////////////////////////////////// Register Unit

module register_13bit(
    input clk, reset_ip,
    input [12:0] inp,
    output reg [12:0] out
);
    always @(posedge clk or posedge reset_ip) begin
        if(reset_ip)
            out <= 13'd0;
        else
            out <= inp;
    end 
endmodule

//////////////////////////////////////////////////////////// Delayers

//////////////////// 8us delay
module delay8 (
input clk, reset_ip, inp, 
output out
);
    reg [7:0] shifter;
    assign out = shifter[7];
    always @(posedge clk or posedge reset_ip) begin
        if(reset_ip)
            shifter <= 8'd0;
        else
            shifter <= {shifter[6:0], inp};
    end
endmodule       
/////////////////// 128us delay //////////////////
module delay128 (
input clk, reset_ip, inp, 
output out
);
    reg [127:0] shifter;
    assign out = shifter[127];
    always @(posedge clk or posedge reset_ip) begin
        if(reset_ip)
            shifter <= 128'd0;
        else
            shifter <= {shifter[126:0], inp};
    end
endmodule                   
///////////////// 1024us delay //////////////////
module delay1024 (
input clk, reset_ip, inp, 
output out
);
    reg [1023:0] shifter;
    assign out = shifter[1023];
    always @(posedge clk or posedge reset_ip) begin
        if(reset_ip)
            shifter <= 1024'd0;
        else
            shifter <= {shifter[1022:0], inp};
    end
endmodule




	/////////////////////////////////////	TEST BENCH	////////////////////////////////
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