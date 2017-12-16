% This file allows the reader to check whether they get similar values to
% that saved in the specimen files. By use of the same methodology used to generate the original
% data. This script is interactive and requires input from the reader.  There are 6 sections.   This requires
% some training till one becomes familiar with the needs of the code. This
% code requires the array_of_hdf52mat_out. 
% File was updated by Brenda Farrell in December 14 2017. 
% Some of the interactive components were originally written by Varun Sreenivasan.
%% Section one
% Load data as an array of structs into memory.  The data loaded is the
% data generated from translating HDF5 to MATLAB this can have 1 to 89
% arrays
close all % remove all figures
clear % clear memory
pathsavedata=('Y:\OHC_Data\Data for portal\Specimen');
genpath('pathsavedata');
cd(pathsavedata);
load(strcat('array_of_hdf52mat_out','.mat'));
pathfunctions=('C:\Users\bfarrell\Documents\M files\OHC analysis\HDF5format\final functions\Package');
cd(pathfunctions)
%% Section two
% This section we create the variables in workspace; determine the extent
% of the ramp and display the C versus V plot for both frequencies and
% interactively pick the voltage at maximum capacitance.  Useful to look at
% plots to establish the linear and non-linear regions.
close all;
k=1; %Pick the specimen value you want to examine

originalCellNumber=array_of_hdf52mat_out(1,k).originalCellNumber;
phenotype=array_of_hdf52mat_out(1,k).phenotype;
sex=array_of_hdf52mat_out(1,k).sex;
researcher=array_of_hdf52mat_out(1,k).researcher;

% values calculated and saved from the original measurements
Cm_low_saved=array_of_hdf52mat_out(1,k).Cmlf;
Cm_high_saved=array_of_hdf52mat_out(1,k).Cmhf;
Rm_saved=array_of_hdf52mat_out(1,k).Rm;
Rs_saved=array_of_hdf52mat_out(1,k).Rs;
NLC_lf_saved=array_of_hdf52mat_out(1,k).NLC_lf;
NLC_hf_saved=array_of_hdf52mat_out(1,k).NLC_hf;
q_lf_saved=array_of_hdf52mat_out(1,k).q_lf;
q_hf_saved=array_of_hdf52mat_out(1,k).q_hf;
potential_saved=array_of_hdf52mat_out(1,k).potential;
voltage=array_of_hdf52mat_out(1,k).voltage;

% key variables
Vpeak_saved=array_of_hdf52mat_out(1,k).Vpeak;
Rm_mean_saved=array_of_hdf52mat_out(1,k).Rm_mean;
Rs_mean_saved=array_of_hdf52mat_out(1,k).Rs_mean;
voltageDrop_saved=array_of_hdf52mat_out(1,k).voltageDrop;
LC_hf_mean_saved=array_of_hdf52mat_out(1,k).LC_hf_mean;
LC_lf_mean_saved=array_of_hdf52mat_out(1,k).LC_lf_mean;
NLC_hf_peak_saved=array_of_hdf52mat_out(1,k).NLC_hf_peak;
NLC_lf_peak_saved=array_of_hdf52mat_out(1,k).NLC_lf_peak;
Q_hf_saved=array_of_hdf52mat_out(1,k).Q_hf;
Q_lf_saved=array_of_hdf52mat_out(1,k).Q_lf;
VSmax_hf_saved=array_of_hdf52mat_out(1,k).VSmax_hf;
VSmax_lf_saved=array_of_hdf52mat_out(1,k).VSmax_lf;

% Determine the extent of the ramp

Numb=length(voltage);
for i=1:1:Numb/2    
 if(voltage(i,1)==-0.06)
    begR=i+1;    
 end
end
begR=begR+2;
endR=0;
for i=Numb:-1:Numb/2    
 if(voltage(i,1)==-0.06)
    endR=i-1;    
 end
end
%    
endR=endR-2; 
% Plot C vs. V to determine peak voltage and look at data
figure1 =figure('NumberTitle','off','Name','C_versus_V');
xlabel('Voltage, V');
ylabel('Membrane capacitance, pF');
hold on;

