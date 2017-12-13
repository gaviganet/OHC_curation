
function arm_assayv10(dirname, filename_fits,k_adult_male,count,pathfunctions,pathbegdata,pathsavedata)

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
newFolder='C:\Users\bfarrell\Documents\M files\OHC analysis\HDF5format\final functions';
genpath('newFolder');
cd(newFolder);
group_id_lc = H5G.create(fileID, '/assay', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'A planned process with the objective to produce information about the material entity that is the evaluant, by physically examining it or its proxies.';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_lc,dadefinition,ATTRIBUTE)

ATTRIBUTE      = 'imported_from';
description=  ' http://purl.obolibrary.org/obo/OBI_0000070';
dadefinition= char(description);
write_attribute_for_group(group_id_lc,dadefinition,ATTRIBUTE)
%
group_id_2a = H5G.create(fileID, '/assay/voltage clamp', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');

didefinition= 'A type of electrophysiological measurement employing a voltage clamp';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_2a,dadefinition,ATTRIBUTE)

didefinition= 'voltage clamp electrophysiological recording';
dadefinition= char(didefinition);
ATTRIBUTE      = 'editor preferred term';
write_attribute_for_group(group_id_2a,dadefinition,ATTRIBUTE)

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
group_id_3a = H5G.create(fileID, '/assay/voltage clamp/WCPCR', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');

didefinition= 'This technique reveals the electrical properties (e.g., capacitance and conductance) of the entire plasma membrane of a cell or the entire membrane of an organelle. Upon forming a high resistance seal (magnitude of the seal should be at least one(1) Giga[omega symbol]) with the patch pipette and membrane, a hole in the membrane is formed at the mouth of the pipette by application of pressure or an electric field (electrical poration) both applied through the pipette. Saline solution within the pipette flows into the interior of the cell and electrical contact is made between the cell and an amplifier via the patch pipette. An electrode (e.g. silver wire) is secured within the pipette. The electrode facilitates communication from the amplifier and head stage to the cell (e.g., to ensure voltage clamp) and from the cell to the amplifier (e.g., to ensure current measurement).';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_3a,dadefinition,ATTRIBUTE);

didefinition= 'whole cell patch clamp electrophysiological recording';
dadefinition= char(didefinition);
ATTRIBUTE      = 'editor preferred term';
write_attribute_for_group(group_id_3a,dadefinition,ATTRIBUTE);
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
group_id_4a = H5G.create(fileID, '/assay/voltage clamp/WCPCR/frequency dependent measurements', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'Group containing measurements of, or reliant upon, frequency';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_4a,dadefinition,ATTRIBUTE);
%
researcher=array_of_do_fits(1,j).researcher;
dofexp=array_of_do_fits(1,j).dofexp;
cellnumber=array_of_do_fits(1,j).cellnumber;
datasteward='Brenda Farrell, PhD';% this is an attribute common to all datasets

% Create datasets
Imlf=array_of_do_fits(1,j).Imlf;
type = H5T.copy ('H5T_NATIVE_DOUBLE');
space = H5S.create('H5S_SCALAR');
didefinition= 'Imlf(Y)'; 
name_def= char(didefinition);
dim0=1;
dimw =length(Imlf);

DATASETID=create_write_array_of_dble_dset(group_id_4a,space,type,dim0,dimw,name_def,Imlf); %calls function
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes


ATTRIBUTE      = 'definition';
description= 'Imaginary component of admittance measured at lower frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'siemens';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

fnadmittance=array_of_do_fits(1,j).fnadmittance;
ATTRIBUTE      = 'original filename of admittance file';
description={fnadmittance}; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
%
Relf=array_of_do_fits(1,j).Relf;

type = H5T.copy ('H5T_NATIVE_DOUBLE');
space = H5S.create('H5S_SCALAR');
didefinition= 'Relf(Y)'; 
name_def= char(didefinition);
dim0=1;
dimw =length(Relf);

DATASETID=create_write_array_of_dble_dset(group_id_4a,space,type,dim0,dimw,name_def,Relf); %calls function

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes

ATTRIBUTE      = 'definition';
description= 'Real component of admittance measured at lower frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

fnadmittance=array_of_do_fits(1,j).fnadmittance;
ATTRIBUTE      = 'original filename of admittance file';
description={fnadmittance}; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'siemens';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

