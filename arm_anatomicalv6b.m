% create anatomical arm of 
% set-up folders to load and run file
function arm_anatomicalv6b(dirname, filename_fits,k_adult_male,count,pathfunctions,pathbegdata,pathsavedata)
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
newFolder=pathfunctions;
genpath('newFolder');
cd(newFolder);

researcher=array_of_do_fits(1,j).researcher; % this is an attribute coomon to all datasets
dofexp=array_of_do_fits(1,j).dofexp; % this is an attribute coomon to all datasets
cellnumber=array_of_do_fits(1,j).cellnumber; % this is an attribute coomon to all datasets
datasteward='Brenda Farrell, PhD';% this is an attribute common to all datasets
datacurator='Jason Bengtson, MLIS, MA';% this is an attribute
funder='NIH-NLM and NIH-NIDCD'; %this is an attribute 

group_id_1e = H5G.create(fileID, '/anatomical', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');

didefinition= 'material anatomical entity'; 
dadefinition= char(didefinition);
ATTRIBUTE='label';
write_attribute_for_group(group_id_1e,dadefinition,ATTRIBUTE);

didefinition= 'Anatomical entity that has mass'; 
dadefinition= char(didefinition);
ATTRIBUTE='definition';
write_attribute_for_group(group_id_1e,dadefinition,ATTRIBUTE);

ATTRIBUTE      = 'imported_from';
description=  'http://purl.obolibrary.org/obo/UBERON_0000465';
dadefinition= char(description);
write_attribute_for_group(group_id_1e,dadefinition,ATTRIBUTE)
% 


% 
group_id_2f = H5G.create(fileID, '/anatomical/cochlea', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
ATTRIBUTE      = 'definition';
didefinition= 'the spiral-shaped bony canal in the inner ear containing the hair cells that transduce sound. Its core component is the Organ of Corti, the sensory organ of hearing, which is distributed along the partition separating fluid chambers in the coiled tapered tube of the cochlea.'; 
dadefinition= char(didefinition);
write_attribute_for_group(group_id_2f,dadefinition,ATTRIBUTE);
ATTRIBUTE      = 'imported_from';
description=  'http://purl.obolibrary.org/obo/UBERON_0001844';
dadefinition= char(description);
write_attribute_for_group(group_id_2f,dadefinition,ATTRIBUTE);

group_id_2d = H5G.create(fileID, '/anatomical/cochlea/subdivision of cochlea', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');

ATTRIBUTE      = 'imported_from';
 description=  'http://purl.obolibrary.org/obo/FMA_61268';
 dadefinition= char(description);
 write_attribute_for_group(group_id_2d,dadefinition,ATTRIBUTE);
 
group_id_2g = H5G.create(fileID, '/anatomical/cochlea/positional polarity', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
ATTRIBUTE      = 'definition';
didefinition= 'A spatial quality inhering in a bearer by virtue of the bearers spatial location relative to other objects in the vicinity';
dadefinition= char(didefinition);
write_attribute_for_group(group_id_2g,dadefinition,ATTRIBUTE);
ATTRIBUTE      = 'imported_from';
description=  ' http://purl.obolibrary.org/obo/PATO_0001769';
dadefinition= char(description);
write_attribute_for_group(group_id_2g,dadefinition,ATTRIBUTE);
% 
% % create datasets
cochlear_side=array_of_do_fits(1,j).ear;
if(strcmp('E',cochlear_side)==1)
    cochlear_side='unknown';
end    
type = H5T.copy ('H5T_C_S1');
space=H5S.create('H5S_SCALAR');
name_def='cochlea';
DATASETID=create_and_write_string_dataset(group_id_2f,space,type,name_def,cochlear_side);
ATTRIBUTE='allowed values';
didefinition= 'left cochlea, right cochlea,  unknown'; 
dadefinition= char(didefinition);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'values imported_from';
description=  'http://purl.obolibrary.org/obo/FMA_60203 and http://purl.obolibrary.org/obo/FMA_60202';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);

group_id_2k = H5G.create(fileID, '/anatomical/cochlea/positional polarity/apical basal polarity', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
ATTRIBUTE      = 'definition';
didefinition= 'A positional quality inhering in a bearer by virtue of the bearers location of features or characteristics along an apical-basal axis.';
dadefinition= char(didefinition);
write_attribute_for_group(group_id_2k,dadefinition,ATTRIBUTE);
ATTRIBUTE      = 'imported_from';
description=  'http://purl.obolibrary.org/obo/PATO_0002023';
dadefinition= char(description);
write_attribute_for_group(group_id_2k,dadefinition,ATTRIBUTE);
% %
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
DATASETID=create_and_write_int_dataset(group_id_2k,space,type,name_def,cochlear_turn);

% %add attributes
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); 
ATTRIBUTE      = 'definition';
description= 'Positional quality along the apical-basal axis that corresponds to whole circular sections of the cochlea.  Positional origin of cell used. '; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE      = 'allowed values';
description= 'one (1), two (2), three (3) and four (4)'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
DATASETID=create_and_write_int_dataset(group_id_2d,space,type,name_def,cochlear_turn);
ATTRIBUTE      = 'definition';
description= 'Positional quality along the apical-basal axis that corresponds to whole circular sections of the cochlea.  Positional origin of cell used. '; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE      = 'allowed values';
description= 'one (1), two (2), three (3) and four (4)'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
% % region
if(array_of_do_fits(1,j).turn==1||array_of_do_fits(1,j).turn==2)
cochlear_region='basal';
elseif(array_of_do_fits(1,j).turn==3||array_of_do_fits(1,j).turn==3.5||array_of_do_fits(1,j).turn==4)
cochlear_region='apical';
elseif(array_of_do_fits(1,j).turn==5||array_of_do_fits(1,j).turn==0||array_of_do_fits(1,j).turn==isNaN)
cochlear_region='unknown';
end

type = H5T.copy ('H5T_C_S1');
space=H5S.create('H5S_SCALAR');
name_def='apical_basal_polarity';

DATASETID=create_and_write_string_dataset(group_id_2k,space,type,name_def,cochlear_region);
% % add attributes
%attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder);% calls a function to add attributes
ATTRIBUTE      = 'note';
description= 'Positional origin of cell used. Legal values are apical, basal or unknown'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = ' definition';
description= 'A positional quality inhering in a bearer by virtue of the bearers location of features or characteristics along an apical-basal axis.'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'imported from';
description= ' http://purl.obolibrary.org/obo/PATO_0002023'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

clearvars -except dirname filename_fits count k_adult_male array_of_do_fits pathfunctions pathbegdata pathsavedata;


end
end

