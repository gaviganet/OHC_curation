
function arm_organismv8a(dirname, filename_fits,k_adult_male,count,pathfunctions,pathbegdata,pathsavedata)

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
datacurator='Jason Bengtson, MLIS, MA';% this is an attribute
funder='NIH-NLM and NIH-NIDCD'; %this is an attribute 
write_attribute_for_file(fileID,researcher, dofexp, cellnumber, datasteward, datacurator,funder);
% Create group structure
group_id_1a = H5G.create(fileID, '/organism', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
didefinition= 'A material entity that is an individual living system, such as animal, plant, bacteria or virus, that is capable of replicating or reproducing, growth and maintenance in the right environment. An organism may be unicellular or made up, like humans, of many billions of cells divided into specialized tissues and organs.'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
write_attribute_for_group(group_id_1a,dadefinition,ATTRIBUTE)

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
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mass=array_of_do_fits(1,j).weight;
type = H5T.copy ('H5T_NATIVE_DOUBLE');
space=H5S.create('H5S_SCALAR');
name_def='mass';
DATASETID=create_and_write_double_dataset(group_id_2a,space,type,name_def,mass);
%attributes
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes

didefinition= 'the weight or mass of the test subject'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'alternative definition';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
didefinition= 'a scalar measurement datum that is the result of measurement of mass quality'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
didefinition= ' http://purl.obolibrary.org/obo/IAO_0000414'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'imported from';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

%%%% units of datset
ATTRIBUTE      = 'units';
description= 'g'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);

life_death_temporal_boundary=array_of_do_fits(1,j).tod;
type = H5T.copy ('H5T_C_S1');
space=H5S.create('H5S_SCALAR');
didefinition= 'life_death_temporal_boundary'; 
name_def= char(didefinition);
DATASETID=create_and_write_string_dataset(group_id_2a,space,type,name_def,life_death_temporal_boundary);

% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'A life cycle temporal boundary that marks the end of the life cycle of the organism'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'imported from';
description= 'http://purl.obolibrary.org/obo/UBERON_0035944';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'alternative definition';
description= 'time at which animal vital functions ceased or time of death'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
%Age
age=array_of_do_fits(1,j).age;
if(strcmp(age,'NA')==1)
age=[]; % Need to add this for this one as NA is in Matlab file
space=H5S.create('H5S_NULL');
else
space=H5S.create('H5S_SCALAR');
end
type = H5T.copy ('H5T_NATIVE_INT');
name_def='age_since_birth';
DATASETID=create_and_write_int_dataset(group_id_2a,space,type,name_def,age);
%attributes
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward,datacurator,funder); % calls a function to add attributes

didefinition= 'An age measurement datum that is the result of the measurement of the age of an organism since birth, the process of emergence and separation of offspring from the mother.'; 
dadefinition= char(didefinition);
ATTRIBUTE      = 'definition';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
ATTRIBUTE      = 'imported from';
description= 'http://purl.obolibrary.org/obo/OBI_0001169';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
%%%% units of datset
ATTRIBUTE      = 'units';
description= 'days'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
phenotype=array_of_do_fits(1,j).phenotype;
if(strcmp(phenotype,'tricolor'))
   phenotype='normal';
end   
type = H5T.copy ('H5T_C_S1');
space=H5S.create('H5S_SCALAR');
name_def='mammalian_phenotype';
DATASETID=create_and_write_string_dataset(group_id_2a,space,type,name_def,phenotype);
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes

%%%%%%%%%%%%%add definition
didefinition= 'The observable morphological, physiological, behavioral and other characteristics of mammalian organisms that are manifested through development and lifespan'; 
dadefinition= char(didefinition);
ATTRIBUTE='definition';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);

didefinition= 'http://purl.obolibrary.org/obo/MP_0000001'; 
dadefinition= char(didefinition);
ATTRIBUTE      ='imported_from';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);

