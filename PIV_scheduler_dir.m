function [doneflag]=PIV_scheduler_dir(dir_in,dir_out,Xres,Yres,nWorkers)
%% PIV_scheduler
%   Introduction:
%
%   Project files structures:
%   This piece of Matlab script can be used to schedule PIV (particle image
%   velocimetry) vector feild extraction. The code implements a C based ex-
%   ecutable for vector field image extraction developed in Von Karman ins-
%   titute by F.Scarano "widim33_2.exe".(To be used only at the University-
%   of Bristol) You have to place "widim33_2.exe" in the same folder along-
%   with this function PIV_scheduler_dir.
%   Please refer to (r.theunissen@bristol.ac.uk, from:F.Scarano@tudelft.nl)
%   for the latter dependency and further permissions.
%   The fucntion schedules multiple vector extracting threads runing on 
%   sepearate workers/CPU-cores. The scheduler can be used to work with 
%   projects exported from PIV measurment tools (eg. DynamicStudio/Dantec).
%   
%   The following is a list of tasks preformed by runing this fuction: 
%   *The fuction automatically looks into two input directories: 
%       1- Image pairs directory 
%       2- Extracted vector fields directory
%   The checkes
%   the  according to the 
%
%  Inputs:
%   dir_in:  Image pairs directory. The each image pair needs to be indexed
%            as follows:
%            ****_****a.tif, ****_****b.tif (eg. run_00523a.tif, run_00523b.tif)
%            Note: Maximum tag number of digits is 5 (eg. run_99999a.tif)
%   
%   dir_out: Resolved vectors directory. Unless already created newly resolved 
%            vectors will be named as follows:
%            bs_*******.plt (****** will represent the tag number taken 
%            from the coressponding image pair)
%  Xres: width resolution of the images (Note to self : modify the code to
%        extract automatically)
%  Yres: hight resolution of the images (Note to self : modify the code to
%        extract automatically)
%  
%  nWorkers: Number of workers to use. Number of threads to run on indvidual 
%            CPU cores. (Note to self: modify the code to Auto detect the 
%            number of cores available and show errors when exceeded)  
%           
%
%  Outputs:
%   Resolved vector fields files
%   dir_out>>bs_****.plt,
%
%  Other m-files required: Get_PIV_paths.m, sub(loop_for_folder_input) ( note to self List
%  all here)
%  Other non Matlab files required: widim33_2.exe

% Author: Weam Elsahhar
% Uinversity of Bristol
% email: we15226@bristol.ac.uk
% Website: https://github.com/weamelsahar/PIVscheduler_v1.1Z
% May 2018; Last revision: 17-oct-2018

%------------- BEGIN CODE --------------

close all
clc

% disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
% disp('%                                                                %');
% disp('% COPYRIGHT : WEAM ELSAHHAR - UNIVERSITY OF BRISTOL              %');
% disp('%                                                                %');
% disp('% THIS CODE REMAINS PROPERTY OF WEAM ELSAHHAR AND MAY NOT BE     %');
% disp('% DISTRIBUTED WITHOUT PRIOR CONSENT OF THE AUTHOR.               %');
% disp('%                                                                %');
% disp('% PLEASE FEEL FREE TO REPORT ANY BUGS TO :we.15226@bristol.ac.uk %');
% disp('%                                                                %');
% disp('% Bristol, July 2018                                             %');
% disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
% disp(' ');

%% Get paths:
% Get the path of the main project folder from the user and ask for includ-
% ed Runs
[Project_name,Run_name,FOV_name, Main_folder,failed]= Get_images_dir_in(dir_in);

if failed ==1
    disp('Error:Folder selection failed')
    return;
end
doneflag=0;
my_firsttime=1; %:D
Prog_bar=waitbar(0,'Starting....');
while(doneflag~=1)

%% Get information lsiting the image pairs content of the project:
% Search for the project content of image pairs and returns files
% arrangment according to the porject structure in the definition of this
% script
[Images_a,failed1]=get_tifs_a(Main_folder);
[Images_b,failed2]=get_tifs_b(Main_folder);
Total_images_num=length(Images_a);

