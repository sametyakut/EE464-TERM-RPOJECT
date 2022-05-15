%% input min, load min
D=0.3846;
iout = 0.3;
fs = 100e3;
Vo = 15;
Ccrit = iout*D/(fs*Vo*0.03);
%2.564uF
%% input min, load max
D=0.3846;
iout = 3;
Ccrit = iout*D/(fs*Vo*0.03);
%25.64uF

%% input max, load min
D=0.2381;
iout = 0.3;
Ccrit = iout*D/(fs*Vo*0.03);
%1.59uF
%% input max, load max
D=0.2381;
iout = 3;
Ccrit = iout*D/(fs*Vo*0.03);
%15.87uF