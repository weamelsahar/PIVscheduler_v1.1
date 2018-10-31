function [Project_name, Main_folder,Runs,Runs_num,Runs_str_len, failed] ...
                                                          = Get_PIV_paths()
%% 
% Description:(created to be used explicitly by'PIV_scheduler.m')
% A small routine that uses dialouge boxes to get the path of the main 
% PIV project from the user and asks for the included Runs in the project.
% 
% Syntax:
% [Project_name, Main_folder,Runs,Runs_num,Runs_str_len,failed]=...
%                                                   Get_PIV_paths()
% 
% Inputs:
% No inputs passed. Folder names will be collected using user interface.
%
% Outputs:
% Project_name- the name of the POV
% Main_folder- Full path of the project
% Runs- A single array of strings including the names of each Run in the 
%       project folder concatenated next to each other
% Runs_num- Number of Runs found in the project folder
% Runs_str_len- Array with the lengths of each returned Run name
% failed- A that is returned =1 if the process was interrupted
%%
% Author: Weam Elsahhar
% Uinversity of Bristol
% email: we15226@bristol.ac.uk
% Website: http://www.
% May 2018; Last revision: 19-Aug-2018

%% Get main project folder
%Get the main PIV project path through a dialouge box. A check is done
%until the user inputs a folder or ask to quit ('loop_for_folder_input.m').
failed =0;
Intial_prompt='Select main PIV project folder:';
no_input_prompt='You didn''t select the main PIV project folder:';
[ Main_folder,failed ] = loop_for_folder_input(Intial_prompt,...
                                               no_input_prompt);
if failed ==1
    return;
end
   
splitted = regexp(Main_folder,'\','split');           %Get last folder name
Project_name=splitted{2};                             %(Project name)


% Print aquired project folder name
disp(['*******************Project:',Project_name,'*********************'...
      '*******']);                                     % Print project name
disp(['Project folder path:',Main_folder]);            % and project path
                                                    
cd(Main_folder);                                       %Move to project dir
                                                       %makes it easier to
                                                       %find the runs

%% Get Runs folders
%Get the all the runs in the main PIV project path through a dialouge box. 
% A check is done until the user inputs at least one folder or asks to quit 
% ('loop_for_folder_input.m'). 

Runs=[];                                    %Define empty Run names array
Intial_prompt='Select Runs folders:';
no_input_prompt='You didn''t select any run folders:';
[Temp_Run,failed ] = loop_for_folder_input(Intial_prompt,no_input_prompt);
if failed ==1
    return;
end
index_last = find(Temp_Run=='\',1,'Last');  %Last folder name sart index
Temp_Run=Temp_Run(index_last+1:end);        %(Run name)

Runs= [Runs, Temp_Run];                     %concatenate name to Run names 
                                            %array 
Runs_str_len(1)=length(Temp_Run);           %Array with the lengths of each
                                            %Run path
Runs_num=1;                                 %Intial number of Runs

% Check if the user wants to input more run folders and get them
Flag='y';
while ~strcmp(Flag,'n')    
    Flag=lower(input('Would you like to add more cases?(Y/N)','s'));
    if ~(strcmp(Flag,'n')||strcmp(Flag,'y'))
        disp('Invalid input!');
    elseif strcmp(Flag,'y')
        [Temp_Run,failed ] = loop_for_folder_input(Intial_prompt,...
                                                   no_input_prompt);
        if failed ==1
            return;
        end
        index_last = find(Temp_Run=='\',1,'Last');   %Get last folder name
        Temp_Run=Temp_Run(index_last+1:end);         %(Run name)
        Runs= [Runs, Temp_Run];
        Runs_num = Runs_num+1;
        Runs_str_len(Runs_num)=length(Temp_Run); %Array with the lengths of 
                                                 % each Run name
    else
        Flag='n';
    end
end


end

