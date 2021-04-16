clear
set more off

cd "C:\Users\wydic\Dropbox\1-Work\Research\COVID\Stata_Files\Data\U.S\"
use "COVID_US_DATA_4-15-21.dta", clear

************ Estimations ************
*create global macros for controls
global demeaned_controls dm_median_age dm_median_income dm_pop_density dm_pct_latino dm_pct_african_american dm_pct_asian dm_pct_manufacturing dm_pct_service_health_educ dm_pct_retail
global interacted_controls pt_x_dmmedian_age pt_x_dmmedian_income pt_x_dmpop_density pt_x_dmpct_latino pt_x_dmpct_african_american pt_x_dmpct_asian pt_x_dmpct_manufacturing pt_x_dmpct_service pt_x_dmpct_retail

*** Table 1: Shelter at Home; Mask-wearing; Covid-Safe Behavior Index
*summary statistics:
sum pct_trump2020 gunownership state_inctax_rate abort_clinics_permillion $controls

xi: reg mask  pct_trump2020 $demeaned_controls $interacted_controls c.pct_trump2020##i.state_fe [aweight=county_population], cluster(state)
outreg2 using COVID_Table1, se bdec(3) rdec(3) word replace
xi: reg std_at_home  pct_trump2020 $demeaned_controls $interacted_controls c.pct_trump2020##i.state_fe [aweight=county_population], cluster(state)
outreg2 using COVID_Table1, se bdec(3) rdec(3) word append
xi: reg std_C19Safe_Index  pct_trump2020 $demeaned_controls $interacted_controls c.pct_trump2020##i.state_fe [aweight=county_population], cluster(state)
outreg2 using COVID_Table1, se bdec(3) rdec(3) word append

* Relative Effects of Other Conservative Measures:
reg mask pct_trump2020 gunownership state_inctax_rate abort_clinics_permillion $controls [aweight=county_population], cluster(state)
outreg2 using COVID_Table1, se bdec(3) rdec(3) excel append
reg std_at_home pct_trump2020 gunownership state_inctax_rate abort_clinics_permillion $controls [aweight=county_population], cluster(state)
outreg2 using COVID_Table1, se bdec(3) rdec(3) excel append
reg std_C19Safe_Index pct_trump2020 gunownership state_inctax_rate abort_clinics_permillion $controls [aweight=county_population], cluster(state)
outreg2 using COVID_Table1, se bdec(3) rdec(3) excel append

* Relative effects by standard deviations: std_pct_trump2020 std_gunownership std_state_inctax_rate std_abortionclinics
reg mask std_pct_trump2020 std_gunownership std_state_inctax_rate std_abort_clinics_permillion  $controls  [aweight=county_population], cluster(state)
outreg2 using COVID_Table1, se bdec(3) rdec(3) excel append
reg std_at_home std_pct_trump2020 std_gunownership std_state_inctax_rate std_abort_clinics_permillion  $controls  [aweight=county_population], cluster(state)
outreg2 using COVID_Table1, se bdec(3) rdec(3) excel append
reg std_C19Safe_Index std_pct_trump2020 std_gunownership std_state_inctax_rate std_abort_clinics_permillion $controls  [aweight=county_population], cluster(state)
outreg2 using COVID_Table1, se bdec(3) rdec(3) excel append


*** Table 2: Cases and Deaths:
* Outcomes on Political Identity:
xi: reg cases_per_100k  pct_trump2020 $demeaned_controls $interacted_controls c.pct_trump2020##i.state_fe [aweight=county_population], cluster(state)
outreg2 using COVID_Table2, se bdec(3) rdec(3) word replace
xi: reg deaths_per_100k  pct_trump2020 $demeaned_controls $interacted_controls c.pct_trump2020##i.state_fe [aweight=county_population], cluster(state)
outreg2 using COVID_Table2, se bdec(3) rdec(3) word append
* 1pp incrase in Trump support causes cases increase by 64 per 100K and deaths by 1.5 per 100K

* Relative Effects of Other Conservative Measures:
reg cases_per_100k pct_trump2020 gunownership state_inctax_rate abort_clinics_permillion $controls [aweight=county_population], cluster(state)
outreg2 using COVID_Table2, se bdec(3) rdec(3) excel append
reg deaths_per_100k pct_trump2020 gunownership state_inctax_rate abort_clinics_permillion $controls [aweight=county_population], cluster(state)
outreg2 using COVID_Table2, se bdec(3) rdec(3) excel append
* lowers cases only to 1.36 and deaths to 59 per 100K