Imhf=array_of_do_fits(1,j).Imhf;
type = H5T.copy ('H5T_NATIVE_DOUBLE');
space = H5S.create('H5S_SCALAR');
didefinition= 'Imhf(Y)'; 
name_def= char(didefinition);
dim0=1;
dimw =length(Imhf);

DATASETID=create_write_array_of_dble_dset(group_id_4a,space,type,dim0,dimw,name_def,Imhf); %calls function
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes

ATTRIBUTE      = 'definition';
description= 'Imaginary component of admittance measured at high frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'original filename of admittance file';
description={fnadmittance}; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'siemens';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

Rehf=array_of_do_fits(1,j).Rehf;
type = H5T.copy ('H5T_NATIVE_DOUBLE');
space = H5S.create('H5S_SCALAR');
dimw =length(Rehf);
didefinition= 'Rehf(Y)'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_4a,space,type,dim0,dimw,name_def,Rehf); %calls function
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Real component of admittance measured at high frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'original filename of admittance file';
description={fnadmittance}; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'siemens';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);

Rm=array_of_do_fits(1,j).Rm;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dimw =length(Rm);
dim0=1;
didefinition= 'Rm'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_4a,space,type,dim0,dimw,name_def,Rm); %calls function

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'membrane resistance'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'Mohm';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'editor note';
description= 'calculated from the admittance based upon model'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

Rs=array_of_do_fits(1,j).Rs;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dimw =length(Rs);
didefinition= 'Rs'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_4a,space,type,dim0,dimw,name_def,Rs); %calls function

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes

ATTRIBUTE      = 'definition';
description= 'series resistance'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'editor note';
description= 'calculated from the admittance based upon model'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'Mohm';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

Cmlf=array_of_do_fits(1,j).calf;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dimw =length(Cmlf);
didefinition= 'Cmlf'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_4a,space,type,dim0,dimw,name_def,Cmlf); %calls function

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'membrane capacitance determined at low frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'editor note';
description= 'calculated from the admittance based upon model'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'pF';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

Cmhf=array_of_do_fits(1,j).cahf;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dimw =length(Cmhf);
dim0=1;
didefinition= 'Cmhf'; 
name_def= char(didefinition);

DATASETID=create_write_array_of_dble_dset(group_id_4a,space,type,dim0,dimw,name_def,Cmhf); %calls function

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'membrane capacitance determined at high frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'editor note';
description= 'calculated from the admittance based upon model'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'pF';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

group_id_4a2 = H5G.create(fileID, '/assay/voltage clamp/WCPCR/frequency dependent measurements/stimulus', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');

didefinition= 'conditions of voltage clamp';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_4a2,dadefinition,ATTRIBUTE);

% creaate data sets
voltage=array_of_do_fits(1,j).voltage;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'voltage'; 
name_def= char(didefinition);
dimw =length(voltage);
dim0=1;
DATASETID=create_write_array_of_dble_dset(group_id_4a2,space,type,dim0,dimw,name_def,voltage); %calls function

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes

ATTRIBUTE      = 'definition';
description= ' DC potential applied to the cytoplasm of the cell where the potential outside the cell is defined as zero'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'note on stimulus';
description= 'two sine waves at stipulated simulating frequency each with peak to peak amplitude of 10 mV were added to DC Potential'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'volts';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

switch array_of_do_fits(1,j).freql
    case 781.250
        tnumber=512;
    case 390.625
        tnumber=1024;
    case 195.3125
         tnumber=2048;
end
freql=array_of_do_fits(1,j).freql;
freqh=array_of_do_fits(1,j).freqh;
freq=[freql
    freqh];
H5P.create ('H5P_DATASET_CREATE');
dimw =length(freq);
dim0=1;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');

didefinition= 'stimulating frequency'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_4a2,space,type,dim0,dimw,name_def,freq); %calls function

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'The low and high frequency of the sine waves used to stimulate the cell and measure the admittance'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'Hz';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

switch array_of_do_fits(1,j).freql
    case 781.250
        tnumber=512;
    case 390.625
        tnumber=1024;
    case 195.3125
         tnumber=2048;
end

