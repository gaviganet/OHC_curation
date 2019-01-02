
function arm_assayv11a2(dirname, filename_fits,k_adult_male,count,pathfunctions,pathbegdata,pathsavedata)
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
 group_id_2a = H5G.create(fileID, '/assay/voltage clamp assay', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
% 
 didefinition= 'A cellular electrophysiology assay where the membrane potential of a cell is controlled. This is accomplished through a feedback mechanism where any change in membrane potential is countered by permitting electrical current to flow into or out of the cell. ';
 dadefinition= char(didefinition);
 ATTRIBUTE      = 'definition';
 write_attribute_for_group(group_id_2a,dadefinition,ATTRIBUTE)

 didefinition= 'OBI';
 dadefinition= char(didefinition);
 ATTRIBUTE      = 'Imported and adapted from';
 write_attribute_for_group(group_id_2a,dadefinition,ATTRIBUTE)

% 
didefinition= 'voltage clamp electrophysiological recording';
dadefinition= char(didefinition);
ATTRIBUTE      = 'editor preferred term';
write_attribute_for_group(group_id_2a,dadefinition,ATTRIBUTE)
%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 group_id_3a = H5G.create(fileID, '/assay/voltage clamp assay/whole-cell patch clamp voltage clamp assay', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
% 
didefinition= 'A patch-clamp configuration where the patch pipette electrode is left in place on the cell membrane until a gigaohm seal is formed between the membrane and the pipette. After which the membrane patch is perforated either chemically, or by application of pressure or by use of an electric field all applied through the pipette. These perforations provide for an electrical connection from the interior of the pipette to the intracellular space of the cell. Measurements made with this voltage clamp technique involve recording currents associated with the entire plasma membrane of a cell or the entire membrane of an organelle.'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
 write_attribute_for_group(group_id_3a,dadefinition,ATTRIBUTE);
% 
didefinition= 'whole cell patch clamp electrophysiological recording';
dadefinition= char(didefinition);
ATTRIBUTE      = 'editor preferred term';
write_attribute_for_group(group_id_3a,dadefinition,ATTRIBUTE);

didefinition= 'OBI';
dadefinition= char(didefinition);
ATTRIBUTE      = 'Imported and adapted from';
write_attribute_for_group(group_id_3a,dadefinition,ATTRIBUTE)
group_id_3a2 = H5G.create(fileID, '/assay/voltage clamp assay/whole-cell patch clamp voltage clamp assay/electrical admittance dual-sine stimulus', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
% 
didefinition= 'The membrane potential was ramped from negative 0.18 to positive 0.18 V, and initially and finally held at membrane potential of negative 0.06 V.  This DC ramp was added to a dual-frequency stimulus. The dual-frequency stimulus was the sum of two 10 mV peak-to-peak sine waves at frequency, f1 and f2, (where f2 =2 times f1).  The membrane current was measured every 10 microseconds and a Fast Fourier Transform conducted from a series of current measurements equivalent to the time that 4 (f1) and 8 (f2) dual frequency sine waves were applied across the membrane.  The real and imaginary parts of the admittance were calculated by dividing the complex current by the complex voltage.'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
 write_attribute_for_group(group_id_3a2,dadefinition,ATTRIBUTE);
group_id_3a3 = H5G.create(fileID, '/assay/voltage clamp assay/whole-cell patch clamp voltage clamp assay/membrane current (I) as a function of membrane potential (V) (I vs V plot)', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
% 
didefinition= 'A square wave pulse with an amplitude of 0.01 volts was applied to the cell via the pipette to determine the membrane current as a function of membrane potential plot. The voltage was ramped from -0.13 to +0.13 volts in 0.01 volt steps and current was sampled every 100 microseconds for a 1000 times at each voltage. The conductance was calculated from the change in the steady-state part of the measured current relative to the change in the membrane potential, and the resistance determined from the reciprocal.'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
 write_attribute_for_group(group_id_3a3,dadefinition,ATTRIBUTE);

time_of_experiment=array_of_do_fits(1,j).toe; 
%Change to ISO time
dofexp=array_of_do_fits(1,j).dofexp;
time2=strsplit(char(dofexp),'/'); 
time3=(strcat(char(time2(3)),'-',char(time2(1)),'-',char(time2(2))));
time4=char(time_of_experiment);
time5=strsplit(time4,':');
 k=contains(time5(3),'P');
 if(k==1)
  time6=strtok(time5(3),'P');
else
  time6=strtok(time5(3),'A');
 end   
time7=(strcat(time3,"  ",char(time5(1)),':',char(time5(2)),':',char(time6(1))));
time_of_experiment=char(time7);

type = H5T.copy ('H5T_C_S1');
space=H5S.create('H5S_SCALAR');
didefinition= 'start_time'; 
name_def= char(didefinition);
DATASETID=create_and_write_string_dataset(group_id_3a2,space,type,name_def,time_of_experiment);
% 
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'A start time is a time instant pertaining to the time at which a process begins. In this case it is the time that assay begins.'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE      = 'imported from';
description= 'http://semanticscience.org/resource/SIO_000669'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
% 
elapsed_time=array_of_do_fits(1,j).dT;
if(strcmp(elapsed_time,'NA'))
    elapsed_time=[];
    space = H5S.create('H5S_NULL');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
else    
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
end    
didefinition= 'time_interval_from_death'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_3a2,space,type,name_def,elapsed_time);
% 
 ATTRIBUTE      = 'definition';
description= 'time interval is a contiguous temporal region having some duration.  In this case it is the time interval between death of animal and commencement of assay'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'imported from';
description= 'http://semanticscience.org/resource/SIO_000417'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'minutes';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
% %
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 group_id_4a = H5G.create(fileID, '/assay/voltage clamp assay/whole-cell patch clamp voltage clamp assay/electrical admittance dual-sine stimulus/intracellular electrophysiology stimulus', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');

didefinition= 'The electrical protocol (e.g. pulse, ramp) used during a intracellular electrophysiology recording';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_4a,dadefinition,ATTRIBUTE);

% % creaate data sets
voltage=array_of_do_fits(1,j).voltage;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'membrane_potential'; 
name_def= char(didefinition);
dimw =length(voltage);
dim0=1;
DATASETID=create_write_array_of_dble_dset(group_id_4a,space,type,dim0,dimw,name_def,voltage); %calls function
% 

ATTRIBUTE      = 'units';
description= 'volts';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'definition';
description= 'A quality inhering in a cells plasma membrane by virtue of the electrical potential difference across it.';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'definition and label imported from';
description= 'http://purl.obolibrary.org/obo/PATO_0001462';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'definition two';
description= 'The DC electric potential applied to the cytoplasm of the cell where the potential outside the cell is defined as zero.'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

switch array_of_do_fits(1,j).freql
    case 781.250;
        tnumber=512;
    case 390.625;
        tnumber=1024;
    case 195.3125;
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

didefinition= 'frequency'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_4a,space,type,dim0,dimw,name_def,freq); %calls function

ATTRIBUTE      = 'definition';
description= 'physical quality which inheres in a bearer by virtue of the number of the bearers repetitive actions in a particular time.' ;
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'imported from';
description= ' http://purl.obolibrary.org/obo/PATO_0000044'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'definition for experiment';
description= 'The two frequencies, f1 and f2 (where f2 = 2 X f1) of the AC voltage sine waves used to stimulate the cell and measure the admittance';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% 
ATTRIBUTE      = 'units';
description= 'Hz';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

amp=0.01;
H5P.create ('H5P_DATASET_CREATE');
dimw =length(amp);
dim0=1;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');

didefinition= 'amplitude'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_4a,space,type,dim0,dimw,name_def,amp); %calls function
% 
ATTRIBUTE      = 'definition';
description= 'It is a physical quality of a process inhering in a bearer by virtue of the size of the bearers maximum displacement from the normal position, when periodic motion is taking place'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE      = 'imported from';
description= 'http://purl.obolibrary.org/obo/PATO_0000080'; 
dadefinition= char(description);
ATTRIBUTE      = 'definition for experiment';
description= 'The amplitude of the AC dual sine stimulus';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
% 
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
% 
array_of_do_fits(1,j).time=(1:1:length(array_of_do_fits(1,j).time))*tnumber*1E-5;
time=array_of_do_fits(1,j).time;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dimw =length(time);
dim0=1;
didefinition= 'time'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_4a,space,type,dim0,dimw,name_def,time); %calls function
%attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'time that each data point was stimulated (and recorded) relative to start of the stimulus and recording'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
%H5DS.set_label(DATASETID,0,'seconds');
ATTRIBUTE      = 'units';
description= 'seconds';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     
group_id_5= H5G.create(fileID, '/assay/voltage clamp assay/whole-cell patch clamp voltage clamp assay/electrical admittance dual-sine stimulus/study design controlled variable', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'Controlled variable specification  is a part of a study design. They are the entities that could vary, but are kept constant to prevent their influence on the effect of the independent variable on the dependent.';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_5,dadefinition,ATTRIBUTE)
didefinition= 'http://purl.obolibrary.org/obo/OBI_0000785';
dadefinition= char(didefinition);
ATTRIBUTE      = 'imported from';
write_attribute_for_group(group_id_5,dadefinition,ATTRIBUTE)
 group_id_5z= H5G.create(fileID, '/assay/voltage clamp assay/whole-cell patch clamp voltage clamp assay/electrical admittance dual-sine stimulus/chemical solution', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'A material entity that is made up of at least 2 scattered molecular aggregates, one playing the role of solvent and the other one playing the role of solute.';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_5z,dadefinition,ATTRIBUTE)
