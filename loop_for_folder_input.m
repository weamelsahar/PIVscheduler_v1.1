function [ Main_folder,failed ] = loop_for_folder_input(prompt1,prompt2)
%% 
% Description:
% The function asks the user to input a folder path through a dialouge box.
% If the user cancels the function will keep asking for an input or permis-
% son to quit.  
% The promprts (propmt1 and prompt2) for the intial message and the looping 
% request are given as 'string' inputs to the functions.  
% THe function returns the folder full path.
%
% Syntax:
% [Main_folder]=loop_for_folder_input(prompt1,prompt2)
% 
% Inputs:
% prompt1- Intial request message (e.g 'Select PIV project folder:')
% prompt2- Looping request message (e.g 'You didn''t select the PIV project
%                                   folder:')
% Outputs:
% Main_folder- Full path of the folder
% failed flag

%%
% Author: Weam Elsahhar
% Uinversity of Bristol
% email: we15226@bristol.ac.uk
% Website: http://www.
% May 2018; Last revision: 19-Aug-2018
%%
failed=0;
disp(prompt1);
Main_folder = uigetdir();                        %Get main folder
if (Main_folder==0)                              %If the user didn't input
    Flag='y';
    while ~strcmp(Flag,'n')                      %Loop for input or quit
        fprintf([prompt2,'\n']);
        Flag=lower(input(['Would you like to try again(Y) or quit(N)?(Y'...
        '/N)'],'s'));                            %Asks to try again or quit
        
        if ~(strcmp(Flag,'n')||strcmp(Flag,'y')) %The user didn't input Y                                                     
            fprintf('Invalid input!\n');         %or n as a choice   
        elseif strcmp(Flag,'y')
            Main_folder = uigetdir();  %Get folder if user tried again
            if Main_folder==0;         %If the user didn't input again :|!!
                Flag='y';              %Set flag to keep looping
            end
        else
            Flag='n';                  %The user chose to quit
            failed=1;                   
            return;                    %break execution
        end   
    end
end

end

