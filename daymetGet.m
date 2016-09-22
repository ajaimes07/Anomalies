 function daymetGet(tileid, yrs, parname)
%daymetGet download Daymet data of tiles 
%##########################################################################
%
%   daymetGet(TILEID, YRS, PARNAME) downloads daymet variable PARNAME of
%   a tile or tiles given in TILEID, for a year or years given in YRS, 
%   and save the data to the current directory in a NetCDF file or files 
%   named in a format of PARNAME_TILEID_YEAR.nc. YRS is a scalar or 
%   vector specifying the year or years of the time series.
%
%
%   See also  daymetMerge.m
%
%
%   Latest Updated: 04/05/2015
%
%   Author : Chao Li, Carnegie Institution, Stanford, lichao@stanford.edu
%
%##########################################################################


% input check
narginchk(3, 3);

if any(yrs<1980) || any(yrs>2013)
    error('daymetGet:BadYear',...
          'No data available for years before 1980 or after 2013.');
end
yrs=unique(yrs(:));

parnames={'dayl', 'prcp', 'srad', 'swe', 'tmax', 'tmin', 'vp'};
if all(~strcmpi(parname, parnames))
    error('daymetGet:BadParameter',...
          'Unrecognized parameter name: ''%s''.', parname);
else
    parname=lower(parname);
end

fprintf('daymetGet:\n')

% drop invalid tiles
tileids=[12625:12663, 12447:12484, 12268:12304, 12088:12121, 11908:11938,...
          11728:11756, 11548:11573, 11369:11393, 11190:11213, 11010:11032,...
          10832:10850, 10653:10666, 10668:10670, 10473:10482, 10489:10490,...
          10294:10302, 10309:10310, 10115:10122, 9983:9942, 9945:9947,...
          9758:9767, 9579:9587, 9402:9405];


tileids=tileids(:);

tileid=unique(tileid(:));
tileidvalid=true(numel(tileid),1);
for i=1:numel(tileid)
    if all(tileid(i)~=tileids)
        tileidvalid(i)=false;
    end
end
tileid=tileid(tileidvalid);


% download data
URLpart='http://thredds.daac.ornl.gov/thredds/fileServer/ornldaac/1219/tiles';
loops=numel(tileid)*numel(yrs);
reverseStr = '';
loopi=1;
for i=1:numel(tileid)
    for j=1:numel(yrs)      
        % URL from which the data are downloaded
        URL=[URLpart, num2str(yrs(j)), '/', num2str(tileid(i)), '_',...
             num2str(yrs(j)), '/', parname, '.nc'];
            
        % file to which the data are written
        filename=[parname, '_', num2str(tileid(i)), '_', num2str(yrs(j)), '.nc'];
            
        % pull data now...
        urlwrite(URL, filename);
            
        % progress bar
        percentDone = 100 * loopi / loops;
        msg = sprintf('      percent done: %3.1f\n', percentDone);
        fprintf([reverseStr, msg]);
        reverseStr = repmat(sprintf('\b'), 1, length(msg));
        loopi=loopi+1;
    end
end


end

