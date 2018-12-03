function transformed_data_set(dirname, filename_fits,k_adult_male,count,pathfunctions,pathbegdata,pathsavedata)
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
namenew=strcat('sensory_cell_#',num2str(m),'.h5');
fileID = H5F.open(namenew,'H5F_ACC_RDWR','H5P_DEFAULT');
newFolder=pathfunctions;
genpath('newFolder');
cd(newFolder);
group_id_lc = H5G.create(fileID, '/transformed data set', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'data set that results from one or more data transformation processes';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_lc,dadefinition,ATTRIBUTE)
% ATTRIBUTE      = 'imported_from';
% description=  'http://purl.obolibrary.org/obo/OBI_0200000';
% dadefinition= char(description);
% write_attribute_for_group(group_id_lc,dadefinition,ATTRIBUTE)
group_id_1c2 = H5G.create(fileID, '/transformed data set/transformed data set for protocol membrane current (I) as a function of membrane potential (V) (I vs V plot)', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
% 
didefinition= 'Data that was extracted after averaging the steady state current measured at each membrane potential, and calculating the slope between two points from the change in mean current (y or ordinate) and change in mean membrane potential (x or abscissa).  The reciprocal of the conductance at each membrane potential is then calculated from the inverse of the slope.';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_1c2,dadefinition,ATTRIBUTE);

T=isempty(array_of_do_fits(1,j).V);
if(T==1)
    V_hold=  array_of_do_fits(1,j).V;
type = H5T.copy ('H5T_NATIVE_DOUBLE');    
space = H5S.create('H5S_SCALAR');
dimw =0;
else
 V_hold=  array_of_do_fits(1,j).V;
type = H5T.copy ('H5T_NATIVE_DOUBLE');    
space = H5S.create('H5S_SCALAR');
dimw =length(V_hold);
end
dim0=1;
didefinition= 'membrane_potential'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_1c2,space,type,dim0,dimw,name_def,V_hold);  %calls function
% % attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'A quality inhering in a cells plasma membrane by virtue of the electrical potential difference across it.'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'volts'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'imported from';
description= 'http://purl.obolibrary.org/obo/PATO_0001462'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

T=isempty(array_of_do_fits(1,j).R);
if(T==1)
 R=  array_of_do_fits(1,j).R;
type = H5T.copy ('H5T_NATIVE_DOUBLE');    
space = H5S.create('H5S_SCALAR');
dimw =0;  
else
  R=  array_of_do_fits(1,j).R;
type = H5T.copy ('H5T_NATIVE_DOUBLE');    
space = H5S.create('H5S_SCALAR');
dimw =length(R);
end
didefinition= 'R_b'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_1c2,space,type,dim0,dimw,name_def,R);  %calls function
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'reciprocal of conductance at each membrane potential equivalent to sum of membrane and series resistance, Rm+Rs'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'Mohm'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

T=isempty(array_of_do_fits(1,j).I_mean);
if(T==1)
   I_mean=  [];
   type = H5T.copy ('H5T_NATIVE_DOUBLE');    
  space = H5S.create('H5S_SCALAR');
  dimw =[0,0];
else
   I_mean=  array_of_do_fits(1,j).I_mean;
   type = H5T.copy ('H5T_NATIVE_DOUBLE');    
  space = H5S.create('H5S_SCALAR');
  dimw =[2,length(I_mean)];
end  
  dim0=2;
didefinition= 'I_mean'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_1c2,space,type,dim0,dimw,name_def,I_mean);  %calls function
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'the mean and standard deviation of the current measured at each membrane potential'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'pA'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
%  
group_id_lz = H5G.create(fileID, '/transformed data set/transformed data sets for protocol electrical admittance dual-sine stimulus', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
group_id_1y = H5G.create(fileID, '/transformed data set/transformed data sets for protocol electrical admittance dual-sine stimulus/linear (voltage-independent) data set', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
% 
didefinition=  'electrical properties determined when there is no voltage-dependent effect';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_1y,dadefinition,ATTRIBUTE);
didefinition='The data was partitioned to separate the linear from non-linear electrical parameters. This was performed by calculating the sectional-slope (see URL) from the membrane capacitance versus membrane potential function and determining the region when the slope is zero. A derivative of zero represents the region when membrane capacitance is linear. The membrane and series resistance and voltage drop are then calculated within this region when there was no detectable voltage-dependent component.'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'note about data transformations used';
write_attribute_for_group(group_id_1y,dadefinition,ATTRIBUTE);
% %
LC_f1_mean=array_of_do_fits(1,j).LC_low_mean(1,1);
LC_f1_std=array_of_do_fits(1,j).LC_low_mean(1,2);
LC_f1=[LC_f1_mean
    LC_f1_std];
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dimw =length(LC_f1);
dim0=1;
didefinition= 'LC_f1_mean'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_1y,space,type,dim0,dimw,name_def,LC_f1); %calls function
% % attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'mean and standard deviation of linear membrane capacitance determined at positive potentials from lower frequency stimulus, Cmf1'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% 
ATTRIBUTE      = 'units';
description= 'pF';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% %
LC_f2_mean=array_of_do_fits(1,j).LC_high_mean(1,1);
LC_f2_std=array_of_do_fits(1,j).LC_high_mean(1,2);
LC_f2=[LC_f2_mean
    LC_f2_std];
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dimw =length(LC_f2);
dim0=1;
didefinition= 'LC_f2_mean'; 
name_def= char(didefinition);

