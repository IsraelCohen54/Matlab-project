function [str_data] = PartA_FileSelect()
%part A)

% func to let the user select a file with extension fileType.
% and get data orgenized in struct:

% 2) A) (1)
[dataFile,dataPath] = uigetfile({'*population*.xls;*population*.xlsx; Excel Files'}); %extention file list, check F1
% 2) A) (2)
FullName = fullfile(dataPath,dataFile);
[~,txt_Data]  = xlsread(FullName,'A:I');
all_num = xlsread(FullName,'A:I'); 

% 2) A) (4)
%first specie, columns 1 and 2:
arr = all_num(:,1); %take array from column 1
temp1(:,1) = arr(~isnan(arr)); %get rid of NuNs and assign 1 column
% (meaning, create array that conteint cell that aren't true to the question
%   = r you NaN?)
arr = all_num(:,2);
temp1(:,2) = arr(~isnan(arr));

%second specie, columns 3 and 4:
arr = all_num(:,4);
temp2(:,1) = arr(~isnan(arr));
arr = all_num(:,5);
temp2(:,2) = arr(~isnan(arr));

%two species together.  columns 7, 8 and 9:
arr = all_num(:,7);
temp3(:,1) = arr(~isnan(arr)); %take column without nan rows
arr = all_num(:,8);
temp3(:,2) = arr(~isnan(arr));
arr = all_num(:,9);
temp3(:,3) = arr(~isnan(arr));

% 2) A) (3+4)
%add to struct:
str_data.title = dataFile;
str_data.time = txt_Data(1);
str_data.first_species_name = txt_Data(2);
str_data.second_species_name = txt_Data(5);
str_data.first_species_data = temp1;
str_data.second_species_data = temp2;
str_data.two_species_data = temp3;

end

