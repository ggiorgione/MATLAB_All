function myImg = imageFilter(myImg,Span,RC,GC,BC)

RCh = myImg(:,:,1);
GCh = myImg(:,:,2);
BCh = myImg(:,:,3);
RCh = smoothGridFun(RCh,Span,'max',RC);
GCh = smoothGridFun(GCh,Span,'max',GC);
BCh = smoothGridFun(BCh,Span,'max',BC);
myImg = cat(3, RCh, GCh, BCh);

            
end

function grid = smoothGridFun(varargin)

WN = {'window','max'}; WM = {[5 5],50000};
s = inputMethods('adv',WN,WM,{'grid','window'},varargin);

grid = medfilt2(s.grid,s.window); 
grid(1:2,1) = s.max; grid(1,1:2) = s.max;
grid(1,(end-1):end) = s.max; grid(1:2,end) = s.max;
grid((end-1):end,1) = s.max; grid(end,(end-1):end) = s.max;
grid(end,1:2) = s.max; grid((end-1):end,end) = s.max;

end