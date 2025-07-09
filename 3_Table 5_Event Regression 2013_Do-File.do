eststo clear 


quietly eststo M1_FullSample: reg eeg_paid_ln ib(2012).syear hgsize nr_member i.hghinc_quintile i.2013.syear#i.hghinc_quintile


quietly eststo M2_CLI_HighC: reg eeg_paid_ln ib(2012).syear hgsize nr_member i.hghinc_quintile i.2013.syear#i.hghinc_quintile if mean_cli < 2


quietly eststo M3_CLI_MidC: reg eeg_paid_ln ib(2012).syear hgsize nr_member i.hghinc_quintile i.2013.syear#i.hghinc_quintile if mean_cli == 2


quietly eststo M4_CLI_LowC: reg eeg_paid_ln ib(2012).syear hgsize nr_member i.hghinc_quintile i.2013.syear#i.hghinc_quintile if mean_cli > 2


esttab M1_FullSample M2_CLI_HighC M3_CLI_MidC M4_CLI_LowC using "eeg_paid_regression_results 2013.rtf", replace ///
    title("Regression Results: Impact on Logged EEG Levy Paid by CLI Subgroup - 2013 Event") ///
    mtitle( "Full Sample" ///
            "CCC-index < 2\nHigh Climate Concerns" ///
            "CCC-index = 2\nMedium Climate Concerns" ///
            "CCC-index > 2\nLow Climate Concerns" ///
          ) ///
    cells(b(fmt(3) star) se(fmt(3) par)) ///
    starlevels(* 0.1 ** 0.05 *** 0.001) ///
    stats(N r2_a, labels("Observations" "Adj. R-squared") fmt(%9.0f %8.3f)) ///
    varwidth(45) ///
    coeflabels( ///
        hgsize "Dwelling Size" ///
        nr_member "Number of Members" ///
        /// syear (Year Dummies - relative to 2012 base year)
        2012.syear "Year 2012 (Omitted)" ///
        2010.syear "Year 2010" ///
        2011.syear "Year 2011" ///
        2013.syear "Year 2013" ///
        2014.syear "Year 2014" ///
        2015.syear "Year 2015" ///
        2016.syear "Year 2016" ///
        2017.syear "Year 2017" ///
        2018.syear "Year 2018" ///
        2019.syear "Year 2019" ///
        2020.syear "Year 2020" ///
        2021.syear "Year 2021" ///
        /// hghinc_quintile (Income Quintile Dummies - relative to Quintile 1)
        1.hghinc_quintile "Income Quintile 1 (Omitted)" ///
        2.hghinc_quintile "Income Quintile 2" ///
        3.hghinc_quintile "Income Quintile 3" ///
        4.hghinc_quintile "Income Quintile 4" ///
        5.hghinc_quintile "Income Quintile 5" ///
        /// Interaction Terms 
        2013.syear#2.hghinc_quintile "2013 x Inc. Q2" ///
        2013.syear#3.hghinc_quintile "2013 x Inc. Q3" ///
        2013.syear#4.hghinc_quintile "2013 x Inc. Q4" ///
        2013.syear#5.hghinc_quintile "2013 x Inc. Q5" ///
        _cons "Constant" ///
    ) ///
    order( ///
        hgsize ///
        nr_member ///
        2012.syear ///
        2010.syear ///
        2011.syear ///
        2013.syear ///
        2014.syear ///
        2015.syear ///
        2016.syear ///
        2017.syear ///
        2018.syear ///
        2019.syear ///
        2020.syear ///
        2021.syear ///
        1.hghinc_quintile ///
        2.hghinc_quintile ///
        3.hghinc_quintile ///
        4.hghinc_quintile ///
        5.hghinc_quintile ///
        2013.syear#2.hghinc_quintile ///
        2013.syear#3.hghinc_quintile ///
        2013.syear#4.hghinc_quintile ///
        2013.syear#5.hghinc_quintile ///
        _cons ///
    ) ///
    keep( ///
        hgsize ///
        nr_member ///
        2012.syear ///
        2010.syear ///
        2011.syear ///
        2013.syear ///
        2014.syear ///
        2015.syear ///
        2016.syear ///
        2017.syear ///
        2018.syear ///
        2019.syear ///
        2020.syear ///
        2021.syear ///
        1.hghinc_quintile ///
        2.hghinc_quintile ///
        3.hghinc_quintile ///
        4.hghinc_quintile ///
        5.hghinc_quintile ///
        2013.syear#2.hghinc_quintile ///
        2013.syear#3.hghinc_quintile ///
        2013.syear#4.hghinc_quintile ///
        2013.syear#5.hghinc_quintile ///
        _cons ///
    )