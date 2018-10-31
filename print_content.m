function []=print_content(Project_name,Main_folder,Runs,Runs_num,...
                   Runs_str_len,FOVs,FOVs_num,FOVs_str_len,Tifts,...
                       Tifs_num,Tifs_str_len,Vectors,Vectors_num,...
                                                   Vectors_str_len);

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp(['%                     %',Project_name,'%                       %']);
disp('------------------------------------------------------------------');
for indexRun=1:Runs_str_len
    [start_Run,end_Run]= get_start_end(indexRun,Runs_str_len);
    disp(['>>',Runs(start_Run:end_Run)]);
    
    for indexFOV=1:FOVs_str_len
        [start_FOV,end_FOV]= get_start_end(indexFOV,FOVs_str_len);
        disp(['>>>>>>>>>>',FOVs(start_FOV:end_FOV),':']);
        for indexTif=1:
            disp(['>>>>>>>>>>contains >>',Tifs_num(indexFOV),...
                                               ' image pairs']);
        end
    end
end
end