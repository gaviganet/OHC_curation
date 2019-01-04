function [array_of_hdf52mat_out,INFO]= HDF52MAT_v2a(hdf52mat_out,array_of_hdf52mat_out, N, beg)
%set up temporary storage for translation

data2=cell(1,N); %string
data3=zeros(1,N, 'int32');
data30=zeros(1,N, 'int32');
data4=zeros(1,1,'double');
data5_double=zeros(2,25,'double');
hdf52mat_out=struct; % this is structure for HDF2mat
array_of_hdf52mat_out=struct; %this is working array for all files
%beg=0;
for  i=1:1:N
m=i+beg;
pathsavedata=('Y:\OHC_Data\Data for portal\Specimen');
genpath('pathsavedata');
cd(pathsavedata);
namenew=strcat('sensory_cell_#',num2str(m),'.h5');
fileID = H5F.open(namenew,'H5F_ACC_RDONLY','H5P_DEFAULT');
INFO = h5info(namenew); 
% read attributes common to all files
 for k=1:1:6
    name_a=INFO.Attributes(k).Name;   
    class_a=INFO.Attributes(k).Datatype.Class;
     switch(class_a)
      case'H5T_INTEGER'
            TF = isempty(h5readatt(namenew,'/',name_a));
              if(TF==0)
                temp_d=h5readatt(namenew,'/',name_a);
                data30(1,1)=temp_d;
              else
               data30(1,1)=NaN;
              end  
            TF2=isvarname(name_a);
             if(TF2==1)
                hdf52mat_out = setfield(hdf52mat_out,name_a,data30(1,1));
                hdf52mat_out.name_a = data30(1,1);
             else
                name_a_corr=   matlab.lang.makeValidName(name_a);
                hdf52mat_out = setfield(hdf52mat_out,name_a_corr,data30(1,1));
              
             end  
      case'H5T_STRING' 
           temp_st = h5readatt(namenew,'/',name_a);
           data2(1,1)=cellstr(temp_st);
           TF2=isvarname(name_a);
              if(TF2==1)
                 hdf52mat_out = setfield(hdf52mat_out,name_a,data2(1,1));
              else
               name_a_corr=   matlab.lang.makeValidName(name_a);
               hdf52mat_out = setfield(hdf52mat_out,name_a_corr,data2(1,1));
              end
     end  
      clear name_a space_a class_a 
 end
%
% %% grab data from organism arm
 name_g=INFO.Groups(5).Groups(1).Name; %group name
 numb=length(INFO.Groups(5).Groups(1).Datasets); %number of datasets
 for k=1:1:numb
name_d=INFO.Groups(5).Groups(1).Datasets(k).Name;
class_d=INFO.Groups(5).Groups(1).Datasets(k).Datatype.Class;
space_d=INFO.Groups(5).Groups(1).Datasets(k).Dataspace.Size;
TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
TF3=isempty(space_d);
TF2=isvarname(name_d);
e=isfield(hdf52mat_out,name_d);
  switch(class_d)
    case'H5T_INTEGER'
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d,N,e);
    case'H5T_STRING' 
    temp_st=h5read(namenew,strcat(name_g,'/',name_d));
    data2(1,1)=cellstr(temp_st);
    if(i==1&&k==1) %may need another loop
     hdf52mat_out=cell2struct(data2(1:1:space_d,1),name_d,1);   
     hdf52mat_out=setfield(hdf52mat_out,name_d,data2(1,1));
   else
       hdf52mat_out=setfield(hdf52mat_out,name_d,data2(1,1));
    end
   case'H5T_FLOAT' 
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d,N,e);
  end 
 clear name_d space_d class_d 
 end
% % % % % % grab data from anatomical arm 
for j=1:1:2
 name_g=INFO.Groups(1).Groups(j).Name;
 numb=length(INFO.Groups(1).Groups(j).Datasets);
 for k=1:1:numb
 name_d=INFO.Groups(1).Groups(j).Datasets(k).Name;
 class_d=INFO.Groups(1).Groups(j).Datasets(k).Datatype.Class;
 space_d=INFO.Groups(1).Groups(j).Datasets(k).Dataspace.Size;
 TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
 TF3=isempty(space_d);
 TF2=isvarname(name_d);
 e=isfield(hdf52mat_out,name_d);
