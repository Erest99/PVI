clear all;
close all;
echo off;
clc;
dbstop if error;



v = VideoReader('cv02_hrnecek.mp4');
videoIM = read(v,1);
id = 1;
im = imread("cv02_vzor_hrnecek.bmp");
im2 = rgb2gray(im);
vel = size(im);
vyska = vel(1);
sirka = vel(2);
im = rgb2hsv(im);
h = im(:,:,1);
hist = double(imhist(h));
vals = hist/max(hist);



% while (1)
    videoIM = read(v, id);

	%kod
    res = zeros(480,640);
    videoIM2 = rgb2hsv(videoIM);
    h = videoIM2(:,:,1);
     for x = 1:640
        for y = 1:480
            [~, index] = min(abs(vals-h(y,x)));
           if  index==254
                res(y,x)=1;
           else
               res(y,x)=0;
           end
        end
     end

     

      
    tot_mass = sum(res(:));
    [jj,ii] = ndgrid(1:size(res,1),1:size(res,2));
    tx = sum(ii(:).*res(:))/tot_mass;
    ty = sum(jj(:).*res(:))/tot_mass;



 
     %zobrazeni
     imshow(videoIM);
     hold on;
     rectangle('position',[tx-sirka/2 ty-vyska/2 sirka vyska], 'LineWidth', 2, 'Edgecolor', 'g');
     hold off;
     pause(0.01);
     id = id+1;


    oldx = round(tx);
    oldy = round(ty);


 %end

 while (1)
    try
        videoIM = read(v, id);
    catch
        break;
    end
	%kod

    res = zeros(480,640);
    videoIM2 = rgb2hsv(videoIM);
    h = videoIM2(:,:,1);
     for x = round(oldx-sirka/2):round(oldx+sirka/2)
        for y = round(oldy-vyska/2):round(oldy+vyska/2)
            [~, index] = min(abs(vals-h(y,x)));
           if  index<256 && index>251
                res(y,x)=1;
           end
        end
     end

     

      
    tot_mass = sum(res(:));
    [jj,ii] = ndgrid(1:size(res,1),1:size(res,2));
    tx = sum(ii(:).*res(:))/tot_mass;
    ty = sum(jj(:).*res(:))/tot_mass;

 
     %zobrazeni
     imshow(videoIM);
     hold on;
     rectangle('position',[tx-sirka/2 ty-vyska/2 sirka vyska], 'LineWidth', 2, 'Edgecolor', 'g');
     hold off;
     pause(0.01);
     id = id+1;

    oldx = round(tx);
    oldy = round(ty);
end