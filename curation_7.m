function curation_7()
% This main script calls six functions that represent an arm
% of the data design.  The first arm (arm_organismv6a.m) opens and creates a
% specimen file and sets up the groups and datasets associated with the
% organism; the second arm (arm_devicev6a.m) is associated with instruments
% used to create data; the third arm (arm_anatomicalv8a.m) is the anatomy of
% the organism and position where the cells where isolated; the fourth (arm_cellv6a.m) is
% the description of the cell that was used to make the electrical
% recording and the 5th arm (arm_assayv11a.m) is the details of the assay that
% were conducted and the 6th (arm_data_transformation.m) is the details of
% the analysis and extracted data sets from the collected data.

% arm_organismv8a(dirname,filename_fits,k_adult_male,count); 
% arm_devicev6a(dirname,filename_fits,k_adult_male,count);
% arm_anatomicalv6a(dirname,filename_fits,k_adult_male,count); 
% arm_cellv6a(dirname, filename_fits,k_adult_male,count); 
% arm_assayv11a(dirname,filename_fits,k_adult_male,count) 
% arm_data_transformation.m(dirname,filename_fits,k_adult_male,count) 

% dirname: is the path where the MATLAB
% data is to be translated; filename_fits is the name of the MATLAB data
% file with extension .MAT it is an array of structs; k_adult_male is the
% number within the original MAT file that are to be translated and
% count is starting number of the specimen file that will be created. The
% following additional seven (7) functions are called from the arms.

% write_attribute_for_group(group_id_1a,dadefinition,ATTRIBUTE) 

%This writes metadata that is associated with group_id; the metadata is described in
% dadefinition and defined in “ATTRIBUTE”.

% DATASETID=create_and_write_string_dataset(group_id_2a,space,type,name_def,vendor);

% This creates and writes dataset of type string that will be found under
% “group_id_2a”; with space and type defined, the description of the string
% is found in “name_def” (e.g., vendor) and the contents of the string are
% found in vendor (e.g., WalMart).  The number of the dataset (datasetid)
% is returned to main script. 
 
%DATASETID =create_and_write_double_dataset(group_id_3a,space,type,name_def,mass);

% This creates and writes dataset of type DOUBLE precision that will be
% found under “group_id_3a”; with space (SCALAR or NULL) and type (DOUBLE
% precision) defined, the description a character string is found in
% “name_def” (e.g., ‘mass’) and the double precision number is found in
% weight. The number of the dataset (datasetid) is returned to main script.

% DATASETID =create_and_write_int_dataset(group_id_3a,space,type,name_def,age); 

%This creates and writes dataset of type INT that will be found under
% “group_id_3a”; with space (SCALAR or NULL) and type (INT precision)
% defined, the description a character string is found in “name_def” (e.g.,
% ‘age’) and the double precision number is found in age. The number of
% the dataset (datasetid) is returned to main script. 

%DATASETID =create_write_array_of_dble_dset(group_id_4a,space_id,type,dim0,dimw,name_def,Imlf)

% This creates and writes an array of type DOUBLE with dimensions dim0 and
% dimw that will be found under “group_id_4a”; with space (SCALAR) and type
% (DOUBLE precision) defined. The description of the dataset a character
% string is found in “name_def” (e.g., ‘Imlf(Y)’) and the double precision
% array is found in Imlf.  The number of the dataset (datasetid) is
% returned to main script. METADATA Attributes are METADATA attached to the
% description of the dataset.

% attribute_general(DATASETID,researcher,dofexp, cellnumber, datasteward, datacurator and funder) 

% To every file within the collection the name of the researcher (researcher)
% that conducted the experiment, the date of the experiment (dofexp); 
% the original cell number; the person responsible for this data (datasteward); the person who 
% curated the collection curator (datacurator) and the instruments used to fund this work (funder). 
% are attached as notes known as attributes to the
% dataset DATASETID.

% specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition) 

% This is description of the dataset where ATTRIBUTE is a string like the
% “definition’, “units’ or ‘note’ and the “dadefinition” is the actual
% description of the definition units or note. They are attached to dataset
% with id: DATASETID.
% Updated June 28 2018
% Copyright Brenda Farrell and Jason Bengtson
warning('off'); % have this because prints of warnings slows code

% Get the data that you want to translate from MATLAB structs to HDF5
clear;
pathbegdata='Y:\OHC_Data\Data for portal\male adult';
newFolder=pathbegdata;
cd(newFolder);
filename_fits='R1_adultmale_mat2hdf5_out.mat';
load(filename_fits);  % 
for i=1:1:length(array_of_do_fits)
    m(1,i)=i;  
end
k_adult_male=find(m); % making sure no empty arrays
k_adult_male=k_adult_male';
clear array_of_do_fits m;
pathfunctions='C:\Users\bfarrell\Box Sync\Documents (bfarrell@bcm.edu)\M files\OHC analysis\HDF5format\final functions\Package';
newFolder=pathfunctions;
genpath('newFolder');
cd(newFolder);
%
pathbegdata='Y:\OHC_Data\Data for portal\';
pathsavedata='Y:\OHC_Data\Data for portal\Specimen\';
C={'male','adult'};
dirname=strjoin(C); 
filename_fits='R1_adultmale_mat2hdf5_out.mat';  %This is my updated file
count =0;
%
arm_organismv8a(dirname, filename_fits,k_adult_male,count,pathfunctions,pathbegdata,pathsavedata);
 arm_devicev6a(dirname, filename_fits,k_adult_male,count,pathfunctions,pathbegdata,pathsavedata)
 arm_anatomicalv6b2(dirname, filename_fits,k_adult_male,count,pathfunctions,pathbegdata,pathsavedata);
