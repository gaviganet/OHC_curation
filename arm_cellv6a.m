
function arm_cellv6a(dirname, filename_fits,k_adult_male,count,pathfunctions,pathbegdata,pathsavedata)

newFolder=strcat(pathbegdata,dirname);
genpath('newFolder');
cd(newFolder);
load(filename_fits);
newFolder=pathfunctions;
genpath('newFolder');
cd(newFolder);
%
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
group_id_1a = H5G.create(fileID, '/cell', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');

didefinition= 'A material entity of anatomical origin (part of or deriving from an organism) that has as its parts a maximally connected cell compartment surrounded by a plasma membrane'; 
dadefinition= char(didefinition);
ATTRIBUTE='definition';
write_attribute_for_group(group_id_1a,dadefinition,ATTRIBUTE);

ATTRIBUTE      = 'imported_from';
description=  'http://purl.obolibrary.org/obo/CL_0000000';
dadefinition= char(description);
write_attribute_for_group(group_id_1a,dadefinition,ATTRIBUTE);


 group_id_2a = H5G.create(fileID, 'cell/outer hair cell', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
 
 didefinition= 'A mechanoreceptor in the organ of Corti. In mammals the outer hair cells are arranged in three rows which are further from the modiolus than the single row of inner hair cells.'; 
 dadefinition= char(didefinition);
 ATTRIBUTE      = 'definition';
 write_attribute_for_group(group_id_2a,dadefinition,ATTRIBUTE);
 
 
ATTRIBUTE      = 'imported_from';
description=  'http://purl.obolibrary.org/obo/CL_0000601';
dadefinition= char(description);
write_attribute_for_group(group_id_2a,dadefinition,ATTRIBUTE);

% Create and write image dataset only do this once so no need for
% additional functions keep code here
image_outer_hair_cell=array_of_do_fits(1,j).cfnimage; %grab image data from file
dim_i=size(image_outer_hair_cell);
dim0=3;
space = H5S.create_simple(dim0, fliplr(dim_i), []);
DATASETID = H5D.create(group_id_2a, 'image_outer_hair_cell', 'H5T_STD_B8BE', space, 'H5P_DEFAULT');
H5D.write(DATASETID,'H5T_NATIVE_B8','H5S_ALL','H5S_ALL','H5P_DEFAULT',image_outer_hair_cell); %write dataset
% add attributes
researcher=array_of_do_fits(1,j).researcher;
dofexp=array_of_do_fits(1,j).dofexp;
cellnumber=array_of_do_fits(1,j).cellnumber;
datasteward='Brenda Farrell, PhD';% this is an attribute common to all datasets
datacurator='Jason Bengtson, MLIS, MA';% this is an attribute
funder='NIH-NLM and NIH-NIDCD'; %this is an attribute 
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
% 
ptom=array_of_do_fits(1,j).ptom; 
type = H5T.copy ('H5T_NATIVE_DOUBLE');
space=H5S.create('H5S_SCALAR');
att_DBL = H5P.create('H5P_ATTRIBUTE_CREATE');
ATTRIBUTE='pixel to  micron conversion';
attr_1 = H5A.create(DATASETID,ATTRIBUTE,type,space,att_DBL); %creates double attribute
H5A.write(attr_1, 'H5ML_DEFAULT', round(ptom,3));
%  
% % Now setting up specific attributes for this dataset (string)
fnimage=array_of_do_fits(1,j).fnimage; % this is an attribute
ATTRIBUTE      = 'original filename of image file';
description={fnimage}; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'scale';
description= 'cross hairs are 10 micronmeter'; 
at_definition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,at_definition)

ATTRIBUTE      = 'definition';
description= 'a bitmap of the cell image captured during data collection'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

% %
% % create third layer
group_id_3a = H5G.create(fileID, 'cell/outer hair cell/cell morphology', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');


ATTRIBUTE      = 'definition';
didefinition= 'The morphology of a cell'; 
dadefinition= char(didefinition);
write_attribute_for_group(group_id_3a,dadefinition,ATTRIBUTE);
ATTRIBUTE      = 'imported from';
didefinition= 'http://purl.obolibrary.org/obo/OBA_1001065'; 
dadefinition= char(didefinition);
write_attribute_for_group(group_id_3a,dadefinition,ATTRIBUTE);

group_id_3b = H5G.create(fileID, 'cell/outer hair cell/cell morphology/predicted data item', 'H5P_DEFAULT', 'H5P_DEFAULT', 'H5P_DEFAULT');
ATTRIBUTE      = 'definition';
didefinition= 'A data item that was generated on the basis of a calculation or logical reasoning'; 
dadefinition= char(didefinition);
write_attribute_for_group(group_id_3b,dadefinition,ATTRIBUTE);
ATTRIBUTE      = 'imported from';
didefinition= 'http://purl.obolibrary.org/obo/OBI_0302867'; 
dadefinition= char(didefinition);
write_attribute_for_group(group_id_3b,dadefinition,ATTRIBUTE);

% 
% % create data sets and add their specific and non-specific attributes
% % surface area
TF=isnan(array_of_do_fits(1,j).Am);
if(TF==1)
    area=[];
    type = H5T.copy ('H5T_NATIVE_DOUBLE');
    space=H5S.create('H5S_NULL');
else
type = H5T.copy ('H5T_NATIVE_DOUBLE');
space=H5S.create('H5S_SCALAR');
area=array_of_do_fits(1,j).Am;
end
name_def='cell_surface_area';
DATASETID=create_and_write_double_dataset(group_id_3b,space,type,name_def,area);
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'surface area of  outer hair cell excluding stereocilia'; 
at_definition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,at_definition)
ATTRIBUTE      = 'label imported from';
description= 'http://purl.obolibrary.org/obo/OBA_1000034'; 
at_definition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,at_definition)
ATTRIBUTE      = 'units';
description= 'micronmeter x micronmeter';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'predicted data item';
description= 'calculated from the measured outer hair cell diameter and measured outer hair cell lateral wall length'; 
at_definition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,at_definition)

