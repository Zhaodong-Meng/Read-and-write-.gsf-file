function [dataMatrix, info, params] = ReadGsfFile(filePath)
% Example: 
% filePath = WORK_PATH;
% [tmp_data,info,params] = ReadGsfFile(filePath); 
% pcolor(data), shading interp
% colorbar


% Open the *.gsf file
    fileId = fopen(filePath, 'r');
    if fileId == -1
        error('Cannot open file: %s', filename);
    end

    % parameters struct
    params = {};
    
    comment_line = 17; %  Do not change this number!
    f_line=0; % reading line
    info = struct();
    
    % read the file line by line
    while ~feof(fileId)
        f_line = f_line+1;
        
        if f_line<=comment_line
            line = fgets(fileId);
            params{end+1, 1} = line;

        elseif f_line>comment_line
            strlen = 0;
            for idx = 1 : length(params)
                
                strlen = strlen + length(params{idx});
                
                info = AcqParamInfo(params{idx}, info);
                                    
            end
            info.x_res = info.x_scale/info.x_pix;
            info.y_res = info.y_scale/info.y_pix;
            
            frewind(fileId); % rewind back to the first line
            
            fread(fileId,ceil(strlen/4)*4, '*char',0,'l'); %read nul_padding and '\0' char
            
            dataMatrix = fread(fileId,Inf, 'float32',0,'l');
            
            dataMatrix = reshape(dataMatrix, [info.x_pix, info.y_pix]);
            return

        end

    end

    % close file
    fclose(fileId);

end