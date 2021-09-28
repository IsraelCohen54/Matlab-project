function  PartD_addAnotation(str_data)
%part D)
%add x labels, title and legend

subplot(2,1,1);
%1)
xlabel(str_data.time) ; %time measurment type (days e.g.)
%2)
ylabel("seperate system") ; %for not competitive popul graph
%4)
title("date file: "+ str_data.title) %whole plot title

hold on

subplot(2,1,2); %2 rows, 1 col, sec option
%1)
xlabel(str_data.time) ;
%2)
ylabel("shared system") ;
hold on
%3) 
legend (str_data.first_species_name{1},str_data.second_species_name{1});

end

