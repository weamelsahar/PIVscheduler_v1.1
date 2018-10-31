function [Project_name,Run_name,FOV_name, Main_folder,failed]= Get_images_dir_in(Main_folder)
%% Get main project folder
%Get the main PIV project directories
failed =1; 
% if failed ==1
%     Project_name=[];
%     Main_folder=[];
%     Run_name=[];
%     FOV_name=[];
%     return;
% end
   
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