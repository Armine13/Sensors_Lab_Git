%% Wolff's method
 
im_0 = imread('/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/wolff/0.jpg');
im_45 = imread('/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/wolff/45.jpg');
im_90 = imread('/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/wolff/90.jpg');
im_no = imread('/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/wolff/no.jpg');

%%
%change pictures to gray
im_0 = rgb2gray(im_0);
im_45 = rgb2gray(im_45);
im_90 = rgb2gray(im_90);
im_no = rgb2gray(im_no);
 %change pictures to double type for the sake of calculation later
im_0 = im2double(im_0);
im_45 = im2double(im_45);
im_90 = im2double(im_90);
I = im_0 + im_90;
subplot(121); imshow(I); title('total light intensity');
subplot(122); imshow(im_no); title('without polarization');
 
%compute the phi pictures
% im_phi = (I - 2.* im_45)./(I - 2.*im_90); 
phi = atan2(I - 2.* im_45, I - 2.*im_90)*180/3.1415/2;
figure();
 % ?? it is weird here. two image's are similar.
%  subplot(121);imshow(im_phi);
%  subplot(122);imshow(phi);
imagesc(phi);% Angle of Polarization

%compute the degree of polarization
DOP = sqrt((I - 2.*im_45).^2 + (I - 2.*im_90).^2)./I;
figure();
imshow(DOP); title('Degree of Polarization');

imwrite(I,'/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/wolff/I.jpg');
imwrite(DOP,'/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/wolff/DOP.jpg'); 
%imwrite(phi,'/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/wolff/AOP.jpg');

%% 
height = size(im_0, 1);
width = size(im_0, 2);
Combine = zeros(height, width, 3);

Combine(:,:,1) = ((2 * phi) + 180) / 360;
Combine(:,:,2) = DOP;
Combine(:,:,3) = I;
RGB = hsv2rgb(Combine);
imshow(RGB);
imwrite(phi,'/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/wolff/HSV2RGB.jpg')


%% Least Mean Square method
%read the image first
N = 9;
folder = '/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/Least_Mean/';
for k = 1 : N
  % Get the base file name.
  baseFileName = sprintf('%d.jpg', (k - 1) * 20);
  % Combine it with the folder to get the full filename.
  fullFileName = fullfile(folder, baseFileName);
  % Read the image file into an array.
  im{k} = imread(fullFileName);
  im{k} = im2double(rgb2gray(im{k}));
end
%intitialization
height = size(im{1},1);
width = size(im{1},2);
A = zeros(N,3);
S0 = zeros(height, width);
S1 = zeros(height, width);
S2 = zeros(height, width);
Y = zeros(N,1);

%Calculate A
for k = 1 : N
    A(k,1) = 0.5;
    A(k,2) =  0.5 * cos(2 * (k - 1) * 20 * 3.1415 / 180);
    A(k,3) =  0.5 * sin(2 * (k - 1) * 20 * 3.1415 / 180);
end

% Least_A = inv(A' * A) * A';
Least_A = (A' * A)\A';
%%
%compute least mean square
for i = 1 : height
    for j = 1 : width
        for k = 1 : N
            Y(k,1) = im{k}(i,j);
        end
        X_tmp = Least_A*Y;
        S0(i,j) = X_tmp(1);
        S1(i,j) = X_tmp(2);
        S2(i,j) = X_tmp(3);
        
    end
end

%
imwrite(S0,'/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/Least_Mean/S0.jpg');
imwrite(S1,'/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/Least_Mean/S1.jpg')
imwrite(S2,'/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/Least_Mean/S2.jpg');

I_Least = S0;
DOP_Least = sqrt(S1.*S1 + S2.*S2) ./ S0;
Phi_Least = atan2(S2, S1)*180/3.1415/2;
imshow(DOP_Least);title('Degree of Polarization');
figure();
imagesc(Phi_Least);
imwrite(I_Least,'/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/Least_Mean/I_Least.jpg');
imwrite(DOP_Least,'/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/Least_Mean/DOP_Least.jpg')
%imwrite(Phi_Least,'/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/Least_Mean/Phi_Least.jpg');

%% H S V
Combine = zeros(height, width, 3);

Combine(:,:,1) = ((2 * Phi_Least) + 180) / 360;
Combine(:,:,2) = DOP_Least;
Combine(:,:,3) = I_Least;
RGB = hsv2rgb(Combine);
imshow(RGB);
imwrite(RGB,'/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/Least_Mean/HSV2RGB.jpg')

%% sinusoidal of different position
point_in_screen = [];
point_in_phone = [];
point_in_other = [];
for k = 1 : N
    point_in_screen = [point_in_screen,im{k}(200,100)];%point in the screen
    point_in_phone = [point_in_phone,im{k}(502,151)];%point in the phone
    point_in_other = [point_in_other,im{k}(300,300)];%point in other place
end
plot(point_in_screen,'r');
hold on;
plot(point_in_phone, 'g');
plot(point_in_other, 'b');
legend('computer screen','phone', 'unpolarized place')

hold off;

print('/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/Least_Mean/sin', '-djpeg');

%% sinusoidal of s0, s1, s2
point_in_s0 = [];
point_in_s1 = [];
point_in_s2 = [];
for k = 1 : N
    point_in_s0 = [point_in_s0,im{k}(200,100)];%point in the screen
    point_in_s1 = [point_in_s1,im{k}(500,150)];%point in the phone
    point_in_s2 = [point_in_s2,im{k}(300,300)];%point in other place
end