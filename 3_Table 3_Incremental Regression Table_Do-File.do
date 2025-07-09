
eststo clear 


quietly eststo M1: regress eeg_paid_ln rangedummy_cli_low rangedummy_cli_high


quietly eststo M2: regress eeg_paid_ln rangedummy_cli_low rangedummy_cli_high hghinc


quietly eststo M3: regress eeg_paid_ln rangedummy_cli_low rangedummy_cli_high hghinc hgsize


quietly eststo M4: regress eeg_paid_ln rangedummy_cli_low rangedummy_cli_high hghinc hgsize nr_member


quietly eststo M5: regress eeg_paid_ln rangedummy_cli_low rangedummy_cli_high hghinc hgsize ib(2010).syear


quietly eststo M6: regress eeg_paid_ln rangedummy_cli_low rangedummy_cli_high hghinc hgsize nr_member ib(2010).syear


quietly eststo M7: regress eeg_paid_ln rangedummy_cli_low rangedummy_cli_high hghinc hgsize nr_member ib(2010).syear ib(5).wum1


esttab using "incremental_regression_table EEG rangedummies_reordered without 2014.rtf", replace ///
        title("Regression Results: Incremental Model Building - Dependent Variable: EEG Levy Charge (logged) - Reordered Variables") ///
        mtitle("Model 1" "Model 2" "Model 3" "Model 4" "Model 5" "Model 6" "Model 7") /// 
        cells(b(fmt(5) star) se(fmt(3) par)) /// 
        starlevels(* 0.1 ** 0.05 *** 0.001) /// 
        stats(N r2_a, labels("Observations" "Adj. R-squared") fmt(%9.0f %8.3f)) /// 
        varwidth(35) /// 
        coeflabels(rangedummy_cli_low "Climate Concern: Low Rangedummy" ///
                    rangedummy_cli_high "Climate Concern: High Rangedummy" ///
                    hghinc "Household Income" ///
                    hgsize "Dwelling Size" ///
                    nr_member "Number of Members" ///
                    2010.syear "Year 2010 (Omitted – base year)" /// 
                    2011.syear "Year 2011" ///
                    2012.syear "Year 2012" /// 
                    2013.syear "Year 2013" ///
                    2015.syear "Year 2015" ///
                    2016.syear "Year 2016" ///
                    2017.syear "Year 2017" ///
                    2018.syear "Year 2018" ///
                    2019.syear "Year 2019" ///
                    2020.syear "Year 2020" ///
                    2021.syear "Year 2021" ///
                    1.wum1 "House Type: Farm/Agricultural Residence" ///
                    2.wum1 "House Type: Detached House" ///
                    3.wum1 "House Type: Row House" ///
                    4.wum1 "House Type: 3-4 Apartments" ///
                    6.wum1 "House Type: 9+ Apartments" ///
                    7.wum1 "House Type: High-rise Building" ///
                    _cons "Constant") /// 
        order(rangedummy_cli_low rangedummy_cli_high hghinc hgsize nr_member ///
              2010.syear 2011.syear 2012.syear 2013.syear 2015.syear 2016.syear 2017.syear ///
              2018.syear 2019.syear 2020.syear 2021.syear ///
              1.wum1 2.wum1 3.wum1 4.wum1 6.wum1 7.wum1 _cons) ///
        keep(rangedummy_cli_low rangedummy_cli_high hghinc hgsize nr_member ///
             2010.syear 2011.syear 2012.syear 2013.syear 2015.syear 2016.syear 2017.syear ///
             2018.syear 2019.syear 2020.syear 2021.syear ///
             1.wum1 2.wum1 3.wum1 4.wum1 6.wum1 7.wum1 _cons)