didefinition= 'http://purl.obolibrary.org/obo/OBI_0302729';
dadefinition= char(didefinition);
ATTRIBUTE      = 'imported from';
write_attribute_for_group(group_id_5z,dadefinition,ATTRIBUTE)

 group_id_5c= H5G.create(fileID, '/assay/voltage clamp assay/whole-cell patch clamp voltage clamp assay/electrical admittance dual-sine stimulus/chemical solution/extracellular solution', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'solution used to bathe cells'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_5c,dadefinition,ATTRIBUTE)

group_id_5d= H5G.create(fileID, '/assay/voltage clamp assay/whole-cell patch clamp voltage clamp assay/electrical admittance dual-sine stimulus/chemical solution/extracellular solution/concentration', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'The quantity of a substance per unit volume or weight; a measure of the amount of substance present in a unit amount of mixture, particularly, the amount of solute dissolved in a solvent. The amounts can be expressed as moles, masses, volumes, or parts.'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_5d,dadefinition,ATTRIBUTE)
didefinition= ' http://purl.obolibrary.org/obo/NCIT_C41185';

dadefinition= char(didefinition);
ATTRIBUTE      = 'imported from';
write_attribute_for_group(group_id_5d,dadefinition,ATTRIBUTE)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % Add datasets
    if(strcmp(array_of_do_fits(1,j).toxins,'No'))
       Xe991=[];
       space = H5S.create('H5S_NULL');
       type = H5T.copy ('H5T_NATIVE_DOUBLE');
    else
        Xe991=60;
        space=H5S.create('H5S_SCALAR');
        type = H5T.copy ('H5T_NATIVE_DOUBLE');
     end     