if (failed1 ==1) || (failed2 ==1) 
    disp('Error:Images selection failed');
    return;
end

if length(Images_a) ~= length(Images_b);
   disp('Warning:Images missing from some image pairs');
   return; 
end

[Vectors]=get_vectors(dir_out);


%% Print out project content and completion precentage
disp([num2str(length(Images_a)),': image pairs were found']);
disp([num2str(length(Vectors)),' resolved vectors were found ....',num2str(length(Vectors)/length(Images_a)*100),'%']);



%% Remove images from list for coressponding resolved vectors
[Images_a,Images_b]=removedone(Images_a,Images_b,Vectors);

%% Create sequential cases and return group sizes for .cas files
if length(Images_a)>100
    opt_Gsize=floor(length(Images_a)/nWorkers);  % Optimal group size
    [groups]=sequence_opt(Images_a,opt_Gsize);
else
    [groups]=sequence_opt(Images_a,1000);
end

if my_firsttime==1
    for index=1:length(groups)
        index_killed(index)=true;
    end
else
    
end

%% Create configuration .cas file for each image pair and run "widim_33_2.exe"  
% cd 'E:\PIV\PIVscheduler_v1.1'

disp('List of .cas files groups:')
for index=1:length(groups)
    if index == 1
        startimage_index=Images_a(index).name;
    else
        startimage_index=Images_a(sum(groups(1:index-1))+1).name;
    end
    if (groups(index)==1)
        endimage_temp=Images_a(sum(groups(1:index-1))+1).name;
        Lastnumber=str2double(endimage_temp(end-length('a.tif')))+1;
        if Lastnumber==10
            startimage_index(end-length('a.tif'))=num2str(Lastnumber-2);
        else
            endimage_temp(end-length('a.tif'))=num2str(Lastnumber);
        end
        
        endimage_index=endimage_temp;
    else
        endimage_index=Images_a(sum(groups(1:index))).name;
    end
        filename{index}=create_cas_dir(Main_folder,dir_out,startimage_index,endimage_index,index,Xres,Yres);
   
        disp(['Group:',num2str(index),':',startimage_index,' to ',endimage_index]);
        startimage(index)=str2double(regexp(startimage_index,'\d*','Match'));
        endimage(index)=str2double(regexp(endimage_index,'\d*','Match'));
end
for index=1:length(Images_a)
    Images_nums=str2double(regexp(Images_a(index).name,'\d*','Match'));
end

fclose('all');
if length(groups)>nWorkers
    groupstorun=nWorkers; %maximum number of groups to run
else
    groupstorun=length(groups);
end

if (groupstorun)==0
    disp('Postprocessing complete  :)')
    return
end

% Set the required hex indexing for each of the 7 processors for parallel
% computing
%%Note: You need to optimise the use of preocessors by dividing the number
%%of groups/per avialbe processor. For now, I hard coded the following indecies 
% for 1600 images where each group utlizes 3 processors
Processorslist={'0x01'; '0x02';'0x04'; '0x08';'0x10'; '0x20'};

