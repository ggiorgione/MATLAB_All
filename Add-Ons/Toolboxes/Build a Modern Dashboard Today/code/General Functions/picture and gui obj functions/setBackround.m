function handles = setBackround(handles,PicName)

hdl.Axes = axes('Position',[0 0 1 1],'Units','normalized');
myImg = imread(PicName);
myImg(1:1000,:,:) = [];
hdl.Axes.Units='pixels';
myImg=imresize(myImg,fliplr(hdl.Axes.Position(1,3:4)));
hdl.Axes.Units='normalized';
hdl.pic = imshow(myImg,'Border','tight');
handles.backround = hdl;


end

