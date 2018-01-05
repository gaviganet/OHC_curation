%function check_cell_parameters()
% This script determines the calculated cell parameters from admittance
% measurements that were measured with admittance 2-sine technique. It compares the
% measurements saved with the values re-calculated upon solving quadratic
% equation with roots function avilable within MATLAB.  It then calculates the
% difference between the two values and plots the absolute value of the difference with respect to time. Six
% subplots are shown.  The first suplot shows the DC voltage which is stimulus. The second is conductance,
% the third and fourth is capacitance determined at low frequency and high frequency.
% The fifth and sixth is membrane and series resistance. 
% This script calls
% two functions.  The first calculates the conductance, (b) the membrane capacitance determined at low (Cm_low) and high (Cm_high)frequency 
% the series resistance, (Rs) and membrane resistance (Rm) from the real (Relf, Rehf() and imaginary (Imlf,Imhf) components of the admittance.   
%[rootsb,b,Rs,Rm,Cm_low,Cm_high]=calculate_b_Rm_Rs_Cm(Imlf(:,1),Imhf(:,1),Relf(:,1),Rehf(:,1),f_low,f_high,n);
% The second calculates the difference (diff) between the original saved data (parameter_saved) and the
% re-calculated value (parameter_calculated) in this MATLAB program with
%[diff]=parameter_sameassaved(parameter_saved,parameter_calculated,n);

        % User needs to point to the correct folder where the data is stored 
        % change line 39 of code and replace with correct path and directory. 
        % Change name of MAT file where data is stored.
        % Change path and directory where the scripts and M files are stored on PC
        % i.e. line 44 and 45 of code.
        
% This data was collected with 16 bit resolution DAQ card
% PCI-6052E and manipulated in LabView (v6.1 to 8).  We used National Instrument traditional drivers to do this.  The data was processed with LabView and
% saved as a spreadsheet and imported into Microsoft Excel (Office version 2003 and
% and then later versions) and then later manipulated in MATLAB. During this period the resolution varied 
% via the version of Windows and Office used. It changed  
% from 16 bit card (National Instruments) on a Windows machine (XP, 2000, Windows 7). The original data was saved as 
% a spreadsheet to be viewed with Microsoft Excel this was initially (8 bit) then later (16 bit). Likewise this data was manipulated with MATLAB where
% we have used 32 bit (version)and now 64 bit (version).  This change among environments affects the magnitude of the digital
% numbers stored and demonstrates the need to monitor them moving forward.
% This script is goverened by license CC BY-NC 3.0 https://creativecommons.org/licenses/by-nc/3.0/
% Revised by Brenda Farrell january 5th 2018

%  Load data as an array of structs into memory.  The data loaded is the data generated from translating HDF5 to MATLAB this can have 1 to 89 arrays
close all % remove all figures
clear % clear memory
pathsavedata=('Y:\OHC_Data\Data for portal\Specimen');
genpath('pathsavedata');
cd(pathsavedata);
load(strcat('array_of_hdf52mat_out','.mat'));

pathfunctions=('C:\Users\bfarrell\Documents\M files\OHC analysis\HDF5format\final functions\Package');
cd(pathfunctions)

% Transfer the data into floats from structure to calculate parameters 
k=1; % This is number of the structure within array of structs you are looking at change this to look at other data
% values measured during an experiment
Imlf=array_of_hdf52mat_out(1,k).Imlf_Y_;
Imhf=array_of_hdf52mat_out(1,k).Imhf_Y_;
Relf=array_of_hdf52mat_out(1,k).Relf_Y_;
Rehf=array_of_hdf52mat_out(1,k).Rehf_Y_;
f_low=array_of_hdf52mat_out(1,k).stimulatingFrequency(1,1);
f_high=array_of_hdf52mat_out(1,k).stimulatingFrequency(2,1);
voltage=array_of_hdf52mat_out(1,k).voltage;
time=array_of_hdf52mat_out(1,k).time;
cellnumber=array_of_hdf52mat_out(1,k).originalCellNumber;
phenotype=array_of_hdf52mat_out(1,k).phenotype;
sex=array_of_hdf52mat_out(1,k).sex;
researcher=array_of_hdf52mat_out(1,k).researcher;

% values calculated and saved from the original measurements
Cm_low_saved=array_of_hdf52mat_out(1,k).Cmlf;
Cm_high_saved=array_of_hdf52mat_out(1,k).Cmhf;
Rs_saved=array_of_hdf52mat_out(1,k).Rs;
Rm_saved=array_of_hdf52mat_out(1,k).Rm;
b_saved(1:1:length(Imlf),1)=(Rs_saved(1:1:length(Imlf),1)*1E6+Rm_saved(1:1:length(Imlf),1)*1E6).^(-1);
n=length(Imlf);
i=1;

% This part ensuring there are no zero values or NaN within array
while(i<n)
    if(Imlf(i,1)~=0||isnan(Imlf(i,1)~=1))
        i=i+1;
    else
        n=i;
    end 
 end
 n=n-1;   
 
for i=1:1:n
    Cm_measured_lowb(i,1)=(Relf(i,1).*Relf(i,1))/(2*pi*f_low*Imlf(i,1))*1E12;% this is capacitance low frequency approximation in pF
    Cm_measured_highb(i,1)=(Rehf(i,1).*Rehf(i,1))/(2*pi*f_high*Imhf(i,1))*1E12; % this is capacitance high frequency approximation in pF
    Cm_measured_low=Imlf(i,1)/(2*pi*f_low)*1E12; % this is the measured capacitance low frequency approximation in pF
    Cm_measured_high=Imhf(i,1)/(2*pi*f_high)*1E12; % this is the measured capacitance high frequency in pF
end

% Determine the conductance, b membrane resistance, Rm, series resistance, Rs and capacitance, C at both frequencies 
[rootsb,b,Rs,Rm,Cm_low,Cm_high]=calculate_b_Rm_Rs_Cm(Imlf(:,1),Imhf(:,1),Relf(:,1),Rehf(:,1),f_low,f_high,n);
% Determine the difference in parameter values calculated with those saved and plot the results
close all;
subplot(2,3,1),plot(time(1:1:n,1),voltage(1:1:n,1),'o'); % this is DC voltage versus time
 set(gca,'Ylim',([-0.2 0.2]),'Xlim',([0 max(time)]),'linewidth',1,'FontSize',12,'FontName','Helvetica','Xticklabel',{'0', '1', '2','3'},...
'Xtick',[0 1 2 3 ],'box','off');
legend('potential, volts','Location','northoutside','Orientation','horizontal')
legend('boxoff');
[diff]=parameter_sameassaved(b_saved,b,n); % this is conductance in Siemens
subplot(2,3,2),plot(time(1:1:n,1),diff(1:1:n,1),'o'); % this is conductance
set(gca,'Ylim',([0 median(diff)]),'Xlim',([0 max(time)]),'linewidth',1,'FontSize',12,'FontName','Helvetica','Xticklabel',{'0', '1', '2','3'},...
'Xtick',[0 1 2 3 ],'box','off');
legend('b, S','Location','northoutside','Orientation','horizontal')
legend('boxoff');
ylabel('delta');
% 
[diff]=parameter_sameassaved(Cm_low_saved,Cm_low,n);% this is capacitance low frequency
subplot(2,3,3),plot(gca,time(1:1:n,1),diff(1:1:n,1),'o'); % 
set(gca, 'Ylim',([0 median(diff)]),'Xlim',([0 max(time)]),'linewidth',1,'FontSize',12,'FontName','Helvetica','Xticklabel',{'0', '1', '2','3'},...
'Xtick',[0 1 2 3 ],'box','off');
legend('C_{f} pF','Location','northoutside','Orientation','horizontal')
legend('boxoff');
xlabel('time, s');  
ylabel('delta');
[diff]=parameter_sameassaved(Cm_high_saved,Cm_high,n);% this is capacitance high frequency
subplot(2,3,4),plot(gca,time(1:1:n,1),diff(1:1:n,1),'o');  % 
set(gca, 'Ylim',([0 median(diff)]),'Xlim',([0 max(time)]),'linewidth',1,'FontSize',12,'FontName','Helvetica','Xticklabel',{'0', '1', '2','3'},...
'Xtick',[0 1 2 3 ],'box','off');
legend('C_{2f}, pF','Location','northoutside','Orientation','horizontal')
legend('boxoff');
xlabel('time, s');  
ylabel('delta');
[diff]=parameter_sameassaved(Rm_saved,Rm,n);% this is membrane resistance
subplot(2,3,5),plot(gca,time(1:1:n,1),diff(1:1:n,1),'o');  
set(gca, 'Ylim',([0 median(diff)]),'Xlim',([0 max(time)]),'linewidth',1,'FontSize',12,'FontName','Helvetica','Xticklabel',{'0', '1', '2','3'},...
'Xtick',[0 1 2 3 ],'box','off');
legend('R_{m}, Mohm','Location','northoutside','Orientation','horizontal')
legend('boxoff');
xlabel('time, s');  
[diff]=parameter_sameassaved(Rs_saved,Rs,n);% this is series resistance
subplot(2,3,6),plot(gca,time(1:1:n,1),diff(1:1:n,1),'o');  % 
set(gca, 'Ylim',([0 median(diff)]),'Xlim',([0 max(time)]),'linewidth',1,'FontSize',12,'FontName','Helvetica','Xticklabel',{'0', '1', '2','3'},...
'Xtick',[0 1 2 3 ],'box','off');
legend('R_{s}, Mohm','Location','northoutside','Orientation','horizontal')
legend('boxoff');
xlabel('time, s');  
% 
%The figure represents the data for the following specimen
gtext(strcat('origcellnumber:', num2str(cellnumber),  '  phenotye: ', phenotype,'  sex: ', sex,'  researcher:', researcher));

%