array_of_do_fits(1,j).time=(1:1:length(array_of_do_fits(1,j).time))*tnumber*1E-5;
time=array_of_do_fits(1,j).time;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dimw =length(time);
dim0=1;
didefinition= 'time'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_4a2,space,type,dim0,dimw,name_def,time); %calls function
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'time that each data point was stimulated (and recorded) relative to start of the stimulus and recording'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
%H5DS.set_label(DATASETID,0,'seconds');
ATTRIBUTE      = 'units';
description= 'seconds';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)


%
group_id_5a = H5G.create(fileID, '/assay/voltage clamp/WCPCR/frequency dependent measurements/linear parameters', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');

didefinition= 'cell electrical properties determined when there is no voltage-dependent effect';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_5a,dadefinition,ATTRIBUTE);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
DATASETID=create_write_array_of_dble_dset(group_id_5a,space,type,dim0,dimw,name_def,LC_lf); %calls function
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'mean linear capacitance and standard deviation of mean determined at low frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'pF';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
%
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

DATASETID=create_write_array_of_dble_dset(group_id_5a,space,type,dim0,dimw,name_def,LC_hf); %calls function

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Mean linear capacitance and standard deviation of mean determined at high frequency'; 
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
DATASETID=create_write_array_of_dble_dset(group_id_5a,space,type,dim0,dimw,name_def,Rm); %calls function

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Membrane resistance determined when there is no non-linear effects present'; 
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
DATASETID=create_write_array_of_dble_dset(group_id_5a,space,type,dim0,dimw,name_def,Rs); %calls function
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Series resistance determined at voltage when there is no non-linear effects present'; 
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
didefinition= 'voltage drop'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5a,space,type,name_def,VD);

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'voltage drop calculated across the pipette'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
group_id_5b = H5G.create(fileID, '/assay/voltage clamp/WCPCR/frequency dependent measurements/voltage dependent', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'A subset of each measurement that is non-linear with respect to voltage';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_5b,dadefinition,ATTRIBUTE);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NLC_lf=array_of_do_fits(1,j).NLC_low;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dim0=1;
dimw =length(NLC_lf);
didefinition= 'NLC_lf'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_5b,space,type,dim0,dimw,name_def,NLC_lf); %calls function
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
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
DATASETID=create_write_array_of_dble_dset(group_id_5b,space,type,dim0,dimw,name_def,NLC_hf); %calls function
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Non-linear or voltage dependent capacitance determined at high frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'pF';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
%
q_hf=array_of_do_fits(1,j).q_high;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dim0=1;
dimw =length(q_hf);
didefinition= 'q_hf'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_5b,space,type,dim0,dimw,name_def,q_hf); %calls function
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Charge moved as a function of potential at high frequency'; 
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
DATASETID=create_write_array_of_dble_dset(group_id_5b,space,type,dim0,dimw,name_def,q_lf); %calls function
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Charge moved as a function of potential at low frequency'; 
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
didefinition= 'potential'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_5b,space,type,dim0,dimw,name_def,potential); %calls function
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Transmembrane potential of non-linear component'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'volts';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
group_id_6a = H5G.create(fileID, '/assay/voltage clamp/WCPCR/frequency dependent measurements/voltage dependent/non linear parameters', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'Cell electrical properties determined when there is a voltage-dependent effect';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_6a,dadefinition,ATTRIBUTE);

%
NLC_lf_peak=array_of_do_fits(1,j).NLC_low_peak(1,1);
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'NLC_lf_peak'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_6a,space,type,name_def,NLC_lf_peak);
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes

ATTRIBUTE      = 'definition';
description= 'Peak capacitance determined at low frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'pF';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
%
NLC_hf_peak=array_of_do_fits(1,j).NLC_high_peak(1,1);
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'NLC_hf_peak'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_6a,space,type,name_def,NLC_hf_peak);

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes

ATTRIBUTE      = 'definition';
description= 'Peak capacitance determined at high frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'pF';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

Q_lf=array_of_do_fits(1,j).Q_low_total(1,1);
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'Q_lf'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_6a,space,type,name_def,Q_lf);
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
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
DATASETID=create_and_write_double_dataset(group_id_6a,space,type,name_def,Q_hf);
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Maximum charge movement high frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'pC';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
%
Vpeakm=array_of_do_fits(1,j).Vm(1,1);
Vpeakcorr=array_of_do_fits(1,j).Vmcorr(1,1);
Vpeak=[Vpeakm Vpeakcorr];
dimw =length(Vpeak);
dim0=1;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');

