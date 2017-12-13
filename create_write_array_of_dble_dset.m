function [ dataset_id ] = create_write_array_of_dble_dset( group_id_2b,dataspaceID,type,dim0,dimw,name1,Imlf )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
H5S.set_extent_simple(dataspaceID, dim0,fliplr(dimw), []);
dataset_id = H5D.create (group_id_2b,name1, type, dataspaceID, 'H5P_DEFAULT');
H5D.write (dataset_id, 'H5ML_DEFAULT', 'H5S_ALL', 'H5S_ALL', 'H5P_DEFAULT', Imlf);

end

