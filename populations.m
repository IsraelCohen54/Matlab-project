% Part A:
   %i)
       clear; %params delete
       close all; %graphs delete
    %ii) Read data from file
       data_from_file = PartA_FileSelect();
    
    %iii) creating LineSpec cell array:
       LineSpec ={'or','ob'}; % 'o' = not connected markers as circles,
                              % (red-1, 2-blue)
    %iv)
         figure (1)
         PartC_two_species_two_axis_sys(data_from_file,LineSpec)
      %v)
           PartD_addAnotation(data_from_file)

% Part E:
   %i) calculate parametres for specie 1 without competition
%    output:
%         1) struct/cell array of 1 specie, with params not depent on spec_2
%         2) struct of mistakeat params of one of the species, every params
%            contain array with 2 numbers, as upper&bottom range
%         3) index of stabilization
   [params1_estimate_nocomp,mistake_param1_nocomp,index1]=partD(data_from_file.first_species_data,0.7);
   
   %ii) calculate parametres for specie 2 without competition
   [params2_estimate_nocomp,mistake_param2_nocomp,index2]=partD(data_from_file.second_species_data,0.7);
   
   %iii) concatenate 
   param_estimate_nocomp(1)=params1_estimate_nocomp;
   param_estimate_nocomp(2)=params2_estimate_nocomp;
   %iv) concatenate creating struct of confidence at not comparing state
   confidence_nocomp(1)=mistake_param1_nocomp;
   confidence_nocomp(2)=mistake_param2_nocomp;
   %v) concatenate 
   A = [index1,index2];
   index_max_stability = max(A); 
   
   
%Part H: calculate parametres with competition
   %i) save variables
   two_competitive_species = data_from_file.two_species_data;
   times_array_2species = two_competitive_species(:,1); %all column_1
   popul_array_first = two_competitive_species(:,2);
   popul_array_sec = two_competitive_species(:,3);
   
   %ii) calculate
   [first_specie_params_comp, first_specie_mistake_params_comp]=partG(param_estimate_nocomp(1),confidence_nocomp(1),popul_array_first,popul_array_sec,times_array_2species,index_max_stability);
   %iii)calculate
   [sec_specie_params_comp, sec_specie_mistake_params_comp]=partG(param_estimate_nocomp(2),confidence_nocomp(2),popul_array_sec,popul_array_first,times_array_2species,index_max_stability);
   %iv) concatenate
   params_2_competitive_species = [first_specie_params_comp sec_specie_params_comp];
   %v) concatenate
   mistakes_2_competitive_species = [first_specie_mistake_params_comp sec_specie_mistake_params_comp];


%Part I: (evaluated params & creating struct)
   %i) creating calc_by_estimated_params struct with data from file:
   calc_by_estimated_params = data_from_file;
    
   %ii) find max time in experiment
       spec_1_max_time = max(data_from_file.first_species_data(:,1));
       spec_2_max_time = max(data_from_file.second_species_data(:,1));
       two_spec_max_time = max(data_from_file.two_species_data(:,1));
    %iii)     make an array time for both species
         spec_1_time =  linspace(0,spec_1_max_time, max(100,spec_1_max_time));
         spec_2_time =  linspace(0,spec_2_max_time, max(100,spec_2_max_time));
         two_spec_time =  linspace(0,two_spec_max_time, max(100,two_spec_max_time));
      
    %iv)    detemenistic simulation of specie without competition 
         first_specie_data = PartH(first_specie_params_comp,spec_1_time);
         second_specie_data = PartH(sec_specie_params_comp,spec_2_time);
         
         %concatenate
         first_specie = [spec_1_time' first_specie_data'];
         second_specie = [spec_2_time' second_specie_data'];
         %add to variable
         calc_by_estimated_params.first_species_data =first_specie;
         calc_by_estimated_params.second_species_data = second_specie;
          
    
      %v)(1) Realization of 2 species with competition
            simulation_competetion_params.time = two_spec_max_time;
            simulation_competetion_params.realizations = 1;
            simulation_competetion_params.minPopulation = 0;
            simulation_competetion_params.initPopulation = [first_specie_params_comp.n0 sec_specie_params_comp.n0];
            simulation_competetion_params.Fk = 1;
            
            %(2) calculate
            simulation_results = PartJ (params_2_competitive_species,simulation_competetion_params);
             
            %concatenate
            matrix(:,2) = simulation_results.first_specie;
            matrix(:,3) = simulation_results.second_specie;
            matrix(:,1) = simulation_results.time';
            
            %add to variable 
            calc_by_estimated_params.two_species_data = matrix;
                