didefinition= 'Vpeak'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_6a,space,type,dim0,dimw,name_def,Vpeak); %calls function

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes

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
DATASETID=create_and_write_double_dataset(group_id_6a,space,type,name_def,VSmax_lf);
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes

ATTRIBUTE      = 'definition';
description= 'maximum voltage sensitivity measured at low frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'per volt';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

VSmax_hf=max(diff(array_of_do_fits(1,j).q_high/(max(array_of_do_fits(1,j).q_high)))./(array_of_do_fits(1,j).potential(array_of_do_fits(1,j).NLpositions(1,1)+3)-array_of_do_fits(1,j).potential(array_of_do_fits(1,j).NLpositions(1,1)+2)));
type = H5T.copy ('H5T_NATIVE_DOUBLE');
space = H5S.create('H5S_SCALAR');
didefinition= 'VSmax_hf'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_6a,space,type,name_def,VSmax_hf);
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes

ATTRIBUTE      = 'definition';
description= 'maximum voltage sensitivity measured at high frequency'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'per volt';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
%
group_id_6b = H5G.create(fileID, '/assay/voltage clamp/WCPCR/frequency dependent measurements/voltage dependent/non linear parameters/calculated with model', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'Cell electrical properties calculated by fitting charge versus potential data and capacitance versus potential data to a two-state Boltzmann model with constraints on values';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_6b,dadefinition,ATTRIBUTE);

% datasets
Qmax_qvsV=array_of_do_fits(1,j).twostate_qvsv_constrained_reverse(1,1);
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'Qmax_qvsV'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_6b,space,type,name_def,Qmax_qvsV);
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes

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
DATASETID=create_and_write_double_dataset(group_id_6b,space,type,name_def,Qmax_CvsV);
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes

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
DATASETID=create_and_write_double_dataset(group_id_6b,space,type,name_def,Vhalf_qvsV);
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes

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
DATASETID=create_and_write_double_dataset(group_id_6b,space,type,name_def,Vhalf_CvsV);
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes

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
DATASETID=create_and_write_double_dataset(group_id_6b,space,type,name_def,alpha_qvsV);
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes

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
DATASETID=create_and_write_double_dataset(group_id_6b,space,type,name_def,alpha_CvsV);
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes

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
DATASETID=create_and_write_int_dataset(group_id_6b,space,type,name_def,low_or_high);

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'note';
description= 'Specifically stipulates whether the low or high frequency q versus V data was chosen for fitting to model'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'note 2';
description= 'one and two represents: data obtained with low or high frequency stimulus';  
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
group_id_4b = H5G.create(fileID, '/assay/voltage clamp/WCPCR/DC measurements', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');

didefinition= 'Group containing measurements at zero-frequency'; % ASK colleagues best definition here
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_4b,dadefinition,ATTRIBUTE)

T=isempty(array_of_do_fits(1,j).Current_DC);
if(T==1)

else
current_DC=array_of_do_fits(1,j).Current_DC;
type = H5T.copy ('H5T_NATIVE_DOUBLE');    
space = H5S.create('H5S_SCALAR');
dimw =length(current_DC);
dim0=1;
didefinition= 'current_DC';
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_4b,space,type,dim0,dimw,name_def,current_DC);  %calls function

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes

ATTRIBUTE      = 'definition';
description= 'Current measured'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'pA'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
fnDC=array_of_do_fits(1,j).fname;
ATTRIBUTE      = 'original filename of saved IvsV data';
description={fnDC}; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

fnDC_TC=array_of_do_fits(1,j).fnameTC;
ATTRIBUTE      = 'filename of saved IvsV data with interval time between points';
description_two={fnDC_TC}; 
dadefinition= char(description_two);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
end

T=isempty(array_of_do_fits(1,j).V);
if(T==1)
else
 V_hold=  array_of_do_fits(1,j).V;
