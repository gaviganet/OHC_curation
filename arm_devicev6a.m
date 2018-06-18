 function arm_devicev6a(dirname, filename_fits,k_adult_male,count,pathfunctions,pathbegdata,pathsavedata)

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
researcher=array_of_do_fits(1,j).researcher; % this is an attribute
dofexp=array_of_do_fits(1,j).dofexp; % this is an attribute
cellnumber=array_of_do_fits(1,j).cellnumber; % this is an attribute
datasteward='Brenda Farrell, PhD';% this is an attribute
datacurator='Jason Bengtson, MLIS, MA';% this is an attribute
funder='NIH-NLM and NIH-NIDCD'; %this is an attribute 

group_id_ld = H5G.create(fileID, '/device', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
%
didefinition= ' A material entity that is designed to perform a function in a scientific investigation, but is not a reagent.';
dadefinition= char(didefinition);
ATTRIBUTE='definition';
write_attribute_for_group(group_id_ld,dadefinition,ATTRIBUTE);
ATTRIBUTE='alternative term';
didefinition= 'instrument';
dadefinition= char(didefinition);
write_attribute_for_group(group_id_ld,dadefinition,ATTRIBUTE);
ATTRIBUTE='imported from';
didefinition= 'http://purl.obolibrary.org/obo/OBI_0000968';
dadefinition= char(didefinition);
write_attribute_for_group(group_id_ld,dadefinition,ATTRIBUTE);

% dataset

DAQ_card='National Instruments PCI-6052E';
type = H5T.copy ('H5T_C_S1');
space=H5S.create('H5S_SCALAR');
name_def='DAQ_card';
DATASETID=create_and_write_string_dataset(group_id_ld,space,type,name_def,DAQ_card);
ATTRIBUTE      = 'definition';
didefinition='The digital acquisition card acts as the interface between the computer and a measurement device via the computer bus. It converts the signal generated by a measurement device (output from device) to a digital signal via an analog-to-digital converter, ADC. It also converts a digital signal to an analog signal via a digital-to-analog converter, DAC. This analog signal (e.g., stimulus) is fed to a measurement device (input to device)';% 
dadefinition= char(didefinition);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
% %%%%%%%%%%%%%add definition
% 
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% 
group_id_le = H5G.create(fileID, '/device/measurement device', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
% create datasets
didefinition= 'A device in which a measure function inheres';
dadefinition= char(didefinition);
ATTRIBUTE='definition';
write_attribute_for_group(group_id_le,dadefinition,ATTRIBUTE);
ATTRIBUTE='imported from';
didefinition= 'http://purl.obolibrary.org/obo/OBI_0000832';
dadefinition= char(didefinition);
write_attribute_for_group(group_id_le,dadefinition,ATTRIBUTE);
% % create datasets
patch_clamp_amplifier='Molecular Devices Axopatch 200B';
type = H5T.copy ('H5T_C_S1');
space=H5S.create('H5S_SCALAR');
name_def='patch_clamp_amplifier';
DATASETID=create_and_write_string_dataset(group_id_le,space,type,name_def,patch_clamp_amplifier);
% 
% %%%%%%%%%%%%%add definition
% 
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% 
didefinition= 'A device used in electrophysiology that is designed to measure: small (pA) currents that originate from a membrane or measure the potential (mV)  across the membrane. In addition to the electronics it requires a headstage that is designed to communicate with, and secure the patch pipette electrode that forms a high resistance seal with the membrane. ';
dadefinition= char(didefinition);
ATTRIBUTE='definition';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);

pressure_clamp='HSPC-1 ALA Scientific Instruments';
type = H5T.copy ('H5T_C_S1');
space=H5S.create('H5S_SCALAR');
name_def='pressure_clamp';
DATASETID=create_and_write_string_dataset(group_id_le,space,type,name_def,pressure_clamp);
% 
% %%%%%%%%%%%%%add definition
% 
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% 
didefinition='High speed pressure clamp used to control pipette pressure during the assay'; 
dadefinition= char(didefinition);
ATTRIBUTE='definition';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
group_id_lf = H5G.create(fileID, '/device/image creation device', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
% create datasets
didefinition= 'An image creation device is a device which produces an image of an object';
dadefinition= char(didefinition);
ATTRIBUTE='definition';
write_attribute_for_group(group_id_lf,dadefinition,ATTRIBUTE);
% 
% % create datasets
camera='MTI-DAGE NC-70 Newvicon';
type = H5T.copy ('H5T_C_S1');
space=H5S.create('H5S_SCALAR');
name_def='analog_camera';
DATASETID=create_and_write_string_dataset(group_id_lf,space,type,name_def,camera);
% 
% %%%%%%%%%%%%%add definition
% 
% attribute_general_v2(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% 
didefinition='An image acquisition device that takes video or still photographs, or both, by recording images via an analog mechanism.'; 
dadefinition= char(didefinition);
ATTRIBUTE='specific definition for assay';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
optical_microscope='Zeiss Axiovert 135 TV';
type = H5T.copy ('H5T_C_S1');
space=H5S.create('H5S_SCALAR');
name_def='optical_microscope';
DATASETID=create_and_write_string_dataset(group_id_lf,space,type,name_def,optical_microscope);
% 
didefinition='A microscope that produces an image of an object by targeting it with an electro-magnetic beam in the visible frequency range'; 
dadefinition= char(didefinition);
ATTRIBUTE='definition';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
didefinition=' http://purl.obolibrary.org/obo/OBI_0000940';
dadefinition= char(didefinition);
ATTRIBUTE='imported from';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
 didefinition='Inverted microscope used to view the cells and position the patch pipette for the assay'; 
 dadefinition= char(didefinition);
 ATTRIBUTE=' specific definition for experiment';
 specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
% 
% 
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% 
 
% 
clearvars -except dirname filename_fits count k_adult_male array_of_do_fits pathfunctions pathbegdata pathsavedata;


end
end
%%
