function [ FOVs,FOVs_num,FOVs_str_len, Tifts,Tifs_num,Tifs_str_len,...
                             Vectors,Vectors_num,Vectors_str_len  ]...
                             = Get_PIV_content(Main_folder,Runs,   ...
                             Runs_num,Runs_str_len)
%%
% Description:(created to be used explicitly by'PIV_scheduler.m')
% The function uses the input Main project directory and names of the Runs
% of the project defined by PIVscheduler to list all FOVs, images and
% resolved vectors in the project.
% The function returns data regading the content in string arrays.
% 
% Syntax:
% [ FOVs,FOVs_num,FOVs_str_len, Tifts,Tifs_num,Tifs_str_len,...
%                             Vectors,Vectors_num,Vectors_str_len  ]...
%                             = Get_PIV_content(Main_folder,Runs,   ...
%                             Runs_num,Runs_str_len)
%
% Inputs:
% Main_folder- Full path of the folder
% Runs- A single array of strings including the names of each Run in the 
%       project folder concatenated next to each other
% Runs_num- Number of Runs found in the project folder
% Runs_str_len- Array with the lengths of each returned Run name
%
% Outputs:
% FOVs- A single array of strings including the names of each FOV in the 
%       project folder concatenated next to each other
% FOVs_num- Number of FOV folders found in each Run
% FOVs_str_len- Array with the lengths of each returned FOV name
% Tifts-A single array of strings including the names of each .tif image 
%       in each FOV folder concatenated next to each other
% Tifs_num- Number of .tiff images found in each FOV folder
% Tifs_str_len- Array with the lengths of each returned .tif image name
%
%%
% Author: Weam Elsahhar
% Uinversity of Bristol
% email: we15226@bristol.ac.uk
% Website: http://www.
% May 2018; Last revision: 20-Aug-2018
%% Get FOVs folders data
[ FOVs,FOVs_num,FOVs_str_len ] = folder_contents( Main_folder,Runs,...
                               Runs_num,Runs_str_len,'FOV*');
%% Get .tif images data 
[ Tifts,Tifs_num,Tifs_str_len ] = sub_files_contents( ...
                            Main_folder,Runs,Runs_num,Runs_str_len,...
                            FOVs,FOVs_num,FOVs_str_len,'Renamed\*a.tif' );
%% Get resolved vectors data  
[ Vectors,Vectors_num,Vectors_str_len ] = sub_files_contents( ...
                            Main_folder,Runs,Runs_num,Runs_str_len,...
                            FOVs,FOVs_num,FOVs_str_len,'Vectors\*.plt' );                          
                           