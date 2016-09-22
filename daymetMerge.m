function [par, lon, lat, x, y] = daymetMerge(filename, parname)
%daymetMerge spatially emerge Daymet NetCDF files
%##########################################################################
%   
%   [PAR, LON, LAT, X, Y] = daymetMerge(FILENAME, PARNAME) returns 
%   spatially emerged NetCDF files of different tiles given in FILENAME.
%   Name of the parameter is given in PARNAME. PAR is the merged field;
%   LON and LAT are the matrices of longitude and latitude coordinates,
%   respectively; X and Y are the vectors of x- and y-coordinates of 
%   projection, respectively. FILENAME should be in the format of 
%   parname_tileid_year.nc.
%
%
%   See also  daymetGet.m
%
%
%   Latest Updated: 04/05/2015
%
%   Author : Chao Li, Carnegie Institution, Stanford, lichao@stanford.edu
%
%##########################################################################


% input check
narginchk(2,2);

if ~iscell(filename) && ~ischar(filename)
    error('daymetMerge:BadFileName',...
          'FILENAME must be a string array or vector.'); 
end
filename=cellstr(filename);
n=numel(filename);

idx1=strfind(filename, '_');
idx2=strfind(filename, '.');
yrs=zeros(n, 1);
for i=1:n
    idx1i=idx1{i};
    idx2i=idx2{i};
    filenamei=filename{i};
    yrs(i)=str2double(filenamei(idx1i(2)+1:idx2i-1));
    if i>1 && yrs(i) ~= yrs(i-1)
        error('daymetMerge:BadFileName',...
              'Data of different years cannot be merged.');       
    end
end
clear idx1 idx1i idx2 idx2i filenamei yrs
% Note:
% only data of the same year can be merged

parnames={'dayl', 'prcp', 'srad', 'swe', 'tmax', 'tmin', 'vp'};
if ~ischar(parname)
    error('daymetMerge:BadParameter',...
          'PARNAME must be a string.');
elseif all(~strcmpi(parname, parnames))
    error('daymetMerge:BadParameter',...
          'Unrecognized parameter name: ''%s''.', parname);   
else
    parname=lower(parname);
end
clear parnames

fprintf('daymetMerge:\n');

% load the supplemental coordinate file
daymetCoordinate=load('daymetCoordinate.mat');
daymetlon=daymetCoordinate.daymetlon;
daymetlat=daymetCoordinate.daymetlat;
daymetx=daymetCoordinate.daymetx;
daymety=daymetCoordinate.daymety;
clear daymetCoordinate


% find the patch formed by tiles.
flag=zeros(size(daymetlon))*NaN;
for i=1:n
    filenamei=filename{i};
    xi=ncread(filenamei, 'x');
    yi=ncread(filenamei, 'y');
    
    xspan=[find(daymetx==xi(1)), find(daymetx==xi(end))];
    yspan=[find(daymety==yi(1)), find(daymety==yi(end))];
    
    flag(xspan(1):xspan(2), yspan(1):yspan(2))=1;
end
clear filenamei xi yi


% find the outermost boundary of the patch
xflag=any(~isnan(flag), 2);
yflag=any(~isnan(flag), 1);
xspan=[find(xflag==1, 1, 'first'), find(xflag==1, 1, 'last')];
yspan=[find(yflag==1, 1, 'first'), find(yflag==1, 1, 'last')];

lon=daymetlon(xspan(1):xspan(2), yspan(1):yspan(2));
lat=daymetlat(xspan(1):xspan(2), yspan(1):yspan(2));
x=daymetx(xspan(1):xspan(2));
y=daymety(yspan(1):yspan(2));

clear flag xflag yflag xspan yspan
clear daymetlon daymetlat daymetx daymety


% field merge
nlon=numel(x);
nlat=numel(y);
ntime=numel(ncread(filename{1}, 'time'));
par=zeros(nlon, nlat, ntime)*NaN;
loops=n;
reverseStr = '';
for i=1:n
    filenamei=filename{i};
    xi=ncread(filenamei, 'x');
    yi=ncread(filenamei, 'y');
    pari=ncread(filenamei, parname);
    for j=1:numel(xi)
        for k=1:numel(yi)
            parijk=pari(j, k, :);
            if ~all(isnan(parijk(:)))
                par(x==xi(j), y==yi(k), :)=parijk;
                % only if a grid contains data, data in this grid are
                % placed to the merged field. Otherwise, i.e., if data 
                % in a grid are all NaNs, this grid is ignored in order
                % to avoid undesired masking the overlapped regions of
                % tiles.
            end
        end
    end
    
    % progress bar
    percentDone = 100 * i / loops;
    msg = sprintf('      percent done: %3.1f\n', percentDone);
    fprintf([reverseStr, msg]);
    reverseStr = repmat(sprintf('\b'), 1, length(msg));
end


end

