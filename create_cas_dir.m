function filename=create_cas_dir(Main_folder,dir_out,startimage,endimage,index,Xres,Yres)
currentFolder = Main_folder;

filename=['config_group',num2str(index)];
fid = fopen([currentFolder,'\',filename,'.cas'], 'w' );

fprintf( fid, '*****Picture_parameters*****\n');
string=[Main_folder,'\',startimage(1:end-length('***a.tif'))];
fprintf( fid,'%s\n',string );

start_number_string=startimage(end-length('**a.tif'):end-length('a.tif'));
end_number_string=endimage(end-length('**a.tif'):end-length('a.tif'));
fprintf( fid,[num2str(str2num(start_number_string)),'\n']);
fprintf( fid,[num2str(str2num(end_number_string)),'\n']);

fprintf( fid,'%s\n','TIF');
fprintf( fid,'%s\n','1');
fprintf( fid,'%s\n',num2str(Xres));
fprintf( fid,'%s\n','1');
fprintf( fid,'%s\n',num2str(Yres));
fprintf( fid,'%s\n','96');
fprintf( fid,'%s\n','96');
fprintf( fid,'%s\n','2');
fprintf( fid,'%s\n','18');
fprintf( fid,'%s\n','18');
fprintf( fid,'%s\n','1.000000');
fprintf( fid,'%s\n','1.000000');
fprintf( fid,'%s\n','1.000000');
fprintf( fid,'%s\n','*****Processing_parameters*****');
fprintf( fid,'%s\n','no_raw');
fprintf( fid,'%s\n','no_centroid');
fprintf( fid,'%s\n','gaussian');
fprintf( fid,'%s\n','no_whittaker');
fprintf( fid,'%s\n','3');
fprintf( fid,'%s\n','3');
fprintf( fid,'%s\n','3');
fprintf( fid,'%s\n','3');
fprintf( fid,'%s\n','100');
fprintf( fid,'%s\n','3');
fprintf( fid,'%s\n','3');
fprintf( fid,'%s\n','2');
fprintf( fid,'%s\n','fft');
fprintf( fid,'%s\n','y');
fprintf( fid,'%s\n','3');
fprintf( fid,'%s\n','*****Validation_procedure_parameters*****');
fprintf( fid,'%s\n','y');
fprintf( fid,'%s\n','5.50000');
fprintf( fid,'%s\n','1.3');
fprintf( fid,'%s\n','4');
fprintf( fid,'%s\n','4');
fprintf( fid,'%s\n','1');
fprintf( fid,'%s\n','1.0000');
fprintf( fid,'%s\n','n');
fprintf( fid,'%s\n','*****Output_parameters*****');
fprintf( fid,'%s\n','tecplot');
fprintf( fid,'%s\n','tecplot');

string=[dir_out,'\bs',startimage((end-length('*****a.tif')):(end-length('***a.tif')))];
fprintf( fid,'%s\n',string );

fprintf( fid,'%s\n','no_map');
fprintf( fid,'%s\n','1');
fprintf( fid,'%s\n','1');
fprintf( fid,'%s\n','*****Optional_parameters*****');

string=[Main_folder,'\mask'];
fprintf( fid,'%s\n',string );

fprintf( fid,'%s\n','enabled');
fprintf( fid,'%s\n','1');
fprintf( fid,'%s\n','0.00000');
fprintf( fid,'%s\n','0.00000');

end