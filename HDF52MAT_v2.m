function [array_of_hdf52mat_out,INFO]= HDF52MAT_v2(hdf52mat_out,array_of_hdf52mat_out, N, beg)
%set up temporary storage for translation
data2=cell(1,N); %string
data3=zeros(1,N, 'int32');
data4=zeros(1,1,'double');
data5_double=zeros(2,25,'double');
for  i=1:1:N
m=i+beg;
pathsavedata=('Y:\OHC_Data\Data for portal\Specimen');
genpath('pathsavedata');
cd(pathsavedata);
namenew=strcat('specimen_#',num2str(m),'.h5');
fileID = H5F.open(namenew,'H5F_ACC_RDONLY','H5P_DEFAULT');
INFO = h5info(namenew); 
%
% read attributes common to all datasets only read three attributes
name_g=INFO.Groups(5).Groups(1).Groups.Name; %group name
name_l=INFO.Groups(5).Groups(1).Groups.Datasets(1).Name;
 for k=1:1:4
    name_a=INFO.Groups(5).Groups(1).Groups.Datasets(1).Attributes(k).Name;   
    class_a=INFO.Groups(5).Groups(1).Groups.Datasets(1).Attributes(k).Datatype.Class;
     switch(class_a)
      case'H5T_INTEGER'
            TF = isempty(h5readatt(namenew,strcat(name_g,'/',name_l),name_a));
              if(TF==0)
                temp_d=h5readatt(namenew,strcat(name_g,'/',name_l),name_a);
                data3(1,1)=temp_d;
              else
               data3(1,1)=NaN;
              end  
            TF2=isvarname(name_a);
             if(TF2==1)
                hdf52mat_out = setfield(hdf52mat_out,name_a,data3(1,1));
                hdf52mat_out.name_a = data3(1,1);
             else
                name_a_corr=   matlab.lang.makeValidName(name_a);
                hdf52mat_out = setfield(hdf52mat_out,name_a_corr,data3(1,1));
              
             end  
      case'H5T_STRING' 
           temp_st = h5readatt(namenew,strcat(name_g,'/',name_l),name_a);
           data2(1,1)=cellstr(temp_st);
           TF2=isvarname(name_a);
              if(TF2==1)
                 hdf52mat_out = setfield(hdf52mat_out,name_a,data2(1,1));
              else
               name_a_corr=   matlab.lang.makeValidName(name_a);
               hdf52mat_out = setfield(hdf52mat_out,name_a_corr,data2(1,1));
              end
     end  
     clear name_d space_d class_d 
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%grab data from organism arm
name_g=INFO.Groups(5).Groups(1).Groups.Name; %group name
numb=length(INFO.Groups(5).Groups(1).Groups.Datasets); %number of datasets
for k=1:1:numb
name_d=INFO.Groups(5).Groups(1).Groups.Datasets(k).Name;
class_d=INFO.Groups(5).Groups(1).Groups.Datasets(k).Datatype.Class;
space_d=INFO.Groups(5).Groups(1).Groups.Datasets(k).Dataspace.Size;
TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
TF3=isempty(space_d);
TF2=isvarname(name_d);
  switch(class_d)
    case'H5T_INTEGER'
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d);
    case'H5T_STRING' 
    temp_st=h5read(namenew,strcat(name_g,'/',name_d));
    data2(1,1)=cellstr(temp_st);
    if(i==1&&k==1)
    hdf52mat_out=cell2struct(data2(1:1:space_d,1),name_d,1);
    hdf52mat_out=setfield(hdf52mat_out,name_d,data2(1,1));
    else
        hdf52mat_out=setfield(hdf52mat_out,name_d,data2(1,1));
    end 
   case'H5T_FLOAT' 
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d);
  end 
 end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% grab data from anatomical arm 
name_g=INFO.Groups(1).Groups(1).Name;
numb=length(INFO.Groups(1).Groups(1).Datasets);
for k=1:1:numb
name_d=INFO.Groups(1).Groups(1).Datasets(k).Name;
class_d=INFO.Groups(1).Groups(1).Datasets(k).Datatype.Class;
space_d=INFO.Groups(1).Groups(1).Datasets(k).Dataspace.Size;
TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
TF3=isempty(space_d);
TF2=isvarname(name_d);
switch(class_d)
case'H5T_INTEGER'
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d);
case'H5T_STRING'
      temp_st=h5read(namenew,strcat(name_g,'/',name_d));
      data2(1,1)=cellstr(temp_st);
      hdf52mat_out=setfield(hdf52mat_out,name_d,data2(1,1));