ylim([4, max(Cm_low_saved(begR:endR,1))+1])
plot(voltage(begR:endR,1),Cm_high_saved(begR:endR,1),'.b','markersize', 24);
plot(voltage(begR:endR,1),Cm_low_saved(begR:endR,1),'.r','markersize', 24);
legend('capacitancehigh','capacitancelow'); % add legend
%%
%get datapoints from the user where C is maximum either in high or low frequency
cursor_vpeak = datacursormode(figure1);
set(cursor_vpeak,'DisplayStyle','window',...
'SnapToDataVertex','off','Enable','on')

disp('Need user input>> Click on the voltage of peak capacitance and hit enter');
pause %waits for user to hit enter
Vm= getCursorInfo(cursor_vpeak);
Vpeak=Vm.Position(1,1);
%% SECTION three
% In this section we experimentally determine the linear region of the C
% versus V curve by calculating a j-slope. This is the local derivative
% calculated with N usually 3, 4 or 5 continuous points (See Integr. Biol.,
% 2013, 5, 204--214 for a description of j-slope). The reason for doing
% this is that when the derivative undulates around zero we are in the
% linear region of the capacitance versus voltage plot. We then calculate
% the linear capacitance at positive or depolarizing potentials. The user
% can use either the low or high frequency data to determine the
% derivative, because of lower noise with higher frequency it is generally
% better to use higher frequency data. This requires the user to become
% familiar with the derivative and it requires some training to establish
% the beginning and end of the linear region.  We define it at the point
% when the derivative crosses zero through the end of the recording but
% sometimes the points at very positive potentials are noisy, and in that
% case we do not include them. It also  helps to look at the original C
% versus V curves.  The analysis is interactive.
% 
figure2 = figure('NumberTitle','off','Name','Jump Slope for Linear Region','Color',[1 1 1]);
axes('Parent',figure2,...
    'FontSize',20,'FontName','Arial');
xlim([-0.2 0.20])
% ylim([-200 200])
xlabel('Voltage, V');
ylabel('Jump Slope , pF/V');
grid('on');
box('on');
hold on;
color={'.c', '.r', '.g', '.b', '.k', '.c'}; %defining different colours
numb=endR-begR;
jslope_high=zeros(Numb,6);  %initializing variable
jslope_low=zeros(Numb,6);
high_or_low=menu('Choose capacitance data for jump slope calculation','High Frequency','Low Frequency'); 
if high_or_low==1
		for delta=3:5
            j=1;
			for i=begR:delta:endR-delta 
				fit_high = polyfit(voltage(i:i+delta-1),Cm_high_saved(i:i+delta-1),1); 
				jslope_high(j,delta)=fit_high(1);
                j=j+1;
			end
		%setting up plot scale and names
		plot(voltage(begR:delta:endR-delta),jslope_high(1:1:j-1,delta), color{delta},'markersize',25);
        end
		
else if high_or_low==2
		for delta=3:5
            j=1;
			for i=begR:delta:endR-delta     
				fit_low = polyfit(voltage(i:i+delta-1),Cm_low_saved(i:i+delta-1),1); 
				jslope_low(j,delta)=fit_low(1);
                j=j+1;
			end
		%setting up plot scale and names
		plot(voltage(begR:delta:endR-delta),jslope_low(1:1:j-1,delta), color{delta},'markersize',25);
        end
	end
end
% get datapoints from the user where dC/dV=0 from any of the five plots
cursor_begin = datacursormode(figure2);
 set(cursor_begin,'DisplayStyle','window',...
'SnapToDataVertex','off','Enable','on')
disp('Need user input>> Hit enter after choosing the begining of dC/dV=0');
pause %waits for user to hit enter
begincursor= getCursorInfo(cursor_begin);

figure(figure2); %just bring the figure to the front again
cursor_end = datacursormode(figure2);
 set(cursor_end,'DisplayStyle','window',...
'SnapToDataVertex','off','Enable','on')
disp('Need user input>> Hit enter after choosing the end of dC/dV=0');
pause %waits for user to hit enter
endcursor= getCursorInfo(cursor_end);

% Determines the extent of linear region
for i=begR:1:endR
    if(voltage(i,1)==begincursor.Position(1,1))
    bLin=i;
    end
end
for i=begR:1:endR
    if(voltage(i,1)==endcursor.Position(1,1))
    eLin=i;
    end
end
%
indexpositions=[begR,endR,bLin,eLin];
clear NLC_low NLC_high NLC_low_peak NLC_high_peak;

