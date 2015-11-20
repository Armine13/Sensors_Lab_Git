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
I = im_0 + im_90;
subplot(121); imshow(I); title('total light intensity');
subplot(122); imshow(im_no); title('without polarization');
 
%compute the phi pictures
im_phi = (I - 2.* im_45)./(I - 2.*im_90); 
phi = atan(im_phi)*180/3.1415/2;
figure();
 % ?? it is weird here. two image's are similar.
%  subplot(121);imshow(im_phi);
%  subplot(122);imshow(phi);
imshow(phi)

%compute the degree of polarization
DOP = sqrt((I - 2.*im_45).^2 + (I - 2.*im_90).^2)./I;
figure();
imshow(DOP); title('Degree of Polarization');

imwrite(I,'/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/wolff/I.jpg');
imwrite(DOP,'/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/wolff/DOP.jpg'); 
imwrite(phi,'/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/wolff/AOP.jpg');
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
Phi_Least = atan(S2./S1)*180/3.1415/2;
imshow(Phi_Least);title('Degree of Polarization');
figure();
imshow(Phi_Least);title('Angle of Polarization');
imwrite(I_Least,'/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/Least_Mean/I_Least.jpg');
imwrite(DOP_Least,'/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/Least_Mean/DOP_Least.jpg')
imwrite(Phi_Least,'/Users/Songyou/Documents/VIBOT/UB/Sensors and Digitization/Sensors_Lab_Git/Lab1/Pictures/Least_Mean/Phi_Least.jpg');

%%
Combine = zeros(height, width, 3);
Combine(:,:,1) = I_Least;
Combine(:,:,2) = DOP_Least;
Combine(:,:,3) = Phi_Least;
imshow(Combine)

%% sinusoidal
b = [im{1}(20,20)];
for k = 2 : N
    b = [b,im{k}(20,20)];
end
plot(b,'r');

