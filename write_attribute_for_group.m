function write_attribute_for_group(group_id_1a,dadefinition,ATTRIBUTE)

type_g = H5T.copy('H5T_C_S1');
H5T.set_size (type_g, length(dadefinition));
H5T.set_strpad(type_g,'H5T_STR_SPACEPAD');
space_g=H5S.create('H5S_SCALAR');
generic_create = H5P.create('H5P_ATTRIBUTE_CREATE');
attr_g = H5A.create(group_id_1a,ATTRIBUTE,type_g,space_g,generic_create);
H5A.write(attr_g,'H5ML_DEFAULT', dadefinition);