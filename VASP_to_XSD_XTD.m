function VASP_to_XSD_XTD
%%  Code written by Geun Ho Gu
%   University of Delaware
%   December 30th, 2015
%
%   Creates  XSD files. Requires rdir and grep functions
%
%   Input:
%       paths (that has CONTCAR POSCAR XDATCAR)
%   Output:
%       Creates XSD files in the folder POSCAR/CONTCAR/XDATCAR is in
%
% Script goes through all subfolders (including specified folders) and find
% POSCAR/CONTCAR/XDATCAR and convert.
% For NEB, the script search for POSCAR in folder name 00, and convert.
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%% User Input %%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%%% path set up
% script find all VASP files - including files within all the subflolders 
input_fldr = 'C:\Research\Data\Projects\MuSiC - SolventGA\GA_Data\Final_dataset\RandomSet\vac_contcars\';
convert_CONTCAR = 1;
convert_XDATCAR = 1;
convert_POSCAR = 1;
convert_NEB = 0;
%%% if turned on, will print energy if OSZICAR is found
% For NEB, image with highest energy will be printed out
options.read_OSZICAR_and_include_energy_in_file_name = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initialize
%%% Add the location of the matlab script as path
paths.mfile = [fileparts(which([mfilename '.m'])) '\'];
%%% Add functions to path
addpath([paths.mfile 'VASP_read_write_library\']);
addpath([paths.mfile 'etc_library\rdir\']);
addpath([paths.mfile 'etc_library\grep04apr06\']);

%% Convert
%%% CONTCAR first
switch convert_CONTCAR; case 1;
    flist = rdir([input_fldr '\**\CONTCAR']);
    for i=1:length(flist)
        paths.input = flist(i).name;
        VASPoutput_to_XSD_XTD(paths,options);      
    end
end

switch convert_POSCAR; case 1;
    flist = rdir([input_fldr '\**\POSCAR']);
    for i=1:length(flist)
        paths.input = flist(i).name;
        VASPoutput_to_XSD_XTD(paths,options);      
    end
end

switch convert_XDATCAR; case 1;
    flist = rdir([input_fldr '\**\XDATCAR']);
    for i=1:length(flist)
        paths.input = flist(i).name;
        VASPoutput_to_XSD_XTD(paths,options);      
    end
end

switch convert_NEB; case 1;
    flist = rdir([input_fldr '\**\00\POSCAR']);
    for i=1:length(flist)
        paths.input = flist(i).name;
        slash_index = regexp(paths.input,'\');
        paths.input = paths.input(1:slash_index(end-1));
        VASP_NEBoutput_to_XTD(paths,options);      
    end
end


end


    