for index=1: groupstorun
   
    if index_killed(index)==true
        
        eval(['!start /affinity ',Processorslist{index},' "group',Project_name,Run_name,FOV_name,num2str(index),'" .\widim33_2.exe ',Main_folder,'\',cell2mat(filename(index))]);
        pause(20);

        index_killed(index)=false;
    else
    end
end
timeout=140;
kill_flag=0;


progress=length(Vectors)/Total_images_num;
progress_message=sprintf(['PIV (',num2str(progress*100),') precent completed in\n',Project_name,':',Run_name,':',FOV_name]);
progress_message(progress_message=='_')=' ';
waitbar(progress,Prog_bar,progress_message);

while (kill_flag==0)
    Vectors1=length(get_vectors(dir_out));
    [ last_resolved ] =get_current_end( dir_out ,Images_nums,groups,startimage,endimage);
    disp('Start time out')
    pause(timeout);
    Vectors2=length(get_vectors(dir_out));
    [ current_last_resolved ] = get_current_end( dir_out,Images_nums,groups,startimage,endimage);
    
    Date_time=(clock);
    disp(['PIV timed out @', num2str(Date_time(4)),':',...
        num2str(Date_time(5)),'---',num2str(Date_time(3)), ....
        '/',num2str(Date_time(2)),'/',num2str(Date_time(1))]);
    if length(last_resolved)==length(current_last_resolved)
       for index=1:length(last_resolved)
            if isnan(last_resolved(index))&& isnan(current_last_resolved(index))
                
                fprintf(['In group:',num2str(index),' Last vector  before time out ',num2str(last_resolved(index)),'\n']);
                fprintf(['In group:',num2str(index),' Last vector  after time out ',num2str(current_last_resolved(index)),'\n']);
                fprintf(['Terminate group:',num2str(index),'\n']);
                eval(['!taskkill /FI "WindowTitle eq group',Project_name,Run_name,FOV_name,num2str(index),'"']);
                eval(['!taskkill /FI "WindowTitle eq group widim33_2.exe"']);
                eval(['!taskkill /FI "IMAGENAME eq WerFault.exe"']);
                index_killed(index)=true;
                kill_flag=1;
                
            elseif isnan(last_resolved(index))&& ~isempty(current_last_resolved(index))
                
                fprintf(['In group:',num2str(index),' Last vector  before time out ',num2str(last_resolved(index)),'\n']);
                fprintf(['In group:',num2str(index),' Last vector  after time out ',num2str(current_last_resolved(index)),'\n']);
                fprintf('Good continue\n');
                index_killed(index)=false;
            
            elseif  current_last_resolved(index)>last_resolved(index)
                
                fprintf(['In group:',num2str(index),' Last vector  before time out ',num2str(last_resolved(index)),'\n']);
                fprintf(['In group:',num2str(index),' Last vector  after time out ',num2str(current_last_resolved(index)),'\n']);
                fprintf('Good continue\n');
                index_killed(index)=false;
            
            elseif current_last_resolved(index)==endimage(index) 
            
                kill_flag=1;
            
            else
                
                fprintf(['In group:',num2str(index),' Last vector  before time out ',num2str(last_resolved(index)),'\n']);
                fprintf(['In group:',num2str(index),' Last vector  after time out ',num2str(current_last_resolved(index)),'\n']);
                fprintf(['Terminate group:',num2str(index),'\n']);
                eval(['!taskkill /FI "WindowTitle eq group',Project_name,Run_name,FOV_name,num2str(index),'"']);
                eval(['!taskkill /FI "WindowTitle eq group widim33_2.exe"']);
                eval(['!taskkill /FI "IMAGENAME eq WerFault.exe"']);
                index_killed(index)=true;
                kill_flag=1;
            
            end
        end
    else
         fprintf(['Number of groups os different from _previous number of groups \',...
         '(Probably one group finished)']);
         kill_flag=1;
    end

[Vectors_prog]=get_vectors(dir_out);    
progress=length(Vectors_prog)/Total_images_num;
progress_message=sprintf(['PIV (',num2str(progress*100),') precent completed in\n',Project_name,':',Run_name,':',FOV_name]);
progress_message(progress_message=='_')=' ';
waitbar(progress,Prog_bar,progress_message);
end
   index_killed;
   my_firsttime=my_firsttime+1;
%    if Vectors2 < Vectors1+2
%        Date_time=(clock);
%        disp(['PIV timed out @', num2str(Date_time(4)),':',...
%            num2str(Date_time(5)),'---',num2str(Date_time(3)), ....
%            '/',num2str(Date_time(2)),'/',num2str(Date_time(1))]); 
%        for index=1:length(groups)
%            eval(['!taskkill /FI "WindowTitle eq group',Project_name,Run_name,FOV_name,num2str(index),'"']);
%        end
%       kill_flag=1;
%    end
   [Images2,failed]=get_tifs_a(Main_folder);
   disp([num2str((Vectors2)),' resolved vectors were found ....',num2str((Vectors2)/length(Images2)*100),'%']);


 if length (Vectors2)>= length(Images2)
    doneflag=1; 
 end
end
clear all
end