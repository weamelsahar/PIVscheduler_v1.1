function [Images,failed]=get_tifs_a(Main_folder)

[Images]=dir([Main_folder,'\*a.tif']);
if isempty(Images)
    disp('EMPTY FOLDER:no *a.tif images in the folder');
    Images=[];
    failed=1;
end
failed =0;
end