% % 
didefinition= 'Xe991'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5d,space,type,name_def,Xe991);
% 
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% 
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
%     
CsCl=20;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'CsCl'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5d,space,type,name_def,CsCl);

%attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'imported_from';
description= 'http://purl.obolibrary.org/obo/CHEBI_63039'; 
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
% 
NaCl=105;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'NaCl'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5d,space,type,name_def,NaCl);

%attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes

ATTRIBUTE      = 'imported_from';
description= 'http://purl.obolibrary.org/obo/CHEBI_26710'; 
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
% 
HEPES=10;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'Hepes'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5d,space,type,name_def,HEPES);

%attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'imported_from';
description= 'http://purl.obolibrary.org/obo/CHEBI_42334'; 
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
% 
TEACL=20;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'TEAC'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5d,space,type,name_def,TEACL);
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'imported_from';
description= 'http://purl.obolibrary.org/obo/CHEBI_78161'; 
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
% 
CoCl2=2;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'CoCl2'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5d,space,type,name_def,CoCl2);

%attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'imported_from';
description= 'http://purl.obolibrary.org/obo/CHEBI_53503'; 
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
% 
MgCl2=2;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'MgCl2'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5d,space,type,name_def,MgCl2);

%attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'imported_from';
description= 'http://purl.obolibrary.org/obo/CHEBI_86345';

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
DATASETID=create_and_write_double_dataset(group_id_5d,space,type,name_def,CaCl2);


%attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'imported_from';
description= 'http://purl.obolibrary.org/obo/CHEBI_3312'; 
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
% 
% 
osmolality_ext=array_of_do_fits(1,j).osmolarityext;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'osmolality_ext'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5c,space,type,name_def,osmolality_ext);
% 
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
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
% 
pH=array_of_do_fits(1,j).pHext;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'pH_ext';
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5c,space,type,name_def,pH);
ATTRIBUTE      = 'definition';
description= 'A concentration quality inhering in a bearer by virtue of the bearers containing acid (hydrogen ions)'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'imported from';
description= ' http://purl.obolibrary.org/obo/PATO_0001842';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'alternative definition';
description= 'Negative logarithm (base 10) of the activity of hydrogen in a solution. In a diluted solution, this activity is equal to the concentration of protons (in fact of ions H3O+). The pH is proportional to the chemical potential of hydrogen, by the relation: pH = -µH ÷ 2.3RT. (with µH=-RTln[H+]). '; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'alternative definition imported_from';
description= 'http://purl.obolibrary.org/obo/SBO_0000304'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% 
ATTRIBUTE      = 'note';
description= 'Cesium hydroxide was added to bring solution to constant pH'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
group_id_5e= H5G.create(fileID, '/assay/voltage clamp assay/whole-cell patch clamp voltage clamp assay/electrical admittance dual-sine stimulus/chemical solution/solution in pipette', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
% 
didefinition= 'solution placed within the patch pipette'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_5e,dadefinition,ATTRIBUTE)