end 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% grab data from cell arm 
name_g=INFO.Groups(3).Groups(1).Groups(1).Name;
numb=length(INFO.Groups(3).Groups(1).Groups(1).Datasets);
for k=1:1:numb
name_d=INFO.Groups(3).Groups(1).Groups(1).Datasets(k).Name; %Dataset name
class_d=INFO.Groups(3).Groups(1).Groups(1).Datasets(k).Datatype.Class; %Type of data like DOUBLE, STRING etc
space_d=INFO.Groups(3).Groups(1).Groups(1).Datasets(k).Dataspace.Size; % Dimensions Size of Data Array if
 TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
 TF3=isempty(space_d);
 TF2=isvarname(name_d);
   switch(class_d)
    case'H5T_INTEGER'
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d);
    case'H5T_STRING'
    temp_st=h5read(namenew,strcat(name_g,'/',name_d));
    data2(1,1)=cellstr(temp_st);
    hdf52mat_out=setfield(hdf52mat_out,name_d,data2(1,1));
    case'H5T_FLOAT' 
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d);
   end
end
%
% add components of assay arm
% physical and temporal information
% drug extracellular
name_g=INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(1).Name;
numb=length(INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(1).Datasets);
for k=1:1:numb
name_d=INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(1).Datasets(k).Name;      
space_d=INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(1).Datasets(k).Dataspace.Size;
class_d=INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(1).Datasets(k).Datatype.Class;
TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
TF3=isempty(space_d);
TF2=isvarname(name_d);
hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d);
end
% intracellular solution
name_g=INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(4).Name;
numb=length(INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(4).Datasets);
for k=1:1:numb
 name_d=INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(4).Datasets(k).Name;      
 space_d=INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(4).Datasets(k).Dataspace.Size;
 class_d=INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(4).Datasets(k).Datatype.Class;
 TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
 TF3=isempty(space_d);
 TF2=isvarname(name_d);
hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d);
end
% extracellular solution
name_g=INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(3).Name;
numb=length(INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(3).Datasets);
for k=1:1:numb
name_d=INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(3).Datasets(k).Name;      
space_d=INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(3).Datasets(k).Dataspace.Size;
class_d=INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(3).Datasets(k).Datatype.Class;
TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
TF3=isempty(space_d);
TF2=isvarname(name_d);
hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d);
end
% physical and temporal
name_g=INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(5).Name;
numb=length(INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(5).Datasets);
for k=1:1:numb
name_d=INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(5).Datasets(k).Name;      
class_d=INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(5).Datasets(k).Datatype.Class;
space_d=INFO.Groups(2).Groups(1).Groups(1).Groups(2).Groups(5).Datasets(k).Dataspace.Size;
TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
TF3=isempty(space_d);
TF2=isvarname(name_d);
switch(class_d)
      case'H5T_STRING' 
      temp_st=h5read(namenew,strcat(name_g,'/',name_d));
      data2(1,1)=cellstr(temp_st);
      hdf52mat_out=setfield(hdf52mat_out,name_d,data2(1,1));
      case'H5T_FLOAT' 
      hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d);
