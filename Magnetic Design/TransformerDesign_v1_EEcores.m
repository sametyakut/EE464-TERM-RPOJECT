% Analytic Model of the Flyback Converter and Magnetic Design
clear all
close all
clc

Vin = 24; % or 48 V
Vout = 15; % V, fixed
Pout = 45; % W, fixed
n = 1; % N1:N2, for operating only as a buck converter
fs = 100e3; % switching frequency
Perm = [90 90 60 26 60]; % relative permittivity, same order with the excel sheet on github
AL = 1e-9*[281 146 300 137 235]; % H/turn^2, same order with the excel sheet on github
Aw = 1e-6*[276 151 537 2762 600]; % m^2
Le = 1e-3*[98.4 69.4 147 208 137]; % m
Ae = 1e-6*[237 84 540 584 368]; % m^2, crossection of the core
mu0 = 4*pi*10^-7; % permittivity of the air

Iout = Pout/Vout;
Iin = Pout/Vin;
D = Vout/(Vout+n*Vin); % Duty cycle
% For CCM, DeltaIL<Iin
Lm_min = Vin*D*fs^-1/Iin;
Lm = Lm_min*1.5;
DeltaIL = Vin*D*fs^-1/Lm; % Magnetizing Inductance Current Ripple



%Ilm_avg = n^-1*(1-D)^-1*Iout;
Ilm_avg = Iin/D;
Imax = Ilm_avg+DeltaIL;
Ipri_rms = Imax*sqrt(D);
Isec_rms = Imax*sqrt(1-D);
CopperCross = pi*(0.5*0.425e-3)^2;% available in the laboratory, m^2


for i = 1:length(Perm)
    Npri(i) = sqrt(Lm/(AL(i)));
    Npri(i) = ceil(Npri(i));
    Acu(i) = 2*Npri(i)*CopperCross; % Total copper area
    kf(i) = Acu(i)/Aw(i); % fill factor
    reluc(i) = Le(i)/(mu0*Perm(i)*Ae(i)); % reluctanof the core without gap
    phi(i) = Npri(i)*Imax/reluc(i); % maximum flux in the core
    B(i) = phi(i)/Ae(i); % maximum flux density
end

%%
% Analytic Model of the Flyback Converter and Magnetic Design
clear all
close all
clc

Vin = 48; % or 48 V
Vout = 15; % V, fixed
Pout = 45; % W, fixed
n = 1; % N1:N2, for operating only as a buck converter
fs = 100e3; % switching frequency
Perm = [90 90 60 26 60 3000]; % relative permittivity, same order with the excel sheet on github
AL = 1e-9*[281 146 300 137 235 1900]; % H/turn^2, same order with the excel sheet on github
Aw = 1e-6*[276 151 537 2762 600 238.62]; % m^2
Le = 1e-3*[98.4 69.4 147 208 137 67]; % m
Ae = 1e-6*[237 84 540 584 368 60]; % m^2, crossection of the core
mu0 = 4*pi*10^-7; % permittivity of the air

Iout = Pout/Vout;
Iin = Pout/Vin;
D = Vout/(Vout+n*Vin); % Duty cycle
% For CCM, DeltaIL<Iin
Ilm_avg = Iin/D;

Lm_min = Vin*D*fs^-1/(Iin/D);
Lm = Lm_min*1.5;
DeltaIL = Vin*D*fs^-1/Lm; % Magnetizing Inductance Current Ripple
Imax = Ilm_avg+DeltaIL;
Ipri_rms = Imax*sqrt(D);
Isec_rms = Imax*sqrt(1-D);
CopperCross = pi*(0.425e-3/2)^2;% available in the laboratory, m^2:



for i = 1:length(Perm)
    Npri(i) = sqrt(Lm/(AL(i)));
    Npri(i) = ceil(Npri(i));
    Acu(i) = 15*Npri(i)*CopperCross; % Total copper area
    kf(i) = Acu(i)/Aw(i); % fill factor
    reluc(i) = Le(i)/(mu0*Perm(i)*Ae(i)); % reluctance of the core without gap
    phi(i) = Npri(i)*Imax/reluc(i); % maximum flux in the core
    B(i) = phi(i)/Ae(i); % maximum flux density
end

%% COMMENTS
% If there is no mistake, the third core (00K6527E060) will be suitable
% for us to use without gap. Manually, I calculated iterations, and I saw
% that it suits for us. 