group_id_5f= H5G.create(fileID, '/assay/voltage clamp assay/whole-cell patch clamp voltage clamp assay/electrical admittance dual-sine stimulus/chemical solution/solution in pipette/concentration', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
% 
didefinition= 'The quantity of a substance per unit volume or weight; a measure of the amount of substance present in a unit amount of mixture, particularly, the amount of solute dissolved in a solvent. The amounts can be expressed as moles, masses, volumes, or parts. [def-source: NCI]';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_5f,dadefinition,ATTRIBUTE)
didefinition= ' http://purl.obolibrary.org/obo/NCIT_C41185'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'imported from';
write_attribute_for_group(group_id_5f,dadefinition,ATTRIBUTE);

% 
% % create data sets 
if(array_of_do_fits(1,j).intracellularchloride==10)
CsCl=6;
else
CsCl=140;
end
% 
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'CsCl'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5f,space,type,name_def,CsCl);
% 
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% 
ATTRIBUTE      = 'imported_from';
description= 'http://purl.obolibrary.org/obo/CHEBI_63039'; 
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
% 
HEPES=10;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'Hepes'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5f,space,type,name_def,HEPES);

ATTRIBUTE      = 'imported_from';
description= 'http://purl.obolibrary.org/obo/CHEBI_42334'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE      = 'common chemical name';
description= 'HEPES';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);

ATTRIBUTE      = 'units';
description= 'mM';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% 
EGTA=10;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'EGTA'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5f,space,type,name_def,EGTA);
% 
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder);
% 
ATTRIBUTE      = 'imported_from';
description= 'http://purl.obolibrary.org/obo/CHEBI_30740';
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
% 
if(array_of_do_fits(1,j).intracellularchloride==10)
Csglutamate=133;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
else
Csglutamate=[];
space = H5S.create('H5S_NULL');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
end
% 
didefinition= 'CsGlutamate'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5f,space,type,name_def,Csglutamate);
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
DATASETID=create_and_write_double_dataset(group_id_5f,space,type,name_def,MgCl2);
ATTRIBUTE      = 'imported_from';
description= 'http://purl.obolibrary.org/obo/CHEBI_86345';
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
% 
osmolality=array_of_do_fits(1,j).osmolarityint;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition= 'osmolality_int'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5e,space,type,name_def,osmolality);
% 
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
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
% 
pH=array_of_do_fits(1,j).pHint;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
didefinition='pH_int';
name_def= char(didefinition);