DATASETID=create_write_array_of_dble_dset(group_id_1y,space,type,dim0,dimw,name_def,LC_f2); %calls function

% % attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Mean and standard deviation of the linear membrane capacitance determined at positive potentials from higher frequency stimulus'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'pF';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)%

Rm_mean=array_of_do_fits(1,j).Rm_mean(1,1);
Rm_std=array_of_do_fits(1,j).Rm_mean(1,2);
Rm=[Rm_mean Rm_std];
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dimw =length(Rm);
didefinition= 'Rm_mean'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_1y,space,type,dim0,dimw,name_def,Rm); %calls function
ATTRIBUTE      = 'definition';
description= 'Mean and standard deviation of membrane resistance determined at positive voltage when no non-linear effects are detected.'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'MOhm';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% %
% %
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
DATASETID=create_write_array_of_dble_dset(group_id_1y,space,type,dim0,dimw,name_def,Rs); %calls function
% % attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Mean and standard deviation of series resistance determined at voltage when no non-linear effects are detected.'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'MOhm';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% %
VD=array_of_do_fits(1,j).VD;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'voltage_drop across membrane'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_1y,space,type,name_def,VD);

%attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'predicted value';
description= 'voltage drop across the membrane calculated from ratio of: membrane resistance and sum of membrane and series resistance'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
group_id_1x = H5G.create(fileID, '/transformed data set/transformed data sets for protocol electrical admittance dual-sine stimulus/non-linear (voltage-dependent) data set', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');

 didefinition=  'electrical properties that are dependent upon voltage';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_1x,dadefinition,ATTRIBUTE);
 didefinition=  'The non-linear electrical parameters were determined after subtracting the linear capacitance, LC from the membrane capacitance.  This provides the NLC versus potential function.  The displacement charge was determined by integrating the NLC with respect to membrane potential to determine the charge as a function of membrane potential i.e. obtain the q versus potential function with the maximum charge, Qmax found from this transformation. The peak capacitance (Cpeak) and voltage of maximum sensitivity (V0.5, Vpeak) was extracted from a plot of  membrane capacitance versus potential function. The voltage sensitvity was determined by calculating the derivative of normalized charge, q/Qmax as a function of membrane potential then finding the maximum of this derivative and multiplying it by 4.  The Vpeak or V0.5 was corrected for the measured voltage drop across the membrane.';
 dadefinition= char(didefinition);
ATTRIBUTE      = 'note about data transformations used';
write_attribute_for_group(group_id_1x,dadefinition,ATTRIBUTE);
% 
 NLC_f1=array_of_do_fits(1,j).NLC_low;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dim0=1;
dimw =length(NLC_f1);
didefinition= 'NLC_f1'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_1x,space,type,dim0,dimw,name_def,NLC_f1); %calls function
% % attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'The non-linear capacitance is the partial derivative of the charge with respect to membrane potential.'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE= 'note';  
description='voltage dependent capacitance determined at f1 the higher frequency';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'pF';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
%
NLC_f2=array_of_do_fits(1,j).NLC_high;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dim0=1;
dimw =length(NLC_f2);
didefinition= 'NLC_f2'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_1x,space,type,dim0,dimw,name_def,NLC_f2); %calls function
ATTRIBUTE      = 'definition';
description= 'The non-linear capacitance is the partial derivative of the charge with respect to membrane potential';  
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'pF';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE= 'note';  
description='voltage dependent capacitance determined at f2 the higher frequency';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% % %
q_f2=array_of_do_fits(1,j).q_high;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dim0=1;
dimw =length(q_f2);
didefinition= 'q_f2'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_1x,space,type,dim0,dimw,name_def,q_f2); %calls function
% % % attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'displacement charge. Under the influence of a membrane potential the charges within a dielectric (e.g., plasma membrane) move from a position of exact cancellation to a state when the charges (i.e., negative or positive or both) separate causing a change in the state of polarization. This changing state of polarization represents the charge moved or the displacement charge. The common term used to describe this for membrane proteins that respond to voltage is gating charge as this is the movement of charge  that results in the opening of the pore (which is like a gate) of an ion channel. This terminology i.e. gating charge is used to describe other membrane proteins that do not exhibit a channel.';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE      = 'note';
note= 'determined as a function of membrane potential at f2 the higher frequency'; 
dadefinition= char(note);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% 
ATTRIBUTE      = 'units';
description= 'pC';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

