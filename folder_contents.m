function [ subs,sub_num,sub_str_len ] = folder_contents( Main_folder,...
                                  Mains,Mains_num,Mains_str_len,key )...
%%
% Description:
% The function fetches the content of the main folders given as inputs 
% 
% Syntax:
%[ subs,sub_num,sub_str_len ] = folder_contents( Main_folder,...
%                         Mains,Mains_num,Mains_str_len,key )...
%
% Inputs:
% Main_folder- Full path of all folders directory
% Mains- A single array of strings including the names of all the main 
%        folders to look into concatenated next to each other
% Mains_num- Number of folders provided to search into
% Mains_str_len- Array of integers with the lengths of each provided folder 
%                name
% key- String used as a search key for sub folders

% Outputs:
% subs- A single array of strings including the names of each subfolder 
%       in the provided set of main folders
% sub_num- Number of folders found in each main folder
% sub_str_len- Array with the lengths of each returned subfolder name
%
%%
% Author: Weam Elsahhar
% Uinversity of Bristol
% email: we15226@bristol.ac.uk
% Website: http://www.
% May 2018; Last revision: 20-Aug-2018
%%
%Initiate output variables
subs=[];
sub_num=[];
sub_str_len=[];


for indexMain=1:Mains_num
    % Define Starting and Ending indecies to fetch current main folder
    % from  Mains
    if indexMain==1                 
        Main_stratindex=1;                      %First loop starting index
    else
        Main_stratindex=sum(Mains_str_len(1:indexMain-1))+1; % incremental 
                                                             % start index
    end
    Main_endindex=sum(Mains_str_len(1:indexMain));%incremental ending index
    
    % Search current main folder
    sub_temp=dir([Main_folder,'\',Mains(Main_stratindex:Main_endindex)...
             ,'\',key]);
    
    % Spread returned suctured sub folders data into single vector arrays
    if isempty(sub_temp)
               subs=[subs];
            sub_str_len=[sub_str_len,0];
            isub_num=[isub_num, 0];
            sub_num(indexMain)=0;
    else
        for indexsubs=1:length(sub_temp)
          subs=[subs, sub_temp(indexsubs).name()]; %Update subfolders names
          sub_str_len=[sub_str_len,length(sub_temp(indexsubs).name())...
                                                ]; %Update subfolders 
                                                   %lengths
        end
    sub_num(indexMain)=length(sub_temp);     % Update number of sub folders 
                                             % in each main folder
    end

end

