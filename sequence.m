function [groups]=sequence(Images_a)
count=0;
groups=[];
for index=1:length(Images_a)
    if index==1
        count= 1;
    else
        currentindex=str2num(cell2mat(regexp(Images_a(index).name,'\d*','Match')));
        previousindex=str2num(cell2mat(regexp(Images_a(index-1).name,'\d*','Match')));
        
        if ((currentindex - previousindex) ==1)                    % If the next image is in sequence example 837 - 838 and not crossing *998 - *999
            count = count+1;                                       % Increment number of images in group
            if floor(currentindex/1000)~=floor(previousindex/1000) % updtae groups and exit if Exit if crossed *999
                groups=[groups , count-1];                         
                count=1;
            end
            if index == length(Images_a)
                groups=[groups , count];
                count=0;
            end
        elseif count == 1                       %If next image is not in sequence and the number of images in the goup is only =1 
            groups=[groups , 1];                %Use 1 as a flg to add the next image because '.cas' can't configure 1 image only
            count=1;
        else
            groups=[groups , count];
            count=1;
        end
    end
end