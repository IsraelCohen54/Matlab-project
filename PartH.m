function [PopSize] = PartH(cellArray, t)
% Taking the parametes requried for the calculation like K ,lambda and N0
% with understaing that time is array 
% calculating logisitic grow as requsted in the formula:
n0 = cellArray.n0;
K = cellArray.k;
lambda = cellArray.lambda;
K_Division = (n0.*(lambda.^t -1))/K;
PopSize = (n0.*lambda.^t) ./ (1+K_Division);
%output ass array of popul size per time, 1d double array
end

