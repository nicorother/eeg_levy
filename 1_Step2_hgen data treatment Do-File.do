*Merge Electricity Expenditures of Homeowners into hgen
merge 1:1 cid hid syear using "hl.dta", keepusing(hlf0084)
drop if _merge == 2
drop _merge

*Merge Climate Concern Index into hgen (for data treatment & collapse code of pl file, see other Do-File)
merge 1:1  cid hid syear using "6_pl_TREATED_COLLAPSED.dta", keepusing(mean_cli)
drop if _merge == 2
drop _merge

*Merge Dwelling Type into hgen
merge 1:1  cid hid syear using "hbrutt.dta", keepusing(wum1)
drop if _merge == 2
drop _merge

drop if syear < 2010


* Insert Electricity Price
	generate elecprice = .
	label variable elecprice "Gross Electricity Price in EUR"
	replace elecprice = 23.69 if syear == 2010
	replace elecprice = 25.23 if syear == 2011
	replace elecprice = 25.89 if syear == 2012
	replace elecprice = 28.84 if syear == 2013
	replace elecprice = 29.14 if syear == 2014
	replace elecprice = 28.70 if syear == 2015
	replace elecprice = 28.80 if syear == 2016
	replace elecprice = 29.28 if syear == 2017
	replace elecprice = 29.47 if syear == 2018
	replace elecprice = 30.46 if syear == 2019
	replace elecprice = 31.81 if syear == 2020
	replace elecprice = 32.16 if syear == 2021
	replace elecprice = 37.91 if syear == 2022
	* Cent to Euro
	replace elecprice = elecprice / 100
*Insert EEG Levy variable
	generate eeg = .
	label variable eeg "EEG-levy per KwH (EUR)"
	replace eeg = 0.0205 if syear == 2010
	replace eeg = 0.0353 if syear == 2011
	replace eeg = 0.0359 if syear == 2012
	replace eeg = 0.0528 if syear == 2013
	replace eeg = 0.0624 if syear == 2014
	replace eeg = 0.0617 if syear == 2015
	replace eeg = 0.0635 if syear == 2016
	replace eeg = 0.0688 if syear == 2017
	replace eeg = 0.0679 if syear == 2018
	replace eeg = 0.0641 if syear == 2019
	replace eeg = 0.0676 if syear == 2020
	replace eeg = 0.065 if syear == 2021
	replace eeg = 0.0372 if syear == 2022

* Generate a new variable for the number of household members
gen int nr_member = .
label variable nr_member "Most Likely Number of Household Members"

* 1-Person Households
replace nr_member = 1 if hgtyp2hh == 11 // 1-Person Household <= 35 Years
replace nr_member = 1 if hgtyp2hh == 12 // 1-Person Household 35- < 60 Years
replace nr_member = 1 if hgtyp2hh == 13 // 1-Person Household >= 60 Years

* 2-Person Households (Couples without children)
replace nr_member = 2 if hgtyp2hh == 21 // Couple without Children

* Single Parents with Children (Alleinerz. = Single Parent)
* Note: For "u.m K." (and more children), I assign the lower bound of the "and more" estimate.
replace nr_member = 2 if hgtyp2hh == 31 // Single Parent + 1 Child <= 16 (1 adult + 1 child = 2)
replace nr_member = 3 if hgtyp2hh == 32 // Single Parent + 2 or more Children <= 16 (1 adult + 2 children = 3)
replace nr_member = 2 if hgtyp2hh == 33 // Single Parent + 1 Child > 16 (1 adult + 1 child = 2)
replace nr_member = 3 if hgtyp2hh == 34 // Single Parent + 2 or more Children > 16 (1 adult + 2 children = 3)
replace nr_member = 3 if hgtyp2hh == 35 // Single Parent + 2 Children <= and > 16 (1 adult + 2 children = 3)
replace nr_member = 4 if hgtyp2hh == 36 // Single Parent + 3 or more Children <= and > 16 (1 adult + 3 children = 4)

* Couples with Children (Paar = Couple)
replace nr_member = 3 if hgtyp2hh == 41 // Couple + 1 Child <= 16 (2 adults + 1 child = 3)
replace nr_member = 4 if hgtyp2hh == 42 // Couple + 2 Children <= 16 (2 adults + 2 children = 4)
replace nr_member = 5 if hgtyp2hh == 43 // Couple + 3 or more Children <= 16 (2 adults + 3 children = 5)
replace nr_member = 3 if hgtyp2hh == 51 // Couple + 1 Child > 16 (2 adults + 1 child = 3)
replace nr_member = 4 if hgtyp2hh == 52 // Couple + 2 Children > 16 (2 adults + 2 children = 4)
replace nr_member = 5 if hgtyp2hh == 53 // Couple + 3 or more Children > 16 (2 adults + 3 children = 5)
replace nr_member = 4 if hgtyp2hh == 61 // Couple + 2 Children <= and > 16 (2 adults + 2 children = 4)
replace nr_member = 5 if hgtyp2hh == 62 // Couple + 3 or more Children <= and > 16 (2 adults + 3 children = 5)

