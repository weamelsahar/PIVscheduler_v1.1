function [Images_a,Images_b]=removedone(Images_a,Images_b,Vectors)
Image_temp=Images_a;
Vectors_temp=Vectors;
for index=1: length(Image_temp)
    Image_temp_cells(index)=str2num(cell2mat(regexp(Image_temp(index).name,'\d*','Match')));
end

for index=1: length(Vectors_temp)
    Vectors_temp_cells(index)=str2num(cell2mat(regexp(Vectors_temp(index).name,'\d*','Match')));
end

if isempty(Vectors_temp)
    Images_a=Images_a;
    Images_b=Images_b;
else
    for index=1:length(Vectors_temp)
        temp=find(Image_temp_cells==Vectors_temp_cells(index));
        if isempty(temp)
            
        else
            Index_done(index)=temp;
            
        end
    end
    
    Images_a(Index_done)=[];
    Images_b(Index_done)=[];
end

end