function [Project_name,Run_name,FOV_name, Main_folder,failed]= Get_images_dir()
%% Get main project folder
%Get the main PIV project path through a dialouge box. A check is done
%until the user inputs a folder or ask to quit ('loop_for_folder_input.m').
Intial_prompt='Select main PIV project folder:';
no_input_prompt='You didn''t select the main PIV project folder:';
[ Main_folder,failed ] = loop_for_folder_input(Intial_prompt,...
                                               no_input_prompt);
if failed ==1
    Project_name=[];
    Main_folder=[];
    Run_name=[];
    FOV_name=[];
    return;
end
   
splitted = regexp(Main_folder,'\','split');           %Get last folder name
Project_name=splitted{2};                             %(Project name)
Run_name=splitted{3};
FOV_name=splitted{4};


% Print aquired project folder name
disp(['*******************Project:',Project_name,'*********************'...
      '*******']);                                     % Print project name
disp(['Project folder path:',Main_folder]);            % and project path
                                                    
% cd(Main_folder);                                       %Move to project dir
                                                       %makes it easier to
                                                       %find the runs
failed =0;

end