arm_assayv11a2(dirname, filename_fits,k_adult_male,count,pathfunctions,pathbegdata,pathsavedata)
 arm_data_transformation(dirname,filename_fits,k_adult_male,count,pathfunctions,pathbegdata,pathsavedata);
 arm_cellv6a(dirname, filename_fits,k_adult_male,count,pathfunctions,pathbegdata,pathsavedata);
%%
% % Get second file
clear;
pathbegdata='Y:\OHC_Data\Data for portal\male prepubertal';
newFolder=pathbegdata;
cd(newFolder);
filename_fits='R1_prepubmale_mat2hdf5_out';
load(filename_fits);  % Just translating some of the data
for i=1:1:length(array_of_do_fits)
          m(1,i)=i;  
end
 
k_prepub_male=find(m);
k_prepub_male=k_prepub_male';
clear array_of_do_fits m;
pathfunctions='C:\Users\bfarrell\Box Sync\Documents (bfarrell@bcm.edu)\M files\OHC analysis\HDF5format\final functions\Package';
newFolder=pathfunctions;
cd(newFolder);
pathbegdata='Y:\OHC_Data\Data for portal\';
pathsavedata='Y:\OHC_Data\Data for portal\Specimen\';
C={'male','prepubertal'};
dirname=strjoin(C);
filename_fits='R1_prepubmale_mat2hdf5_out';
count =39;
arm_organismv8a(dirname, filename_fits,k_prepub_male,count,pathfunctions,pathbegdata,pathsavedata);
arm_devicev6a(dirname, filename_fits,k_prepub_male,count,pathfunctions,pathbegdata,pathsavedata)
 arm_anatomicalv6b2(dirname, filename_fits,k_prepub_male,count,pathfunctions,pathbegdata,pathsavedata);
 arm_assayv11a(dirname, filename_fits,k_prepub_male,count,pathfunctions,pathbegdata,pathsavedata)
arm_cellv6a(dirname, filename_fits,k_prepub_male,count,pathfunctions,pathbegdata,pathsavedata);
arm_data_transformation(dirname,filename_fits,k_prepub_male,count,pathfunctions,pathbegdata,pathsavedata);
%
clear;
pathbegdata='Y:\OHC_Data\Data for portal\female prepubertal';
newFolder=pathbegdata;
cd(newFolder);
filename_fits='R1_prepubfemale_mat2hdf5_out.mat';
load(filename_fits);  % 
for i=1:1:length(array_of_do_fits)
          m(1,i)=i;  
end
k_prepub_female=find(m);
k_prepub_female=k_prepub_female';
clear array_of_do_fits m;
pathfunctions='C:\Users\bfarrell\Box Sync\Documents (bfarrell@bcm.edu)\M files\OHC analysis\HDF5format\final functions\Package';
newFolder=pathfunctions;
cd(newFolder);
pathbegdata='Y:\OHC_Data\Data for portal\';
pathsavedata='Y:\OHC_Data\Data for portal\Specimen\';
C={'female','prepubertal'};
dirname=strjoin(C);
filename_fits='R1_prepubfemale_mat2hdf5_out.mat';
count =60;
arm_organismv8a(dirname, filename_fits,k_prepub_female,count,pathfunctions,pathbegdata,pathsavedata);
arm_devicev6a(dirname, filename_fits,k_prepub_female,count,pathfunctions,pathbegdata,pathsavedata)
arm_anatomicalv6b(dirname, filename_fits,k_prepub_female,count,pathfunctions,pathbegdata,pathsavedata)
arm_cellv6a(dirname, filename_fits,k_prepub_female,count,pathfunctions,pathbegdata,pathsavedata)
arm_assayv11a(dirname, filename_fits,k_prepub_female,count,pathfunctions,pathbegdata,pathsavedata)
arm_data_transformation(dirname,filename_fits,k_prepub_female,count,pathfunctions,pathbegdata,pathsavedata);
%
clear;
pathbegdata='Y:\OHC_Data\Data for portal\female adult mid-estrous';
newFolder=pathbegdata;
cd(newFolder);
filename_fits='R1_midestrousfemale_mat2hdf5_out.mat';
load(filename_fits);  % Just translating some of the data
for i=1:1:length(array_of_do_fits)
          m(1,i)=i;  
end
k_adult_female=find(m);
k_adult_female=k_adult_female';
clear array_of_do_fits m;
pathfunctions='C:\Users\bfarrell\Box Sync\Documents (bfarrell@bcm.edu)\M files\OHC analysis\HDF5format\final functions\Package';
newFolder=pathfunctions;
cd(newFolder);
pathbegdata='Y:\OHC_Data\Data for portal\';
pathsavedata='Y:\OHC_Data\Data for portal\Specimen\';
C={'female','adult','mid-estrous'};
dirname=strjoin(C);
filename_fits='R1_midestrousfemale_mat2hdf5_out.mat';

count =88;
arm_organismv8a(dirname, filename_fits,k_adult_female,count,pathfunctions,pathbegdata,pathsavedata);
arm_devicev6a(dirname, filename_fits,k_adult_female,count,pathfunctions,pathbegdata,pathsavedata)
arm_anatomicalv6b(dirname, filename_fits,k_adult_female,count,pathfunctions,pathbegdata,pathsavedata)
arm_cellv6a(dirname, filename_fits,k_adult_female,count,pathfunctions,pathbegdata,pathsavedata)
arm_assayv11a(dirname, filename_fits,k_adult_female,count,pathfunctions,pathbegdata,pathsavedata);
arm_data_transformation(dirname, filename_fits,k_adult_female,count,pathfunctions,pathbegdata,pathsavedata);

end
% 
