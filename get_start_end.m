function[start_ind,end_ind]= get_start_end(index,str_len)
if  index==1
    start_ind=1;
else
    start_ind=sum(str_len(1:index-1))+1;
end

end_ind=sum(str_len(1:index));

end