clc;
clear;
file_name=uigetfile({'*.bmp;*.jpg;*.png;*.tiff;';'*.*'},'Select an Image File');
fileinfo = dir(file_name);
SIZE = fileinfo.bytes;
Size = SIZE/1024;
disp('input image bytes');
disp(Size);
X=imread(file_name);

[cratio,bpp] = wcompress('c',X,'wpeppers.wtc','spiht','maxloop',12);

disp('compression ratio');
disp(cratio);

disp('bits per pixels');
disp(bpp);

Xc = wcompress('u','wpeppers.wtc');
imwrite(Xc,'comperssed.jpg');

file_name='comperssed.jpg';
fileinfo = dir(file_name);
SIZE = fileinfo.bytes;
cSize = SIZE/1024;
disp('compressed image bytes');
disp(cSize);
delete('wpeppers.wtc');
subplot(1,2,1);
image(X);
title('Original image');
axis square;
subplot(1,2,2);
image(Xc);
title('Compressed image');
axis square;



D = abs(double(X)-double(Xc)).^2;
mse  = sum(D(:))/numel(X);
disp('mean square error is');
disp(mse);
psnr = 10*log10(255*255/mse);
disp('peak signal to noise ratio is');
disp(psnr);
