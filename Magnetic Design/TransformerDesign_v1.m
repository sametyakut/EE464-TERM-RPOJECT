% Analytic Model of the Flyback Converter
clear all
close all
clc

Vin = 24; % or 48 V
Vout = 15; % V, fixed
Pout = 45; % W, fixed
n = 1; % N1:N2
fs = 60e3; % switching frequency
CopperCross = 1e-6*0.205;% m^2:
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
Lm = Lm_min*10;
DeltaIL = Vin*D*fs^-1/Lm; % Magnetizing Inductance Current Ripple
Imax = Iin+DeltaIL;


for i = 1:length(Perm)
    Npri(i) = sqrt(Lm/(AL(i)));
    Acu(i) = 3*Npri(i)*CopperCross; % Total copper area
    kf(i) = Acu(i)/Aw(i); % fill factor
    reluc(i) = Le(i)/(mu0*Perm(i)*Ae(i)); % reluctance of the core without gap
    phi(i) = Npri(i)*Imax/reluc(i); % maximum flux in the core
    B(i) = phi(i)/Ae(i); % maximum flux density
end

