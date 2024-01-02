function SaveGsfFile(file_name, header, data, directory)
% DESCRIPTION:
% This function is used to convert the data mat into a *.gsf file
% file_name: the file
% header: has field include:
%           x_real: x axis area, default: 1.0
%           y_real: y axis area, default: 1.0
%           x_offset: x offset of piezo, default: 0.0
%           y_offset: y offset of piezo, default: 0.0
%           title: channel of the mapping, default: height
%           xy_units: units in x/y direction, default: um
%           z_units: units in z direction, default: m
% eg: 
% header = struct('x_real', 5e-06, ...
%                     'y_real', 5e-06,...
%                    'x_offset',0,...
%                    'y_offset', 0,...
%                       'title', 'z1',...
%                    'xy_units', 'um',...
%                     'z_units', 'm');
% data: data mat
% directory: path to save the *.gsf file

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  this block is for testing the code
% x = -1:0.01:1; y = x;
% [X,Y] = meshgrid(x,y);
% Z = X.^2 + Y.^2;
% surf(Z)
% Z = single(Z);
% [m,n] = size(Z);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% open a new *.gsf file 
file_name = strcat(file_name ,'.gsf');
file_name = strcat(directory, '\', file_name);

[m_sz , n_sz] = size(data);

x_res = strcat('XRes = ',32, num2str(m_sz));
y_res = strcat('YRes = ',32, num2str(n_sz));

x_real = strcat('XReal = ',32, num2str(header.x_real));
y_real = strcat('YReal = ',32, num2str(header.y_real));
x_offset = strcat('XOffset = ',32, num2str(header.x_offset));
y_offset = strcat('YOffset = ',32, num2str(header.y_offset));
title = strcat('Title = ',32, header.title);
xy_units = strcat('XYUnits = ',32, header.xy_units);
z_units = strcat('ZUnits = ',32, header.z_units);

fileID = fopen(file_name, 'w');

% magic line 
fwrite(fileID, 'Gwyddion Simple Field 1.0', 'char'); fprintf(fileID,'\n');

% text header
fwrite(fileID, x_res, 'char'); fprintf(fileID,'\n');
fwrite(fileID, y_res, 'char'); fprintf(fileID,'\n');
fwrite(fileID, x_real, 'char'); fprintf(fileID,'\n');
fwrite(fileID, y_real, 'char'); fprintf(fileID,'\n');
fwrite(fileID, x_offset, 'char'); fprintf(fileID,'\n');
fwrite(fileID, y_offset, 'char'); fprintf(fileID,'\n');
fwrite(fileID, title, 'char'); fprintf(fileID,'\n');
fwrite(fileID, xy_units, 'char'); fprintf(fileID,'\n');
fwrite(fileID, z_units, 'char'); fprintf(fileID,'\n');

% NUL padding
Non_data_str = strcat('Gwyddion Simple Field 1.0', x_res, y_res, x_real, y_real,...
               x_offset, y_offset, title, xy_units, z_units);
Non_data_str,        
NUL_padding = mod(length(Non_data_str) , 4);

NUL_padding,

for idx = 1:NUL_padding
    fprintf(fileID,'\0');
end

% write the data into the new file
fwrite(fileID, data(:), 'float32', 'l');

% close the file 
fclose(fileID);