%
didefinition= 'normal and albino'; 
dadefinition= char(didefinition);
ATTRIBUTE      ='allowed values';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
%
% maturity
maturity=char(array_of_do_fits(1,j).agetype);
if(strcmp(maturity,'Adult'))
   maturity='mature';
end
if(strcmp(maturity,'prepubertal'))
   maturity='juvenile';
end
type = H5T.copy ('H5T_C_S1');
space=H5S.create('H5S_SCALAR');
name_def='maturity';
DATASETID=create_and_write_string_dataset(group_id_2a,space,type,name_def,maturity);

% add attributes
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder);% calls a function to add attributes

didefinition= 'A quality of a single physical entity which is held by a bearer when the latter exhibits complete growth, differentiation, or development'; 
dadefinition= char(didefinition);
ATTRIBUTE='definition';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
didefinition= ' http://purl.obolibrary.org/obo/PATO_0000261'; 
dadefinition= char(didefinition);
ATTRIBUTE='imported from';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
didefinition= 'mature (or adult) and juvenile (or prepubertal)';  
dadefinition= char(didefinition);
ATTRIBUTE='allowed values';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
% 
 
% estrous
estrous_cycle_phase=array_of_do_fits(1,j).estrous;
if(strcmp(estrous_cycle_phase,'NA')==1)
    estrous_cycle_phase='NULL';
else   
       estrous_cycle_phase='metestrus';
end
space=H5S.create('H5S_SCALAR');
type = H5T.copy ('H5T_C_S1');
name_def='estrous_cycle_phase';
DATASETID=create_and_write_string_dataset(group_id_2a,space,type,name_def,estrous_cycle_phase);

% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward,datacurator,funder); % calls a function to add attributes

%%%%%%%%%%%%%add definition

didefinition= 'for females only, the progression of physiological phases, occurring in the endometrium during the estrous cycle that recur at regular intervals during the reproductive years. The estrous cycle is an ovulation cycle where the endometrium is resorbed if pregnancy does not occur.' ; 
dadefinition= char(didefinition);
ATTRIBUTE='definition';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
didefinition= 'http://purl.obolibrary.org/obo/GO_0060206'; 
dadefinition= char(didefinition);
ATTRIBUTE='imported from';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
didefinition= 'diestrus, proestrus, estrus, metestrus';  
dadefinition= char(didefinition);
ATTRIBUTE='allowed values';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);

% Sex
sex=array_of_do_fits(1,j).sex;
if(strcmp(sex,'F'))
   sex='female';
end
if(strcmp(sex,'M'))
   sex='male';
end
type = H5T.copy ('H5T_C_S1');
name_def='phenotypic_sex';
DATASETID=create_and_write_string_dataset(group_id_2a,space,type,name_def,sex);

%create attributes
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
didefinition= 'gender of the subject'; 
dadefinition= char(didefinition);
ATTRIBUTE='definition';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);
didefinition= 'http://purl.obolibrary.org/obo/PATO_0001894'; 
dadefinition= char(didefinition);
ATTRIBUTE='imported from';
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition);

% Add vendor to group
phenotype=array_of_do_fits(1,j).phenotype;
if(strcmp(phenotype,'tricolor'))
   didefinition='bred at Baylor College of Medicine with initial and supplemented stock from Elm Hill Labs';
   dadefinition= char(didefinition);
else
   didefinition='animals purchased from Charles River Laboratories';
   dadefinition= char(didefinition);
end   
ATTRIBUTE='vendor';
write_attribute_for_group(group_id_2a,dadefinition,ATTRIBUTE);
% %add atributes
% didefinition= 'company where animals were bred and/or purchased'; 
% dadefinition= char(didefinition);
% ATTRIBUTE='definition';
% specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
H5F.close(fileID)
clearvars -except dirname filename_fits count k_adult_male array_of_do_fits pathfunctions pathbegdata pathsavedata;

end
end
