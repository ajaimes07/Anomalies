%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3. Download Daymet data of different year at different tiles
%%% BRAZOS REGION
%%% ALINE JAIMES
%%% 071116

clear
clc

% interested tile IDs
tileid=[11021:11023, 10841:10843, 10661:10663];

% interested years
yrs=1981:2013;

% interested Daymet variable
% parname='tmax'; %done!
% parname='tmin'; 

 parname='prcp'; % precipitation
% parname='srad'; % solar radiation
% parname='vp';   % water vapor pressure
% parname='swe';  % snow water equivalent


% download data
daymetGet(tileid, yrs, parname)
pause

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 4. Spatilly merge data at different tiles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
clc
% G:\TWO\DATA\DAYMET\prcp\data
% list0 = ls('../MODIS_ET/*.tif');

list0 = ls('G:/TWO/DATA/DAYMET/prcp/data/*.nc');

N=32;
k=1; 
m=34; 
o=67

for k = 1:N
    filename={list0(1,1:18),list0(34,1:18),list0(67,1:18)}
    name = ['prcp_1981_T6163' list0(1,11:15)]

    % interested Daymet variable
    parname='prcp';
    % spatially merge the different tiles
    [par, lon, lat, x, y] = daymetMerge(filename, parname);
    
    
    cmd = sprintf('%s = map_cutk;',name);
    eval(cmd);
    
    cmd = sprintf('save ..\\MODIS_ET\\%s %s', name, name);
    eval(cmd);
    
         
end


% NetCDF file names where the data are save
% filename={'prcp_10661_1981.nc', 'prcp_10662_1981.nc','prcp_10663_1981.nc'};
%  filename={'prcp_10841_1981.nc', 'prcp_10842_1981.nc','prcp_10843_1981.nc'};
  filename={'prcp_11021_1981.nc', 'prcp_11022_1981.nc','prcp_11023_1981.nc'};
% interested Daymet variable
parname='prcp';

% spatially merge the different tiles
[par, lon, lat, x, y] = daymetMerge(filename, parname);
% Note:
% merged : the merged data set
% lon : longitude coordinate of the merged field
% lat : latitude coordiante of the merged field
% x : x coordinate of projection
% y : y coordinate of projection

% save data
% save Tile61_63
%  save Tile41_43
 save Tile21_23
figure
imagesc(x,y,par(:,:,5)); 

