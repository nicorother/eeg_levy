
preserve

drop if hghinc < 0 

collapse (mean) hghinc_mean=eeg_paid, by(syear hghinc_quintile) 
sort syear hghinc_quintile

twoway (line hghinc_mean syear if hghinc_quintile == 1, sort lcolor(blue) lwidth(medium) legend(order(1 "Q1"))) ///
        (line hghinc_mean syear if hghinc_quintile == 2, sort lcolor(orange) lwidth(medium) legend(order(2 "Q2"))) ///
        (line hghinc_mean syear if hghinc_quintile == 3, sort lcolor(dkorange) lwidth(medium) legend(order(3 "Q3"))) ///
        (line hghinc_mean syear if hghinc_quintile == 4, sort lcolor(gold) lwidth(medium) legend(order(4 "Q4"))) ///
        (line hghinc_mean syear if hghinc_quintile == 5, sort lcolor(navy) lwidth(medium) legend(order(5 "Q5"))), ///
        ytitle("EEG Levy Charge (€)") ///
        ylabel(, labsize(small) angle(0) grid glcolor(gs12) glpattern(solid)) ///
        xtitle("Year") ///
        title("Absolute EEG Levy Charge by Income Quintile", size(medium) color(black)) ///
        xlabel(2010 2011 2012 2013 2015 2016 2017 2018 2019 2020 2021, labsize(small)) ///
        graphregion(fcolor(white) lcolor(white)) plotregion(fcolor(white) lcolor(white)) ///
        legend(order(1 "Q1 (poorest)" 2 "Q2" 3 "Q3" 4 "Q4" 5 "Q5 (wealthiest)") cols(5) pos(6) rowgap(0) size(small) region(fcolor(white) lcolor(white))) ///


restore