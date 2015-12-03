L = [2.42 1.88 2.40 1.5 1.61 1.36 3.1]';
L0 = 3.1;
%e1 = L1 / Lb
e0 = 0.95;
%e0 = L0 / Lb

%e1 / e0 = L1 / L0

e = e0 * L ./ L0;
Radiance = L;
Emissivity = e;
materials = {'Polish steel'; 'Stainless steel'; 'Laminate';
 'Red copper'; 'Brass'; 'Aluminium';'Black plate'};
T = table(Radiance, Emissivity,'RowNames',materials)
