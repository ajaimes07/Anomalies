cd C:\Users\ajaimes\Documents\TWO\DATA\DAYMET\Tmean\Anomalies\081716
clear all; close all
% load Anom_imag

list0 = ls('*.mat');
imag = cell(size(list0,1),1);
N=length(list0);

% for k=1:size(list0,1)
for k=200:size(list0,1)
    fprintf('%i out of %i\n',k,N);
    load(list0(k,:));
    imag{k} = anomaly;    
end

save imag
    lt0= 30.617622;      lg0= -97.293525; % (Stiles)
    lt1= 31.480192;      lg1= -96.883186; % (Riesel)
    lt2= 29.118876;      lg2= -95.786198; % (Dance Bayou)
    lt3= 28.870245;      lg3= -95.545145; % (San Bernard)
%   lt4= 27.68361111;    lg4= -98.20361111; % (La Copita)
cd C:\Users\ajaimes\Documents\TWO\DATA\DAYMET\Tmean\Anomalies\081716
figure('position', [200 50  1043    773]);
for k=1:33
    pause(0.3)
    imagesc(lon(:,1),lat(1,:),anomaly(:,:,k));
    set(gca,'yDir','normal');
    colorbar
     caxis([-10 10])
    xlabel('longitude')
    ylabel('latitude')
    title (['Anomalies of temperature _' num2str(1980+k) 'degrees C'],'interpreter','none')
    title= (num2str(1980+k));
    hold on;
    plot(lg0,lt0,'o', 'MarkerEdgeColor','k','MarkerFaceColor',[0 0 0],'MarkerSize',10);
    plot(lg1,lt1,'o', 'MarkerEdgeColor','k','MarkerFaceColor',[0 0 0],'MarkerSize',10);
    plot(lg2,lt2,'o', 'MarkerEdgeColor','k','MarkerFaceColor',[0 0 0],'MarkerSize',10);
    plot(lg3,lt3,'o', 'MarkerEdgeColor','k','MarkerFaceColor',[0 0 0],'MarkerSize',10);
    cd C:\Users\ajaimes\Documents\TWO\DATA\DAYMET\Tmean\Anomalies\081916
    savefig  (title)
    drawnow;
    
end
