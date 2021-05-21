function output = google(q)
% google questions obtain answers and links
% From: Alex Geiger
% Email: ajg1444@rit.edu
% 
% Input search query
% Output: Structure
% answer - google has found an answer it will most likely apear hear
% links  - the links and info google has returned


if isempty(q) % make sure user is searching for something
    error('Must specify search keyword argument')
end


q(q == ' ') = '+'; % switchout spaces for + (HTML FORMATING)
html_txt = urlread(['https://www.google.com/search?q=',q]);


try % try to obtain info
    output.answer = getInfo(html_txt);
catch
    output.answer = [];
end

urls = regexp(html_txt,'<a href=".*?q=(http://.*?)&amp.*?>(.*?)</a>.*?<cite>(.*?)</cite>.*?<span class="st">(.*?)</span>','tokens')';

% obtain links and structured data:
output.links = getlink(urls);


end

% Obtain Answer:
function data = getInfo(txt)

Info = strsplit(txt,'<br>'); Info = Info{1};
Info = strsplit(Info,'class="_sPg">'); Info = Info{2};
Info = strsplit(Info,'<b>');


p1 = Info{1}; p2 = Info{2};
Answer = strsplit(p2,'</b>'); p2 = Answer{2}; Answer = Answer{1};

p1(p1 == ',' | p1 == '.' | p1 == ';') = [];
p2(p2 == ',' | p2 == '.' | p2 == ';') = [];

p1 = strsplit(p1,' '); p2 = strsplit(p2,' ');

if strcmpi(p1{end},''), p1(end) = []; end
if strcmpi(p2{1},''), p2(1) = []; end



if strcmpi(p1{end},{'was'})
    if strcmpi(p2{1},{'in'}) && length(p2{2}) == 4
        data.date = str2double(p2{2});
    end, p1(end) = []; data.description = strjoin(p1);
    
elseif strcmpi(p1{1},{'in'})
    if strcmpi(p1{2},{'the'})
        if isnan(str2double(p1{3})) == 0, data.date = str2double(p1{3});
        end, else
        if isnan(str2double(p1{2})) == 0
            data.date = str2double(p1{2});
        end
    end, else, data.description = strjoin(p1);
end

if ismember('$',Answer)
    data.type = 'USD'; data.answer = str2double(Answer(Answer ~='$'));
elseif ismember('%',Answer)
    data.type = 'percent'; data.answer = str2double(Answer(Answer ~='%'));
elseif isnan(str2double(Answer)) == 0
    data.type = 'double'; data.answer = str2double(Answer); else
    data.type = 'string'; data.answer = Answer;
end

end

% Obtain Links:
function data = getlink(urls)

data = cell(numel(urls),1);

for k=1:numel(urls), url=urls{k};
    
    s.link = url{1};
    s.string = regexprep(url{2},'</?br?>',''); s1 = [s.string,'</a>'];
    s.cite = regexprep(url{3},'</?br?>','');
    s.description=regexprep(url{4},'</?br?>','');
    s.view = ['<a href="matlab:web(''',url{1},''',''-browser'')">',s1];
    data{k} = s;

end

end


