function [ ] = attribute_general(dataset_id,researcher, dofexp, cellnumber, datasteward)
% Now setting up space for string attribute
memtypest = H5T.copy ('H5T_C_S1');
H5T.set_strpad(memtypest,'H5T_STR_SPACEPAD')
att_str = H5P.create('H5P_ATTRIBUTE_CREATE');
space_id = H5S.create('H5S_SCALAR');

% Now setting up space for integer attribute
memtypeint = H5T.copy ('H5T_NATIVE_INT');
att_int = H5P.create('H5P_ATTRIBUTE_CREATE');
dim0=1; %this is dimension 
space_id2 = H5S.create_simple (1,fliplr( dim0), []);

ATTRIBUTE      = 'researcher';
description={researcher}; 
at_definition= char(description);
H5T.set_size (memtypest, length(at_definition));
attr_1 = H5A.create(dataset_id,ATTRIBUTE,memtypest,space_id,att_str);
H5A.write(attr_1, 'H5ML_DEFAULT', at_definition);

ATTRIBUTE      = 'date of experiment';
description={dofexp}; 
at_definition= char(description);
H5T.set_size (memtypest, length(at_definition));
attr_1 = H5A.create(dataset_id,ATTRIBUTE,memtypest,space_id,att_str);
H5A.write(attr_1, 'H5ML_DEFAULT', at_definition);

ATTRIBUTE      = 'data steward';
description=datasteward; 
at_definition= char(description); %already a string;
H5T.set_size (memtypest, length(at_definition));
attr_1 = H5A.create(dataset_id,ATTRIBUTE,memtypest,space_id,att_str);
H5A.write(attr_1, 'H5ML_DEFAULT', at_definition);

ATTRIBUTE='original cell number';
 % this is an attribute
attr_1 = H5A.create(dataset_id,ATTRIBUTE,memtypeint,space_id2,att_int);
H5A.write(attr_1, 'H5ML_DEFAULT', cellnumber);



end