% % 
 switch(class_d)
 case'H5T_INTEGER'
     hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d,N,e);
 case'H5T_STRING'
     temp_st=h5read(namenew,strcat(name_g,'/',name_d));
     data2(1,1)=cellstr(temp_st);
     hdf52mat_out=setfield(hdf52mat_out,name_d,data2(1,1));
 end 
 end
end
name_g=INFO.Groups(1).Groups(2).Groups(1).Name;
name_d=INFO.Groups(1).Groups(2).Groups(1).Datasets(1).Name;
class_d=INFO.Groups(1).Groups(2).Groups(1).Datasets(1).Datatype.Class;
space_d=INFO.Groups(1).Groups(2).Groups(1).Datasets(1).Dataspace.Size;
TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
TF3=isempty(space_d);
TF2=isvarname(name_d);
e=isfield(hdf52mat_out,name_d);
% % 
 switch(class_d)
 case'H5T_INTEGER'
     hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d,N,e);
 case'H5T_STRING'
     temp_st=h5read(namenew,strcat(name_g,'/',name_d));
     data2(1,1)=cellstr(temp_st);
     hdf52mat_out=setfield(hdf52mat_out,name_d,data2(1,1));
 end 
 
% % % % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % grab data from cell arm 
for j=1:1:2
 name_g=INFO.Groups(3).Groups(1).Groups(2).Groups(j).Name;
 numb=length(INFO.Groups(3).Groups(1).Groups(2).Groups(j).Datasets);
 for k=1:1:numb
 name_d=INFO.Groups(3).Groups(1).Groups(2).Groups(j).Datasets(k).Name; %Dataset name
 class_d=INFO.Groups(3).Groups(1).Groups(2).Groups(j).Datasets(k).Datatype.Class; %Type of data like DOUBLE, STRING etc
 space_d=INFO.Groups(3).Groups(1).Groups(2).Groups(j).Datasets(k).Dataspace.Size; % Dimensions Size of Data Array if
 TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
 TF3=isempty(space_d);
 TF2=isvarname(name_d);
e=isfield(hdf52mat_out,name_d);
   switch(class_d)
    case'H5T_INTEGER'
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d, e);
    case'H5T_STRING'
    temp_st=h5read(namenew,strcat(name_g,'/',name_d));
    data2(1,1)=cellstr(temp_st);
    hdf52mat_out=setfield(hdf52mat_out,name_d,data2(1,1));
    case'H5T_FLOAT' 
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d, N, e);
   end
 end
end 
clear TF TF3 TF2 e numb name_g name_d
%  % grab image from cell arm
name_g=INFO.Groups(3).Groups(1).Groups(1).Name;
 numb=length(INFO.Groups(3).Groups(1).Groups(1).Datasets);
 for k=1:1:numb
 name_d=INFO.Groups(3).Groups(1).Groups(1).Datasets(k).Name; %Dataset name
 class_d=INFO.Groups(3).Groups(1).Groups(1).Datasets(k).Datatype.Class; %Type of data like DOUBLE, STRING etc
 space_d=INFO.Groups(3).Groups(1).Groups(1).Datasets(k).Dataspace.Size; % Dimensions Size of Data Array if
  TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
TF3=isempty(space_d);
TF2=isvarname(name_d);
e=isfield(hdf52mat_out,name_d);
if(TF3==0&&TF==0)  
   data2_bitfield=h5read(namenew,strcat(name_g,'/',name_d));
   if(TF2==1)
       hdf52mat_out=setfield(hdf52mat_out,name_d,data2_bitfield);
   else
       name_d_corr=   matlab.lang.makeValidName(name_d);
       hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data2_bitfield);
   end
end
 if(TF3==0&& TF==1)  
     data2_bitfield=[];
   if(TF2==1)
        hdf52mat_out=setfield(hdf52mat_out,name_d,data2_bitfield);
   else
        name_d_corr=   matlab.lang.makeValidName(name_d);
        hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data2_bitfield);
   end
 end
 end 
