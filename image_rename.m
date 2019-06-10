
clc 
clear all
close all
folder = 'C:\Users\fq\Desktop\calibration_v23\20160726\serial1';
files = dir([folder '\*.bmp']);
for i = 1 : numel(files)
    oldname = files(i).name;
    I = imread(oldname);
    %[pathstr, name, ext] = fileparts(oldname) ;
    if i<10
        newname = strcat('cam0',num2str(i),'.bmp');
        imwrite(I,newname,'bmp');
    elseif i>=10
        newname = strcat('cam',num2str(i),'.bmp');
        imwrite(I,newname,'bmp');
    end
end