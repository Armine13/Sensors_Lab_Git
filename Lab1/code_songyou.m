 %% Wolff's method
 
 im_0 = imread('/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/wolff/0.jpg');
 im_45 = imread('/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/wolff/45.jpg');
 im_90 = imread('/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/wolff/90.jpg');
 im_no = imread('/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/wolff/no.jpg');
 %change pictures to gray
 im_0 = rgb2gray(im_0);
 im_45 = rgb2gray(im_45);
 im_90 = rgb2gray(im_90);
 im_no = rgb2gray(im_no);
 %change pictures to double type for the sake of calculation later
 im_0 = im2double(im_0);
 im_45 = im2double(im_45);
 im_90 = im2double(im_90);
 im_total = im_0 + im_90;
 subplot(121); imshow(im_total); title('total light intensity');
 subplot(122); imshow(im_no); title('without polarization');
 
 %compute the phi pictures
 im_phi = (im_total - 2.* im_45)./(im_total - 2.*im_90); 
 phi = atan(im_phi);
 figure();
 % ?? it is weird here. two image's are similar.
 subplot(121);imshow(im_phi);
 subplot(122);imshow(phi);
 
 %compute the degree of polarization
 dop = sqrt((im_total - 2.*im_45).^2 + (im_total - 2.*im_90).^2)./im_total;
 figure();
 imshow(dop)