% % % % assay arm
 name_g=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Name;
 numb=length(INFO.Groups(2).Groups(1).Groups(1).Groups(1).Datasets);
 for k=1:1:numb
 name_d=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Datasets(k).Name;      
 space_d=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Datasets(k).Dataspace.Size;
class_d=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Datasets(k).Datatype.Class;
TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
TF3=isempty(space_d);
TF2=isvarname(name_d);
e=isfield(hdf52mat_out,name_d);
switch(class_d)
    case'H5T_INTEGER'    
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d,N, e);
    case'H5T_STRING'
    temp_st=h5read(namenew,strcat(name_g,'/',name_d));
    data2(1,1)=cellstr(temp_st);
    hdf52mat_out=setfield(hdf52mat_out,name_d,data2(1,1));
    case'H5T_FLOAT'       
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d, N, e);
   end
 end% 
for j=2:5 
name_g=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(j).Name;
 numb=length(INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(j).Datasets);
 for k=1:1:numb
 name_d=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(j).Datasets(k).Name;      
 space_d=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(j).Datasets(k).Dataspace.Size;
class_d=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(j).Datasets(k).Datatype.Class;
TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
TF3=isempty(space_d);
TF2=isvarname(name_d);
e=isfield(hdf52mat_out,name_d);
switch(class_d)
    case'H5T_INTEGER'    
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d,N, e);
    case'H5T_STRING'
    temp_st=h5read(namenew,strcat(name_g,'/',name_d));
    data2(1,1)=cellstr(temp_st);
    name_d_corr=   matlab.lang.makeValidName(name_d);
    hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data2(1,1));
    case'H5T_FLOAT'       
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d, N, e);
   end
 end% 
end
% grab extracellular solution parameters
name_g=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Groups(1).Name;
 numb=length(INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Groups(1).Datasets);
 for k=1:1:numb
 name_d=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Groups(1).Datasets(k).Name;      
 space_d=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Groups(1).Datasets(k).Dataspace.Size;
 class_d=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Groups(1).Datasets(k).Datatype.Class;
 TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
 TF3=isempty(space_d);
 TF2=isvarname(name_d);
 e=isfield(hdf52mat_out,name_d);
 switch(class_d)
    case'H5T_INTEGER'    
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d,N, e);
    case'H5T_STRING'
    temp_st=h5read(namenew,strcat(name_g,'/',name_d));
    data2(1,1)=cellstr(temp_st);
    name_d_corr=   matlab.lang.makeValidName(name_d);
    hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data2(1,1));
    case'H5T_FLOAT'       
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d, N, e);
   end
 end% 

%grab ions used

name_g=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Groups(1).Groups(1).Name;
 numb=length(INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Groups(1).Groups(1).Datasets);
 for k=1:1:numb
 name_d=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Groups(1).Groups(1).Datasets(k).Name;      
 space_d=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Groups(1).Groups(1).Datasets(k).Dataspace.Size;
class_d=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Groups(1).Groups(1).Datasets(k).Datatype.Class;
TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
TF3=isempty(space_d);
TF2=isvarname(name_d);
e=isfield(hdf52mat_out,name_d);
hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d, N, e);
end
% grab solution in pipette
name_g=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Groups(2).Name;
 numb=length(INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Groups(2).Datasets);
 for k=1:1:numb
 name_d=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Groups(2).Datasets(k).Name;      
 space_d=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Groups(2).Datasets(k).Dataspace.Size;
class_d=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Groups(2).Datasets(k).Datatype.Class;
TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
TF3=isempty(space_d);
TF2=isvarname(name_d);
e=isfield(hdf52mat_out,name_d);
switch(class_d)
    case'H5T_INTEGER'    
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d,N, e);
    case'H5T_STRING'
    temp_st=h5read(namenew,strcat(name_g,'/',name_d));
    data2(1,1)=cellstr(temp_st);
    name_d_corr=   matlab.lang.makeValidName(name_d);
    hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data2(1,1));
    case'H5T_FLOAT'       
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d, N, e);
   end
 end% 

