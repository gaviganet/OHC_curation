function arm_data_transformation(dirname, filename_fits,k_adult_male,count,pathfunctions,pathbegdata,pathsavedata)
newFolder=strcat(pathbegdata,dirname);
genpath('newFolder');
cd(newFolder);
load(filename_fits);
newFolder=pathfunctions;
genpath('newFolder');
cd(newFolder);

for  i=1:1:length(k_adult_male)
j=k_adult_male(i,1);
 m=count+i;
newFolder=pathsavedata;
genpath('newFolder');
cd(newFolder);
namenew=strcat('specimen_#',num2str(m),'.h5');
fileID = H5F.open(namenew,'H5F_ACC_RDWR','H5P_DEFAULT');
newFolder=pathfunctions;
genpath('newFolder');
cd(newFolder);
group_id_lc = H5G.create(fileID, '/data transformation', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'A planned process that produces output data from input data.';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_lc,dadefinition,ATTRIBUTE)

ATTRIBUTE      = 'imported_from';
description=  'http://purl.obolibrary.org/obo/OBI_0200000';
dadefinition= char(description);
write_attribute_for_group(group_id_lc,dadefinition,ATTRIBUTE)
group_id_lc2 = H5G.create(fileID, '/data transformation/mean current vs membrane potential,(I_mean vs membrane potential) data set', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'The mean current versus holding potential data set determined from DC recordings';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_lc2,dadefinition,ATTRIBUTE)

T=isempty(array_of_do_fits(1,j).V);
if(T==1)
else
 V_hold=  array_of_do_fits(1,j).V;
type = H5T.copy ('H5T_NATIVE_DOUBLE');    
space = H5S.create('H5S_SCALAR');
dimw =length(V_hold);
dim0=1;
didefinition= 'membrane_potential'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_lc2,space,type,dim0,dimw,name_def,V_hold);  %calls function
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'DC membrane potential'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'volts'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
end
T=isempty(array_of_do_fits(1,j).R);
if(T==1)
  
else
  R=  array_of_do_fits(1,j).R;
type = H5T.copy ('H5T_NATIVE_DOUBLE');    
space = H5S.create('H5S_SCALAR');
dimw =length(R);
dim0=1;
didefinition= 'R'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_lc2,space,type,dim0,dimw,name_def,R);  %calls function
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'resistance i.e.,(Rm+Rs) equivalent to reciprocal of conductance at each voltage. Conductance is determined by calculating the derivative between adjacent membrane potential, I_mean points of scatter plot'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'Mohm'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
end
T=isempty(array_of_do_fits(1,j).I_mean);
if(T==1)
   
else
   I_mean=  array_of_do_fits(1,j).I_mean;
   type = H5T.copy ('H5T_NATIVE_DOUBLE');    
  space = H5S.create('H5S_SCALAR');
  dimw =[2,length(I_mean)];
  dim0=2;
didefinition= 'I_mean'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_lc2,space,type,dim0,dimw,name_def,I_mean);  %calls function
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'the mean and standard deviation of the current measured at each voltage'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'pA'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
end


group_id_ld = H5G.create(fileID, '/data transformation/partitioning data', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'Data partitioning is a data transformation with the objective of partitioning or separating input data into output subsets';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_ld,dadefinition,ATTRIBUTE)

ATTRIBUTE      = 'imported_from';
description=  'http://purl.obolibrary.org/obo/OBI_0200156';
dadefinition= char(description);
write_attribute_for_group(group_id_ld,dadefinition,ATTRIBUTE);

