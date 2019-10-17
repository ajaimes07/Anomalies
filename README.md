# Anomalies
MATLAB scripts to estimate anomalies using extreme value theory. 
1) DOWNDATA_AND_MERGE_V4.m
Download Daymet data from different years and tiles.
Spatilly merge data at different tiles using the function daymetMerge.m
A figure is generated to verify tiles have been merged correctly 

2) Anomalies 1
% Creates a variable named days
% Days is an array that contains 365 matrices of 568 x 668 x 33 (LAT x LONG x YEARS)

3) AnomaliesDriver
Input: Days.m
Output: 
pc1- percentile 90
pc1- percentile 10
ind1- Index of days above pc1
ind2- Index of days above pc2
Plot's the result
