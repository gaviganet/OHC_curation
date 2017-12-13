function [ ] = specific_string_attribute(dataset_id,ATTRIBUTE,at_definition)
memtypest = H5T.copy ('H5T_C_S1');
H5T.set_strpad(memtypest,'H5T_STR_SPACEPAD')
att_str = H5P.create('H5P_ATTRIBUTE_CREATE');
space_id = H5S.create('H5S_SCALAR');

H5T.set_size (memtypest, length(at_definition));
attr_1 = H5A.create(dataset_id,ATTRIBUTE,memtypest,space_id,att_str);
H5A.write(attr_1,'H5ML_DEFAULT',at_definition);

end

