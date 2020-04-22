function [out,x0,str,ts] = network(t,x,in,flag)

global Y0
switch flag,

case 0,
   sizes = simsizes;
 	sizes.NumContStates  = 0;
	sizes.NumDiscStates  = 0;
	sizes.NumOutputs     =  56 ;
	sizes.NumInputs      =  88 ;
	sizes.DirFeedthrough = 1;
	sizes.NumSampleTimes = 1;
	out = simsizes(sizes);
	x0  = []; str = []; ts  = [-1 0];

case 3,

Y=Y0;

% Contributions of machines to Y
Y(  1,  1)=Y(  1,  1)+ in(  3,1)+ j* in(  4,1) ;
Y(  2,  2)=Y(  2,  2)+ in(  7,1)+ j* in(  8,1) ;
Y(  3,  3)=Y(  3,  3)+ in( 11,1)+ j* in( 12,1) ;
Y(  4,  4)=Y(  4,  4)+ in( 15,1)+ j* in( 16,1) ;
Y(  5,  5)=Y(  5,  5)+ in( 19,1)+ j* in( 20,1) ;
Y(  6,  6)=Y(  6,  6)+ in( 23,1)+ j* in( 24,1) ;
Y( 26, 26)=Y( 26, 26)+ in( 27,1)+ j* in( 28,1) ;
Y( 27, 27)=Y( 27, 27)+ in( 31,1)+ j* in( 32,1) ;
Y( 28, 28)=Y( 28, 28)+ in( 35,1)+ j* in( 36,1) ;

% Contributions of loads to Y
Y(  1,  1)=Y(  1,  1)+in( 39, 1)+ j* in( 40, 1) ;
Y(  2,  2)=Y(  2,  2)+in( 43, 1)+ j* in( 44, 1) ;
Y(  7,  7)=Y(  7,  7)+in( 47, 1)+ j* in( 48, 1) ;
Y(  8,  8)=Y(  8,  8)+in( 51, 1)+ j* in( 52, 1) ;
Y(  9,  9)=Y(  9,  9)+in( 55, 1)+ j* in( 56, 1) ;
Y( 10, 10)=Y( 10, 10)+in( 59, 1)+ j* in( 60, 1) ;
Y( 11, 11)=Y( 11, 11)+in( 63, 1)+ j* in( 64, 1) ;
Y( 12, 12)=Y( 12, 12)+in( 67, 1)+ j* in( 68, 1) ;
Y( 13, 13)=Y( 13, 13)+in( 71, 1)+ j* in( 72, 1) ;
Y( 21, 21)=Y( 21, 21)+in( 75, 1)+ j* in( 76, 1) ;
Y( 22, 22)=Y( 22, 22)+in( 79, 1)+ j* in( 80, 1) ;
Y( 24, 24)=Y( 24, 24)+in( 83, 1)+ j* in( 84, 1) ;
Y( 25, 25)=Y( 25, 25)+in( 87, 1)+ j* in( 88, 1) ;

% Contributions of machines to I
phi=zeros( 28,1) ;
phi(  1,1)=in(  1,1)+ j* in(  2,1) ;
phi(  2,1)=in(  5,1)+ j* in(  6,1) ;
phi(  3,1)=in(  9,1)+ j* in( 10,1) ;
phi(  4,1)=in( 13,1)+ j* in( 14,1) ;
phi(  5,1)=in( 17,1)+ j* in( 18,1) ;
phi(  6,1)=in( 21,1)+ j* in( 22,1) ;
phi( 26,1)=in( 25,1)+ j* in( 26,1) ;
phi( 27,1)=in( 29,1)+ j* in( 30,1) ;
phi( 28,1)=in( 33,1)+ j* in( 34,1) ;

% Contributions of loads to I
phi(  1,1)=in( 37,1)+ j* in( 38,1) ;
phi(  2,1)=in( 41,1)+ j* in( 42,1) ;
phi(  7,1)=in( 45,1)+ j* in( 46,1) ;
phi(  8,1)=in( 49,1)+ j* in( 50,1) ;
phi(  9,1)=in( 53,1)+ j* in( 54,1) ;
phi( 10,1)=in( 57,1)+ j* in( 58,1) ;
phi( 11,1)=in( 61,1)+ j* in( 62,1) ;
phi( 12,1)=in( 65,1)+ j* in( 66,1) ;
phi( 13,1)=in( 69,1)+ j* in( 70,1) ;
phi( 21,1)=in( 73,1)+ j* in( 74,1) ;
phi( 22,1)=in( 77,1)+ j* in( 78,1) ;
phi( 24,1)=in( 81,1)+ j* in( 82,1) ;
phi( 25,1)=in( 85,1)+ j* in( 86,1) ;

volt = Y\phi ;

for l=1: 28
   out(2*l-1)=real(volt(l,1)) ;
   out(2*l  )=imag(volt(l,1)) ;
end

case 2,
case 9,
case 5,
otherwise
    error(['Unhandled flag = ',num2str(flag)]);

end