* Relative effects by standard deviations: std_pct_trump2020 std_gunownership std_state_inctax_rate std_abortionclinics
reg cases_per_100k std_pct_trump2020 std_gunownership std_state_inctax_rate std_abort_clinics_permillion  $controls  [aweight=county_population], cluster(state)
outreg2 using COVID_Table2, se bdec(3) rdec(3) excel append
reg deaths_per_100k std_pct_trump2020 std_gunownership std_state_inctax_rate std_abort_clinics_permillion  $controls  [aweight=county_population], cluster(state)
outreg2 using COVID_Table2, se bdec(3) rdec(3) excel append
* Trump voting is the only variable that survives after loading all conservative variables
* This holds even if we substitute the abortion ratio or abortion rate for clinics per million


*** Table 3: Cases and Deaths on Behaviors:

* OLS Outcomes on behaviors, potential endogeneity:
xi: reg cases_per_100k mask std_at_home $demeaned_controls i.state_fe [aweight=county_population], cluster(state) 
outreg2 using COVID_Table3a, se bdec(3) rdec(3) word replace
xi: reg deaths_per_100k mask std_at_home  $demeaned_controls i.state_fe [aweight=county_population], cluster(state) 
outreg2 using COVID_Table3a, se bdec(3) rdec(3) word append

xi: reg cases_per_100k mask std_at_home pct_trump2020 $demeaned_controls i.state_fe [aweight=county_population], cluster(state) 
outreg2 using COVID_Table3a, se bdec(3) rdec(3) word append
xi: reg deaths_per_100k mask std_at_home pct_trump2020  $demeaned_controls i.state_fe [aweight=county_population], cluster(state) 
outreg2 using COVID_Table3a, se bdec(3) rdec(3) word append

xi: reg cases_per_100k std_mask std_at_home $demeaned_controls i.state_fe [aweight=county_population], cluster(state) 
outreg2 using COVID_Table3a, se bdec(3) rdec(3) word append
xi: reg deaths_per_100k std_mask std_at_home  $demeaned_controls i.state_fe [aweight=county_population], cluster(state) 
outreg2 using COVID_Table3a, se bdec(3) rdec(3) word append

xi: reg cases_per_100k std_mask std_at_home pct_trump2020 $demeaned_controls i.state_fe [aweight=county_population], cluster(state) 
outreg2 using COVID_Table3a, se bdec(3) rdec(3) word append
xi: reg deaths_per_100k std_mask std_at_home pct_trump2020  $demeaned_controls i.state_fe [aweight=county_population], cluster(state) 
outreg2 using COVID_Table3a, se bdec(3) rdec(3) word append


* IV (GMM) estimations:
ren pt_x_dmpct_service_health_educ pt_x_dmpct_service
global instruments pt_x_dmpct_latino pt_x_dmpct_african_american pt_x_dmpct_asian pt_x_dmpct_manufacturing pt_x_dmpct_service pt_x_dmpct_retail pct_trump2020
global instruments_NT pt_x_dmpct_latino pt_x_dmpct_african_american pt_x_dmpct_asian pt_x_dmpct_manufacturing pt_x_dmpct_service pt_x_dmpct_retail 

*Mask-wearing variable in percent form:
xtivreg2 cases_per_100k (mask std_at_home = $instruments) $demeaned_controls [aweight=county_population], gmm fe i(state_fe) cluster(state) first
outreg2 using COVID_Table3b, se bdec(2) rdec(2) word replace
xtivreg2 deaths_per_100k (mask std_at_home = $instruments) $demeaned_controls [aweight=county_population], gmm fe i(state_fe) cluster(state) first
outreg2 using COVID_Table3b, se bdec(2) rdec(2) word append

*Test if the main county Trump vote variable is significant as independent variable:
xtivreg2 cases_per_100k pct_trump2020 (mask std_at_home = $instruments_NT) $demeaned_controls [aweight=county_population], gmm fe i(state_fe) cluster(state) first
outreg2 using COVID_Table3b, se bdec(2) rdec(2) word append
xtivreg2 deaths_per_100k pct_trump2020 (mask std_at_home = $instruments_NT) $demeaned_controls [aweight=county_population], gmm fe i(state_fe) cluster(state) first
outreg2 using COVID_Table3b, se bdec(2) rdec(2) word append

