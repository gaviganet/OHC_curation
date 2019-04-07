# OHC_curation
The package contains four main items: (1) MATLAB scripts that facilitate the translation of a data collection from MATLAB to HDF5; (2) MATLAB scripts that facilitate the translation of the data collection back to MATLAB from HDF5; (3) MATLAB scripts used to analyze the data and (4) the ontological OWL file (OBI_based_Inner_Ear_Electrophysiology, OBI_IEE). This data collection is whole-cell voltage clamp recordings of isolated outer hair cells obtained from the domestic guinea pig.  The original unstructured data (four files) is saved as an array of structs in MATLAB and can be found (here at repository) the structured data saved as a collection of digital specimens in HDF5 format with metadata can also be found (here at repository). Further details about the curation of this data can be found here http://ceur-ws.org/Vol-2285/.   

1. To persue the curated data this can be done with HFFView after downloading the HDF5 digital specimen files from the repository.  HDFView which can be found here https://www.hdfgroup.org/downloads/hdfview/ after you open a free account https://www.hdfgroup.org/register/.  Note there are work arounds if using a MAC or Windows-based PC. 

(2) MATLAB scripts that facilitate the translation of a data from MATLAB to HDF5. 

      (2A) The main M script file is curationv7.m.  
      
      (2B) This script calls 6 different functions that represent five arms of the curated data-set. These files are:
            arm_organismv8a.m
            arm_anatomicalv6b2.m
            arm_devicev6a.m
            arm_cellv6a.m
            arm_assayv11a2.m
            transformed_data_set.m
            
      (2C) Each of the six (6) different functions calls another seven (7) functions
            create_and_write_double_dataset.m
            create_and_write_int_dataset.m
            create_and_write_string_dataset.m
            create_write_array_of_dble_dset.m
            specific_string_attribute.m
            write_attribute_for_group.m
            attribute_general.m
To run these scripts you will need to change the paths where the original MATLAB data is stored, the paths where the M files are stored and the path where the specimen files will be stored. 

(3)  MATLAB scripts that facilitate the translation of the data back to MATLAB from HDF5

      (3A) The main M script file is HDF52MAT_script.m.  
      
      (3B) This script calls the function HDF52MAT_v2a.m.
      
(4) MATLAB scripts used to check the integrity of the data-set

4.1 To check whether you calculate the same electrical parameters (membrane resistance, membrane capacitance and series resistance) from the admittance measurements as that reported by the researcher. You will need to translate data from HDF5 to MATLAB (see item 2 above) and require

      (4.1A) The main M script file is check_cell_parameters.m 

      (4.1B) This script calls the functions calculate_b_Rm_Rs_Cm.m and parameter_sameassaved.m.

This script also plots the difference between that reported in the data-set, and that calculated now by the interested user in MATLAB. 

4.2 To check whether you calculate the same non-linear and linear electrical parameters (e.g., voltage at peak capacitance, linear capacitance) as that reported. You will need to translate data from HDF5 to MATLAB (see item 2 above) and require

     (4.2A) check_non_linear_electrical_properties.
     
(5)  The ontology OWL file is named OBI_IEE.owl and can be viewed with Protege which can be downloaded here https://protege.stanford.edu/  



