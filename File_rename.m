function File_rename(im_direc,target_direc)

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp('%                                                                         %');
disp('% COPYRIGHT : RAF THEUNISSEN - UNIVERSITY OF BRISTOL                      %');
disp('%                                                                         %');
disp('% THIS CODE REMAINS PROPERTY OF RAF THEUNISSEN AND MAY NOT BE DISTRIBUTED %');
disp('% WITHOUT PRIOR CONSENT OF THE AUTHOR.                                    %');
disp('%                                                                         %');
disp('% PLEASE FEEL FREE TO REPORT ANY BUGS TO : R.Theunissen@bristol.ac.uk     %');
disp('%                                                                         %');
disp('% Bristol, September 2014                                                 %');
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
rootname='run_'; %rootname of the renamed images



%----------------------------------------------------------------------------------
%----------------------------------------------------------------------------------
%------------                         CODE                           -------------
%----------------------------------------------------------------------------------
%----------------------------------------------------------------------------------

%%RENAMING THE IMAGES
%change director
eval(['cd ','(im_direc)'])
%find all the tif files
[A] = dir('*.tif');
%number of images
bf = size(A,1);
%Start splitting the image and changing the name
parfor i=1:size(A,1);
    %get file name
    file = A(i,:).name;
    %deterimine the number of frames and bitdepth
    bf              = imfinfo(file);
    Nframes         = size(bf,1);
    bitdpth         = bf(1).BitDepth;
    %define the new filename
    filenum=str2num(cell2mat(regexp(file,'\d*','Match')));
    
    if filenum>=0; nz='0000'; end;
    if filenum>=10; nz='000'; end;
    if filenum>=100; nz='00'; end;
    if filenum>=1000; nz='0'; end;
    if filenum>=10000;
        nz='';
    end;
    newfile=[target_direc,'\',rootname,nz,num2str(filenum)]
    %Read each frame and store it
    for nf=1:Nframes
        %read the nf frame of the image
        Im = double(imread(file,nf));
        
        %define the extention
        ext='a.tif';
        if nf==2; ext='b.tif';
            %shift image frame if shifted
%                             if logical(sum(filenum == [1:175, 401 575 801 975 1201 1375]))
%                                 Im=circshift(Im,[0 -64]);
%                             end
        end
        %store the image
        if bitdpth==8;
            imwrite(uint8(Im),[newfile,ext]);
        elseif bitdpth==16;
            imwrite(uint16(Im),[newfile,ext]);
        end
    end
    disp([file,' renamed']);
    %     deletefilename=['E:\Weam_Bluff_Body_2018_52mm\52mm\30msec\FOV2\data\',file];
    %     delete (deletefilename)
end
end