% Calculate OHC properties
LC_low_mean(1,1)     =mean(Cm_low_saved(bLin:eLin));
LC_low_mean(1,2)     =std(Cm_low_saved(bLin:eLin));
mean_LC_low=LC_low_mean(1,1);
std_LC_low=LC_low_mean(1,2);
LC_high_mean(1,1)    =mean(Cm_high_saved(bLin:eLin));
LC_high_mean(1,2)     =std(Cm_high_saved(bLin:eLin));
mean_LC_high=LC_high_mean(1,1);
std_LC_high=LC_high_mean(1,2);
%
NLC_low(:,1)         =Cm_low_saved(begR:1:bLin)-LC_low_mean(1,1);
NLC_high(:,1)        =Cm_high_saved(begR:1:bLin)-LC_high_mean(1,1);
NLC_low_peak    =(Cm_low_saved(Vm.DataIndex+begR)-LC_low_mean(1,1));
NLC_high_peak   =(Cm_high_saved(Vm.DataIndex+begR)-LC_high_mean(1,1));
 
%% SECTION four
% In this section we check whether the non-linear capacitance is everywhere
% positive if not the range is reduced to that region where it is positive
% and establish by clicking the beginning and end positions of the
% non-linear region. This is interactive the first point is most negative
% the last point is most positive

close all
figure2 = figure('Color',[1 1 1]);
 plot(voltage(indexpositions(1,1):1:indexpositions(1,3)), NLC_low, 'bo'); 
 hold on;
 plot(voltage(indexpositions(1,1):1:indexpositions(1,3)), NLC_high, 'ro')
 set(gca,'box','off','Ygrid', 'on','Ylim',([-1 max(NLC_low)+1]));
cursor_begin2 = datacursormode(figure2);
 set(cursor_begin2,'DisplayStyle','window',...
'SnapToDataVertex','off','Enable','on')

disp('Need user input>> Hit enter after choosing the begining of NLC');
pause %waits for user to hit enter

begincursor2= getCursorInfo(cursor_begin2);

cursor_end2 = datacursormode(figure2);
set(cursor_end2,'DisplayStyle','window',...
'SnapToDataVertex','off','Enable','on')
disp('Need user input>> Hit enter after choosing the end of NLC');
pause %waits for user to hit enter
endcursor2= getCursorInfo(cursor_end2);
bNL=begincursor2.DataIndex(1,1);
eNL=endcursor2.DataIndex(1,1);

clear q_low q_high
dV = voltage(begR+1)-voltage(begR);

NLpositions=[bNL eNL];
q_low           =zeros(bNL-eNL,1);
q_high          =zeros(bNL-eNL,1);

for i=bNL:1:(eNL)-1
    q_low(i-bNL+1)    =sum(NLC_low(bNL:i))*dV;
    q_high(i-bNL+1)   =sum(NLC_high(bNL:i))*dV;
end
q_low=q_low';
q_high=q_high';
Q_low_total     =max(q_low);
Q_high_total    =max(q_high);

Rm_mean(1,1)         =mean(Rm_saved(bLin:1:eLin));
Rm_mean(1,2)          =std(Rm_saved(bLin:1:eLin));
mean_Rm=Rm_mean(1,1);
std_Rm=Rm_mean(1,2);
Rs_mean(1,1)         =mean(Rs_saved(bLin:1:eLin));
Rs_mean(1,2)         =std(Rs_saved(bLin:1:eLin));
mean_Rs=Rs_mean(1,1);
std_Rs=Rs_mean(1,2);
VD=Rm_mean(1,1)/(Rm_mean(1,1)+Rs_mean(1,1));
Vmcorr=VD*Vm.Position(1,1);
% Calculate the voltage sensitivity
A_low=diff(q_lf_saved/(max(q_lf_saved))./(potential_saved(NLpositions(1,1)+3)-potential_saved(NLpositions(1,1)+2)));
VSmax_lf=max(A_low);
A_high=diff(q_hf_saved/(max(q_hf_saved))./(potential_saved(NLpositions(1,1)+3)-potential_saved(NLpositions(1,1)+2)));
VSmax_hf=max(A_high);
            

