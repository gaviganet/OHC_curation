function [ datsetid ] = create_and_write_int_dataset(group_id_3a,space,type,name_def,age)
%UNTITLED5 Summary of this function goes here
%  
generic_create = H5P.create('H5P_DATASET_CREATE');
layout = H5ML.get_constant_value('H5D_COMPACT');
H5P.set_layout(generic_create,layout);
datsetid = H5D.create(group_id_3a,name_def,type,space,generic_create);
H5D.write (datsetid, 'H5ML_DEFAULT', 'H5S_ALL', 'H5S_ALL', 'H5P_DEFAULT', age)

end

