
local graph_window_left_padding = 10 

local graph_window_top_padding = 10  

local plot_area_left_margin = 2   



preserve 

collapse (mean) mean_cli=mean_cli, by(syear hghinc_quintile)

sort syear hghinc_quintile 

twoway (line mean_cli syear if hghinc_quintile == 1, sort lcolor(blue) lwidth(medium) legend(order(1 "Q1"))) ///
        (line mean_cli syear if hghinc_quintile == 2, sort lcolor(orange) lwidth(medium) legend(order(2 "Q2"))) ///
        (line mean_cli syear if hghinc_quintile == 3, sort lcolor(dkorange) lwidth(medium) legend(order(3 "Q3"))) ///
        (line mean_cli syear if hghinc_quintile == 4, sort lcolor(gold) lwidth(medium) legend(order(4 "Q4"))) ///
        (line mean_cli syear if hghinc_quintile == 5, sort lcolor(navy) lwidth(medium) legend(order(5 "Q5"))),  ///
        ytitle("Climate Concern Index (1-high to 3-low concerns)", size(small))  ///
        ylabel(, labsize(small) angle(0) grid glcolor(gs12) glpattern(solid))  ///
        xtitle("Year", size(small)) ///
		 title("Climate Concern Index of Individual Households," "by Income Quintiles", size(medium) color(black)) ///
        xlabel(2010(1)2021, labsize(small))  ///
        graphregion(fcolor(white) lcolor(white) margin(l+`graph_window_left_padding' t+`graph_window_top_padding')) /// 
        plotregion(fcolor(white) lcolor(white) margin(l+`plot_area_left_margin')) /// 
        yscale(reverse) /// 
        legend(order(1 "Q1 (poorest)" 2 "Q2" 3 "Q3" 4 "Q4" 5 "Q5 (wealthiest)") cols(5) pos(6) rowgap(0) size(small) region(fcolor(white) lcolor(white)) ///
        label(1 "Q1", color(blue)) label(2 "Q2", color(orange)) label(3 "Q3", color(dkorange)) label(4 "Q4", color(gold)) label(5 "Q5", color(navy)))


restore