%% Section five
% Compare Data with that which is saved and plot it the last command line
% gtext provides for interactive plot to place the information relating to
% the specimen number 
close all;
subplot(2,2,1),plot(voltage(begR:1:bLin,1),NLC_low(:,1),'o',potential_saved,NLC_lf_saved,'+'); % this is ramp voltage versus NLC_low frequency
 set(gca,'Xlim',([-0.2 0.2]),'Ylim',([0 max(NLC_low)]),'linewidth',1,'FontSize',12,'FontName','Helvetica','Xticklabel',{'-0.2', '-0.1','0', '0.1','0.2'},...
'Xtick',[-0.2 -0.1 0 0.1 0.2 ],'box','off');
legend('C_{lf}','C_{lf} saved ','Location','northoutside','Orientation','vertical')
legend('boxoff');
ylabel('pF');
xlabel('potential, V');  
subplot(2,2,2),plot(voltage(begR:1:bLin,1),NLC_high(:,1),'o',potential_saved,NLC_hf_saved,'+'); % this is ramp voltage versus NLC_low frequency
set(gca,'Xlim',([-0.2 0.2]),'Ylim',([0 max(NLC_high)]),'linewidth',1,'FontSize',12,'FontName','Helvetica','Xticklabel',{'-0.2', '-0.1','0', '0.1','0.2'},...
'Xtick',[-0.2 -0.1 0 0.1 0.2 ],'box','off');
legend('C_{hf}', 'C_{hf} saved','Location','northoutside','Orientation','vertical')
legend('boxoff');
xlabel('potential, V');  
subplot(2,2,3),plot(voltage(begR+bNL-1:1:bLin-1,1),q_low(:,1),'o',potential_saved(1:1:length(q_lf_saved),1),q_lf_saved(:,1),'+'); % this is ramp voltage versus NLC_low frequency
 set(gca,'Xlim',([-0.2 0.2]),'Ylim',([0 Q_low_total]),'linewidth',1,'FontSize',12,'FontName','Helvetica','Xticklabel',{'-0.2', '-0.1','0', '0.1','0.2'},...
'Xtick',[-0.2 -0.1 0 0.1 0.2 ],'box','off');
legend('q_{lf}','q_{lf} saved ','Location','northoutside','Orientation','vertical')
legend('boxoff');
ylabel('pC');
xlabel('potential, V');  
subplot(2,2,4),plot(voltage(begR+bNL-1:1:bLin-1,1),q_high(:,1),'o',potential_saved(1:1:length(q_hf_saved),1),q_hf_saved(:,1),'+'); % this is ramp voltage versus NLC_low frequency
 set(gca,'Xlim',([-0.2 0.2]),'Ylim',([0 Q_high_total]),'linewidth',1,'FontSize',12,'FontName','Helvetica','Xticklabel',{'-0.2', '-0.1','0', '0.1','0.2'},...
'Xtick',[-0.2 -0.1 0 0.1 0.2 ],'box','off');
legend('q_{lf}','q_{lf} saved ','Location','northoutside','Orientation','vertical')
legend('boxoff');
ylabel('pC');
xlabel('potential, V');  
gtext(strcat('specimen no: ',  num2str(k),' originalCellNumber: ', num2str(originalCellNumber),  '  phenotye: ', phenotype,'  sex: ', sex,'  researcher:', researcher));
%% Section 6
% Create Table of main parameters and compare with saved values.  This
% allows the user to check whether the parameters saved are the same as
% re-calculated.  The user can peruse the Tout Table and compare the saved
% with calculated for the main parameters usually reported in an
% experiment.
Tout=table(mean_LC_low,std_LC_low,mean_LC_high,std_LC_high,mean_Rm,std_Rm,mean_Rs,std_Rs,VD, Vpeak,Vmcorr,NLC_low_peak,NLC_high_peak,Q_low_total,Q_high_total,VSmax_lf,VSmax_hf);
TSaved=table(LC_lf_mean_saved(1,1),LC_lf_mean_saved(2,1),LC_hf_mean_saved(1,1),LC_hf_mean_saved(2,1),Rm_mean_saved(1,1),Rm_mean_saved(2,1),Rs_mean_saved(1,1),Rs_mean_saved(2,1),voltageDrop_saved,Vpeak_saved(1,1),Vpeak_saved(2,1),NLC_lf_peak_saved,NLC_hf_peak_saved,Q_lf_saved,Q_hf_saved,VSmax_lf_saved,VSmax_hf_saved);
Tout(end+1,:) = TSaved;
Tout.Properties.RowNames = {'Current','Saved'};
Tout %This print the table on command line