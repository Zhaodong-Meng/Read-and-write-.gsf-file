function info = AcqParamInfo(line_str, info)
%AcqParamInfo: acquire the information of comment line in gsf file
%   此处显示详细说明
    
        if contains(line_str, 'XReal')
            line_data = regexp(line_str, '=', 'split');
            info.x_scale = str2double(char(line_data{end}));
        elseif contains(line_str, 'YReal')
            line_data = regexp(line_str, '=', 'split');
            info.y_scale = str2double(char(line_data{end}));
        end
        
        
        % pixels in x and y
        if contains(line_str, 'XRes')
            line_data = regexp(line_str, '=', 'split');
            info.x_pix = str2double(char(line_data{end}));
        elseif contains(line_str, 'YRes')
            line_data = regexp(line_str, '=', 'split');
            info.y_pix = str2double(char(line_data{end}));

        end
        
        % X,Y offset
        if contains(line_str, 'XOffset')
            line_data = regexp(line_str, '=', 'split');
            info.x_offset = str2double(char(line_data{end}));
        elseif contains(line_str, 'YOffset')
            line_data = regexp(line_str, '=', 'split');
            info.y_offset = str2double(char(line_data{end}));
        end
        
        
        % unit of data
        if contains(line_str, 'XYUnit')
            line_data = regexp(line_str, '=', 'split');
            info.xy_unit = char(line_data{end}(1));
        elseif contains(line_str, 'ZUnit')
            line_data = regexp(line_str, '=', 'split');
            info.z_unit = char(line_data{end}(1));
        end
end

