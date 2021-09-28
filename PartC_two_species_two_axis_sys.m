function PartC_two_species_two_axis_sys(str_data,LineSpec) 
%part c)

% The cell array in input (2), has 2 cells, 
% each hold array of chars for axis type
% The struct (1) hold the data

%subplot 2 species in sepereted system
subplot(2,1,1);
plot(str_data.first_species_data(:,1),str_data.first_species_data(:,2),LineSpec{1})
hold on
plot(str_data.second_species_data(:,1),str_data.second_species_data(:,2),LineSpec{2})

%subplot 2 species in shared system
hold on
subplot(2,1,2);
plot(str_data.two_species_data(:,1),str_data.two_species_data(:,2),LineSpec{1} );
hold on
plot(str_data.two_species_data(:,1),str_data.two_species_data(:,3),LineSpec{2});
hold on
end