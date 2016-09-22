% prom1=mean(tmpk,3)
% prom2=means{1};
% Aline Jaimes 
% 08/16/16

% NOTE: The output files are stored C:\Users\ajaimes\Documents\TWO\DATA\DAYMET\Tmean\Anomalies
% Filename:Anomalies_ DOY000
% Each file contains the 33 years anomalies.
% In other word, Anomalies_ DOY001, contains the anomalies calculated for
% all january 1st over the 33 year period. 

%Tmean_per_day

clear all ; close all

load ('SP_Tmean')


list0 = dir('../Tmean_per_day/*.mat');

N = length(list0);
% The cycle starts for all the files on the directory (365)
% day_1_over_33_years.mat

 for k=1:N 

    
    fprintf('%i out of %i\n',k,N);
    load(['../Tmean_per_day/' list0(k).name]); % Load the k file .mat
    

    
    anomaly = tmpk - repmat(means{k},1,1,33);
%     anomaly = zeros (size (tmpk));
%     for i=1:33; % repeat the cycle for 33 years
%         anomaly(:,:,i)=tmpk(:,:,i) - means{k};   
%     end
    
    name = ['082216/Anomalies_DOY'  num2str(k,'%0.3d')];
    
    save (name, 'anomaly','lat','lon')
    
end