end   
end
% first going to grab processed parameters
name_g=INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(1).Name;
numb=length(INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(1).Datasets);
for k=1:1:numb
name_d=INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(1).Datasets(k).Name;      
space_d=INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(1).Datasets(k).Dataspace.Size;
class_d=INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(1).Datasets(k).Datatype.Class;
TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
TF3=isempty(space_d);
TF2=isvarname(name_d);
hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d);
end 
% Grab voltage dependent terms measured
name_g=INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(3).Groups(1).Name;
numb=length(INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(3).Groups(1).Datasets);
for k=1:1:numb
name_d=INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(3).Groups(1).Datasets(k).Name;      
space_d=INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(3).Groups(1).Datasets(k).Dataspace.Size;
class_d=INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(3).Groups(1).Datasets(k).Datatype.Class;
TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
TF3=isempty(space_d);
TF2=isvarname(name_d);
hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d);
end
% Grab voltage dependent terms calculated with model
name_g=INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(3).Groups(1).Groups(1).Name;
numb=length(INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(3).Groups(1).Groups(1).Datasets);
for k=1:1:numb
name_d=INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(3).Groups(1).Groups(1).Datasets(k).Name;      
space_d=INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(3).Groups(1).Groups(1).Datasets(k).Dataspace.Size;
class_d=INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(3).Groups(1).Groups(1).Datasets(k).Datatype.Class;
TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
    TF3=isempty(space_d);
    TF2=isvarname(name_d);
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d);
end
% stimulus group
name_g=INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(2).Name;
numb=length(INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(2).Datasets);
for k=1:1:numb
name_d=INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(2).Datasets(k).Name;      
space_d=INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(2).Datasets(k).Dataspace.Size;
class_d=INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(2).Datasets(k).Datatype.Class;
TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
TF3=isempty(space_d);
TF2=isvarname(name_d);
hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d);
end  
% frequency dependent arrays
name_g=INFO.Groups(2).Groups(1).Groups(1).Groups(3).Name;
numb=length(INFO.Groups(2).Groups(1).Groups(1).Groups(3).Datasets);
for k=1:1:numb
name_d=INFO.Groups(2).Groups(1).Groups(1).Groups(3).Datasets(k).Name;      
space_d=INFO.Groups(2).Groups(1).Groups(1).Groups(3).Datasets(k).Dataspace.Size;
class_d=INFO.Groups(2).Groups(1).Groups(1).Groups(3).Datasets(k).Datatype.Class;
TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
TF3=isempty(space_d);
TF2=isvarname(name_d);
hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d);
end
%
name_g=INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(3).Name;
numb=length(INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(3).Datasets);
for k=1:1:numb
name_d=INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(3).Datasets(k).Name;      
space_d=INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(3).Datasets(k).Dataspace.Size;
class_d=INFO.Groups(2).Groups(1).Groups(1).Groups(3).Groups(3).Datasets(k).Datatype.Class;
TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
TF3=isempty(space_d);
TF2=isvarname(name_d);
hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d);
end
% DC measures
X=isempty(INFO.Groups(2).Groups(1).Groups(1).Groups(1).Datasets);
if(X==0)
name_g=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Name;
numb=length(INFO.Groups(2).Groups(1).Groups(1).Groups(1).Datasets);
 for k=1:1:numb
    name_d=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Datasets(k).Name;
    space_d=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Datasets(k).Dataspace.Size;
    class_d=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Datasets(k).Datatype.Class;
    T=strcmp(name_d,'current_DC');
    P=strcmp(name_d,'I_mean');
    S=strcmp(name_d,'R');
    V=strcmp(name_d,'V_hold');
    TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
    TF3=isempty(space_d);
    TF2=isvarname(name_d);
if(T==1)
hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d);
end
if(P==1)  
    if(TF3==0&& TF==0)  
         data5_double(1:1:space_d(1,1),1:1:space_d(1,2))=h5read(namenew,strcat(name_g,'/',name_d));
     if(TF2==1)
         hdf52mat_out=setfield(hdf52mat_out,name_d,data5_double(1:1:space_d(1,1),1:1:space_d(1,2)));
     else
         name_d_corr=   matlab.lang.makeValidName(name_d);
         hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data5_double(1:1:space_d(1,1),1:1:space_d(1,2)));
     end  
    end  
if(TF3==0&& TF==1)  
     data5_double(1:1:space_d(1,1),1:1:space_d(1,2))=NaN;
  if(TF2==1)
         hdf52mat_out=setfield(hdf52mat_out,name_d,data5_double(1:1:space_d(1,1),1:1:space_d(1,2)));
     else
         name_d_corr=   matlab.lang.makeValidName(name_d);
         hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data5_double(1:1:space_d(1,1),1:1:space_d(1,2)));
 end  
end
 if(TF3==1&&TF==0)
    data4(1,1)=h5read(namenew,strcat(name_g,'/',name_d));
    if(TF2==1)
           hdf52mat_out=setfield(hdf52mat_out,name_d,data4(1,1));
    else
           name_d_corr=   matlab.lang.makeValidName(name_d);
           hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data4(1,1));
    end        
 end
 if(TF3==1&&TF==1)
     data4(1,1)=NaN;
     if(TF2==1)
     hdf52mat_out=setfield(hdf52mat_out,name_d,data4(1,1));
     else
     name_d_corr=   matlab.lang.makeValidName(name_d);
     hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data4(1,1));
     end        
 end    
end
if(S==1||V==1)   
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d);
end  
end
else
   data4_double(1:1:1,1)=NaN;
   data6_double(1:1:1,1:1:1,1)=NaN;
   hdf52mat_out=setfield(hdf52mat_out,'I_mean',data6_double(1,1,1));
   hdf52mat_out=setfield(hdf52mat_out,'R',data4_double(1,1));
   hdf52mat_out=setfield(hdf52mat_out,'V_hold',data4_double(1,1));
   hdf52mat_out=setfield(hdf52mat_out,'current_DC',data4_double(1,1));
end
%stimulus group 
X=isempty(INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Datasets);
if(X==0)
    name_g=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Name;
    numb=length(INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Datasets);
for k=1:1:numb
    name_d=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Datasets(k).Name;      
    space_d=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Datasets(k).Dataspace.Size;
    class_d=INFO.Groups(2).Groups(1).Groups(1).Groups(1).Groups(1).Datasets(k).Datatype.Class;
    TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
    TF3=isempty(space_d);
    TF2=isvarname(name_d);
    hdf52mat_out=translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,class_d);