%grab ions within pipette
name_g=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Groups(2).Groups(1).Name;
 numb=length(INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Groups(2).Groups(1).Datasets);
 for k=1:1:numb
 name_d=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Groups(2).Groups(1).Datasets(k).Name;      
 space_d=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Groups(2).Groups(1).Datasets(k).Dataspace.Size;
class_d=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Groups(2).Groups(1).Datasets(k).Datatype.Class;
TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
TF3=isempty(space_d);
TF2=isvarname(name_d);
e=isfield(hdf52mat_out,name_d);
switch(class_d)
    case'H5T_INTEGER'    
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d,N, e);
    case'H5T_STRING'
    temp_st=h5read(namenew,strcat(name_g,'/',name_d));
    data2(1,1)=cellstr(temp_st);
     hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data2(1,1));
    case'H5T_FLOAT'       
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d, N, e);
   end
 end% 
for j=1:3
 name_g=INFO.Groups(6).Groups(2).Groups(j).Name;
 numb=length(INFO.Groups(6).Groups(2).Groups(j).Datasets);
 for k=1:1:numb
 name_d=INFO.Groups(6).Groups(2).Groups(j).Datasets(k).Name;      
 space_d=INFO.Groups(6).Groups(2).Groups(j).Datasets(k).Dataspace.Size;
 class_d=INFO.Groups(6).Groups(2).Groups(j).Datasets(k).Datatype.Class;
 TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
 TF3=isempty(space_d);
 TF2=isvarname(name_d);
 e=isfield(hdf52mat_out,name_d);
    switch(class_d)
    case'H5T_INTEGER'    
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d,N, e);
    case'H5T_STRING'
    temp_st=h5read(namenew,strcat(name_g,'/',name_d));
    data2(1,1)=cellstr(temp_st);
    name_d_corr=   matlab.lang.makeValidName(name_d);
    hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data2(1,1));
    case'H5T_FLOAT'   
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d, N, e);
   end
 end 
 end
% Assay protocol 2
for j=2:1:3
name_g=INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(j).Name;
numb=length(INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(j).Datasets);
for k=1:1:numb
name_d=INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(j).Datasets(k).Name;      
space_d=INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(j).Datasets(k).Dataspace.Size;
class_d=INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(j).Datasets(k).Datatype.Class;
TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
TF3=isempty(space_d);
TF2=isvarname(name_d);
e=isfield(hdf52mat_out,name_d);
  switch(class_d)
    case'H5T_INTEGER'
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d,N, e);
    case'H5T_STRING'
    temp_st=h5read(namenew,strcat(name_g,'/',name_d));
    data2(1,1)=cellstr(temp_st);
    name_d_corr=   matlab.lang.makeValidName(name_d);
    hdf52mat_out=setfield(hdf52mat_out, name_d_corr,data2(1,1));
    case'H5T_FLOAT' 
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d, N, e);
  end
end
end
%transformed data sets
 name_g=INFO.Groups(6).Groups(1).Name;
 numb=length(INFO.Groups(6).Groups(1).Datasets);
 for k=1:1:numb
 name_d=INFO.Groups(6).Groups(1).Datasets(k).Name;      
 space_d=INFO.Groups(6).Groups(1).Datasets(k).Dataspace.Size;
 class_d=INFO.Groups(6).Groups(1).Datasets(k).Datatype.Class;
 TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
 TF3=isempty(space_d);
 TF2=isvarname(name_d);
 e=isfield(hdf52mat_out,name_d);
 hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d, N, e);
 end
  H5F.close(fileID); %close file
   if(i==1)
     array_of_hdf52mat_out=hdf52mat_out;
    array_of_hdf52mat_out(:,1:1:N)=array_of_hdf52mat_out;
   else
       fieldnames(hdf52mat_out);
      array_of_hdf52mat_out(:,i)=hdf52mat_out;  
  end  
 clear  namenew hdf52mat_out
 hdf52mat_out=struct;
end  
end
 % main local function to call
