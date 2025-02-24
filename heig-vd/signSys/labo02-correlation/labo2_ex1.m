%% Labo2 - Ex 1: Inter-corrélation

clc; clear; close all;

%% Variables

 x = [0, 1, 1, 0, 0, 0, 0, 0, 0, 0];
 y = [0, 0, 0, 2, 2, 0, 0, 0, 0, 0];
 
 %% Verify link between conv and corr
 minusX = fliplr(x)
 
 convXY = myconv(minusX,y)
 % that's what we expect using the theory
 % caution: lag can be positive or negative! here we only represented the
 %          positive lag!!
 corrXY = [0,2,4,2,0,0,0,0,0]
 
 %% test mycorr
 [rxy,lag] = mycorr(x,y);
 
 figure();
 stem(lag, rxy);
 title('Cross-corelation of x and y');
 
 %% test mycorr with different length vectors
 x = [0, 1, 1, 0];
 y = [0, 0, 0, 2, 2, 0, 0, 0, 0, 0];
 
 [rxy,lag] = mycorr(x,y);
 
 figure();
 stem(lag, rxy);
 title('x shorter than y');
 

 