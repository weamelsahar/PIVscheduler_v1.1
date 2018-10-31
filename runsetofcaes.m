% [doneflag]=PIV_scheduler_dir('G:\PIV_TIFF_50mm\10msec\FOV2\Renamed','J:\PIV_TIFF_50mm\10msec\FOV2\Vectors',3528,2072,6)
% [doneflag]=PIV_scheduler_dir('G:\PIV_TIFF_50mm\20msec\FOV1\Renamed','J:\PIV_TIFF_50mm\20msec\FOV1\Vectors',2072,2072,6)
% [doneflag]=PIV_scheduler_dir('G:\PIV_TIFF_50mm\20msec\FOV2\Renamed','J:\PIV_TIFF_50mm\20msec\FOV2\Vectors',3528,2072,6)
% [doneflag]=PIV_scheduler_dir('G:\PIV_TIFF_50mm\30msec\FOV1\Renamed','J:\PIV_TIFF_50mm\30msec\FOV1\Vectors',2072,2072,6)
% [doneflag]=PIV_scheduler_dir('G:\PIV_TIFF_50mm\30msec\FOV2\Renamed','J:\PIV_TIFF_50mm\30msec\FOV2\Vectors',3528,2072,6)

clear all
close all
clc
% 
% PIV_check_quality('F:\PIV_TIFF_34mm\10msec\FOV1\Vectors')
% PIV_check_quality('F:\PIV_TIFF_34mm\10msec\FOV2\Vectors')
% PIV_check_quality('F:\PIV_TIFF_34mm\20msec\FOV1\Vectors')
% PIV_check_quality('F:\PIV_TIFF_34mm\20msec\FOV2\Vectors')
% PIV_check_quality('J:\PIV_TIFF_50mm\10msec\FOV1\Vectors')
% PIV_check_quality('J:\PIV_TIFF_50mm\10msec\FOV2\Vectors')
% PIV_check_quality('J:\PIV_TIFF_50mm\20msec\FOV1\Vectors')
% PIV_check_quality('J:\PIV_TIFF_50mm\20msec\FOV2\Vectors')
% PIV_check_quality('J:\PIV_TIFF_50mm\30msec\FOV1\Vectors')
% PIV_check_quality('J:\PIV_TIFF_50mm\30msec\FOV2\Vectors')

[doneflag]=PIV_scheduler_dir('J:\PIV_TIFF_6mm\10msec\FOV1\Renamed','J:\PIV_TIFF_6mm\10msec\FOV1\Vectors',2072,2072,6);
PIV_check_quality('J:\PIV_TIFF_6mm\10msec\FOV1\Vectors')