DATASETID=create_and_write_double_dataset(group_id_5e,space,type,name_def,pH);
% 
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'A concentration quality inhering in a bearer by virtue of the bearers containing acid (hydrogen ions)'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'imported from';
description= ' http://purl.obolibrary.org/obo/PATO_0001842';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'alternative definition';
description= 'Negative logarithm (base 10) of the activity of hydrogen in a solution. In a diluted solution, this activity is equal to the concentration of protons (in fact of ions H3O+). The pH is proportional to the chemical potential of hydrogen, by the relation: pH = -µH ÷ 2.3RT. (with µH=-RTln[H+]). '; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'alternative definition imported_from';
description= 'http://purl.obolibrary.org/obo/SBO_0000304'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'note';
description= 'Cesium hydroxide was added to bring solution to constant pH'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
group_id_6= H5G.create(fileID, '/assay/voltage clamp assay/whole-cell patch clamp voltage clamp assay/electrical admittance dual-sine stimulus/measurement datum', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'A measurement datum is an information content entity that is a recording of the output of a measurement such as produced by a device.';
dadefinition= char(didefinition);
 ATTRIBUTE      = 'definition';
 write_attribute_for_group(group_id_6,dadefinition,ATTRIBUTE);
didefinition= 'http://purl.obolibrary.org/obo/IAO_0000109';
dadefinition= char(didefinition);
ATTRIBUTE      = 'imported from';
write_attribute_for_group(group_id_6,dadefinition,ATTRIBUTE);
group_id_6a= H5G.create(fileID, '/assay/voltage clamp assay/whole-cell patch clamp voltage clamp assay/electrical admittance dual-sine stimulus/predicted data item', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'A data item that was generated on the basis of a calculation or logical reasoning';
dadefinition= char(didefinition);
 ATTRIBUTE      = 'definition';
 write_attribute_for_group(group_id_6a,dadefinition,ATTRIBUTE);
didefinition= 'http://purl.obolibrary.org/obo/OBI_0302867';
dadefinition= char(didefinition);
ATTRIBUTE      = 'imported from';
write_attribute_for_group(group_id_6a,dadefinition,ATTRIBUTE);
ATTRIBUTE      = 'editor note';
description= 'calculated from the admittance based upon model'; 
dadefinition= char(description);
write_attribute_for_group(group_id_6a,dadefinition,ATTRIBUTE);


% researcher=array_of_do_fits(1,j).researcher;
% dofexp=array_of_do_fits(1,j).dofexp;
% cellnumber=array_of_do_fits(1,j).cellnumber;
% datasteward='Brenda Farrell, PhD';% this is an attribute common to all datasets
% datacurator='Jason Bengtson, MLIS, MA';% this is an attribute
% funder='NIH-NLM and NIH-NIDCD'; %this is an attribute 
% 
% % Create datasets
Imf1=array_of_do_fits(1,j).Imlf;
type = H5T.copy ('H5T_NATIVE_DOUBLE');
space = H5S.create('H5S_SCALAR');
didefinition= 'imaginary_part_admittance(Imf1(Y))'; 
name_def= char(didefinition);
dim0=1;
dimw =length(Imf1);

DATASETID=create_write_array_of_dble_dset(group_id_6,space,type,dim0,dimw,name_def,Imf1); %calls function
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% 
% 
ATTRIBUTE      = 'definition';
description= 'Imaginary component of electrical admittance. It is the susceptance that describes the dynamic (e.g. frequency-dependent) characteristics of capacitors and inductors within an electrical circuit.';
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
ATTRIBUTE      = 'note';
description= 'The value measured at f1 the lower frequency';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)


Ref1=array_of_do_fits(1,j).Relf;

type = H5T.copy ('H5T_NATIVE_DOUBLE');
space = H5S.create('H5S_SCALAR');
didefinition= 'real_part_admittance(Ref1(Y))'; 
name_def= char(didefinition);
dim0=1;
dimw =length(Ref1);

DATASETID=create_write_array_of_dble_dset(group_id_6,space,type,dim0,dimw,name_def,Ref1); %calls function

%attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes

ATTRIBUTE      = 'definition';
description= 'Real component of electrical admittance. It is the conductance, where electrical admittance is a measure of how easily a circuit allows current to flow.';
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

ATTRIBUTE      = 'note';
description= 'The value measured at f1 the lower frequency';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

Imf2=array_of_do_fits(1,j).Imhf;
type = H5T.copy ('H5T_NATIVE_DOUBLE');
space = H5S.create('H5S_SCALAR');

didefinition= 'imaginary_part_admittance(Imf2(Y))'; 
name_def= char(didefinition);
dim0=1;
dimw =length(Imf2);

DATASETID=create_write_array_of_dble_dset(group_id_6,space,type,dim0,dimw,name_def,Imf2); %calls function
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% 
 ATTRIBUTE      = 'definition';
description= 'Imaginary component of electrical admittance. It is the susceptance that describes the dynamic (e.g. frequency-dependent) characteristics of capacitors and inductors within an electrical circuit.';
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

ATTRIBUTE      = 'note';
description= 'The value measured at f2 the higher frequency';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)


Rehf=array_of_do_fits(1,j).Rehf;
type = H5T.copy ('H5T_NATIVE_DOUBLE');
space = H5S.create('H5S_SCALAR');
dimw =length(Rehf);
didefinition= 'real_part_admittance(Ref2(Y))'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_6,space,type,dim0,dimw,name_def,Rehf); %calls function
%attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Real component of electrical admittance. It is the conductance, where electrical admittance is a measure of how easily a circuit allows current to flow.';
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

ATTRIBUTE      = 'note';
description= 'The value measured at f2 the higher frequency';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

