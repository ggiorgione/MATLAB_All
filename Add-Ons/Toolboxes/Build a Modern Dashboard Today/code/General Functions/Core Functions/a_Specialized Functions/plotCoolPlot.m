function handles = plotCoolPlot(handles,xx,yy)

s.x = xx;
s.y = yy;
handles.plot1 = UIGrapher(s);
           
datetick('x','mmm')
axis tight

end