type = H5T.copy ('H5T_NATIVE_DOUBLE');    
space = H5S.create('H5S_SCALAR');
dimw =length(V_hold);
dim0=1;
didefinition= 'V_hold'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_4b,space,type,dim0,dimw,name_def,V_hold);  %calls function
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'DC clamp potential'; 
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
DATASETID=create_write_array_of_dble_dset(group_id_4b,space,type,dim0,dimw,name_def,R);  %calls function
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'resistance i.e.,(Rm+Rs) equivalent to reciprocal of conductance: determined from the derivative between adjacent [V_hold, I_mean] points and then finding inverse'; 
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
DATASETID=create_write_array_of_dble_dset(group_id_4b,space,type,dim0,dimw,name_def,I_mean);  %calls function
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'the mean and standard deviation of the current measured at each voltage'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'pA'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
end
group_id_5z = H5G.create(fileID, '/assay/voltage clamp/WCPCR/DC measurements/stimulus_DC', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'conditions of voltage clamp for DC'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_5z,dadefinition,ATTRIBUTE);

% add DC datasets
T=isempty(array_of_do_fits(1,j).delta_time);
if(T==1)
   
else
delta_time=  array_of_do_fits(1,j).delta_time;
type = H5T.copy ('H5T_NATIVE_DOUBLE');    
space = H5S.create('H5S_SCALAR');
dim0=1;
dimw =length(delta_time);
didefinition= 'delta_time'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_5z,space,type,dim0,dimw,name_def,delta_time);  %calls function
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'time that each data point was recorded relative to start of the stimulus'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'seconds';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
end
T=isempty(array_of_do_fits(1,j).voltage_DC);
if(T==1)
   
else
   voltage_DC=  array_of_do_fits(1,j).voltage_DC;
type = H5T.copy ('H5T_NATIVE_DOUBLE');    
space = H5S.create('H5S_SCALAR');
dimw =length(voltage_DC);
dim0=1;

didefinition= 'voltage_DC'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_5z,space,type,dim0,dimw,name_def, voltage_DC);  %calls function
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'note on stimulus';
description= 'The DC potential was held at constant value and then ramped to most negative value and then increased in 10 mV steps and held at each voltage for 0.2 seconds'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'definition';
description= 'DC potential applied to inside the cell where the potential outside of the cell is defined as zero'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'volts';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
end
group_id_4c= H5G.create(fileID, '/assay/voltage clamp/WCPCR/experimental conditions', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'Group containing conditions of experiment that was conducted';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_4c,dadefinition,ATTRIBUTE)

group_id_4d = H5G.create(fileID, '/assay/voltage clamp/WCPCR/experimental conditions/physical and temporal', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'factors that may influence results like pressure, temperature and time of the recordings'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_4d,dadefinition,ATTRIBUTE)
%%%%%%%%%%%%%%%%
%datasets
temperature=array_of_do_fits(1,j).temp;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');    
didefinition= 'temperature'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_4d,space,type,name_def,temperature);

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'temperature during experiment'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'degrees centigrade';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)


pressure=array_of_do_fits(1,j).pressure;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');    
didefinition= 'pressure'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_4d,space,type,name_def,pressure);

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'pressure at the pipette'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'kPa';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

time_of_animal_death=array_of_do_fits(1,j).tod;
type = H5T.copy ('H5T_C_S1');
space=H5S.create('H5S_SCALAR');
didefinition= 'time_of_animal_death'; 
name_def= char(didefinition);
DATASETID=create_and_write_string_dataset(group_id_4d,space,type,name_def,time_of_animal_death);

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'time at which animal vital functions ceased'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

time_of_experiment=array_of_do_fits(1,j).toe;
type = H5T.copy ('H5T_C_S1');
space=H5S.create('H5S_SCALAR');
didefinition= 'time_of_experiment'; 
name_def= char(didefinition);
DATASETID=create_and_write_string_dataset(group_id_4d,space,type,name_def,time_of_experiment);

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'time at which assay was conducted'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);

elapsed_time=array_of_do_fits(1,j).dT;
if(strcmp(elapsed_time,'NA'))
    elapsed_time=[];
    space = H5S.create('H5S_NULL');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
else    
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
end    
didefinition= 'elapsed_time'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_4d,space,type,name_def,elapsed_time);

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); 
ATTRIBUTE      = 'definition';
description= 'time of recording relative to death of animal'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'minutes';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);

T=isempty(array_of_do_fits(1,j).tofexp_DC);
if(T==1)
   
