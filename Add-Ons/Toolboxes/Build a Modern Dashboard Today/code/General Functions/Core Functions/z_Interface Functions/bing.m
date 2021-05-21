function txt = bing(q)

q(q == ' ') = '+';
if isempty(q),q = 'hype';end

url=['https://www.bing.com/search?q=' q ]; 
txt = urlread(url);
txt = strsplit(txt,'<h2><a href='); txt(1) = [];
for i = 1:length(txt)
    temp = strsplit(txt{i},'" h="ID=SERP');
    txt{i} = temp{1};
end


end

