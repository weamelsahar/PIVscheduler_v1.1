function [Images,failed]=get_tifs_b(Main_folder)

[Images]=dir([Main_folder,'\*b.tif']);
if isempty(Images)
    disp('EMPTY FOLDER:no *b.tif images in the folder');
    Images=[];
    failed=1;
end
failed =0;
end