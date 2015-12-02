data = csvread('calibdata.dat');
dl = data(:,1);
temps = data(:,2);
plot(temps, dl);
hold on;
plot(temps, dl, '*');
grid on;
title('Digital Level Vs. Actual Temperature');
xlabel('T');
ylabel('DL');
%print -djpg 'calibplot.jpg'