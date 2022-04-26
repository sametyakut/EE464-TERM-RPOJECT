% Analytic Model of the Flyback Converter and Magnetic Design (with
% Toroids)
clear all
close all
clc

Vin = 24; % or 48 V
Vout = 15; % V, fixed
Pout = 45; % W, fixed
n = 1; % N1:N2, for operating only as a buck converter
fs = 60e3; % switching frequency
Perm = [160 90 26 125 60 60 60 81 59 75]; % relative permittivity, same order with the excel sheet on github
AL = 1e-9*[201 202 33 90 135 75 138 81 59 75]; % H/turn^2, same order with the excel sheet on github
Aw = 1e-6*[156 427 948 139 427 156 514 427 427 156]; % m^2
Le = 1e-3*[63.5 107 143 56.7 107 63.5 125 98.4 107 63.5]; % m
Ae = 1e-6*[65.4 199 144 31.7 199 65.4 229 107 199 64.5]; % m^2, crossection of the core
mu0 = 4*pi*10^-7; % permittivity of the air

Iout = Pout/Vout;
Iin = Pout/Vin;
D = Vout/(Vout+n*Vin); % Duty cycle
% For CCM, DeltaIL<Iin
Lm_min = Vin*D*fs^-1/Iin;
Lm = Lm_min*10; % can be changed to adjust current ripple
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
Perm = [160 90 26 125 60 60 60 81 59 75]; % relative permittivity, same order with the excel sheet on github
AL = 1e-9*[201 202 33 90 135 75 138 81 59 75]; % H/turn^2, same order with the excel sheet on github
Aw = 1e-6*[156 427 948 139 427 156 514 427 427 156]; % m^2
Le = 1e-3*[63.5 107 143 56.7 107 63.5 125 98.4 107 63.5]; % m
Ae = 1e-6*[65.4 199 144 31.7 199 65.4 229 107 199 64.5]; % m^2, crossection of the core
mu0 = 4*pi*10^-7; % permittivity of the air


Iout = Pout/Vout;
Iin = Pout/Vin;
D = Vout/(Vout+n*Vin); % Duty cycle
% For CCM, DeltaIL<Iin
Lm_min = Vin*D*fs^-1/Iin;
Lm = Lm_min*10; % can be changed to adjust current ripple
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
% If there is no mistake, the second core (0077442A7) will be suitable
% for us to use. Manually, I calculated iterations, and I saw
% that it suits for us.
% Note that turns ratio is selected as 1 in order to operate as a buck
% converter all the time, which will ease the control.
%% ORDER OF TOROIDS' DATA IN THE ARRAY
% C055928A2
% 0077442A7
% 0077111A7
% 0077310A7
% 0077439A7
% 0079894A7
% 0079192A7
% 0079083A7
% 0079440A7
% 0088894A7


