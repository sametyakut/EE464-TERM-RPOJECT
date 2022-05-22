% Analytic Model of the Flyback Converter and Magnetic Design
clear all
close all
clc

Vin = 24; % or 48 V
Vout = 15; % V, fixed
Pout = 45; % W, fixed
n = 1; % N1:N2, for operating only as a buck converter
fs = 50e3; % switching frequency
Perm = 2500; % relative permittivity, same order with the excel sheet on github
Le = 97e-3; % m
Ae = 233e-6; % m^2, crossection of the core
mu0 = 4*pi*10^-7; % permittivity of the air
B = 0.18; % Tesla
J=4e6; % A/m^2

Iout = Pout/Vout;
Iin = Pout/Vin;
D = Vout/(Vout+n*Vin); % Duty cycle





%Ilm_avg = n^-1*(1-D)^-1*Iout;
Ilm_avg = Iin/D;

% For CCM, DeltaIL/2<Ilm,avg
Lm_min = Vin*D*fs^-1/(2*Ilm_avg);
%Lm = Lm_min*1.5;
Lm = 60e-6;
DeltaIL = Vin*D*fs^-1/Lm; % Magnetizing Inductance Current Ripple
Imax = Ilm_avg+DeltaIL;
Imin = Ilm_avg-DeltaIL/2;

Ipri_rms = Imax*sqrt(D);
Isec_rms = Imax*sqrt(1-D);
CopperCross = pi*(0.5*0.425e-3)^2;% available in the laboratory, m^2
Pri_par = ceil((Ipri_rms/J)/CopperCross);
Sec_par = ceil((Isec_rms/J)/CopperCross);

Npri = ceil(Lm*Imax/(B*Ae));
R = Npri^2/Lm;
g = 0.5*mu0*Ae*(R-Le/(mu0*Perm*Ae)); % m
g_mm = 1e3*g; %mm

% Double check
B_min = Npri*Imin/(R*Ae);
B_max = Npri*Imax/(R*Ae);
DeltaB = B_max-B_min;
Aw = 8.65e-3*14.8e-3*4;
kf = 22*CopperCross*Npri/Aw;
%%
% Analytic Model of the Flyback Converter and Magnetic Design
clear all
close all
clc

Vin = 48; % or 48 V
Vout = 15; % V, fixed
Pout = 45; % W, fixed
n = 1; % N1:N2, for operating only as a buck converter
fs = 50e3; % switching frequency
Perm = 2500; % relative permittivity, same order with the excel sheet on github
Le = 97e-3; % m
Ae = 233e-6; % m^2, crossection of the core
mu0 = 4*pi*10^-7; % permittivity of the air
B = 0.15; % Tesla
J = 4e6; % A/m^2

Iout = Pout/Vout;
Iin = Pout/Vin;
D = Vout/(Vout+n*Vin); % Duty cycle





%Ilm_avg = n^-1*(1-D)^-1*Iout;
Ilm_avg = Iin/D;

% For CCM, DeltaIL/2<Ilm,avg
Lm_min = Vin*D*fs^-1/(2*Ilm_avg);
%Lm = Lm_min*1.5;
Lm = 60e-6;
DeltaIL = Vin*D*fs^-1/Lm; % Magnetizing Inductance Current Ripple
Imax = Ilm_avg+DeltaIL/2;
Imin = Ilm_avg-DeltaIL/2;

Ipri_rms = Imax*sqrt(D);
Isec_rms = Imax*sqrt(1-D);
CopperCross = pi*(0.5*0.425e-3)^2;% available in the laboratory, m^2
Pri_par = ceil((Ipri_rms/J)/CopperCross);
Sec_par = ceil((Isec_rms/J)/CopperCross);

Npri = ceil(Lm*Imax/(B*Ae));
R = Npri^2/Lm;
g = 0.5*mu0*Ae*(R-Le/(mu0*Perm*Ae)); % m
g_mm = g*1e3; %mm

% Double check
B_min = Npri*Imin/(R*Ae);
B_max = Npri*Imax/(R*Ae);
DeltaB = B_max-B_min;
Aw = 8.65e-3*14.8e-3*4;
kf = 22*CopperCross*Npri/Aw;
