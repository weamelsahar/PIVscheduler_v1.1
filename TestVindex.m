clc
% load('J:\PIV_TIFF_6mm\10msec\FOV1\Vectors\Vindex.mat')
% bad1=length(find(Vindex==0));
% load('J:\PIV_TIFF_6mm\20msec\FOV1\Vectors\Vindex.mat')
% bad2=length(find(Vindex==0));
% load('J:\PIV_TIFF_6mm\30msec\FOV1\Vectors\Vindex.mat')
% bad3=length(find(Vindex==0));
% disp(['Bad vector fields:',num2str(bad1+bad2+bad3)]);
% 
% load('J:\PIV_TIFF_10mm\10msec\FOV1\Vectors\Vindex.mat')
% bad1=length(find(Vindex==0));
% load('J:\PIV_TIFF_10mm\20msec\FOV1\Vectors\Vindex.mat')
% bad2=length(find(Vindex==0));
% load('J:\PIV_TIFF_10mm\30msec\FOV1\Vectors\Vindex.mat')
% bad3=length(find(Vindex==0));
% disp(['Bad vector fields:',num2str(bad1+bad2+bad3)]);
% 
% 
% load('F:\PIV_TIFF_20mm\10msec\FOV1\Vectors\Vindex.mat')
% bad1=length(find(Vindex==0));
% load('F:\PIV_TIFF_20mm\20msec\FOV1\Vectors\Vindex.mat')
% bad2=length(find(Vindex==0));
% load('F:\PIV_TIFF_20mm\30msec\FOV1\Vectors\Vindex.mat')
% bad3=length(find(Vindex==0));
% disp(['Bad vector fields:',num2str(bad1+bad2+bad3)]);
% load('F:\PIV_TIFF_20mm\10msec\FOV2\Vectors\Vindex.mat')
% bad1=length(find(Vindex==0));
% load('F:\PIV_TIFF_20mm\20msec\FOV2\Vectors\Vindex.mat')
% bad2=length(find(Vindex==0));
% 
% 
% % load('F:\PIV_TIFF_20mm\30msec\FOV2\Vectors\Vindex.mat')
% % bad3=length(find(Vindex==0));
% disp(['Bad vector fields:',num2str(bad1+bad2)]);


load('F:\PIV_TIFF_34mm\10msec\FOV1\Vectors\Vindex.mat')
bad1=length(find(Vindex==0));
load('F:\PIV_TIFF_34mm\20msec\FOV1\Vectors\Vindex.mat')
bad2=length(find(Vindex==0));
load('F:\PIV_TIFF_34mm\30msec\FOV1\Vectors\Vindex.mat')
bad3=length(find(Vindex==0));
disp(['Bad vector fields:',num2str(bad1+bad2+bad3)]);
load('F:\PIV_TIFF_34mm\10msec\FOV2\Vectors\Vindex.mat')
bad1=length(find(Vindex==0));
load('F:\PIV_TIFF_34mm\20msec\FOV2\Vectors\Vindex.mat')
bad2=length(find(Vindex==0));
load('F:\PIV_TIFF_34mm\30msec\FOV2\Vectors\Vindex.mat')
bad3=length(find(Vindex==0));


% load('F:\PIV_TIFF_20mm\30msec\FOV2\Vectors\Vindex.mat')
% bad3=length(find(Vindex==0));
disp(['Bad vector fields:',num2str(bad1+bad2+bad3)]);