*Standardized Mask Variable:
xtivreg2 cases_per_100k (std_mask std_at_home = $instruments) $demeaned_controls [aweight=county_population], gmm fe i(state_fe) cluster(state) first
outreg2 using COVID_Table3b, se bdec(2) rdec(2) word append
xtivreg2 deaths_per_100k (std_mask std_at_home = $instruments) $demeaned_controls [aweight=county_population], gmm fe i(state_fe) cluster(state) first
outreg2 using COVID_Table3b, se bdec(2) rdec(2) word append

*Test if the main county Trump vote variable is significant as independent variable:
xtivreg2 cases_per_100k pct_trump2020 (std_mask std_at_home = $instruments_NT) $demeaned_controls [aweight=county_population], gmm fe i(state_fe) cluster(state) first
outreg2 using COVID_Table3b, se bdec(2) rdec(2) word append
xtivreg2 deaths_per_100k pct_trump2020 (std_mask std_at_home = $instruments_NT) $demeaned_controls [aweight=county_population], gmm fe i(state_fe) cluster(state) first
outreg2 using COVID_Table3b, se bdec(2) rdec(2) word append


****Hausman Tests on IV estimations:
xi: reg cases_per_100k mask std_at_home $demeaned_controls i.state_fe  
estimates store OLS
xtivreg2 cases_per_100k (mask std_at_home = $instruments) $demeaned_controls, fe i(state_fe) 
estimates store IV
hausman IV OLS
*reject OLS efficiency at p<0.01

xi: reg deaths_per_100k mask std_at_home $demeaned_controls i.state_fe  
estimates store OLS
xtivreg2 deaths_per_100k (mask std_at_home = $instruments) $demeaned_controls, fe i(state_fe) 
estimates store IV
hausman IV OLS
*reject OLS efficiency at p<0.01

xi: reg cases_per_100k mask std_at_home pct_trump2020  $demeaned_controls i.state_fe  
estimates store OLS
xtivreg2 cases_per_100k pct_trump2020 (mask std_at_home = $instruments_NT) $demeaned_controls, fe i(state_fe) 
estimates store IV
hausman IV OLS
*reject OLS efficiency at p<0.07


xi: reg deaths_per_100k mask std_at_home pct_trump2020 $demeaned_controls i.state_fe  
estimates store OLS
xtivreg2 deaths_per_100k pct_trump2020 (mask std_at_home = $instruments_NT) $demeaned_controls, fe i(state_fe) 
estimates store IV
hausman IV OLS
*does not reject OLS efficiency

*standardized mask-wearing yields same results on tests

*Hausman tests rejects null of OLS efficiency in all cases at p < 0.01



******Scatter Plots with estimated variables (Actually create the graphs in R) *****

scatter mask pct_trump2020

capture drop y mask_hat
xi: quietly reg mask pct_trump2020 $controls i.state_fe [aweight=county_population], cluster(state)
capture drop y_hat
predict y_hat
ren y_hat mask_hat
scatter cases_per_100k mask_hat
capture drop y_hat

scatter cases_per_100k pct_trump2020 
scatter deaths_per_100k pct_trump2020 



***Choose controls through LASSO: Does LASSO retain all the controls?
*Using Cross-Validation for selection:
cvlasso deaths_per_100k  pct_trump2020 $demeaned_controls, seed(123) lopt notpen(pct_trump2020) alpha(1) nfolds(10)
*all controls are retained.



***Oster Bounds Tests
xi: reg cases_per_100k pct_trump2020 $demeaned_controls i.state_fe [aweight=county_population], cluster(state) 
psacalc delta pct_trump2020, rmax(1) 
* Oster's deta = 4.35

xi: reg deaths_per_100k  pct_trump2020 $demeaned_controls i.state_fe [aweight=county_population], cluster(state) 
psacalc delta pct_trump2020, rmax(1) 
*Oster's delta is negative (-2.02)--coefficient is higher with controls than without--little sign of endogeneity.

xi: reg mask pct_trump2020 $demeaned_controls i.state_fe [aweight=county_population], cluster(state) 
psacalc delta pct_trump2020, rmax(1) 
* Oster's deta = 1.25

