function PIV_check_quality(dir_in)
tic
% PIV_check_quality
% This code is used to check the quality of a bluk of vector fields generated
% from PIV analysis
[Vectors]=get_vectors(dir_in);
Vindex=zeros(1,length(Vectors));

parfor index=1:length(Vectors)
    Vectors(index).name
    [Nko,Ntot]=VValidation([dir_in,'\',Vectors(index).name],1.3,0);
    validity=Nko/Ntot*100;
    disp(['Vector number:',Vectors(index).name,':Validity=',num2str(validity),'%\n']);
    
    if validity <35
        Vindex(index)=1;
    else
        Vindex(index)=0;
    end
    
    
    
end
if isempty(find(Vindex==0))
save([dir_in,'\Therearebadvectors.txt']);

end
end
save([dir_in,'\Vindex.mat'],'Vindex');

toc
end