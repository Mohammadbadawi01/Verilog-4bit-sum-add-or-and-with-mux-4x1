module AND(a,b,out);
  input [3:0]a,b;
  output [3:0]out;
  and a(out,a,b);
endmodule

module OR(a,b,out);
  input [3:0]a,b;
  output [3:0]out;
  or o(out,a,b);
endmodule

module FA(a,b,cin,s,cout);
  input a,b,cin;
  output cout,s;
  assign s = a^b^cin;
  assign cout = ((a&b) | (cin&a) | (cin&b));
endmodule

module add_sub(a,b,s,m,c4);
  input [3:0]a,b;
  input m;
  output [3:0]s;
  wire c1,c2,c3,x1,x2,x3,x4;
  output c4;
  reg c4;
  xor xor1(x1,b[0],m);
  xor xor1(x2,b[1],m);
  xor xor1(x3,b[2],m);
  xor xor1(x4,b[3],m);
  FA u1(a[0],x1,m,s[0],c1);
  FA u2(a[1],x2,c1,s[1],c2);
  FA u3(a[2],x3,c2,s[2],c3);
  FA u4(a[3],x4,c3,s[3],c4);
endmodule 

module mux(And,Or,sum_add,sel,out);
  input [3:0]And,Or,sum_add;
  output [3:0]out;
  reg [3:0]out;
  input [1:0]sel;
  always @(sel or And or Or or sum_add)
      case(sel)
        0:out = sum_add;
        1:out = (sum_add ^ 0000);
        2:out = And;
        3:out = Or;
      endcase
endmodule

module AUL(A,B,sel,result);
  input [3:0]A,B;
  input [1:0]sel;
  output [3:0]result;
  reg [3:0]result;
  wire [3:0]W1,W2,W3;
  wire c4;
  add_sub U3(A,B,W3,sel[0],c4);
  AND U1(A,B,W1);
  OR U2(A,B,W2);
  mux U4(W1,W2,W3,sel,result);
endmodule

