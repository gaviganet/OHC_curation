# OHC_curation
The package contains three main items: (1) MATLAB scripts that facilitate the translation of a data-set from MATLAB to HDF5; (2) MATLAB scripts that facilitate the translation of the data-set back to MATLAB from HDF5; (3) MATLAB scripts used to analyze the data-set. This data set is whole-cell voltage clamp recordings of isolated outer hair cells from guinea pig.  The original data-set (four files) saved as an array of structs in MATLAB without metadata can be found (here at repository) the data set saved as a collection of Specimens in HDF5 format with metadata can also be found (here at repository). Further details about the curation of this data-set can be found here.   

Download the HDF5 specimen files from the repository and peruse the data with HDFView which can be found here https://support.hdfgroup.org/products/java/release/hdfview3.html.  Note the work arounds if using a MAC or Windows-based PC. 
To examine the data in MATLAB use BACKFLOW_script.m to create a Table and give it a name like: 'array_of_hdf52mat_out.mat. 

(1) MATLAB scripts that facilitate the translation of a data-set from MATLAB to HDF5. 

      (1A) The main M script file is curationv7.m.  
      
      (1B) This script calls 6 different functions that represent five arms of the curated data-set. These files are:
            arm_organismv8a.m
            arm_anatomicalv6b2.m
            arm_devicev6a.m
            arm_cellv6a.m
            arm_assayv11a2.m
            arm_data_transformation.m
            
      (1C) Each of the six (6) different functions calls another seven (7) functions
            create_and_write_double_dataset.m
            create_and_write_int_dataset.m
            create_and_write_string_dataset.m
            create_write_array_of_dble_dset.m
            specific_string_attribute.m
            write_attribute_for_group.m
            attribute_general.m
To run these scripts you will need to change the paths where the original MATLAB data is stored, the paths where the M files are stored and the path where the specimen files will be stored. More information about the script and functions can be found in the pdf file: ReadMe_translation_from_MATLAB_to_HDF5.

(2)  MATLAB scripts that facilitate the translation of the data-set back to MATLAB from HDF5

      (2A) The main M script file is HDF52MAT_script.m.  
      
      (2B) This script calls the function HDF52MAT_v2a.m.
      
(3) MATLAB scripts used to check the integrity of the data-set

3.1 To check whether you calculate the same electrical parameters (membrane resistance, membrane capacitance and series resistance) from the admittance measurements as that reported by the researcher. You will need to translate data from HDF5 to MATLAB (see item 2 above) and require

      (3.1A) The main M script file is check_cell_parameters.m 

      (3.1B) This script calls the functions calculate_b_Rm_Rs_Cm.m and parameter_sameassaved.m.

This script also plots the difference between that reported in the data-set, and that calculated now by the interested user in MATLAB. 

3.2 To check whether you calculate the same non-linear and linear electrical parameters (e.g., voltage at peak capacitance, linear capacitance) as that reported. You will need to translate data from HDF5 to MATLAB (see item 2 above) and require

     (3.2A) check_non_linear_electrical_properties.



