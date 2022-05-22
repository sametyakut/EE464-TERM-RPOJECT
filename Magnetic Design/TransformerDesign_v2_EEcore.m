% Analytic Model of the Flyback Converter and Magnetic Design
clear all
close all
clc

Vin = 24; % or 48 V
Vout = 15; % V, fixed
Pout = 45; % W, fixed
n = 1; % N1:N2, for operating only as a buck converter
fs = 60e3; % switching frequency
Perm = 2500; % relative permittivity, same order with the excel sheet on github
Le = 97e-3; % m
Ae = 233e-6; % m^2, crossection of the core
mu0 = 4*pi*10^-7; % permittivity of the air
B = 0.1; % Tesla

Iout = Pout/Vout;
Iin = Pout/Vin;
D = Vout/(Vout+n*Vin); % Duty cycle





%Ilm_avg = n^-1*(1-D)^-1*Iout;
Ilm_avg = Iin/D;

% For CCM, DeltaIL/2<Ilm,avg
Lm_min = Vin*D*fs^-1/(2*Ilm_avg);
Lm = Lm_min*1.5;
DeltaIL = Vin*D*fs^-1/Lm; % Magnetizing Inductance Current Ripple
Imax = Ilm_avg+DeltaIL;

Ipri_rms = Imax*sqrt(D);
Isec_rms = Imax*sqrt(1-D);
CopperCross = pi*(0.5*0.425e-3)^2;% available in the laboratory, m^2


Npri = ceil(Lm*Imax/(B*Ae));
R = Npri^2/Lm;
g = 0.5*mu0*Ae*(R-Le/(mu0*Perm*Ae)); % m

%%
% Analytic Model of the Flyback Converter and Magnetic Design
clear all
close all
clc

Vin = 48; % or 48 V
Vout = 15; % V, fixed
Pout = 45; % W, fixed
n = 1; % N1:N2, for operating only as a buck converter
fs = 60e3; % switching frequency
Perm = 2500; % relative permittivity, same order with the excel sheet on github
Le = 97e-3; % m
Ae = 233e-6; % m^2, crossection of the core
mu0 = 4*pi*10^-7; % permittivity of the air
B = 0.1; % Tesla

Iout = Pout/Vout;
Iin = Pout/Vin;
D = Vout/(Vout+n*Vin); % Duty cycle





%Ilm_avg = n^-1*(1-D)^-1*Iout;
Ilm_avg = Iin/D;

% For CCM, DeltaIL/2<Ilm,avg
Lm_min = Vin*D*fs^-1/(2*Ilm_avg);
Lm = Lm_min*1.5;
DeltaIL = Vin*D*fs^-1/Lm; % Magnetizing Inductance Current Ripple
Imax = Ilm_avg+DeltaIL;

Ipri_rms = Imax*sqrt(D);
Isec_rms = Imax*sqrt(1-D);
CopperCross = pi*(0.5*0.425e-3)^2;% available in the laboratory, m^2


Npri = ceil(Lm*Imax/(B*Ae));
R = Npri^2/Lm;
g = 0.5*mu0*Ae*(R-Le/(mu0*Perm*Ae)); % m

%% COMMENTS
% If there is no mistake, the third core (00K6527E060) will be suitable
% for us to use without gap. Manually, I calculated iterations, and I saw
% that it suits for us. 

