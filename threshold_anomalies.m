
% recall folder 082216 has the anomalies
% We now want to threshold them against percentiles:





clear all; close all

list0 = dir('082216/Anomalies*.mat');
N = length(list0);

load percentile_02.mat % here variable perm_m is laoded (low percentile)
load percentile_98.mat % here variable perm_M is loaded (high percentile)

anomaly_low_threshold = zeros(568,668,33);
anomaly_high_threshold = zeros(568,668,33);

anom_low_count  = zeros(N,33);
anom_high_count = zeros(N,33);



for k = 1:N
    
    fprintf('%d out of %d\n',k,N);
    
    load (['082216/' list0(k).name]); % here varibale "anomaly" 568x668x33 is loaded
    
    ind_low_thr  = anomaly <= repmat(per_m,1,1,33);
    anomaly_low_threshold(ind_low_thr) = anomaly(ind_low_thr);
    anomaly_low_threshold(isnan(anomaly)) = NaN;
    
    ind_high_thr = anomaly >= repmat(per_M,1,1,33);
    anomaly_high_threshold(ind_high_thr) = anomaly(ind_high_thr);
    anomaly_high_threshold(isnan(anomaly)) = NaN;
    
    
    anom_low_count(k,:) = squeeze(sum(sum(ind_low_thr,1),2));
    anom_high_count(k,:) = squeeze(sum(sum(ind_high_thr,1),2));
    
    % plot(anom_low_count(1,:)) This is number of anomalies found in
    % january 01 per every year. See notebook
    
        save(['082816\Anomalies_DOY' num2str(k,'%.3i') '_low_thrs'], 'anomaly_low_threshold');
    save(['082816\Anomalies_DOY' num2str(k,'%.3i') '_high_thrs'], 'anomaly_high_threshold');
end

save('anom_low_count','anom_low_count');
save('anom_high_count','anom_high_count');

% figure
% plot(sum(anom_low_count),'bX')
% ylim([0 10e6])







