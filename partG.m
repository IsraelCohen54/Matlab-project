function [params,mistake_params_out] = partG(specie_params,Params_mistake,Nr,Nc,t,index_stab_without_competition)

%The func evaluates params of specie *with other competitive* specie.
%output: params calculaded as struct, and range of mistakes struct
%input: specie_params - struct specie Nr params, struct for mistake, Nr -
%       checked specie popul, Nc - competing specie with Nr, t is array of times

%1)
params = specie_params;
mistake_params_out = Params_mistake;

[calcConst,~,Bindex] = PartB_asympt(Nr,0.01);
%3)
%a) %find indx from which both species stabilize:
A = [Bindex,index_stab_without_competition];
max_index = max(A);

%b) #save valuse from that indx to end
threshold_Nr = Nr(max_index:end);
threshold_Nc = Nc(max_index:end);

%c) %alpha(cempeting factor)_vector = array of 'to be' mean in order to get alpha value
alpha_vector = ((specie_params.k -threshold_Nr)./threshold_Nc);

%d) %getting alpha:
alpha = mean(alpha_vector);
params.alpha = alpha;

%e) %range mistake calc:
upperalpha = alpha +2*std(alpha_vector);
loweralpha = alpha -2*std(alpha_vector);

%f)
mistake_params_out.alpha = [loweralpha,upperalpha];

%4)
%a) %2D array of time and popul of 1 specie
relaventRows(:,1) = t;
relaventRows(:,2) = Nr;
%b)+c)
threshold = 0.7*calcConst;

%getting evaluated init popul size, and mistake range from PartF
[params.n0,mistake_params_out.n0]=partF(relaventRows,threshold,specie_params.lambda);

end