group_id_1e = H5G.create(fileID, '/data transformation/partitioning data/linear (voltage-independent) data set', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');

didefinition=  'Cell electrical properties determined when there is no voltage dependent effects';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_1e,dadefinition,ATTRIBUTE);
%
LC_lf_mean=array_of_do_fits(1,j).LC_low_mean(1,1);
LC_lf_std=array_of_do_fits(1,j).LC_low_mean(1,2);
LC_lf=[LC_lf_mean
    LC_lf_std];
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dimw =length(LC_lf);
dim0=1;
didefinition= 'LC_lf_mean'; 
name_def= char(didefinition);
 DATASETID=create_write_array_of_dble_dset(group_id_1e,space,type,dim0,dimw,name_def,LC_lf); %calls function
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'mean standard deviation of linear membrane capacitance determined from capacitance obtained at low frequency, Cmlf'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% 
ATTRIBUTE      = 'units';
description= 'pF';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% %
LC_hf_mean=array_of_do_fits(1,j).LC_high_mean(1,1);
LC_hf_std=array_of_do_fits(1,j).LC_high_mean(1,2);
LC_hf=[LC_hf_mean
    LC_hf_std];
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dimw =length(LC_hf);
dim0=1;
didefinition= 'LC_hf_mean'; 
name_def= char(didefinition);

DATASETID=create_write_array_of_dble_dset(group_id_1e,space,type,dim0,dimw,name_def,LC_hf); %calls function

% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Mean and standard deviation of mean of the linear membrane capacitance determined from capacitance obtained at high frequency, Cmhf'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'pF';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)%

Rm_mean=array_of_do_fits(1,j).Rm_mean(1,1);
Rm_std=array_of_do_fits(1,j).Rm_mean(1,2);
Rm=[Rm_mean
    Rm_std];
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dimw =length(Rm);
didefinition= 'Rm_mean'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_1e,space,type,dim0,dimw,name_def,Rm); %calls function

% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Mean and standard deviation of membrane resistance determined when there is no non-linear effects present'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
%H5DS.set_label(DATASETID,0,'MOhm');
ATTRIBUTE      = 'units';
description= 'MOhm';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
%
Rs_mean=array_of_do_fits(1,j).Rs_mean(1,1);
Rs_std=array_of_do_fits(1,j).Rs_mean(1,2);
Rs=[Rs_mean
    Rs_std];
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dim0=1;
dimw =length(Rs);
didefinition= 'Rs_mean'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_1e,space,type,dim0,dimw,name_def,Rs); %calls function
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Mean and standard deviation of mean of series resistance determined at voltage when there is no non-linear effects present'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'MOhm';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
%
VD=array_of_do_fits(1,j).VD;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'voltage_drop'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_1e,space,type,name_def,VD);

%attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'predicted value';
description= 'voltage drop calculated across the pipette'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% 

group_id_1f = H5G.create(fileID, '/data transformation/partitioning data/non-linear (voltage dependent) data sets', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');

didefinition=  'Cell electrical properties that are voltage-dependent';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_1f,dadefinition,ATTRIBUTE);

NLC_lf=array_of_do_fits(1,j).NLC_low;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dim0=1;
dimw =length(NLC_lf);
didefinition= 'NLC_lf'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_1f,space,type,dim0,dimw,name_def,NLC_lf); %calls function
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Non-linear or voltage dependent capacitance determined at low frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'pF';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
%
NLC_hf=array_of_do_fits(1,j).NLC_high;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dim0=1;
dimw =length(NLC_hf);
didefinition= 'NLC_hf'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_1f,space,type,dim0,dimw,name_def,NLC_hf); %calls function
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Non-linear or voltage dependent capacitance determined at high frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'pF';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
%
group_id_1fa = H5G.create(fileID, '/data transformation/partitioning data/non-linear (voltage dependent) data sets/integrate NLC vs membrane potential scatter plot', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');

didefinition=  'Determing the charge by integrating the area under the curve of non linear capacitance versus membrane potential scatter plots';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_1fa,dadefinition,ATTRIBUTE);
q_hf=array_of_do_fits(1,j).q_high;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dim0=1;
dimw =length(q_hf);
didefinition= 'q_hf'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_1fa,space,type,dim0,dimw,name_def,q_hf); %calls function
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Charge movememt at specific membrane potential at high frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'pC';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

q_lf=array_of_do_fits(1,j).q_low;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dim0=1;
dimw =length(q_lf);
didefinition= 'q_lf'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_1fa,space,type,dim0,dimw,name_def,q_lf); %calls function
%attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Charge movement at specific membrane potential at low frequency stimulus'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE      = 'units';
description= 'pC';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);