%Part J: %input: T = array of chars, N = scalar value, V = range wrong as
%array of 2 num
partJ_text_maker = @(T,N,V) append(T, " = ", " ",num2str (N)," ","[", num2str(V(1))," ",num2str(V(2)),"]");

%Part K:
   %i)
     figure (1)
     subplot(2,1,1);
     hold on
     subplot(2,1,2);
     hold on
    %ii)
     LineSpec ={'-r','-b'}; %solid red & solid blue
    %iii) %show:
     PartC_two_species_two_axis_sys(calc_by_estimated_params,LineSpec)
    %iv)
        %1) %text for growth factor per specie
         spec_1_lambda = partJ_text_maker("spec1 lambda",first_specie_params_comp.lambda, first_specie_mistake_params_comp.lmabda);
         spec_2_lambda = partJ_text_maker("spec2 lambda",sec_specie_params_comp.lambda, sec_specie_mistake_params_comp.lmabda);
        %2) %text for capacity per specie
         spec_1_K = partJ_text_maker("spec1 K",first_specie_params_comp.k, first_specie_mistake_params_comp.k);
         spec_2_K = partJ_text_maker("spec2 K",sec_specie_params_comp.k, sec_specie_mistake_params_comp.k);
%3)  creating text as string type:
     text = spec_1_lambda+"; "+spec_2_lambda+"; "+spec_1_K +"; "+spec_2_K;
     subplot(2,1,2);
     title(text)
     hold on

      %v) %creating upper_legend cell array:
         %1) specie name per popul:
         upper_legend{1} = data_from_file.first_species_name;
         upper_legend{2} = data_from_file.second_species_name;
         %2) popul init num
         upper_legend{3} = partJ_text_maker(" n0",params1_estimate_nocomp.n0, mistake_param1_nocomp.n0);
         upper_legend{4} = partJ_text_maker(" n0",params2_estimate_nocomp.n0, mistake_param2_nocomp.n0);
        
        subplot(2,1,1);
        legend(char(upper_legend{1}), char(upper_legend{2}), upper_legend{3},upper_legend{4} )
        hold on
        
      %vi) creating cell array lower_legend:
      %1) specie name per specie:
         lower_legend{1} = data_from_file.first_species_name;
         lower_legend{2} = data_from_file.second_species_name;
      %2) init popul
         lower_legend{3} = partJ_text_maker(" n0",first_specie_params_comp.n0,  first_specie_mistake_params_comp.n0)+ " " +partJ_text_maker(" alpha",first_specie_params_comp.alpha,  first_specie_mistake_params_comp.alpha) ;
         
         lower_legend{4} = partJ_text_maker(" n0",sec_specie_params_comp.n0, sec_specie_mistake_params_comp.n0)+ " " +partJ_text_maker(" alpha",sec_specie_params_comp.alpha,  sec_specie_mistake_params_comp.alpha) ;
            subplot(2,1,2);

   legend(char(lower_legend{1}), char(lower_legend{2}), lower_legend{3},lower_legend{4} )
   hold on
   

   %4) %Run simulation from given growth factor lambda,
       %competition factor from experienced.
       %user choose init popul num, K capacity (Fk) 
   %A)
     %i)
            figure (2)
     %ii)
            simulation_competetion_params_user_input = PartF_userInput (simulation_competetion_params);
   %B)
   while (1)
     %i) set variable
       params_2_competitive_species_user = params_2_competitive_species;
     %ii) update n0 bu user input
       params_2_competitive_species_user(1).n0 = simulation_competetion_params_user_input.initPopulation(1);
       params_2_competitive_species_user(2).n0 = simulation_competetion_params_user_input.initPopulation(2);

       %iii) update k
       params_2_competitive_species_user(1).k = params_2_competitive_species_user(1).k* simulation_competetion_params_user_input.Fk(1);
       params_2_competitive_species_user(2).k = params_2_competitive_species_user(2).k* simulation_competetion_params_user_input.Fk(1);

       %iv) simulate
    simulation_results = PartJ (params_2_competitive_species_user,simulation_competetion_params_user_input);

       %v) clear graphic window:
       clf

       %vi) show results in graph
           %(1) if realizations == 1
           if (simulation_competetion_params_user_input.realizations == 1)
               %(a)
                   plot (simulation_results.time,simulation_results.first_specie,'-b') %solid blue
                   hold on
                  plot ( simulation_results.time,simulation_results.second_specie,'-g') %solid green
              %(b) %Show specie name, K, N0 (init popul size):
              legend ("n0 = "+ num2str(params_2_competitive_species_user(1).n0) + ", k =" +num2str(params_2_competitive_species_user(1).k)+", name:" +data_from_file.first_species_name ,"n0 = " +num2str(params_2_competitive_species_user(2).n0) + ", k =" +num2str(params_2_competitive_species_user(2).k)+", name:" +data_from_file.second_species_name)
              %(c)
              title(data_from_file.title)
           end
        
        %(2) if realizations > 1
        if (simulation_competetion_params_user_input.realizations > 1)
            %(a) plot all realizations for specie_1
          subplot(2,1,1) %show popul size foreach realization specie_1
            plot(simulation_results.time, simulation_results.first_specie);
             ylabel("n0 = "+ num2str(params_2_competitive_species_user(1).n0) + ", k =" +num2str(params_2_competitive_species_user(1).k)+", name:" +data_from_file.first_species_name)
             xlabel(data_from_file.time)

             
           subplot(2,1,2) %show popul size foreach realization specie_2
            plot(simulation_results.time, simulation_results.second_specie);
            %(b) %specie,k,N0
            ylabel("n0 = "+ num2str(params_2_competitive_species_user(1).n0) + ", k =" +num2str(params_2_competitive_species_user(1).k)+", name:" +data_from_file.first_species_name)
            %(c) %file name
             xlabel(data_from_file.time)
            hold on
            
         % plot all realizations for specie 2

            subplot(2,1,2)
            plot(simulation_results.second_specie(:,2),simulation_results.time)
            ylabel("n0 = " +num2str(params_2_competitive_species_user(2).n0) + ", k =" +num2str(params_2_competitive_species_user(2).k)+", name:" +data_from_file.second_species_name)
            xlabel(data_from_file.time)
            hold on
        end
        
        
        %(3)set title
           title(data_from_file.title)
            
          %vii)
           simulation_competetion_params_user_input = PartF_userInput (simulation_competetion_params_user_input);
        % viii)
           if (simulation_competetion_params_user_input.initPopulation(1) == 0 || simulation_competetion_params_user_input.initPopulation(2) == 0)
               break
           end
   end
   
