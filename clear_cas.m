function []= clear_cas(Main_folder,Images_a_name)
fclose('all');
currentFolder = pwd;

config_file_number=cell2mat(regexp(Images_a_name,'\d*','Match')); %string
filename=['config_',config_file_number];

delete([currentFolder,'\' ,filename,'.cas']);
end