potential=array_of_do_fits(1,j).potential;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dim0=1;
dimw =length(potential);
didefinition= 'membrane_potential'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_1f,space,type,dim0,dimw,name_def,potential); %calls function
%attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'The electrical potential difference across a plasma membrane. The DC electric potential applied to the cytoplasm of the cell where the potential outside the cell is defined as zero.'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'volts';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% this is data extraction region
group_id_1f2 = H5G.create(fileID, '/data transformation/partitioning data/non-linear (voltage dependent) data sets/extracted_from_scatter_plot', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');

didefinition=  'Electrical properties extracted from scatter plots of the non-linear capacitance and charge as a function of membrane potential';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_1f2,dadefinition,ATTRIBUTE);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NLC_lf_peak=array_of_do_fits(1,j).NLC_low_peak(1,1);
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'NLC_lf_peak'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_1f2,space,type,name_def,NLC_lf_peak);
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% 
ATTRIBUTE      = 'definition';
description= 'Peak capacitance determined at low frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'pF';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% %
NLC_hf_peak=array_of_do_fits(1,j).NLC_high_peak(1,1);
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'NLC_hf_peak'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_1f2,space,type,name_def,NLC_hf_peak);
% 
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% 
ATTRIBUTE      = 'definition';
description= 'Peak capacitance determined at high frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'pF';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% 
Q_lf=array_of_do_fits(1,j).Q_low_total(1,1);
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'Q_lf'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_1f2,space,type,name_def,Q_lf);
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Maximum charge movement low frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'pC';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

Q_hf=array_of_do_fits(1,j).Q_high_total(1,1);
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'Q_hf'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_1f2,space,type,name_def,Q_hf);
%attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Maximum charge movement high frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'pC';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% %
Vpeakm=array_of_do_fits(1,j).Vm(1,1);
Vpeakcorr=array_of_do_fits(1,j).Vmcorr(1,1);
Vpeak=[Vpeakm Vpeakcorr];
dimw =length(Vpeak);
dim0=1;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');

didefinition= 'Vpeak'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_1f2,space,type,dim0,dimw,name_def,Vpeak); %calls function

% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% 
ATTRIBUTE      = 'definition';
description= 'Voltage at peak capacitance: measured and corrected for voltage drop'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'volts';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

VSmax_lf=max(diff(array_of_do_fits(1,j).q_low/(max(array_of_do_fits(1,j).q_low)))./(array_of_do_fits(1,j).potential(array_of_do_fits(1).NLpositions(1,1)+3)-array_of_do_fits(1,j).potential(array_of_do_fits(1,j).NLpositions(1,1)+2)));
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'VSmax_lf'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_1f2,space,type,name_def,VSmax_lf);
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% 
ATTRIBUTE      = 'definition';
description= 'maximum voltage sensitivity measured at low frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% 
ATTRIBUTE      = 'units';
description= 'per volt';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

VSmax_hf=max(diff(array_of_do_fits(1,j).q_high/(max(array_of_do_fits(1,j).q_high)))./(array_of_do_fits(1,j).potential(array_of_do_fits(1,j).NLpositions(1,1)+3)-array_of_do_fits(1,j).potential(array_of_do_fits(1,j).NLpositions(1,1)+2)));
type = H5T.copy ('H5T_NATIVE_DOUBLE');
space = H5S.create('H5S_SCALAR');
didefinition= 'VSmax_hf'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_1f2,space,type,name_def,VSmax_hf);
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% 
ATTRIBUTE      = 'definition';
description= 'maximum voltage sensitivity measured at high frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% 
ATTRIBUTE      = 'units';
description= 'per volt';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% %

group_id_1g = H5G.create(fileID, '/data transformation/partitioning data/non-linear (voltage dependent) data sets/curve-fitting transformation', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');

didefinition=  'A curve fitting is a data transformation that has objective curve fitting and that consists of finding a curve which matches a series of data points and possibly other constraints';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_1g,dadefinition,ATTRIBUTE);
ATTRIBUTE      = 'imported_from';
description=  ' http://purl.obolibrary.org/obo/OBI_0200072';
dadefinition= char(description);
write_attribute_for_group(group_id_1g,dadefinition,ATTRIBUTE);