%C) if realizations > 1
   if (simulation_competetion_params_user_input.realizations>1)
       %i)
       figure (3)
       %ii) calculate mean and std
       specie_1_mean = mean(simulation_results.first_specie,2);
       specie_2_mean = mean(simulation_results.second_specie,2);
      
       specie_1_std = std(simulation_results.first_specie,0,2);
       specie_2_std= std(simulation_results.second_specie,0,2);
    
       %iii) if time steps < 50
     if (simulation_competetion_params_user_input.time < 50)
        errorbar(simulation_results.time, specie_1_mean, specie_1_std)
        hold on
        errorbar(simulation_results.time, specie_2_mean, specie_2_std)
        hold on
     end
     
     %iv) if time steps > 50
     if (simulation_competetion_params_user_input.time > 50)
         %(1)
        plot(simulation_results.time, specie_1_mean)
        hold on
        plot(simulation_results.time, specie_2_mean)
        hold on
        %(3)
        legend ("n0 = "+ num2str(params_2_competitive_species_user(1).n0) + ", k =" +num2str(params_2_competitive_species_user(1).k)+", name:" +data_from_file.first_species_name ,"n0 = " +num2str(params_2_competitive_species_user(2).n0) + ", k =" +num2str(params_2_competitive_species_user(2).k)+", name:" +data_from_file.second_species_name)
        %(4)
       title(data_from_file.title)
        
       %(2) %get every fifth point
        five_mean_specie_1 = specie_1_mean(1:5:end);
        five_mean_specie_2 = specie_2_mean(1:5:end);
        five_time = simulation_results.time(1:5:end);
        
        five_std_specie_1 = specie_1_std(1:5:end);
        five_std_specie_2 = specie_2_std(1:5:end);
        
        errorbar (five_time,five_mean_specie_1,five_std_specie_1)
        hold on
        errorbar (five_time,five_mean_specie_2,five_std_specie_2)
        hold on
     end
   end