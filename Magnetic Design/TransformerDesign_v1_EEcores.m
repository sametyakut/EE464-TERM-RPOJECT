% Analytic Model of the Flyback Converter and Magnetic Design
clear all
close all
clc

Vin = 24; % or 48 V
Vout = 15; % V, fixed
Pout = 45; % W, fixed
n = 1; % N1:N2, for operating only as a buck converter
fs = 60e3; % switching frequency
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
Imax = Iin+DeltaIL;
CopperCross = 1e-6*Imax/4;% since J = 4 A/mm^2, m^2:
CopperRadius = sqrt(Imax/(4*pi)); % wire selection


for i = 1:length(Perm)
    Npri(i) = sqrt(Lm/(AL(i)));
    Acu(i) = 2*Npri(i)*CopperCross; % Total copper area
    kf(i) = Acu(i)/Aw(i); % fill factor
    reluc(i) = Le(i)/(mu0*Perm(i)*Ae(i)); % reluctance of the core without gap
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
fs = 60e3; % switching frequency
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
Imax = Iin+DeltaIL;
CopperRadius = 0.5e-3; % insert the value found in previous part for convenience!!!!!!!!!!!
CopperCross = CopperRadius^2*pi;% since J = 4 A/mm^2, m^2:



for i = 1:length(Perm)
    Npri(i) = sqrt(Lm/(AL(i)));
    Acu(i) = 2*Npri(i)*CopperCross; % Total copper area
    kf(i) = Acu(i)/Aw(i); % fill factor
    reluc(i) = Le(i)/(mu0*Perm(i)*Ae(i)); % reluctance of the core without gap
    phi(i) = Npri(i)*Imax/reluc(i); % maximum flux in the core
    B(i) = phi(i)/Ae(i); % maximum flux density
end

%% COMMENTS
% If there is no mistake, the third core (00K6527E060) will be suitable
% for us to use without gap. Manually, I calculated iterations, and I saw
% that it suits for us. 