Rm=array_of_do_fits(1,j).Rm;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dimw =length(Rm);
dim0=1;
didefinition= 'membrane_resistance(Rm)'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_6a,space,type,dim0,dimw,name_def,Rm); %calls function
% 
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'imported from';
description= 'http://purl.org/incf/ontology/Computational_Neurosciences/cno_alpha.owl#cno_0000221';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description= 'Mohm';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% 
ATTRIBUTE      = 'definition';
description='Measure of the degree to which the cellular membrane opposes the passage of an electric current.'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'definition two';
description='It is the ratio of the voltage across the membrane relative to the current through the membrane.';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

Rs=array_of_do_fits(1,j).Rs;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dimw =length(Rs);
didefinition= 'series_resistance(Rs)'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_6a,space,type,dim0,dimw,name_def,Rs); %calls function
% 
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% 
ATTRIBUTE      = 'definition';
description='access resistance, and it is a measure of how difficult it is for current to flow through the pipette.  It is the ratio of the voltage drop across the pipette relative to the current flow through the pipette.';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% 
ATTRIBUTE      = 'units';
description= 'Mohm';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

Cmf1=array_of_do_fits(1,j).calf;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dimw =length(Cmf1);
didefinition= 'membrane_capacitance(Cmf1)'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_6a,space,type,dim0,dimw,name_def,Cmf1); %calls function
% 
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Measure of the amount of electric charge stored (or separated) by the cellular membrane for a given electric potential.'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'pF';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'imported from';
description= 'http://purl.org/incf/ontology/Computational_Neurosciences/cno_alpha.owl#cno_0000220';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'note';
description= 'determined at f1 the lower frequency';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% 
Cmf2=array_of_do_fits(1,j).cahf;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');
dimw =length(Cmf2);
dim0=1;
didefinition= 'membrane_capacitance(Cmf2)'; 
name_def= char(didefinition);
% 
 DATASETID=create_write_array_of_dble_dset(group_id_6a,space,type,dim0,dimw,name_def,Cmf2); %calls function
% 
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Measure of the amount of electric charge stored (or separated) by the cellular membrane for a given electric potential.' ;
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
% 
ATTRIBUTE      = 'units';
description= 'pF';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'note';
description= 'determined at f2 the higher frequency';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'imported from';
description= 'http://purl.org/incf/ontology/Computational_Neurosciences/cno_alpha.owl#cno_0000220';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% 

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %datasets
 temperature=array_of_do_fits(1,j).temp;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');    
didefinition= 'temperature'; 
name_def= char(didefinition);
DATASETID=create_and_write_double_dataset(group_id_5,space,type,name_def,temperature);

%attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'units';
description= 'degrees centigrade';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'note';
description= 'temperature that assay was conducted';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'definition';
description= 'A physical quality of the thermal energy of a system.';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'imported from';
description= 'http://purl.obolibrary.org/obo/PATO_0000146'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);


pressure=array_of_do_fits(1,j).pressure;
space = H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_NATIVE_DOUBLE');    
didefinition= 'pipette_pressure'; 
name_def= char(didefinition);
DATASETIDP=create_and_write_double_dataset(group_id_5,space,type,name_def,pressure);

% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'units';
description= 'kPa';
dadefinition= char(description);
specific_string_attribute(DATASETIDP,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'definition';
%description= 'pressure is a physical quality that inheres in a bearer by virtue of the bearers amount of force per unit area it exerts. In this case it is pressure at the pipette';
description= 'pressure at the patch pipette';
dadefinition= char(description);
specific_string_attribute(DATASETIDP,ATTRIBUTE,dadefinition)

group_id_7= H5G.create(fileID, '/assay/voltage clamp assay/whole-cell patch clamp voltage clamp assay/membrane current (I) as a function of membrane potential (V) (I vs V plot)/measurement datum', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'A measurement datum is an information content entity that is a recording of the output of a measurement such as produced by a device.';
dadefinition= char(didefinition);
 ATTRIBUTE      = 'definition';
 write_attribute_for_group(group_id_7,dadefinition,ATTRIBUTE);
didefinition= 'http://purl.obolibrary.org/obo/IAO_0000109';
dadefinition= char(didefinition);
ATTRIBUTE      = 'imported from';
write_attribute_for_group(group_id_7,dadefinition,ATTRIBUTE);
group_id_7a= H5G.create(fileID, '/assay/voltage clamp assay/whole-cell patch clamp voltage clamp assay/membrane current (I) as a function of membrane potential (V) (I vs V plot)/study design controlled variable', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'Controlled variable specification  is a part of a study design. They are the entities that could vary, but are kept constant to prevent their influence on the effect of the independent variable on the dependent.';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_7a,dadefinition,ATTRIBUTE)
didefinition= 'http://purl.obolibrary.org/obo/OBI_0000785';
dadefinition= char(didefinition);
ATTRIBUTE      = 'imported from';
write_attribute_for_group(group_id_7a,dadefinition,ATTRIBUTE)

 lcpl_id='H5P_DEFAULT';
 lapl_id = 'H5P_DEFAULT';
 H5L.create_hard(group_id_5,'temperature',group_id_7a,'temperature', lcpl_id,lapl_id)
 H5L.create_hard(group_id_5,'pipette_pressure',group_id_7a,'pipette_pressure', lcpl_id,lapl_id)
group_id_5y= H5G.create(fileID, '/assay/voltage clamp assay/whole-cell patch clamp voltage clamp assay/membrane current (I) as a function of membrane potential (V) (I vs V plot)/chemical solution', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'A material entity that is homogeneous, made up of at least two scattered molecular aggregates, one playing the role of solute and the other playing the role of solvent.'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_5y,dadefinition,ATTRIBUTE)
ATTRIBUTE      = 'imported from';
didefinition= 'http://purl.obolibrary.org/obo/OBI_0302729';
dadefinition= char(didefinition);
write_attribute_for_group(group_id_5y,dadefinition,ATTRIBUTE)

 group_id_5x= H5G.create(fileID, '/assay/voltage clamp assay/whole-cell patch clamp voltage clamp assay/membrane current (I) as a function of membrane potential (V) (I vs V plot)/chemical solution/extracellular solution', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'solution used to bathe cells'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_5x,dadefinition,ATTRIBUTE)
 lcpl_id='H5P_DEFAULT';
 lapl_id = 'H5P_DEFAULT';
 H5L.create_hard(group_id_5c,'pH_ext',group_id_5x,'pH_ext', lcpl_id,lapl_id)
 H5L.create_hard(group_id_5c,'osmolality_ext',group_id_5x,'osmolality_ext', lcpl_id,lapl_id)

group_id_5w= H5G.create(fileID, '/assay/voltage clamp assay/whole-cell patch clamp voltage clamp assay/membrane current (I) as a function of membrane potential (V) (I vs V plot)/chemical solution/extracellular solution/concentration', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'The quantity of a substance per unit volume or weight; a measure of the amount of substance present in a unit amount of mixture, particularly, the amount of solute dissolved in a solvent. The amounts can be expressed as moles, masses, volumes, or parts';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_5w,dadefinition,ATTRIBUTE)
didefinition= 'http://purl.obolibrary.org/obo/NCIT_C41185'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'imported from';
write_attribute_for_group(group_id_5w,dadefinition,ATTRIBUTE)
H5L.create_hard(group_id_5d,'CaCl2',group_id_5w,'CaCl2', lcpl_id,lapl_id);
H5L.create_hard(group_id_5d,'CoCl2',group_id_5w,'CoCl2', lcpl_id,lapl_id);
H5L.create_hard(group_id_5d,'CsCl',group_id_5w,'CsCl', lcpl_id,lapl_id);  
H5L.create_hard(group_id_5d,'Hepes',group_id_5w,'Hepes', lcpl_id,lapl_id);  
H5L.create_hard(group_id_5d,'MgCl2',group_id_5w,'MgCl2', lcpl_id,lapl_id);  
H5L.create_hard(group_id_5d,'NaCl',group_id_5w,'NaCl', lcpl_id,lapl_id);  
H5L.create_hard(group_id_5d,'Xe991',group_id_5w,'Xe991', lcpl_id,lapl_id);  
H5L.create_hard(group_id_5d,'TEAC',group_id_5w,'TEAC', lcpl_id,lapl_id);  
group_id_5v= H5G.create(fileID, '/assay/voltage clamp assay/whole-cell patch clamp voltage clamp assay/membrane current (I) as a function of membrane potential (V) (I vs V plot)/chemical solution/solution in pipette', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
% 
didefinition= 'solution placed within the patch pipette'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_5v,dadefinition,ATTRIBUTE)
H5L.create_hard(group_id_5e,'pH_int',group_id_5v,'pH_int', lcpl_id,lapl_id)
H5L.create_hard(group_id_5e,'osmolality_int',group_id_5v,'osmolality_int', lcpl_id,lapl_id);
 
group_id_5u= H5G.create(fileID, '/assay/voltage clamp assay/whole-cell patch clamp voltage clamp assay/membrane current (I) as a function of membrane potential (V) (I vs V plot)/chemical solution/solution in pipette/concentration', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
% 
didefinition= 'The quantity of a substance per unit volume or weight; a measure of the amount of substance present in a unit amount of mixture, particularly, the amount of solute dissolved in a solvent. The amounts can be expressed as moles, masses, volumes, or parts';
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_5u,dadefinition,ATTRIBUTE)
didefinition= 'http://purl.obolibrary.org/obo/NCIT_C41185'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'imported from';
write_attribute_for_group(group_id_5u,dadefinition,ATTRIBUTE)
H5L.create_hard(group_id_5f,'EGTA',group_id_5u,'EGTA', lcpl_id,lapl_id);
H5L.create_hard(group_id_5f,'CsGlutamate',group_id_5u,'CsGlutamate', lcpl_id,lapl_id);
H5L.create_hard(group_id_5f,'CsCl',group_id_5u,'CsCl', lcpl_id,lapl_id);  
H5L.create_hard(group_id_5f,'Hepes',group_id_5u,'Hepes', lcpl_id,lapl_id);  
H5L.create_hard(group_id_5f,'MgCl2',group_id_5u,'MgCl2', lcpl_id,lapl_id);  
 


T=isempty(array_of_do_fits(1,j).Current_DC);
if(T==1)
current=  [];
  dimw =0;
else
current=array_of_do_fits(1,j).Current_DC;
dimw =length(current);
end
type = H5T.copy ('H5T_NATIVE_DOUBLE');    
space = H5S.create('H5S_SCALAR');
dim0=1;
didefinition= 'current';
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_7,space,type,dim0,dimw,name_def,current);  %calls function

ATTRIBUTE      = 'definition';
description= 'flow rate property that is the temporal derivative of an amount of portion of electrical charge'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'imported from';
description= 'http://bhi.washington.edu/OPB#OPB_00318'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'pA'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

% fnDC_TC=array_of_do_fits(1,j).fname_DC_TC;
%  ATTRIBUTE      = 'filename of saved IvsV data with interval time between points';
%  description_two={fnDC_TC};
%  dadefinition= description_two;
%  specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% 

group_id_7b= H5G.create(fileID, '/assay/voltage clamp assay/whole-cell patch clamp voltage clamp assay/membrane current (I) as a function of membrane potential (V) (I vs V plot)/intracellular electrophysiology stimulus', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'The electrical protocol (e.g. pulse, ramp) used during a intracellular electrophysiology recording. ';
dadefinition= char(didefinition);
 ATTRIBUTE      = 'definition';
 write_attribute_for_group(group_id_7b,dadefinition,ATTRIBUTE);
%
T=isempty(array_of_do_fits(1,j).voltage_DC);
if(T==1)
    V_hold=[];
    type = H5T.copy ('H5T_NATIVE_DOUBLE');    
space = H5S.create('H5S_SCALAR');
dimw =0;
else
V_hold=  array_of_do_fits(1,j).voltage_DC;
type = H5T.copy ('H5T_NATIVE_DOUBLE');    
space = H5S.create('H5S_SCALAR');
dimw =length(V_hold);
end
dim0=1;
didefinition= 'membrane_potential';
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_7b,space,type,dim0,dimw,name_def,V_hold);  %calls function
ATTRIBUTE      = 'definition';
description= 'A quality inhering in a cells plasma membrane by virtue of the electrical potential difference across it.';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'definition and label imported from';
description= 'http://purl.obolibrary.org/obo/PATO_0001462';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'definition two';
description= 'The DC electric potential applied to the cytoplasm of the cell where the potential outside the cell is defined as zero.'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'volts'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

% add DC datasets
T=isempty(array_of_do_fits(1,j).delta_time);
if(T==1)
 delta_time=  [];
   type = H5T.copy ('H5T_NATIVE_DOUBLE');    
  space = H5S.create('H5S_SCALAR');
  dimw =0;
else
delta_time=  array_of_do_fits(1,j).delta_time;
type = H5T.copy ('H5T_NATIVE_DOUBLE');    
space = H5S.create('H5S_SCALAR');
dimw =length(delta_time);
end 
dim0=1;

didefinition= 'time'; 
name_def= char(didefinition);
DATASETID=create_write_array_of_dble_dset(group_id_7b,space,type,dim0,dimw,name_def,delta_time);  %calls function
ATTRIBUTE      = 'definition';
description= 'time that each data point was recorded relative to start of the stimulus'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'seconds';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

clearvars -except dirname filename_fits count k_adult_male array_of_do_fits pathfunctions pathbegdata pathsavedata;


end