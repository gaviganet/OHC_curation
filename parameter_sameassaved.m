function [diff]=parameter_sameassaved(Cm_low_saved,Cm_low,n)
% This function calculates the differrence between saved 
% value and currently calculated values for all parameters
for i=1:1:n
    diff(i,1)=abs(Cm_low_saved(i,1)-Cm_low(i,1));
end    
end
