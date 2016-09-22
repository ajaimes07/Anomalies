function xi = mypercentile(v,p,dim)
% v is data
% p is percentile in percentage
% dim is dimension where to compute percentile

if nargin<3, dim=[]; end
if isempty(dim), dim=1; end

ind = max(round(p*.01*size(v,dim)),1);
sv = sort(v,dim);

if dim==1
    xi = sv(ind,:,:);
elseif dim==2
    xi = sv(:,ind,:);
elseif dim==3
    xi = sv(:,:,ind);
end

end