group_id_lh = H5G.create(fileID, '/data transformation/partitioning data/non-linear (voltage dependent) data sets/curve-fitting transformation/Two-state Boltzmann', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
 didefinition= 'Cell electrical properties calculated by fitting charge versus potential data and capacitance versus potential data to a two-state Boltzmann model with constraints on values';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_lh,dadefinition,ATTRIBUTE);

% datasets
Qmax_qvsV=array_of_do_fits(1,j).twostate_qvsv_constrained_reverse(1,1);
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'Qmax_qvsV'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_lh,space,type,name_def,Qmax_qvsV);
%attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes

ATTRIBUTE      = 'definition';
description= 'Maximum charge calculated at frequency with highest signal to noise'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'note';
description= 'calculated from q versus V data for data with frequency with highest signal to noise'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'pC';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
%
Qmax_CvsV=array_of_do_fits(1,j).twostate_cvsv_constrained(1,1);
type = H5T.copy ('H5T_NATIVE_DOUBLE');
space = H5S.create('H5S_SCALAR');
didefinition= 'Qmax_CvsV'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_lh,space,type,name_def,Qmax_CvsV);
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes

ATTRIBUTE      = 'definition';
description= 'Maximum charge calculated at frequency with highest signal to noise'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'note';
description= 'calculated from C versus V data for data with frequency with highest signal to noise'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'pC';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)


Vhalf_qvsV=array_of_do_fits(1,j).twostate_qvsv_constrained_reverse(1,3);
type = H5T.copy ('H5T_NATIVE_DOUBLE');
space = H5S.create('H5S_SCALAR');
didefinition= 'Vhalf_qvsV'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_lh,space,type,name_def,Vhalf_qvsV);
%attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes

ATTRIBUTE      = 'definition';
description= 'Voltage calculated when half of maximum charge was attained for frequency with highest signal to noise'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'note';
description= 'calculated from q versus V data for data with frequency with highest signal to noise'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'volts';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
%
Vhalf_CvsV=array_of_do_fits(1,j).twostate_cvsv_constrained(1,3);
type = H5T.copy ('H5T_NATIVE_DOUBLE');
space = H5S.create('H5S_SCALAR');
didefinition= 'Vhalf_CvsV'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_lh,space,type,name_def,Vhalf_CvsV);
%attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes

ATTRIBUTE      = 'definition';
description= 'Voltage calculated when half of maximum charge was attained for frequency with highest signal to noise'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'note';
description= 'calculated from C versus V data for data with frequency with highest signal to noise'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'volts';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

alpha_qvsV=array_of_do_fits(1,j).twostate_qvsv_constrained_reverse(1,2);
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'alpha_qvsV'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_lh,space,type,name_def,alpha_qvsV);
%attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes

ATTRIBUTE      = 'definition';
description= 'Voltage sensitivity calculated for data with highest signal to noise'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'note';
description= 'calculated from q versus V data for data with frequency with highest signal to noise'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'per volt';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
%
alpha_CvsV=array_of_do_fits(1,j).twostate_cvsv_constrained(1,2);
type = H5T.copy ('H5T_NATIVE_DOUBLE');
space = H5S.create('H5S_SCALAR');
didefinition= 'alpha_CvsV'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_lh,space,type,name_def,alpha_CvsV);
%attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes

ATTRIBUTE      = 'definition';
description= 'Voltage sensitivity calculated for data with highest signal to noise'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'note';
description= 'calculated from C versus V data for data with frequency with highest signal to noise'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'per volt';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
%
low_or_high=array_of_do_fits(1,j).choice;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_INT');
didefinition= 'low_or_high'; 
name_def= char(didefinition);
DATASETID=create_and_write_int_dataset(group_id_lh,space,type,name_def,low_or_high);

% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'note';
description= 'Specifically stipulates whether the low or high frequency q versus V data was chosen for fitting to model'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'note 2';
description= 'one and two represents: data obtained with low or high frequency stimulus';  
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
clearvars -except dirname filename_fits count k_adult_male array_of_do_fits pathfunctions pathbegdata pathsavedata;

end
end

