%cd C:\Users\ajaimes\Documents\TWO\DATA\DAYMET\Tmean\Anomalies\081716
clear all; close all
% load Anom_imag

list0 = dir('082216/Anomalies*.mat');
imag = cell(length(list0),1);
N=length(list0);


%{
% This code was only to detect that day 171 is missgin
% NOTEL in new folder "08216" no day is missing
yr = zeros(N,1);
for k=1:N % only january 1 along all years
    fprintf('%i out of %i\n',k,N);
    tmp = list0(k).name;
    ind = findstr(tmp,'DOY');
    tmp = tmp(ind+3:end);
    ind = find(tmp=='.');
    tmp = tmp(1:ind-1);
    yr(k) = str2num(tmp);
end
plot(diff(yr))
%}


pcm = 2;
pcM = 98;

fprintf('creating supercube\n');
supercube = zeros(1,668,N*33);
fprintf('done supercube\n');

per_m = zeros(568,668);
per_M = zeros(568,668);

for k0=1:568

    fprintf('%i out of %i\n',k0,568);
    fprintf('==================================\n');
    for k=1:N % only january 1 along all years
        
        if mod(k,20) ==0, fprintf('%i out of %i\n',k,N); end
        
        load(['082216/' list0(k).name]); % variables "lon", "lat" "anomaly" is loaded
        
        anomaly = anomaly(k0,:,:); % operate latitude by latitude (big data!)
        
        supercube(1,:,(k-1)*33+1:k*33) = anomaly;
    end

    per_m(k0,:) = mypercentile(supercube,pcm,3);
    per_M(k0,:) = mypercentile(supercube,pcM,3);
end



fprintf('done computing, saving...\n');
save percentile_02 per_m
save percentile_98 per_M


fprintf('done\n');

























