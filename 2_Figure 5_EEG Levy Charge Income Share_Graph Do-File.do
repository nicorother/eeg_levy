drop if eeg_paid_ishare_pct < 0 | eeg_paid_ishare_pct > 100

preserve
collapse (mean) eeg_paid_ishare_pct=eeg_paid_ishare_pct, by(syear hghinc_quintile)
sort syear hghinc_quintile

twoway (line eeg_paid_ishare_pct syear if hghinc_quintile == 1, sort lcolor(blue) lwidth(medium) legend(order(1 "Q1"))) ///
       (line eeg_paid_ishare_pct syear if hghinc_quintile == 2, sort lcolor(orange) lwidth(medium) legend(order(2 "Q2"))) ///
       (line eeg_paid_ishare_pct syear if hghinc_quintile == 3, sort lcolor(dkorange) lwidth(medium) legend(order(3 "Q3"))) ///
       (line eeg_paid_ishare_pct syear if hghinc_quintile == 4, sort lcolor(gold) lwidth(medium) legend(order(4 "Q4"))) ///
       (line eeg_paid_ishare_pct syear if hghinc_quintile == 5, sort lcolor(navy) lwidth(medium) legend(order(5 "Q5"))), ///
       ytitle("% of income")  ///
       ylabel(0(0.5)2, labsize(small) angle(0) grid glcolor(gs12) glpattern(solid)) ///
       xtitle("year") ///
       xlabel(2010 2011 2012 2013 2015 2016 2017 2018 2019 2020 2021, labsize(small))  ///
       graphregion(fcolor(white) lcolor(white)) plotregion(fcolor(white) lcolor(white)) ///
	   legend(order(1 "Q1" 2 "Q2" 3 "Q3" 4 "Q4" 5 "Q5") cols(5) pos(6) rowgap(0) size(small) region(fcolor(white) lcolor(white)) ///
       label(1 "Q1", color(blue)) label(2 "Q2", color(orange)) label(3 "Q3", color(dkorange)) label(4 "Q4", color(gold)) label(5 "Q5", color(navy))) ///
 
		
	   restore
	   