xi: reg std_at_home pct_trump2020 $demeaned_controls i.state_fe [aweight=county_population], cluster(state) 
psacalc delta pct_trump2020, rmax(1) 
* Oster's deta = 2.03

xi: reg std_C19Safe_Index pct_trump2020 $demeaned_controls i.state_fe [aweight=county_population], cluster(state) 
psacalc delta pct_trump2020, rmax(1) 
* Oster's deta = 1.78



***Spatially Correlated Standard Errors:
*correcting for spatial autocorrelation seems to make no difference in Table 1 & 2 estimates

*Table 1:
acreg mask pct_trump2020 $demeaned_controls $interacted_controls , spatial pfe1(state_fe) latitude(county_lat) longitude(county_lon) dist(500) bartlett
acreg std_at_home  pct_trump2020 $demeaned_controls $interacted_controls , spatial pfe1(state_fe) latitude(county_lat) longitude(county_lon) dist(500) bartlett
acreg std_C19Safe_Index  pct_trump2020 $demeaned_controls $interacted_controls , spatial pfe1(state_fe) latitude(county_lat) longitude(county_lon) dist(500) bartlett

acreg mask pct_trump2020 gunownership state_inctax_rate abort_clinics_permillion $demeaned_controls $interacted_controls , spatial latitude(state_lat) longitude(state_lon) dist(500) bartlett
acreg std_at_home pct_trump2020 gunownership state_inctax_rate abort_clinics_permillion $demeaned_controls $interacted_controls , spatial latitude(state_lat) longitude(state_lon) dist(500) bartlett
acreg std_C19Safe_Index pct_trump2020 gunownership state_inctax_rate abort_clinics_permillion $demeaned_controls $interacted_controls , spatial latitude(state_lat) longitude(state_lon) dist(500) bartlett
*results are essentially unchanged from the results obtained using se's clustered at the state level.

*Table 2:
acreg cases_per_100k  pct_trump2020 $demeaned_controls $interacted_controls , spatial pfe1(state_fe) latitude(county_lat) longitude(county_lon) dist(500) bartlett
acreg deaths_per_100k  pct_trump2020 $demeaned_controls $interacted_controls , spatial pfe1(state_fe) latitude(county_lat) longitude(county_lon) dist(500) bartlett

acreg cases_per_100k pct_trump2020 gunownership state_inctax_rate abort_clinics_permillion $demeaned_controls $interacted_controls , spatial latitude(state_lat) longitude(state_lon) dist(500) bartlett
acreg deaths_per_100k pct_trump2020 gunownership state_inctax_rate abort_clinics_permillion $demeaned_controls $interacted_controls , spatial latitude(state_lat) longitude(state_lon) dist(500) bartlett
*results don't change fundamentally at all--some weakening of significance of abortion variable, but in line with main hypothesis.

*Table 3:
*reduced form (endogenous):
acreg cases_per_100k mask $demeaned_controls $interacted_controls , spatial pfe1(state_fe) latitude(county_lat) longitude(county_lon) dist(500) bartlett
acreg cases_per_100k std_at_home $demeaned_controls $interacted_controls , spatial pfe1(state_fe) latitude(county_lat) longitude(county_lon) dist(500) bartlett

*IVs:
acreg cases_per_100k (mask = $instruments ) $controls , spatial pfe1(state_fe) latitude(county_lat) longitude(county_lon) dist(500) bartlett
acreg deaths_per_100k (mask  = $instruments ) $controls , spatial pfe1(state_fe) latitude(county_lat) longitude(county_lon) dist(500) bartlett

acreg cases_per_100k (std_at_home = $instruments ) $controls , spatial pfe1(state_fe) latitude(county_lat) longitude(county_lon) dist(500) bartlett
acreg deaths_per_100k (std_at_home = $instruments ) $controls , spatial pfe1(state_fe) latitude(county_lat) longitude(county_lon) dist(500) bartlett

acreg cases_per_100k (mask std_at_home = $instruments ) $controls , spatial pfe1(state_fe) latitude(county_lat) longitude(county_lon) dist(500) bartlett
acreg deaths_per_100k (mask std_at_home = $instruments ) $controls , spatial pfe1(state_fe) latitude(county_lat) longitude(county_lon) dist(500) bartlett
*same basic results as before--sheltering at home somewhat stronger than before.



