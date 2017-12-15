function [rootsb,b,Rs,Rm,Cm_low,Cm_high]=calculate_b_Rm_Rs_Cm(Imlf,Imhf,Relf,Rehf,f_low,f_high,n) 
% calculate cell properties from the measured admittance assuming membrane capacitance
% is in parallel with membrane resistance and both are in series with access resistance
% 
% declare memory
b=zeros(n,1); %conductance
Rs=zeros(n,1); % calculate the value with 2f
Rm=zeros(n,1); % calculate the value with 1f term
Cm_low=zeros(n,1); % membrane capacitance low frequency
Cm_high=zeros(n,1); % membrane capacitance high frequency
sterm=zeros(n,1); % square term of quadratic expression
lterm=zeros(n,1); % linear term of quadratic expression
cterm=zeros(n,1); % constant term of quadratic expression
rootsb=zeros(n,2);
% Write b in terms of a quadratic equation with three terms: square, linear and constant in
% this case the second root is the solution 
 for i=1:1:n
% the three terms are     
sterm(i,1)=(Rehf(i,1)-Relf(i,1)); % square term
lterm(i,1)=(Relf(i,1).^(2)+Imlf(i,1).^(2))-(Rehf(i,1).^(2)+Imhf(i,1).^(2)); % linear term
cterm(i,1)=Relf(i,1)*(Rehf(i,1).^(2)+Imhf(i,1).^(2))-Rehf(i,1)*(Relf(i,1).^(2)+Imlf(i,1).^(2)); %constant term
 p=[sterm(i,1) lterm(i,1) cterm(i,1)];
% find roots
rootsb(i,1:1:2)=roots(p);
b(i,1)=abs(rootsb(i,2)); % this is the calculated conductance units of Siemens
% calculate cell parameters with equations 
Rs(i,1)=((Rehf(i,1)-b(i,1))/((Rehf(i,1).^2)+(Imhf(i,1).^2)-Rehf(i,1)*b(i,1)))*1E-6; %units of Mohm Eq.1.25
Rm(i,1)=((1/b(i,1))*((Relf(i,1)-b(i,1)).^2+Imlf(i,1).^2)/((Relf(i,1).^2)+(Imlf(i,1).^2)-Relf(i,1)*b(i,1)))*1E-6; %units of Mohm Eq.1.24;
Cm_low(i,1)=((((1/(2*pi*f_low*Imlf(i,1)))*(Relf(i,1).^(2)+Imlf(i,1).^(2)-Relf(i,1)*b(i,1)).^2)*(1/((Relf(i,1)-b(i,1)).^2+(Imlf(i,1)).^2)))*1E12);%units of pF Eq.1.23
Cm_high(i,1)=((((1/(2*pi*f_high*Imhf(i,1)))*(Rehf(i,1).^2+Imhf(i,1).^2-Rehf(i,1)*b(i,1)).^2)*(1/((Rehf(i,1)-b(i,1)).^2+(Imhf(i,1)).^2)))*1E12);%units of pF Eq.1.23
end
end