function hdf52mat_out = translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,type_d, N, e)
data4_double=zeros(1,N,'double');
data6_double=zeros(2,25,'double');
data3=zeros(1,N, 'int32');
sum1=0;
if(e==1)
    sum1 =sum1+1;
    name_d_corr=strcat(name_d,num2str(sum1));
    name_d_corr=   matlab.lang.makeValidName(name_d_corr);
    e1=isfield(hdf52mat_out,name_d_corr);
    if(e1==1)
     sum1=sum1+1;  
     name_d_corr=strcat(name_d_corr,num2str(sum1));
     e2=isfield(hdf52mat_out,name_d_corr);
      if(e2==1)
     sum1=sum1+1;  
     name_d_corr=strcat(name_d_corr,num2str(sum1));
      end
    end
end  
 if(length(space_d)~=2) % gets everything except I_mean
  switch(type_d)
    case'H5T_FLOAT' 
        if(TF3==0&&TF==0&& e==0 &&TF2==1)  
             data4_double(1:1:space_d(1),1)=h5read(namenew,strcat(name_g,'/',name_d));
             hdf52mat_out=setfield(hdf52mat_out,name_d,data4_double(1:1:space_d,1));
        end
        if(TF3==0&&TF==0&& e==1&&TF2==1)
            data4_double(1:1:space_d(1),1)=h5read(namenew,strcat(name_g,'/',name_d));
            hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data4_double(1:1:space_d,1));       
        end  
        if(TF3==0&&TF==0&& e==0 &&TF2==0)
            data4_double(1:1:space_d(1),1)=h5read(namenew,strcat(name_g,'/',name_d));
            name_d_corr=   matlab.lang.makeValidName(name_d);
            hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data4_double(1:1:space_d,1));
        end
        if(TF3==0&& TF==1&& e==0 &&TF2==1)
             data4_double(1:1:space_d,1)=NaN;
             hdf52mat_out=setfield(hdf52mat_out,name_d,data4_double(1:1:space_d,1));
        end    
        if(TF3==0&& TF==1&& e==1 &&TF2==1)   
              data4_double(1:1:space_d,1)=NaN;     
              hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data4_double(1:1:space_d,1));
        end
        if(TF3==0&& TF==1&& e==0 &&TF2==0)
              data4_double(1:1:space_d,1)=NaN;
              name_d_corr=   matlab.lang.makeValidName(name_d);
              hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data4_double(1:1:space_d,1));
        end
        if(TF3==1&& TF==1&& e==0 &&TF2==1)
              data4_double(1:1:space_d,1)=NaN;
              hdf52mat_out=setfield(hdf52mat_out,name_d,data4_double(1:1:space_d,1));
        end 
        if(TF3==1&& TF==0 && e==0 &&TF2==1)
            data4_double(1,1)=h5read(namenew,strcat(name_g,'/',name_d));
            hdf52mat_out=setfield(hdf52mat_out,name_d, data4_double(1,1));
        end   
        if(TF3==1&& TF==0 && e==1 &&TF2==1)
         data4_double(1,1)=h5read(namenew,strcat(name_g,'/',name_d));
         hdf52mat_out=setfield(hdf52mat_out,name_d_corr, data4_double(1,1));
        end
        if(TF3==1&& TF==0 && e==1 &&TF2==0)
         data4_double(1,1)=h5read(namenew,strcat(name_g,'/',name_d));
         name_d_corr=   matlab.lang.makeValidName(name_d);
         hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data4_double(1,1));
         end
