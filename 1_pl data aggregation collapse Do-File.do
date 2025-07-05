keep pid hid cid pnr syear plh0037
*drop values before assessed period
drop if syear < 2010
*drop error / nonresponse values
drop if plh0037 < 0

* Create the Climate Concern index
bysort hid syear: egen mean_cli = mean(plh0037)
label var mean_cli "Household mean: Climate change perception (plh0037)"

*collapse for merge to only have one observation per household and year
sort cid hid syear
collapse (first) mean_cli, by(cid hid syear)