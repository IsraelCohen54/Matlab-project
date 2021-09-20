function [outputStruct] = PartF_userInput(input)
%part F)
%Get simulation parameters from user as input of struct type

dlgtitle = 'Input'; %char type
dims = [1 35]; %input size
definput  = {num2str(input.time), num2str(input.realizations), num2str(input.minPopulation), num2str(input.initPopulation), num2str(input.Fk) };

%iv (1)
prompt = {'Enter time:','Enter realizations:','Enter min population for stop','Enter initial population','Enter Fk' };
   
answer = inputdlg(prompt,dlgtitle,dims,definput);  %get data from user
            %prompt - data type explanation, dlgtitle - the title,
            %dims - len of answer, definput -
            %input
%Check if only one parameres entered in answer 4
    k = strfind(answer{4},' '); %get ' ' indices in array
    check_if_one_num = isempty(k); %meaning if ' ' not found = empty array
    if check_if_one_num==1 %indeed empty
        answer = inputdlg(prompt,dlgtitle,dims,definput);
    end
    
%assign data to output struct
    outputStruct.time = str2double(answer (1)); %time steps
    outputStruct.realizations = str2double(answer (2)); %num to run simulations
    outputStruct.minPopulation = str2double(answer (3)); %
    cellArray = str2double(split(answer (4)));
    outputStruct.initPopulation = [cellArray(1) cellArray(2)];
    outputStruct.Fk = str2double(answer (5)); %Fk - mekaem kosher nesia' K - carying capacity
    
    %iv 3)
    %check user input. all inputs must be greater than zero.
while(1)
    flag = 0;
    
    %check time
    if outputStruct.time > 0
        flag = flag+1;
        definput{1} = num2str(outputStruct.time);
    else
        definput{1}='Enter number bigger than 0 without letters'; %chagne defualt to the wrong input
    end
    
     %check realizations
    if outputStruct.realizations > 0
        flag = flag+1;
        definput{2} = num2str(outputStruct.realizations);
    else
        definput{2}='Enter number bigger than 0 without letters';
    end
   
    %check minPopulation
    if outputStruct.minPopulation > 0
        flag = flag+1;
        definput{3} = num2str(outputStruct.minPopulation);
    else
        definput{3}='Enter number bigger than 0 without letters';
    end
    
    
  %check initPopulation  
    if outputStruct.initPopulation(1)>0  && outputStruct.initPopulation(2)  > 0
        flag = flag+1;
        str_first = num2str(outputStruct.initPopulation(1));
        str_two = num2str(outputStruct.initPopulation(2));
        cell_arr.str_first=str_first;
        cell_arr.str_two=str_two;
        definput{4} = num2str(outputStruct.initPopulation);
    else
        definput{4}='Enter 2 numbers bigger than 0 with space between them';
    end
    
    %check Fk
    if outputStruct.Fk > 0
        flag = flag+1;
        definput{5} = num2str(outputStruct.Fk);
    else
        definput{5}='Enter number bigger than 0 without letters';
    end
    
    %3) (c)
    %if all inputs are postitive numbers- exit
    if flag == 5
        break
    end  
    
    % if the input is not good, show input dialog again with default
    % values:
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    outputStruct.time = str2double(answer (1));
    outputStruct.realizations = str2double(answer (2));
    outputStruct.minPopulation = str2double(answer (3));
    cellArray = str2double(split(answer (4)));
    outputStruct.initPopulation = [cellArray(1) cellArray(2)];
    outputStruct.Fk = str2double(answer (5));
end
end