else
time_of_DC_experiment=array_of_do_fits(1,j).tofexp_DC;
type = H5T.copy ('H5T_C_S1');
space=H5S.create('H5S_SCALAR');
didefinition= 'time_of_DC_experiment'; 
name_def= char(didefinition);

DATASETID=create_and_write_string_dataset(group_id_4d,space,type,name_def,time_of_DC_experiment);

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'time at which DC assay was conducted'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
group_id_5a = H5G.create(fileID, '/assay/voltage clamp/WCPCR/experimental conditions/drug extracellular', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'drugs added to the extracellular solution during experiment'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_5a,dadefinition,ATTRIBUTE)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Add datasets
    if(strcmp(array_of_do_fits(1,j).toxins,'No'))
       Xe991=[];
       space = H5S.create('H5S_NULL');
       type = H5T.copy ('H5T_NATIVE_DOUBLE');
    else
        Xe991=60;
        space=H5S.create('H5S_SCALAR');
        type = H5T.copy ('H5T_NATIVE_DOUBLE');
    end     

didefinition= 'Xe991'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5a,space,type,name_def,Xe991);

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes

ATTRIBUTE      = 'imported_from';
description= 'http://purl.obolibrary.org/obo/CHEBI_35046';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'common chemical name';
description= 'XE 991 dihydrochloride';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE      = 'units';
description= 'micromolar';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
group_id_5b = H5G.create(fileID, '/assay/voltage clamp/WCPCR/experimental conditions/drug intracellular', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'drugs added to the patch pipette during experiment'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_5b,dadefinition,ATTRIBUTE)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
group_id_5c = H5G.create(fileID, '/assay/voltage clamp/WCPCR/experimental conditions/extracellular solution', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'saline solution used to bathe the sampled cell'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_5c,dadefinition,ATTRIBUTE)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CsCl=20;

space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'CsCl'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5c,space,type,name_def,CsCl);

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'imported_from';
description= 'http://www.commonchemistry.org/ChemicalDetail.aspx?ref=7647-17-8'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'common chemical name';
description= 'cesium chloride (CsCl)';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE      = 'units';
description= 'mM';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

NaCl=105;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'NaCl'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5c,space,type,name_def,NaCl);

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes

ATTRIBUTE      = 'imported_from';
description= 'http://www.commonchemistry.org/ChemicalDetail.aspx?ref=7647-14-5'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'common chemical name';
description= 'Sodium chloride (NaCl)';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE      = 'units';
description= 'mM';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

HEPES=10;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'HEPES'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5c,space,type,name_def,HEPES);

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'imported_from';
description= 'http://www.commonchemistry.org/ChemicalDetail.aspx?ref=7365-45-9'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'common chemical name';
description= 'HEPES';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE      = 'units';
description= 'mM';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

TEACL=20;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'TEACL'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5c,space,type,name_def,TEACL);
attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'imported_from';
description= 'http://www.commonchemistry.org/ChemicalDetail.aspx?ref=7791-13-1'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'common chemical name';
description= 'tetraethylammonium (TEA) chloride';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE      = 'units';
description= 'mM';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

CoCl2=2;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'CoCL2'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5c,space,type,name_def,CoCl2);

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'imported_from';
description= 'http://www.commonchemistry.org/ChemicalDetail.aspx?ref=7791-13-1'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'common chemical name';
description= 'Cobalt chloride (CoCl2), hexahydrate';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE      = 'units';
description= 'mM';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

MgCl2=2;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'MgCl2'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5c,space,type,name_def,MgCl2);

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'imported_from';
description= 'http://www.commonchemistry.org/ChemicalDetail.aspx?ref=7791-18-6'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'common chemical name';
description= 'Magnesium chloride (MgCl2), hexahydrate';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE      = 'units';
description= 'mM';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

CaCl2=2;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'CaCl2'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5c,space,type,name_def,CaCl2);


attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'imported_from';
description= 'http://www.commonchemistry.org/ChemicalDetail.aspx?ref=10043-52-4&terms=calcium+chloride'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'common chemical name';
description= 'calcium chloride ANHYDROUS';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE      = 'units';
description= 'mM';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)