% % cell length
TF=isnan(array_of_do_fits(1,j).l);
if(TF==1)
    type = H5T.copy ('H5T_NATIVE_DOUBLE');
    space=H5S.create('H5S_NULL');
    OHC_length=[];
else
type = H5T.copy ('H5T_NATIVE_DOUBLE');
space=H5S.create('H5S_SCALAR');
OHC_length=array_of_do_fits(1,j).l;
end    
name_def='cochlear_outer_hair_cell_length';
DATASETID=create_and_write_double_dataset(group_id_3a,space,type,name_def,OHC_length);
% attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'length of outer hair cell from basal pole to cuticular plate'; 
atdefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,atdefinition)

ATTRIBUTE      = 'units';
description= 'micronmeter';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'label imported from';
description= 'http://purl.obolibrary.org/obo/OBA_VT0004466';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
% 
% % length lateral wall
OHC_lateral_wall_length=array_of_do_fits(1,j).L;
TF=isnan(array_of_do_fits(1,j).L);
if(TF==1)
    type = H5T.copy ('H5T_NATIVE_DOUBLE');
    space=H5S.create('H5S_NULL');
    OHC_lateral_wall_length=[];
else
    OHC_lateral_wall_length=array_of_do_fits(1,j).L;
    type = H5T.copy ('H5T_NATIVE_DOUBLE');
    space=H5S.create('H5S_SCALAR');
end
name_def='cochlear_outer_hair_cell_lateral_wall_length';
DATASETID=create_and_write_double_dataset(group_id_3a,space,type,name_def,OHC_lateral_wall_length);

%attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attribute

ATTRIBUTE      = 'definition';
description= 'length of cylindrical part of outer hair cell from cuticular plate to edge of basal portion'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

ATTRIBUTE      = 'units';
description ='micronmeter';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

TF=isnan(array_of_do_fits(1,j).diameter);

if(TF==1)
    OHC_diameter=[];
 type = H5T.copy ('H5T_NATIVE_DOUBLE');
space=H5S.create('H5S_NULL');
else
type = H5T.copy ('H5T_NATIVE_DOUBLE');
space=H5S.create('H5S_SCALAR');
OHC_diameter=array_of_do_fits(1,j).diameter;
end   
name_def='cell_diameter';
DATASETID=create_and_write_double_dataset(group_id_3a,space,type,name_def,OHC_diameter);
% 
%attribute_general(DATASETID,researcher, dofexp, cellnumber, datasteward, datacurator,funder); % calls a function to add attributes
ATTRIBUTE      = 'definition';
description= 'width of outer hair cell determined at nucleus'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'units';
description= 'micronmeter';
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)
ATTRIBUTE      = 'label imported from';
description= 'http://purl.obolibrary.org/obo/OBA_0000048'; 
dadefinition= char(description);
specific_string_attribute(DATASETID,ATTRIBUTE,dadefinition)

clearvars -except dirname filename_fits count k_adult_male array_of_do_fits pathfunctions pathbegdata pathsavedata;


end
end