q_f1=array_of_do_fits(1,j).q_low;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dim0=1;
dimw =length(q_f1);
didefinition= 'q_f1'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_1x,space,type,dim0,dimw,name_def,q_f1); %calls function
% %attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'displacement charge. Under the influence of a membrane potential the charges within a dielectric (e.g., plasma membrane) move from a position of exact cancellation to a state when the charges (i.e., negative or positive or both) separate causing a change in the state of polarization. This changing state of polarization represents the charge moved or the displacement charge. The common term used to describe this for membrane proteins that respond to voltage is gating charge as this is the movement of charge  that results in the opening of the pore (which is like a gate) of an ion channel. This terminology i.e. gating charge is used to describe other membrane proteins that do not exhibit a channel.';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE      = 'units';
description= 'pC';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE      = 'note';
description= 'determined at f1 the lower frequency stimulus'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
% % 
potential=array_of_do_fits(1,j).potential;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dim0=1;
dimw =length(potential);
didefinition= 'membrane_potential'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_1x,space,type,dim0,dimw,name_def,potential); %calls function
% % %attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'A quality inhering in a cells plasma membrane by virtue of the electrical potential difference across it.';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE      = 'definition two';
description= 'The DC electric potential applied to the cytoplasm of the cell where the potential outside the cell is defined as zero.'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE      = 'units';
description= 'volts';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% % % this is data extraction region
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NLC_f1_peak=array_of_do_fits(1,j).NLC_low_peak(1,1);
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'NLC_f1_peak'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_1x,space,type,name_def,NLC_f1_peak);
% % % attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% % % 
ATTRIBUTE      = 'definition';
description= 'maximum non-linear membrane capacitance determined at f1 the lower frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% 
ATTRIBUTE      = 'units';
description= 'pF';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% % %
NLC_f2_peak=array_of_do_fits(1,j).NLC_high_peak(1,1);
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'NLC_f2_peak'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_1x,space,type,name_def,NLC_f2_peak);
% % % 
% % % attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% % % 
ATTRIBUTE      = 'definition';
description= 'maximum non-linear capacitance determined at f2 the higher frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'pF';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% % 
Q_f1=array_of_do_fits(1,j).Q_low_total(1,1);
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'Qmax_f1'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_1x,space,type,name_def,Q_f1);
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Maximum displacement charge at f1 the lower frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'pC';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% 
Q_f2=array_of_do_fits(1,j).Q_high_total(1,1);
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'Qmax_f2'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_1x,space,type,name_def,Q_f2);
% %attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Maximum displacement charge at f2 the higher frequency'; 
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
% 
didefinition= 'V_0p5'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_1x,space,type,dim0,dimw,name_def,Vpeak); %calls function
% % 
% % % attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% % % 
ATTRIBUTE      = 'definition';
description= 'potential of maximum sensitivity: measured value and value corrected for voltage drop'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'volts';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% 
VS_f1=4*max(diff(array_of_do_fits(1,j).q_low/(max(array_of_do_fits(1,j).q_low)))./(array_of_do_fits(1,j).potential(array_of_do_fits(1).NLpositions(1,1)+3)-array_of_do_fits(1,j).potential(array_of_do_fits(1,j).NLpositions(1,1)+2)));
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'alpha_f1'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_1x,space,type,name_def,VS_f1);
% % attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% % 
ATTRIBUTE      = 'definition';
description= 'A quality inherent in the membrane by virtue of the membranes disposition to detect a change in membrane potential'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'note';
description= 'voltage sensitivity determined at f1 the lower frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'definition two';
description= 'The DC electric potential applied to the cytoplasm of the cell where the potential outside the cell is defined as zero.'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)% 
ATTRIBUTE      = 'units';
description= 'per volt';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% 
VS_f2=4*max(diff(array_of_do_fits(1,j).q_high/(max(array_of_do_fits(1,j).q_high)))./(array_of_do_fits(1,j).potential(array_of_do_fits(1,j).NLpositions(1,1)+3)-array_of_do_fits(1,j).potential(array_of_do_fits(1,j).NLpositions(1,1)+2)));
type = H5T.copy ('H5T_NATIVE_DOUBLE');
space = H5S.create('H5S_SCALAR');
didefinition= 'alpha_f2'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_1x,space,type,name_def,VS_f2);
% % attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% % 
ATTRIBUTE      = 'definition';
description= 'A quality inherent in the membrane by virtue of the membranes disposition to detect a change in membrane potential'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'note';
description= 'voltage sensitivity determined at f2 the higher frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% % % 
ATTRIBUTE      = 'units';
description= 'per volt';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% % %
% % 
group_id_1w = H5G.create(fileID, '/transformed data set/transformed data sets for protocol electrical admittance dual-sine stimulus/data set of predicted values after fitting to 2-state Boltzmann', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');

didefinition= 'Cell electrical properties calculated by fitting charge versus potential data and capacitance versus potential data to a two-state Boltzmann model with constraints on predicted values.';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
 write_attribute_for_group( group_id_1w,dadefinition,ATTRIBUTE);
 ATTRIBUTE      = 'note about data transfromation used';
description=  'The displacement charge versus membrane potential (Q vs V) and the non-linear membrane capacitance, NLC versus membrane potential (C vs V) were fit to 2-state Boltzmann function (see: URL for reference) and the maximum charge, potential of maximum sensitivity and voltage sensitivity were determined from the fit.'; 
dadefinition= char(description);
 write_attribute_for_group(group_id_1w,dadefinition,ATTRIBUTE);
% 
% % 
% % % datasets
Qmax_qvsV=array_of_do_fits(1,j).twostate_qvsv_constrained_reverse(1,1);
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'Qmax_qvsV'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_1w,space,type,name_def,Qmax_qvsV);
% % %attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% % 
ATTRIBUTE      = 'definition';
description= 'Maximum charge calculated'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'note';
description= 'calculated from charge, q versus membrane potential, V data'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'pC';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% % %
Qmax_CmvsV=array_of_do_fits(1,j).twostate_cvsv_constrained(1,1);
type = H5T.copy ('H5T_NATIVE_DOUBLE');
space = H5S.create('H5S_SCALAR');
didefinition= 'Qmax_CmvsV'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset( group_id_1w,space,type,name_def,Qmax_CmvsV);
% % % attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% % 
ATTRIBUTE      = 'definition';
description= 'Maximum charge calculated'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'note';
description= 'calculated from non-linear capacitance versus membrane potential data'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'pC';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% % 
% % 
Vhalf_qvsV=array_of_do_fits(1,j).twostate_qvsv_constrained_reverse(1,3);
type = H5T.copy ('H5T_NATIVE_DOUBLE');
space = H5S.create('H5S_SCALAR');
didefinition= 'Vhalf_qvsV'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_1w,space,type,name_def,Vhalf_qvsV);
% % %attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% % 
ATTRIBUTE      = 'definition';
description= 'Voltage calculated when half of maximum charge was attained'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'note';
description= 'calculated from charge, q versus membrane potential, V data'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'volts';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% % %
Vhalf_CmvsV=array_of_do_fits(1,j).twostate_cvsv_constrained(1,3);
type = H5T.copy ('H5T_NATIVE_DOUBLE');
space = H5S.create('H5S_SCALAR');
didefinition= 'Vhalf_CmvsV'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_1w,space,type,name_def,Vhalf_CmvsV);
% % %attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% % 
ATTRIBUTE      = 'definition';
description= 'Voltage calculated when half of maximum charge was attained'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'note';
description= 'calculated from NLC, versus membrane potential, V data'; 
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
DATASETID=create_and_write_double_dataset(group_id_1w,space,type,name_def,alpha_qvsV);
% % %attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% % 
ATTRIBUTE      = 'definition';
description= 'Voltage sensitivity calculated'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'note ';
description= 'calculated from charge, q versus membrane potential, V data'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'per volt';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% % %
alpha_CmvsV=array_of_do_fits(1,j).twostate_cvsv_constrained(1,2);
type = H5T.copy ('H5T_NATIVE_DOUBLE');
space = H5S.create('H5S_SCALAR');
didefinition= 'alpha_CmvsV'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_1w,space,type,name_def,alpha_CmvsV);
%attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% % 
ATTRIBUTE      = 'definition';
description= 'Voltage sensitivity calculated'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'note';
description= 'calculated from NLC versus membrane potential, V data'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'per volt';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% % %
f1_or_f2=array_of_do_fits(1,j).choice;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_INT');
didefinition= 'f1_or_f2'; 
name_def= char(didefinition);
DATASETID=create_and_write_int_dataset(group_id_1w,space,type,name_def,f1_or_f2);
% % 
% % % attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'note';
description= 'Specifically stipulates whether the data for fitting to model was chosen from data obtained from f1 (low) or f2 (high) stimulus frequency '; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'note 2';
description= 'one and two represents: data obtained with f1 (lower) or f2 (higher) frequency stimulus';  
dadefinition= char(description);
% specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
clearvars -except dirname filename_fits count k_adult_male array_of_do_fits pathfunctions pathbegdata pathsavedata;

end
end

