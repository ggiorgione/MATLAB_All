%Import all the Person IDs from the Berlin Population

X=[];                                                  %creates an empty matrix
fid = fopen('/Users/giulio.giorgione/Documents/MATLAB/Input Generator/planstest.txt');    
tline = fgetl(fid);                                      %Read line from file specified in "fid", removing newline characters
while ischar(tline)                                      %while the line is a character do...
    if (startsWith(tline,'<activity'))                 %take every line starting with '...' 
        splittedLine=strsplit(tline,'"');                %split line with that character
        X=[X; splittedLine(6)];                     %which cell of the splittedLine to take
    end
    tline = fgetl(fid);
end
fclose(fid);

% Y=[];                                             %creates an empty matrix
% fid = fopen('/Users/giulio.giorgione/Documents/MATLAB/Input Generator/test_plans.txt');    
% tline = fgets(fid);                                      %Read line from file specified in "fid", removing newline characters
% while ischar(tline)                                      %while the line is a character do...
%     if (startsWith(tline,'<activity'))                 %take every line starting with '...' 
%         splittedLine=strsplit(tline,'"');                %split line with that character
%         Y=[Y; splittedLine(8)];            %which cell of the splittedLine to take
%     end
%     tline = fgets(fid);
% end
% fclose(fid);
% 
% XY=[];
% XY = [X Y];
% unique_XY = unique(XY,'stable');
% dim = [size(unique_XY)/2,2];
% dim = [dim(:,1) dim(:,3)];
% XY = reshape(unique_XY,dim);