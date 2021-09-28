function [params,mistakeparam,index_for_stability_start] = partD(array,stable_value_prec)

%The func calc params of one species, from measurments done about system with
% sole specie *no competing*
%input: 1) array with 2 column, time and popul size
%       2) percent of stable value, below it we assume popul
%       growth=exponential growth
%output: 1)struct/cell array of 1 specie, with params not depent on spec_2
%        2) struct of mistakeat params of one of the species, every params
%            contain array with 2 numbers, as upper&bottom range
%        3) index of stabilization

%iii)
% (1) find array stable point
%calc place and value of stabilization:
[calcConst,Confidence, index_for_stability_start]=PartB_asympt(array(:,1)',0.01); 

% (2)calculate threshold. Below threshold population growth exponentially
exponent_threshold=calcConst*stable_value_prec; 

% (3) calculate exponential parameters:
[lambda,N0, growth_confidence, Primary_population_confidence]=PartC_Params_estimation(array,exponent_threshold);

% (4) one specie params struct
params.n0=N0; %init popul size
params.lambda=lambda;
params.k=calcConst;
params.alpha=0; %competition factor

% (5) struct for "mistakes" space
mistakeparam.n0=Primary_population_confidence;
mistakeparam.lmabda=growth_confidence;
mistakeparam.k=Confidence;
mistakeparam.alpha=0;
end