end
else
   data4_double(1:1:1,1)=NaN;
   hdf52mat_out=setfield(hdf52mat_out,'delta_time',data4_double(1,1));
   hdf52mat_out=setfield(hdf52mat_out,'voltage_DC',data4_double(1,1));
end
%grab cell image
name_g=INFO.Groups(3).Groups(1).Name;
numb=length(INFO.Groups(3).Groups(1).Datasets);
for k=1:1:numb
name_d=INFO.Groups(3).Groups(1).Datasets(k).Name;      
space_d=INFO.Groups(3).Groups(1).Datasets(k).Dataspace.Size;

TF= isempty(h5read(namenew,strcat(name_g,'/',name_d)));
TF3=isempty(space_d);
TF2=isvarname(name_d);
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
%
H5F.close(fileID); %close file
if(i==1)
   array_of_hdf52mat_out=hdf52mat_out;
   array_of_hdf52mat_out(:,1:1:N)=array_of_hdf52mat_out;
 else
   array_of_hdf52mat_out(:,i)=hdf52mat_out;  
 end  
clear  namenew
end
% main local function to call
%%%%%%%%%%%%%
function [hdf52mat_out] = translate_HDF5double_or_int_2_MLB(namenew,name_g,name_d,space_d,TF,TF3,TF2,hdf52mat_out,type_d)
data4_double=zeros(1,N,'double');
data3=zeros(1,N, 'int32');
switch(type_d)
    case'H5T_FLOAT'  
if(TF3==0&&TF==0)  
     data4_double(1:1:space_d,1)=h5read(namenew,strcat(name_g,'/',name_d));
     if(TF2==1)
          hdf52mat_out=setfield(hdf52mat_out,name_d,data4_double(1:1:space_d,1));
     else
          name_d_corr=   matlab.lang.makeValidName(name_d);
          hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data4_double(1:1:space_d,1));
     end  
end  
 if(TF3==0&& TF==1)  
     data4_double(1:1:space_d,1)=NaN;
 if(TF2==1)
           hdf52mat_out=setfield(hdf52mat_out,name_d,data4_double(1:1:space_d,1));
     else
           name_d_corr=   matlab.lang.makeValidName(name_d);
           hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data4_double(1:1:space_d,1));
 end  
 end
 if(TF3==1&& TF==0)
    data4_double(1,1)=h5read(namenew,strcat(name_g,'/',name_d));
    if(TF2==1)
           hdf52mat_out=setfield(hdf52mat_out,name_d,data4_double(1,1));
    else
           name_d_corr=   matlab.lang.makeValidName(name_d);
           hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data4_double(1,1));
    end        
 end
 if(TF3==1&& TF==1)
     data4_double(1,1 )=NaN;
     if(TF2==1)
     hdf52mat_out=setfield(hdf52mat_out,name_d,data4_double(1,1));
     else
     name_d_corr=   matlab.lang.makeValidName(name_d);
     hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data4_double(1,1));
     end        
 end    
 case'H5T_INTEGER'
    data3=zeros(1,1, 'int32');
    if(TF3==0&& TF==0)  
    data3(1:1:space_d,1)=h5read(namenew,strcat(name_g,'/',name_d));
    if(TF2==1)
          hdf52mat_out=setfield(hdf52mat_out,name_d,data3(1:1:space_d,1));
    else
          name_d_corr=   matlab.lang.makeValidName(name_d);
          hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data3(1:1:space_d,1));
    end  
    end  
   if(TF3==0&& TF==1)  
     data3(1:1:space_d,1)=NaN;
   if(TF2==1)
           hdf52mat_out=setfield(hdf52mat_out,name_d,data3(1:1:space_d,1));
   else
           name_d_corr=   matlab.lang.makeValidName(name_d);
           hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data3(1:1:space_d,1));
   end  
   end
   if(TF3==1&& TF==0)
         data3(1,1)=h5read(namenew,strcat(name_g,'/',name_d));
      if(TF2==1)
           hdf52mat_out=setfield(hdf52mat_out,name_d,data3(1,1));
      else
           name_d_corr=   matlab.lang.makeValidName(name_d);
           hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data3(1,1));
      end        
   end
 if(TF3==1&& TF==1)
     data3(1,1)=NaN;
     if(TF2==1)
     hdf52mat_out=setfield(hdf52mat_out,name_d,data3(1,1));
     else
     name_d_corr=   matlab.lang.makeValidName(name_d);
     hdf52mat_out=setfield(hdf52mat_out,name_d_corr,data3(1,1));
     end        
 end    
end
end
end


