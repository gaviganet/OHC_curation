% create anatomical arm of 
% set-up folders to load and run file
function arm_anatomicalv5(dirname, filename_fits,k_adult_male,count,pathfunctions,pathbegdata,pathsavedata)
newFolder=strcat(pathbegdata,dirname);
genpath('newFolder');
cd(newFolder);
load(filename_fits);
newFolder=pathfunctions;
genpath('newFolder');
cd(newFolder);
% Start loop
for  i=1:1:length(k_adult_male)
j=k_adult_male(i,1);
 m=count+i;
% open filename
newFolder=pathsavedata;
genpath('newFolder');
cd(newFolder);
namenew=strcat('specimen_#',num2str(m),'.h5');
fileID = H5F.open(namenew,'H5F_ACC_RDWR','H5P_DEFAULT');
newFolder='C:\Users\bfarrell\Documents\M files\OHC analysis\HDF5format\final functions';
genpath('newFolder');
cd(newFolder);

researcher=array_of_do_fits(1,j).researcher; % this is an attribute coomon to all datasets
dofexp=array_of_do_fits(1,j).dofexp; % this is an attribute coomon to all datasets
cellnumber=array_of_do_fits(1,j).cellnumber; % this is an attribute coomon to all datasets
datasteward='Brenda Farrell, PhD';% this is an attribute common to all datasets

group_id_1e = H5G.create(fileID, '/anatomical', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');

didefinition= 'material anatomical entity'; 
dadefinition= char(didefinition);
ATTRIBUTE='label';
write_attribute_for_group(group_id_1e,dadefinition,ATTRIBUTE);

ATTRIBUTE      = 'imported_from';
description=  'http://purl.obolibrary.org/obo/UBERON_0000465';
dadefinition= char(description);
write_attribute_for_group(group_id_1e,dadefinition,ATTRIBUTE)

group_id_2d = H5G.create(fileID, '/anatomical/cochlea', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
ATTRIBUTE      = 'definition';
didefinition= 'the spiral-shaped bony canal in the inner ear containing the hair cells that transduce sound. Its core component is the Organ of Corti, the sensory organ of hearing, which is distributed along the partition separating fluid chambers in the coiled tapered tube of the cochlea.'; 
dadefinition= char(didefinition);
write_attribute_for_group(group_id_2d,dadefinition,ATTRIBUTE);


ATTRIBUTE      = 'imported_from';
description=  'http://purl.obolibrary.org/obo/UBERON_0001844';
dadefinition= char(description);
write_attribute_for_group(group_id_2d,dadefinition,ATTRIBUTE);

% create datasets
cochlear_side=array_of_do_fits(1,j).ear;
if(strcmp('E',cochlear_side)==1)
    cochlear_side='unknown';
end    
type = H5T.copy ('H5T_C_S1');
space=H5S.create('H5S_SCALAR');
name_def='cochlear_side';
dataset_id=create_and_write_string_dataset(group_id_2d,space,type,name_def,cochlear_side);
% add attributes
attribute_general(dataset_id,researcher, dofexp, cellnumber, datasteward); % calls a function to add attributes

ATTRIBUTE='definition';
didefinition= 'cochlea of the test subject used. Legal values are left, right or unknown'; 
dadefinition= char(didefinition);
specific_string_attribute(dataset_id,ATTRIBUTE,dadefinition)
%
cochlear_turn=array_of_do_fits(1,j).turn;
if(array_of_do_fits(1,j).turn==5||array_of_do_fits(1,j).turn==0)
 cochlear_turn=[];
type = H5T.copy ('H5T_NATIVE_INT');
space=H5S.create('H5S_NULL');
else
type = H5T.copy ('H5T_NATIVE_INT');
space=H5S.create('H5S_SCALAR');
end
name_def='cochlear_turn';
dataset_id=create_and_write_int_dataset(group_id_2d,space,type,name_def,cochlear_turn);

%add attributes
attribute_general(dataset_id,researcher, dofexp, cellnumber, datasteward); 
ATTRIBUTE      = 'definition';
description= 'Whole circular sections of the coiled cochlea (origin of cell used)'; 
dadefinition= char(description);
specific_string_attribute(dataset_id,ATTRIBUTE,dadefinition);

% region
if(array_of_do_fits(1,j).turn==1||array_of_do_fits(1,j).turn==2)
cochlear_region='basal';
elseif(array_of_do_fits(1,j).turn==3||array_of_do_fits(1,j).turn==3.5||array_of_do_fits(1,j).turn==4)
cochlear_region='apical';
elseif(array_of_do_fits(1,j).turn==5||array_of_do_fits(1,j).turn==0||array_of_do_fits(1,j).turn==isNaN)
cochlear_region='unknown';
end

type = H5T.copy ('H5T_C_S1');
space=H5S.create('H5S_SCALAR');
name_def='cochlear_region';

dataset_id=create_and_write_string_dataset(group_id_2d,space,type,name_def,cochlear_region);
% add attributes
attribute_general(dataset_id,researcher, dofexp, cellnumber, datasteward);% calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'Subdivision of cochlea possible values are basal, apical or whole (origin of cell used)'; 
dadefinition= char(description);
specific_string_attribute(dataset_id,ATTRIBUTE,dadefinition)

clearvars -except dirname filename_fits count k_adult_male array_of_do_fits pathfunctions pathbegdata pathsavedata;


end
end