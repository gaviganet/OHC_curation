# OHC_curation
The package contains three main items: (1) MATLAB scripts that facilitate the translation of a data-set from MATLAB to HDF5; (2) MATLAB scripts that facilitate the translation of the data-set back to MATLAB from HDF5; (3) MATLAB scripts used to analyze the data-set. This data set is whole-cell voltage clamp recordings of isolated outer hair cells from guinea pig.  The original data set saved as an array of structs in MATLAB without metadata can be found (here at repository) the data set saved as a collection of Specimens in HDF5 format with metadata can also be found (here at repository). Further details about this data-set can be found here.   

Download the HDF5 specimen files from the repository and peruse the data with HDFView which can be found here https://support.hdfgroup.org/products/java/release/hdfview3.html.  Note the work arounds if using a MAC or Windows-based PC. 
To examine the data in MATLAB use BACKFLOW_script.m to create a Table and give it a name like: 'array_of_hdf52mat_out.mat. 

There are several scripts that can be used to check the integrity of the data. For example, to check whether you can get the same calculated electrical parameters as reported by the researchers run the script CHECK_ELECTRICAL_PARAMETERS.m which plots the difference between that reported in the data-set and that calculated now by the interested user. 
