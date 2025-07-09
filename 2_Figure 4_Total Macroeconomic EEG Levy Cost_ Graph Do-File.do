
preserve


collapse (sum) eeg_paid_sum=eeg_paid, by(syear hghinc_quintile)

bysort syear: egen total_eeg_year = sum(eeg_paid_sum)

gen share_eeg = (eeg_paid_sum / total_eeg_year) * 100

local plot_commands ""

local colors "blue orange dkorange gold navy"
local i = 1
foreach q in 1 2 3 4 5 {
    local color = word("`colors'", `i')
    local plot_commands "`plot_commands' (line share_eeg syear if hghinc_quintile == `q', lcolor(`color') lwidth(medium) clpattern(solid))"
    local i = `i' + 1
}

twoway `plot_commands', ///
        legend(order(1 "Q1 (poorest)" 2 "Q2" 3 "Q3" 4 "Q4" 5 "Q5 (wealthiest)") /// 
               pos(6) col(5) row(1) ring(0) size(small) symxsize(2) symysize(2)) /// 
        ylabel(0(5)30, labsize(small) angle(horizontal) grid glpattern(dash) glcolor(gs15)) /// 
        xlabel(2010 2011 2012 2013 2015 2016 2017 2018 2019 2020 2021, labsize(small) angle(horizontal) labcolor(black) grid glpattern(dash) glcolor(gs15)) /// 
        title("Annual Share of Total Macroeconomic EEG Levy Cost," "by Income Quintiles as a Whole (aggregated)", size(medium) color(black)) /// 
        ytitle("Percent of Total Macroeconomic EEG Cost") xtitle("") /// 
        graphregion(margin(zero) color(white)) /// 
        plotregion(margin(zero) color(white)) /// 
        xscale(range(2010 2021)) /// 
        yscale(range(0 30)) /// 
        aspectratio(0.6) /// 
        graphregion(fcolor(white) lcolor(white)) plotregion(fcolor(white) lcolor(white)) 

restore
