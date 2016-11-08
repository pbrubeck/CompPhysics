close all; clear;
load tarea10problema3.mat
%   A - input data.
%   y - target data.
A = [a; b; c; d; e];
trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.

% Create a Fitting Network
hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize,trainFcn);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio   = 15/100;
net.divideParam.testRatio  = 15/100;

% Train the Network
[net,tr] = train(net,A,y);

% Test the Network
y = net(A);
%signal phi

yy = net(eye(size(A,1)));
COEFFICIENTS = round(yy(1:5));
display(COEFFICIENTS);