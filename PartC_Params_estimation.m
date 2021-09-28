function [lambda,N0, growth_confidence, Primary_population_confidence] = PartC_Params_estimation(array,threshold)
%iii)
%estimating params of exponential formula by experimental data given
%input: 1) 2d array of 2 column, 1 for time, 1 for popul size
%       2) threshold, below it - behave like exponential formula
% output: growth factor (lamba)
        % init popul size
          % 2 number in array, for growth factor ("revach bar semech")
          % 2 num in array,  for init popul ("revach bar semech")
%(1)
% first_col = array (:,1); 
% first_col = first_col(first_col<threshold);
% second_col = array (:,2);
% second_col = second_col(first_col<threshold);

first_col = array (:,1); 
second_col = array (:,2);
second_col = second_col(second_col<threshold);

first_col = first_col(second_col<threshold);

C = [first_col ones(size(first_col))];
% user_conf = inputdlg({'% confidence'});
% conf = str2double(user_conf{1}) ; 

[ab,intv] = regress(log(second_col),C); 
%ab- coeffient vector
%intv- Confidence interval

%(3)
c = exp(ab);
lambda = c(1);
N0 = c(2);
growth_confidence = intv (1,:);
Primary_population_confidence = intv (2,:);

end