* Multi-generational and Other Households
replace nr_member = 3 if hgtyp2hh == 71 // 3-Generation Household (at least 3, taking minimum)
replace nr_member = 4 if hgtyp2hh == 72 // 4-Generation Household (at least 4, taking minimum)
replace nr_member = 3 if hgtyp2hh == 73 // Grandparents-Grandchildren Household (typically 2 adults + 1 child = 3)
replace nr_member = 2 if hgtyp2hh == 81 // Other Combination without Children <= 16 (taking minimum 2)
replace nr_member = 3 if hgtyp2hh == 82 // Other Combination with Children <= 16 (taking minimum 3)


	
*remove negative wum1 values for regression
replace wum1 = . if wum1 < 0

*remove empty and unplausibly high incomes
drop if hghinc > 80000
drop if hghinc < 0

*drop missing Climate Concern Index Values
drop if mean_cli == .


*Impute Monthly Electricity Consumption of Homeowners
replace hgelectr = . if hgelectr < 0
	sort hid syear
	tsset hid syear
	bysort hid: gen double hlf0084_next_year = F.hlf0084
	replace hgelectr = hlf0084_next_year / 12 if missing(hgelectr) & !missing(hlf0084_next_year) & hlf0084_next_year >= 0
	drop hlf0084_next_year

*drop dwelling size non-responses
drop if hgsize < 0

*drop strongly biased years
drop if syear == 2022
drop if syear == 2014

*Delete still observations where still no imputation was possible
drop if missing(hgelectr)


* calculate KwH
	gen kwh = hgelectr / elecprice
	label variable kwh "KwH consumed per month (estimated)"
	gen kwh_ln = ln(kwh)
	
*calculate EEG-levy burden absolute and relative
	gen eeg_paid = kwh * eeg
	label variable eeg_paid "monthly EEG-levy paid"
	gen eeg_paid_ln = log(eeg_paid)
	
	gen eeg_paid_ishare = eeg_paid / hghinc
	label variable eeg_paid_ishare "share of monthly EEG-levy paid of net household income
	
	gen eeg_paid_ishare_pct = eeg_paid_ishare * 100
	


	
	
	
*Create euqally sized income quintiles 
gen double _random_sort_order = runiform()
sort syear hghinc _random_sort_order
gen hghinc_quintile = .
levelsof syear, local(years)
foreach yr of local years {
    display "--- Processing year `yr` for equal-sized quintiles ---"
    count if syear == `yr' & !missing(hghinc)
    local obs_in_year = r(N)
    if `obs_in_year' == 0 {
        display as text "Warning: No non-missing hghinc observations in year `yr`. Skipping."
        continue
    }
    bysort syear (hghinc _random_sort_order): gen long _rank_in_year = _n if syear == `yr' & !missing(hghinc)
    replace hghinc_quintile = ceil((_rank_in_year / `obs_in_year') * 5) if syear == `yr' & !missing(_rank_in_year)
    drop _rank_in_year
}
drop _random_sort_order




*Create dummies for Climate Concern Categories
* Create rangedummy_cli_high (High Climate Concern: mean_cli < 2)
gen byte rangedummy_cli_high = 0
replace rangedummy_cli_high = 1 if mean_cli < 2 & !missing(mean_cli)
label variable rangedummy_cli_high "Dummy: CLI Mean < 2 (High Climate Concern)"

* Create rangedummy_cli_medium (Medium Climate Concern: mean_cli == 2)
gen byte rangedummy_cli_medium = 0
replace rangedummy_cli_medium = 1 if mean_cli == 2 & !missing(mean_cli)
label variable rangedummy_cli_medium "Dummy: CLI Mean = 2 (Medium Climate Concern)"

* Create rangedummy_cli_low (Low Climate Concern: mean_cli > 2)
gen byte rangedummy_cli_low = 0
replace rangedummy_cli_low = 1 if mean_cli > 2 & !missing(mean_cli)
label variable rangedummy_cli_low "Dummy: CLI Mean > 2 (Low Climate Concern)"

drop if missing()


