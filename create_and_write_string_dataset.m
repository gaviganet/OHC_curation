function [datsetid]=create_and_write_string_dataset(group_id_2a,space,type,name_def,vendor)
%UNTITLED2 Summary of this function goes here
H5T.set_size (type, length(vendor));
H5T.set_strpad(type,'H5T_STR_SPACEPAD');
generic_create = H5P.create('H5P_DATASET_CREATE');
layout = H5ML.get_constant_value('H5D_COMPACT');
H5P.set_layout(generic_create,layout);
datsetid = H5D.create(group_id_2a,name_def,type,space,generic_create);
H5D.write (datsetid, 'H5ML_DEFAULT', 'H5S_ALL', 'H5S_ALL', 'H5P_DEFAULT',vendor);


end