% %% 
case 'H5T_INTEGER'
          if(TF3==0&&TF==0&& e==0 &&TF2==1)  
              data3(1:1:space_d,1)=h5read(namenew,strcat(name_g,'/',name_d));
              hdf52mat_out=setfield(hdf52mat_out,name_d,data3(1:1:space_d,1));
          end  
           if(TF3==0&&TF==0&& e==1&&TF2==1)
               data3(1:1:space_d,1)=h5read(namenew,strcat(name_g,'/',name_d)); 
               hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data3(1:1:space_d,1));
          end
          if(TF3==0&&TF==0&& e==0 &&TF2==0)
              data3(1:1:space_d,1)=h5read(namenew,strcat(name_g,'/',name_d)); 
              name_d_corr=   matlab.lang.makeValidName(name_d);
                   hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data3(1:1:space_d,1));
          end
          if(TF3==0&& TF==1&& e==0 &&TF2==1)      
             data3(1:1:space_d,1)=NaN;
             hdf52mat_out=setfield(hdf52mat_out,name_d,data3(1:1:space_d,1));
          end   
         if(TF3==0&& TF==1&& e==1 &&TF2==1)   
             data3(1:1:space_d,1)=NaN;
             hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data3(1:1:space_d,1));
         end   
         if(TF3==0&& TF==1&& e==0 &&TF2==0)
             data3(1:1:space_d,1)=NaN;       
             name_d_corr=   matlab.lang.makeValidName(name_d);
             hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data3(1:1:space_d,1));
         end
         if(TF3==1&& TF==0 && e==0 &&TF2==1)  
                 data3(1,1)=h5read(namenew,strcat(name_g,'/',name_d));        
                   hdf52mat_out=setfield(hdf52mat_out,name_d,data3(1,1));
         end
        if(TF3==1&& TF==1 && e==0 &&TF2==1)
             data3(1,1)=NaN;
             hdf52mat_out=setfield(hdf52mat_out,name_d,data3(1,1));
        end
        if(TF3==1&& TF==1 && e==0 &&TF2==0)
            data3(1,1)=NaN;
             name_d_corr=   matlab.lang.makeValidName(name_d);
             hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data3(1,1));    
        end        
end
 else  %gets I_mean
       if(TF3==0&&TF==0&& e==0 &&TF2==1)  
        data6_double(1:1:space_d(1),1:1:space_d(2))=h5read(namenew,strcat(name_g,'/',name_d));
        hdf52mat_out=setfield(hdf52mat_out,name_d,data6_double(1:1:space_d(1),1:1:space_d(2)));
       end
       if(TF3==0&&TF==0&& e==1&&TF2==1)   
        data6_double(1:1:space_d(1),1:1:space_d(2))=h5read(namenew,strcat(name_g,'/',name_d));
         hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data6_double(1:1:space_d(1),1:1:space_d(2)));       
       end  
       if(TF3==0&&TF==0&& e==0 &&TF2==0)    
        data6_double(1:1:space_d(1),1:1:space_d(2))=h5read(namenew,strcat(name_g,'/',name_d));
        name_d_corr=   matlab.lang.makeValidName(name_d);
        hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data6_double(1:1:space_d(1),1:1:space_d(2)));
       end
       if(TF3==0&& TF==1&& e==0 &&TF2==1)
         data6_double(1:1:space_d,1)=NaN;
         hdf52mat_out=setfield(hdf52mat_out,name_d,data6_double(1:1:space_d,1));
       end    
       if(TF3==0&& TF==1&& e==1 &&TF2==1)   
          data6_double(1:1:space_d,1)=NaN;     
          hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data6_double(1:1:space_d,1));
       end
       if(TF3==0&& TF==1&& e==0 &&TF2==0)
          data6_double(1:1:space_d,1)=NaN;
          name_d_corr=   matlab.lang.makeValidName(name_d);
          hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data6_double(1:1:space_d,1));
       end
       if(TF3==1&& TF==0 && e==0 &&TF2==1)
        data6_double(1,1)=h5read(namenew,strcat(name_g,'/',name_d));
        hdf52mat_out=setfield(hdf52mat_out,name_d, data6_double(1,1));
       end   
       if(TF3==1&& TF==0 && e==1 &&TF2==1)
        data6_double(1,1)=h5read(namenew,strcat(name_g,'/',name_d));
        hdf52mat_out=setfield(hdf52mat_out,name_d_corr, data6_double(1,1));
       end
       if(TF3==1&& TF==0 && e==1 &&TF2==0)
        data6_double(1,1)=h5read(namenew,strcat(name_g,'/',name_d));
        name_d_corr=   matlab.lang.makeValidName(name_d);
        hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data6_double(1,1));
       end
 end

 clear data3 data4_double A data6_double;
end
