function [N0,confidence] = partF(array,threshold_size_pop,lambda)

%function evaluateing init popul num with given growth factor (lambda)

%input: 1) array of 2 colms, time & popul_size
%       2) threshold = below it, popul growth is exponential
%       3) lambda = growth factor

%output: 1) calculated N0 (init popul)
%        2) range of mistake (array of 2 numbers, min max range)
%

%iii)
    %1) get popul values lesser than threshold from array
    pop_col = array (:,2);
    pop_col = pop_col(pop_col<threshold_size_pop);

    %2) get time values in accordance to values from 1)
    time_col = array (:,1);
    time_col = time_col(pop_col<threshold_size_pop);

    %3) division
    arrayofdivide = (pop_col./(lambda.^time_col));

    %4) getting evaluating N0 as mean:
          N0 = mean(arrayofdivide);
    %5) %mistake calc range:
        %a)
        Upper = N0-2*std(arrayofdivide);
        %b)
        lower = N0+2*std(arrayofdivide);
        confidence = [Upper,lower];
end