osmolality_ext=array_of_do_fits(1,j).osmolarityext;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'osmolality_ext'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5c,space,type,name_def,osmolality_ext);

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'A concentration quality inhering in a bearer by virtue of the bearers amount of osmoles of solute per kilogram of solvent. '; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description = 'mOsm/kg';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'imported_from';
description= 'http://purl.obolibrary.org/obo/PATO_0002027'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'note';
description= 'glucose was added to ensure solution exhibited constant osmolality'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

pH=array_of_do_fits(1,j).pHext;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'pH_ext';
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5c,space,type,name_def,pH);

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Negative logarithm (base 10) of the activity of hydrogen in a solution. In a diluted solution, this activity is equal to the concentration of protons (in fact of ions H3O+). The pH is proportional to the chemical potential of hydrogen, by the relation: pH = -�H � 2.3RT. (with �H=-RTln[H+]). '; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'imported_from';
description= 'http://purl.obolibrary.org/obo/SBO_0000304'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'note';
description= 'Cesium hydroxide was added to bring solution to constant pH'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
group_id_5d = H5G.create(fileID, '/assay/voltage clamp/WCPCR/experimental conditions/intracellular solution', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');

didefinition= 'Saline solution within the patch pipette'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_5d,dadefinition,ATTRIBUTE)

% create data sets 
if(array_of_do_fits(1,j).intracellularchloride==10)
CsCl=6;
else
CsCl=140;
end

space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'CsCl'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5d,space,type,name_def,CsCl);

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes

ATTRIBUTE      = 'imported_from';
description= 'http://www.commonchemistry.org/ChemicalDetail.aspx?ref=7647-17-8'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'common chemical name';
description= 'Cesium chloride (CsCl)';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE      = 'units';
description= 'mM';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

HEPES=10;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'HEPES'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5d,space,type,name_def,HEPES);

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes

ATTRIBUTE      = 'imported_from';
description= 'http://www.commonchemistry.org/ChemicalDetail.aspx?ref=7365-45-9'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'common chemical name';
description= 'HEPES';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);

ATTRIBUTE      = 'units';
description= 'mM';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

EGTA=10;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'EGTA'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5d,space,type,name_def,EGTA);

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward);

ATTRIBUTE      = 'imported_from';
description= 'http://www.commonchemistry.org/ChemicalDetail.aspx?ref=67-42-5'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'common chemical name';
description= 'EGTA';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE      = 'units';
description= 'mM';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

if(array_of_do_fits(1,j).intracellularchloride==10)
Csglutamate=133;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
else
Csglutamate=[];
space = H5S.create('H5S_NULL');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
end

didefinition= 'CsGlutamate'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5d,space,type,name_def,Csglutamate);

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'cesium glutamate made by reacting glutamic acid (acid) with cesium hydroxide (base)'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'mM';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

MgCl2=2;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'MgCl2'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5d,space,type,name_def,MgCl2);

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'imported_from';
description= 'http://www.commonchemistry.org/ChemicalDetail.aspx?ref=7791-18-6'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'common chemical name';
description= 'Magnesium chloride (MgCl2), hexahydrate';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE      = 'units';
description= 'mM';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

osmolality=array_of_do_fits(1,j).osmolarityint;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'osmolality_int'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5d,space,type,name_def,osmolality);

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'A concentration quality inhering in a bearer by virtue of the bearers amount of osmoles of solute per kilogram of solvent. '; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'mOsm/kg';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'imported_from';
description= 'http://purl.obolibrary.org/obo/PATO_0002027'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'note';
description= 'glucose was added to ensure solution exhibited constant osmolality'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

pH=array_of_do_fits(1,j).pHint;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition='pH_int';
name_def= char(didefinition);

DATASETID=create_and_write_double_dataset(group_id_5d,space,type,name_def,pH);

attribute_general(DATASETID,researcher, dofexp, cellnumber,datasteward); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Negative logarithm (base 10) of the activity of hydrogen in a solution. In a diluted solution, this activity is equal to the concentration of protons (in fact of ions H3O+). The pH is proportional to the chemical potential of hydrogen, by the relation: pH = -�H � 2.3RT. (with �H=-RTln[H+]). '; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'imported_from';
description= 'http://purl.obolibrary.org/obo/SBO_0000304'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'note';
description= 'Cesium hydroxide was added to bring solution to constant pH'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

clearvars -except dirname filename_fits count k_adult_male array_of_do_fits pathfunctions pathbegdata pathsavedata;

end
end