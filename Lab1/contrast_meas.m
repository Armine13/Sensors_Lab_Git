clc; clear all;
%Ip = imread('./Pictures/reflect/0c_cr.jpg');
%Io = imread('./Pictures/reflect/90c_cr.jpg');
%Ip = rgb2gray(double(Ip));
%Io = rgb2gray(double(Io));
%Itotal = Ip + Io;
%Icontr = Ip - Io;
%Iratio = Icontr ./ Itotal;
%%figure(), imshow(Itotal);
%%figure(), imshow((Icontr));
%figure(), imshow((Iratio));
%colormap(gray);

Ip = imread('./Pictures/reflect/d90.jpg');
Io = imread('./Pictures/reflect/d0.jpg');
Ip = rgb2gray(double(Ip));
Io = rgb2gray(double(Io));
Itotal = Ip + Io;
Icontr = Ip - Io;
Iratio = Icontr ./ Itotal;
%figure(), imshow(Itotal);
%figure(), imshow((Icontr));
figure(), imshow((Iratio));
colormap(gray);
axis('equal')
print -djpg dratio.jpg