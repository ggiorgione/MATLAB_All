function myImg = changeColor(myImg,from1,from2,from3,to1,to2,to3,AP,AW)

RChannel = myImg(:,:,1); GChannel = myImg(:,:,2); BChannel = myImg(:,:,3);


blkPxls1 = RChannel > from1-AP & GChannel  > from2-AP & BChannel  > from3-AP; 
blkPxls2 = RChannel < from1+AW & GChannel  < from2+AW & BChannel  < from3+AW;
blkPxls  = blkPxls1 & blkPxls2;
RChannel(blkPxls) = to1; GChannel(blkPxls) = to2; BChannel(blkPxls) = to3;
myImg = cat(3, RChannel, GChannel, BChannel);

end

