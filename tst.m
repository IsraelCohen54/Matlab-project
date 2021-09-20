
  %Part A)
     clear; %clear workspace
     exp_data = PartA_FileSelect; %struct
     figure (1) %Create figure window

  %Part C) creating cell array LineSpec:
     LineSpec ={'--r','--g'}; %dashed, red || dashed, green. dashed = merusak
     PartC_two_species_two_axis_sys(exp_data,LineSpec) %see 2 populations graphs, upper plt without competition, lower with competition
   %Part D)
   %Part E)
       PartD_addAnotation(exp_data)


    %part G)  %check part F
    %default values for F_tst struct:
         F_tst.time = 50;
         F_tst.realizations = 10;
         F_tst.minPopulation = 2;
         F_tst.initPopulation = [5 6]; 
         F_tst.Fk = 1;
         
      %G) iii)%creating simulation_parameters struct:
         simulation_parameters = PartF_userInput(F_tst); 
         
         
    %Part I)
        %i) %create time array, 201 nums between:start=0 & sim_par.time
          time = linspace(0,simulation_parameters.time,201); %time array
       %ii)
        %struct for population 1:
        specie_1.n0 = 4.5;
        specie_1.lambda  = 1.1;
        specie_1.k = 9;
        specie_1.alpha = 0.9;
        
        %struct for population 2:
        specie_2.n0 = 5;
        specie_2.lambda  = 1.2;
        specie_2.k = 10;
        specie_2.alpha = 1;
        
        %iii) %update init popul by user input
        specie_1.n0 = simulation_parameters.initPopulation(1);
        specie_2.n0 = simulation_parameters.initPopulation(2);
        
        %struct of both popul together
        species_parameters(1) = specie_1;
        species_parameters(2) = specie_2;
        
        %iv)                   %H - logistic growth:
        first_specie_popSize = PartH(species_parameters(1),time);
        % got popul num with logistic grouth
        
        %v)
        figure (2) %openning a new graphic window
        subplot(2,1,1); %2 rows, 1 col, choose first area to plot...
        
        %vi) %plot popul_1 of logistic growth per time
        plot(first_specie_popSize,time,'k') %'k' = solid black line

        hold on
        
        %vii) %same as v) for popul_2, plotted in same area
        second_specie_popSize = PartH(species_parameters(2),time);
        subplot(2,1,1);
        plot(second_specie_popSize,time,'k') %'k' = solid black line
        
        
        
    %part K)
         %i) %2 popul, many realization, statistic random round_floor
            %creating simulation_results struct:
            simulation_resaults = PartJ(species_parameters,simulation_parameters);
          %ii) %plot results:
            figure (3)
            subplot(2,1,1)
            plot(simulation_resaults.first_specie(:,1),simulation_resaults.time);
            hold on
            subplot(2,1,2)
            plot(simulation_resaults.second_specie(:,2),simulation_resaults.time)
            hold on
            
         %iii,iv)  %check functionality with 1 relization only
            species_parameters(1).alpha = 0; %meaning - no competition
            species_parameters(2).alpha = 0; %meaning - no competition
            simulation_parameters.realizations = 1;
            simulation_parameters.minPopulation = 0;
          %v)   
            simulation_resaults = PartJ(species_parameters,simulation_parameters);
          %vi)
          
            %see that simulation result equal calc by formula results:
            figure (2)
            subplot(2,1,1)
            plot(simulation_resaults.first_specie,simulation_resaults.time,'--r'); %dashed red line
            hold on
            subplot(2,1,1)
            plot(simulation_resaults.second_specie,simulation_resaults.time,'--g'); %dashed green line





