function [last_resolved]=getend(groups,Images_a)

for index=1:length(groups)
    if index == 1
        last_resolved(index)=Images_a(index).name;
    else
        last_resolved(index)=Images_a(sum(groups(1:index-1))+1).name;
    end
        
end

end