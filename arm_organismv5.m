
function arm_organismv5(dirname, filename_fits,k_adult_male,count,pathfunctions,pathbegdata,pathsavedata)

%General stuff
newFolder=strcat(pathbegdata,dirname);
genpath('newFolder');
cd(newFolder);
load(filename_fits);
newFolder=pathfunctions;
genpath('newFolder');
cd(newFolder);
%start the loop
for i=1:1:length(k_adult_male)
j=k_adult_male(i,1);
%Create group structure for organism arm this is the first arm   
 m=count+i;
 filename = fullfile(strcat(pathsavedata,'specimen_#',num2str(m),'.h5'));
 fileID = H5F.create(filename,'H5F_ACC_TRUNC','H5P_DEFAULT','H5P_DEFAULT'); % This overwrites file with same name
% ADDING attributes
% attributes
researcher=array_of_do_fits(1,j).researcher; % this is an attribute
dofexp=array_of_do_fits(1,j).dofexp;% this is an attribute
cellnumber=array_of_do_fits(1,j).cellnumber; % this is an attribute
datasteward='Brenda Farrell, PhD';% this is an attribute

% Create group structure
group_id_1a = H5G.create(fileID, '/organism', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'A material entity that is an individual living system, such as animal, plant, bacteria or virus, that is capable of replicating or reproducing, growth and maintenance in the right environment. An organism may be unicellular or made up, like humans, of many billions of cells divided into specialized tissues and organs.'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_1a,dadefinition,ATTRIBUTE)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
group_id_2a = H5G.create(fileID, '/organism/Cavia porcellus', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'http://purl.obolibrary.org/obo/ncbitaxon.owl'; 
dadefinition= char(didefinition);
ATTRIBUTE      ='imported_from';
write_attribute_for_group(group_id_2a,dadefinition,ATTRIBUTE)
%
didefinition= 'domestic guinea pig'; 
dadefinition= char(didefinition);
ATTRIBUTE      ='genbank common name';
write_attribute_for_group(group_id_2a,dadefinition,ATTRIBUTE)
%
% Add vendor dataset within second group
phenotype=array_of_do_fits(1,j).phenotype;
if(strcmp(phenotype,'tricolor'))
   vendor='bred at Baylor College of Medicine with initial and supplemented stock from Elm Hill Labs';
else
   vendor ='Charles River Laboratories';
end   
type = H5T.copy ('H5T_C_S1');
space=H5S.create('H5S_SCALAR');
name_def='vendor';
DATASETID=create_and_write_string_dataset(group_id_2a,space,type,name_def,vendor);
%add atributes
attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward); % calls a function to add attributes

didefinition= 'company where animals were bred and/or purchased'; 
dadefinition= char(didefinition);
ATTRIBUTE='definition';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add third group
group_id_3a = H5G.create(fileID, '/organism/Cavia porcellus/organism information', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'the properties of a discrete organism'; 
dadefinition= char(didefinition);
ATTRIBUTE='definition';
write_attribute_for_group(group_id_3a,dadefinition,ATTRIBUTE);

% Create data sets within group three
% Weight
weight=array_of_do_fits(1,j).weight;
type = H5T.copy ('H5T_NATIVE_DOUBLE');
space=H5S.create('H5S_SCALAR');
name_def='weight';
DATASETID=create_and_write_double_dataset(group_id_3a,space,type,name_def,weight);
%attributes
attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward); % calls a function to add attributes

didefinition= 'the weight of the test subject in grams'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

%%%% units of datset
ATTRIBUTE      = 'units';
description= 'g'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);

%Age
age=array_of_do_fits(1,j).age;
if(strcmp(age,'NA')==1)
age=[]; % Need to add this for this one as NA is in Matlab file
space=H5S.create('H5S_NULL');
else
space=H5S.create('H5S_SCALAR');
end
type = H5T.copy ('H5T_NATIVE_INT');
name_def='age';
DATASETID=create_and_write_int_dataset(group_id_3a,space,type,name_def,age);
%attributes
attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward); % calls a function to add attributes

didefinition= 'the age of the test subject'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);

%%%% units of datset
ATTRIBUTE      = 'units';
description= 'days'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
%
% agetype
agetype=char(array_of_do_fits(1,j).agetype);
type = H5T.copy ('H5T_C_S1');
space=H5S.create('H5S_SCALAR');
name_def='agetype';
DATASETID=create_and_write_string_dataset(group_id_3a,space,type,name_def,agetype);

% add attributes
attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward); % calls a function to add attributes

didefinition= 'the general age group of the test subject possible values are adult and juvenile'; 
dadefinition= char(didefinition);
ATTRIBUTE='definition';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
% 
 
% estrous
estrous=array_of_do_fits(1,j).estrous;
if(strcmp(estrous,'NA')==1)
    estrous='NULL';
   else    
end
space=H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_C_S1');
name_def='estrous';
DATASETID=create_and_write_string_dataset(group_id_3a,space,type,name_def,estrous);

attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward); % calls a function to add attributes

%%%%%%%%%%%%%add definition

didefinition= 'for females only, the stage of estrous cycle of the test subject' ; 
dadefinition= char(didefinition);
ATTRIBUTE='definition';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);

% create  Phenotype data set
phenotype=array_of_do_fits(1,j).phenotype;
if(strcmp(phenotype,'tricolor'))
   phenotype='pigmented';
end   
type = H5T.copy ('H5T_C_S1');
space=H5S.create('H5S_SCALAR');
name_def='phenotype';
DATASETID=create_and_write_string_dataset(group_id_3a,space,type,name_def,phenotype);
attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward); % calls a function to add attributes

%%%%%%%%%%%%%add definition
didefinition= 'phenotype of cell donor, evident by fur and eye color'; 
dadefinition= char(didefinition);
ATTRIBUTE='definition';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);

% Sex
sex=array_of_do_fits(1,j).sex;
type = H5T.copy ('H5T_C_S1');
name_def='sex';
DATASETID=create_and_write_string_dataset(group_id_3a,space,type,name_def,sex);

%create attributes
attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward); % calls a function to add attributes

didefinition= 'gender of the subject'; 
dadefinition= char(didefinition);
ATTRIBUTE='definition';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);

H5F.close(fileID)
clearvars -except dirname filename_fits count k_adult_male array_of_do_fits pathfunctions pathbegdata pathsavedata;

end
end
