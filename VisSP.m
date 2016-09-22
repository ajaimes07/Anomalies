clear all
close all
cd C:\Users\ajaimes\Documents\TWO\DATA\DAYMET\Tmean\Anomalies

load ('SP_Tmean')
    lt0= 30.617622;      lg0= -97.293525; % (Stiles)
    lt1= 31.480192;      lg1= -96.883186; % (Riesel)
    lt2= 29.118876;      lg2= -95.786198; % (Dance Bayou)
    lt3= 28.870245;      lg3= -95.545145; % (San Bernard)
%     lt4= 27.68361111;    lg4= -98.20361111; % (La Copita)
     
figure('position', [200 50  1043    773]);
for o=1:365
% for o=1:10

    pause (0.2)
    
    imagesc (lon(:,1), lat(1,:),means{o});
    set(gca,'yDir','normal');
    colorbar
    caxis ([4 35])
    xlabel('Longitude'); ylabel ('Latitude')
    title (['Daily Temperature Pattern (Daily Average 1980-2013) DOY_' num2str(o)],'interpreter', 'none')
    name='SP_DOY_';
       
    hold on;
    plot(lg0,lt0,'o', 'MarkerEdgeColor','k','MarkerFaceColor',[0 0 0],'MarkerSize',10);
    plot(lg1,lt1,'o', 'MarkerEdgeColor','k','MarkerFaceColor',[0 0 0],'MarkerSize',10);
    plot(lg2,lt2,'o', 'MarkerEdgeColor','k','MarkerFaceColor',[0 0 0],'MarkerSize',10);
    plot(lg3,lt3,'o', 'MarkerEdgeColor','k','MarkerFaceColor',[0 0 0],'MarkerSize',10);
%     plot(lg4,lt4,'o', 'MarkerEdgeColor','k','MarkerFaceColor',[0 0 0],'MarkerSize',10); % 10481 and 10482 Mosaics needed
    drawnow;
    
%     namesave=[name num2str(o)];
%     savefig (namesave)
end