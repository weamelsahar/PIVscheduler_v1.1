function [ last_resolved ] = get_current_end( Main_folder,Images_nums,groups_init,startimage,endimage)


[Vectors]=get_vectors(Main_folder);


if isempty(Vectors)
    for index=1:length(groups_init) 
        last_resolved(index)=nan;
    end
else
    
    for index=1:length(Vectors)
        Vectors_nums(index)=str2double(regexp(Vectors(index).name,'\d*','Match'));
    end
    
    
    for index=1:length(groups_init)
        grouptemp=[];
        grouptemp=startimage(index):1:endimage(index);
        last_resolved_temp=[];
        for index_vector=1:length(grouptemp)
            
            new_last_resolved_temp=Vectors_nums(Vectors_nums==grouptemp(index_vector));
            if isempty(new_last_resolved_temp)
                last_resolved_temp=last_resolved_temp;
            else
                if  isempty(last_resolved_temp)||(new_last_resolved_temp>last_resolved_temp)
                    last_resolved_temp=new_last_resolved_temp;
                else
                    
                    last_resolved_temp=last_resolved_temp;
                end
            end
        end
        if isempty(last_resolved_temp)
            last_resolved(index)=nan;
        else
            last_resolved(index)=last_resolved_temp;
        end
        fprintf(['Vector Group:',num2str(index),':',num2str(startimage(index)),' to ',num2str(endimage(index)),'\n']);
        fprintf(['Last vector found:',num2str(last_resolved(index)),'\n']);
        
    end
end

end

