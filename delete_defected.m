
load('J:\PIV_TIFF_6mm\10msec\FOV1\Vectors\Vindex.mat')
inedxdel=find(Vindex==0);
for index=1:length(inedxdel)
    nzeros=5-length(num2str(inedxdel(index)));
    
    if nzeros==4; nz='0000'; end;
    if nzeros==3; nz='000'; end;
    if nzeros==2; nz='00'; end;
    if nzeros==1; nz='0'; end;
    if nzeros==0; nz=''; end;
    filename=['J:\PIV_TIFF_6mm\10msec\FOV1\Vectors\bs_',nz,num2str(inedxdel(index)),'.plt'];
    disp(['Deleting ...... :',filename]);
    delete(filename);
end