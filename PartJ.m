function [simulation_results] = PartJ(species_struct,simulation_parameters)
%part J)
%run simulation for 2 *competing species* and given simulation_parameters,
%and return results
% input: 1) species_struct -  array of 2 struct: popul data (N0, lambda etc)
%        2) simulation_parameters - struct of params data (realization num
%        etc)

%   iii)
%   create 2d NaN mat (array) of lenght time +1 (+1 for time = 0)
%   foreach popul
% first line in mat: init popul num, time=0
first_specie_result = nan(simulation_parameters.time,simulation_parameters.realizations);
second_specie_result = nan(simulation_parameters.time,simulation_parameters.realizations);

%enter the initial population in the first row of the matrix:
for i = 1:simulation_parameters.realizations
    first_specie_result(1,i) = species_struct(1).n0;
    second_specie_result(1,i) = species_struct(2).n0;
end

% vi) %calc pop num givan pop_1&_2 curr num
for i = 2:simulation_parameters.time
    % (1) pop_1 calc
    first_specie_result (i,:) = calculate_nextStep(species_struct(1),first_specie_result (i-1,:),second_specie_result (i-1,:));
    
    % (2) pop_2 calc
    second_specie_result (i,:) = calculate_nextStep(species_struct(2),second_specie_result (i-1,:),first_specie_result (i-1,:));
    
    %(3) (a)
    if simulation_parameters.realizations > 1
        %change growth of popul by rand variant
        first_specie_result(i,:) = randomround(first_specie_result(i,:));
        second_specie_result(i,:) = randomround(second_specie_result(i,:));

        %(3) (b) %check if curr popul num is 
        C = first_specie_result(i,:) - simulation_parameters.minPopulation;
        D = second_specie_result(i,:) - simulation_parameters.minPopulation;
        E = (C > 0);
        F = (D > 0);
        
        %zeroing any realization of too low popul num currently:
        first_specie_result(i,:) = first_specie_result(i,:).*E;
        second_specie_result(i,:)=second_specie_result(i,:).*F;
        
        % (3) (c) 
        if sum (first_specie_result(i,:)) ==0
            break %all realization popul_1 died
        end
        if sum (second_specie_result(i,:)) ==0
            break %all realization popul_2 died
        end
    end
    
    %vii)
    first_specie_result(i,:) = ex6_2nan(first_specie_result(i,:));
    second_specie_result(i,:) = ex6_2nan(second_specie_result(i,:));

end
% viii) %return results of popul_1&_2 with time steps
simulation_results.time = 0:1:size(first_specie_result,1)-1; %fixed 
simulation_results.first_specie = first_specie_result;
simulation_results.second_specie = second_specie_result;

%iv) %calculating next generation popul num:
    function [output_pop] = calculate_nextStep(specie_params,this_prev_pop,other_prev_pop)
        A = this_prev_pop + (specie_params.alpha.*other_prev_pop); %alpha - competition factor
        B = (1-A./specie_params.k);
        output_pop = this_prev_pop.* (specie_params.lambda.^B);
    end

% v)
%randomly round number
%similar to lecuter 6 example 6 only to apply to arrays
    function [round_row__of_numbers]= randomround(row_of_numebrs)
     %(3)
        [~,numCols] = size(row_of_numebrs); %output is 1 10, ~ discarded the 1 output
          %(a)
        fraction = rem (row_of_numebrs,1); %rem = reminder after division of array
        %(b)
        random = rand(1,numCols);
        %(c)
        A = logical (random<fraction);
        round_down_rows= floor(row_of_numebrs);
        round_row__of_numbers = round_down_rows +A;
    end

%erase nans
    function [B] = ex6_2nan(array)
        L = isnan(array); %TF = isnan(A) returns a *logical array (L)*
                          % containing 1 (true) where the elements 
                          % of A are NaN, 
                          % and 0 (false) where they are not.
        L = not (L); %check whose isnt NaN
        B = array (L); %continue with them
    end

end


