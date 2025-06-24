/* This command loads the dataset from the specified file path. */ use "C:\Users\ADMIN\Desktop\Econ Stats 4.2\STA 432 - Applied Econometrics\STATA DATASETS\KHDS\KHDS\Dataset\KEPR8CDT\KEPR8CFL.DTA" 

/* creates an empty variable for respondent's age. */ gen age_respondent = . 
/* creates an empty variable for respondent's gender. */ gen sex = . 
/* creates an empty variable for household's COVID vaccination status. */ gen hh_vaccinated_covid = . 
/* creates an empty variable for agricultural land ownership status. */ gen owns_agri_land = . 
/* creates an empty variables for marital status categories. */ gen marital_status = . 
/* creates an empty variable for mobile money usage status. */ gen mobile_money_use = . 


/* replaces 'age_repondent' with values from hv105. */ replace age_respondent = hv105

/* replaces 'sex' with values from hv104. */ replace sex = hv104

/* ensures 1 represents 'male' and 2 represents 'female'. */ label define sex_lbl 1 "male" 2 "female"

/* define and assign labels for the 'sex' variable. */ label values sex sex_lbl

/* replaces 'marital_status' with values from hv115. */ replace marital_status = hv115

/* defines labels to clarify marital categories. */ label define marital_status_lbl 0 "never married" 1 "married" 3 "widowed" 4 "divorced" 5 "not living together"
/* defines and assigns labels for the 'marital_status' variable */ label values marital_status marital_status_lbl

/* replaces 'owns_agri_land' with values from hv244. */ replace owns_agri_land = hv244

/* ensures clear distinction between land ownership statuses. */ label define owns_agri_land_lbl 0 "no" 1 "yes"
/* defines and assigns label to the 'owns_agri_land' variable. */ label values owns_agri_land owns_agri_land_lbl

/* replaces 'mobile_money_use' with values from hv263. */ replace mobile_money_use = hv263

/* defines labels to clarify mobile money usage. */label define mobile_money_use_lbl 0 "no" 1 "yes"
/* defines and assigns labels for the 'mobile_money_use' variable. */ label values mobile_money_use mobile_money_use_lbl

/*replaces 'hh_vaccinated_covi' with values from sh135l. */ replace hh_vaccinated_covid = sh135l

/* Drop observations where 'marital_status' is missing to maintain data quality. */ drop if missing(marital_status)
/* Tabulate marital status to review its distribution, including missing values. */ tab marital_status, missing

/* Install the 'asdoc' package, which allows exporting Stata output to Word documents. */ ssc install asdoc

/* Create a directory called 'results' in the C: drive. This folder will store output files from the analysis. */ mkdir c:/results

/* Change the working directory to 'c:/results'. All saved files will be stored in this location. */ cd c:/results

/* Generate descriptive statistics (mean, standard deviation, etc.) for key variables. Export results to 'my results.doc' using asdoc. */ asdoc sum age_respondent sex hh_vaccinated_covid owns_agri_land marital_status mobile_money_use, save(my results.doc)

/* Create frequency tables for key categorical variables and save them in the document. */
asdoc tab age_respondent, save(my results.doc)
asdoc tab sex, save(my results.doc)
asdoc tab hh_vaccinated_covid, save(my results.doc)
asdoc tab owns_agri_land, save(my results.doc)
asdoc tab marital_status, save(my results.doc)
asdoc tab mobile_money_use, save(my results.doc)

/* Run logistic regression to estimate the effects of age, sex, and marital status on COVID-19 vaccination status. Export results to 'my results.doc'. */ asdoc logistic hh_vaccinated_covid age_respondent sex marital_status, save(my results.doc)

/* Run logistic regression for mobile money use with additional predictors, including agricultural land ownership.Export results to 'my results.doc'. */ asdoc logistic mobile_money_use age_respondent sex marital_status owns_agri_land, save(my results.doc)

/* Compute correlation matrices to analyze relationships between key variables. Export results to 'my results.doc'. */ 
asdoc corr hh_vaccinated_covid age_respondent sex marital_status, save(my results.doc)
asdoc corr mobile_money_use age_respondent sex marital_status owns_agri_land, save(my results.doc)

/* Generate a histogram of respondents' age distribution with a normal curve overlay. */ histogram age, normal
 
/* Export the age histogram to a PNG file for documentation. */ graph export "C:\Users\ADMIN\Desktop\Econ Stats 4.2\STA 432 - Applied Econometrics\STATA GROUP CAT ASSIGNMENT\age respondent histogram.png", as(png) replace

/* Create a bar graph to visualize marital status distribution.*/ graph bar, over( marital_status )

/* Export the marital status graph to a PNG file for documentation. */ graph export "C:\Users\ADMIN\Desktop\Econ Stats 4.2\STA 432 - Applied Econometrics\STATA GROUP CAT ASSIGNMENT\marital status graph.png", as(png) replace
