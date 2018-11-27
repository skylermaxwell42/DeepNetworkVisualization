function [RW,GW,BW,colormap_red,colormap_green,colormap_blue] = get_color_map(filt)
RW=(filt(:,:,1));
GW=(filt(:,:,2));
BW=(filt(:,:,3));

stepsize=10;

min_val_red=min(min(RW));
max_val_red=max(max(RW));
 
min_val_green=min(min(GW));
max_val_green=max(max(GW));
 
min_val_blue=min(min(BW));
max_val_blue=max(max(BW));

minval=[min_val_red,min_val_green,min_val_blue];
maxval=[max_val_red,max_val_green,max_val_blue];

minimum=min(minval);
maximum=max(maxval);

Steps=(abs(minimum)+abs(maximum))/stepsize;
COL=1;
ROW=1;
i=1;

while(ROW<=11)
   while(COL<=11)
        if (minimum<=RW(ROW,COL) && RW(ROW,COL)<minimum+Steps)
            colormap_red(ROW,COL)=0.1;
        end
        if (minimum+Steps<RW(ROW,COL) && RW(ROW,COL)<=minimum+Steps*2)
            colormap_red(ROW,COL)=0.2;
        end
        if (minimum+Steps*2<RW(ROW,COL) && RW(ROW,COL)<=minimum+Steps*3)
            colormap_red(ROW,COL)=0.3;
        end
        if (minimum+Steps*3<RW(ROW,COL) && RW(ROW,COL)<=minimum+Steps*4)
            colormap_red(ROW,COL)=0.4;
        end
        if (minimum+Steps*4<RW(ROW,COL) && RW(ROW,COL)<=minimum+Steps*5)
            colormap_red(ROW,COL)=0.5;
        end
        if (minimum+Steps*5<RW(ROW,COL) && RW(ROW,COL)<=minimum+Steps*6)
            colormap_red(ROW,COL)=0.6;
        end
        if (minimum+Steps*6<RW(ROW,COL) && RW(ROW,COL)<=minimum+Steps*7)
            colormap_red(ROW,COL)=0.7;
        end
        if (minimum+Steps*7<RW(ROW,COL) && RW(ROW,COL)<=minimum+Steps*8)
            colormap_red(ROW,COL)=0.8;
        end
        if (minimum+Steps*8<RW(ROW,COL) && RW(ROW,COL)<=minimum+Steps*9)
            colormap_red(ROW,COL)=0.9;
        end
        if (minimum+Steps*9<RW(ROW,COL) && RW(ROW,COL)<=maximum)
            colormap_red(ROW,COL)=1;
        end
        COL=COL+1;
        i=i+1;
    end
    ROW=ROW+1;
    COL=1;
end
colormap_red(:,:,1) = [colormap_red];
colormap_red(:,:,2) = [zeros(11)];
colormap_red(:,:,3) = [zeros(11)];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%finding green color mapping
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
COL=1;
ROW=1;
i=1;
while(ROW<=11)
   while(COL<=11)
        if (minimum<=GW(ROW,COL) && GW(ROW,COL)<minimum+Steps)
            colormap_green(ROW,COL)=0.1;
        end
        if (minimum+Steps<GW(ROW,COL) && GW(ROW,COL)<=minimum+Steps*2)
            colormap_green(ROW,COL)=0.2;
        end
        if (minimum+Steps*2<GW(ROW,COL) && GW(ROW,COL)<=minimum+Steps*3)
            colormap_green(ROW,COL)=0.3;
        end
        if (minimum+Steps*3<GW(ROW,COL) && GW(ROW,COL)<=minimum+Steps*4)
            colormap_green(ROW,COL)=0.4;
        end
        if (minimum+Steps*4<GW(ROW,COL) && GW(ROW,COL)<=minimum+Steps*5)
            colormap_green(ROW,COL)=0.5;
        end
        if (minimum+Steps*5<GW(ROW,COL) && GW(ROW,COL)<=minimum+Steps*6)
            colormap_green(ROW,COL)=0.6;
        end
        if (minimum+Steps*6<GW(ROW,COL) && GW(ROW,COL)<=minimum+Steps*7)
            colormap_green(ROW,COL)=0.7;
        end
        if (minimum+Steps*7<GW(ROW,COL) && GW(ROW,COL)<=minimum+Steps*8)
            colormap_green(ROW,COL)=0.8;
        end
        if (minimum+Steps*8<GW(ROW,COL) && GW(ROW,COL)<=minimum+Steps*9)
            colormap_green(ROW,COL)=0.9;
        end
        if (minimum+Steps*9<GW(ROW,COL) && GW(ROW,COL)<=maximum)
            colormap_green(ROW,COL)=1;
        end
        COL=COL+1;
        i=i+1;
    end
    ROW=ROW+1;
    COL=1;
end
colormap_green(:,:,2) = [colormap_green];
colormap_green(:,:,1) = [zeros(11)];
colormap_green(:,:,3) = [zeros(11)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%finding blue color mapping
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
COL=1;
ROW=1;
i=1;
while(COL<=11)
   while(ROW<=11)
        if (minimum<=BW(ROW,COL) && BW(ROW,COL)<minimum+Steps)
            colormap_blue(ROW,COL)=0.1;
        end
        if (minimum+Steps<BW(ROW,COL) && BW(ROW,COL)<=minimum+Steps*2)
            colormap_blue(ROW,COL)=0.2;
        end
        if (minimum+Steps*2<BW(ROW,COL) && BW(ROW,COL)<=minimum+Steps*3)
            colormap_blue(ROW,COL)=0.3;
        end
        if (minimum+Steps*3<BW(ROW,COL) && BW(ROW,COL)<=minimum+Steps*4)
            colormap_blue(ROW,COL)=0.4;
        end
        if (minimum+Steps*4<BW(ROW,COL) && BW(ROW,COL)<=minimum+Steps*5)
            colormap_blue(ROW,COL)=0.5;
        end
        if (minimum+Steps*5<BW(ROW,COL) && BW(ROW,COL)<=minimum+Steps*6)
            colormap_blue(ROW,COL)=0.6;
        end
        if (minimum+Steps*6<BW(ROW,COL) && BW(ROW,COL)<=minimum+Steps*7)
            colormap_blue(ROW,COL)=0.7;
        end
        if (minimum+Steps*7<BW(ROW,COL) && BW(ROW,COL)<=minimum+Steps*8)
            colormap_blue(ROW,COL)=0.8;
        end
        if (minimum+Steps*8<BW(ROW,COL) && BW(ROW,COL)<=minimum+Steps*9)
            colormap_blue(ROW,COL)=0.9;
        end
        if (minimum+Steps*9<BW(ROW,COL) && BW(ROW,COL)<=maximum)
            colormap_blue(ROW,COL)=1;
        end
        ROW=ROW+1;
        i=i+1;
    end
    COL=COL+1;
    ROW=1;
end
colormap_blue(:,:,3) = [colormap_blue];
colormap_blue(:,:,1) = [zeros(11)];
colormap_blue(:,:,2) = [zeros(11)];
end