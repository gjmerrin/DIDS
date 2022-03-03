rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. 
cat("\f") # clear console when working in RStudio

# ---- load-packages -----------------------------------------------------------
library(haven)
library(mokken)
library(psych)

# ---- declare-globals ---------------------------------------------------------
# Assigns file path to path_input
path_input <- ("./data/derived/DIDSFinal_37i.sav")

# ---- load-data ---------------------------------------------------------------
# reads the path input
ds0 <- haven::read_sav(path_input)

# View column names
names(ds0) 

# descriptive table
descriptive37 <- psych::describe(ds0)

# ---- Automated Item Selection Procedure ----------------------------------------
AISP <- mokken::aisp(ds0)

# ---- Scalability Coefficients H -----------------------------------------------
COEFH <- mokken::coefH(ds0)
COEFH$Hij
COEFH$Hi
COEFH$H

# ---- Check of Invariant Item Ordering ----------------------------------------
iio_results <- mokken::check.iio(ds0, method = "MS-CPM")
iio_summary <- summary(iio_results)
iio_results$HT

# Plot Invariant Item Ordering
monotonicity_results <- iio_results
# plot(monotonicity_results)

# ---- Check of Monotonicity -----------------------------------------------------
pmatrix_results <- mokken::check.monotonicity(ds0)
pmatrix_results_summary <- summary(pmatrix_results)
# plot(pmatrix_results)

# ---- Computation of reliability statistics --------------------------------------
reliability <- mokken::check.reliability(ds0)

# ---- Write to Disk --------------------------------------------------------------
# write descriptives to csv file
write.csv(descriptive37, file = "./output/37-items/Descriptive37.csv", row.names = TRUE)

# write OMEGA to text file
capture.output(COEFH,                   file = "./output/37-items/COEFH.txt")
capture.output(iio_results,             file = "./output/37-items/iio_results.txt")
capture.output(iio_summary,             file = "./output/37-items/iio_summary.txt")
capture.output(monotonicity_results,    file = "./output/37-items/monotonicity_results.txt")
capture.output(pmatrix_results,         file = "./output/37-items/pmatrix_results.txt")
capture.output(pmatrix_results_summary, file = "./output/37-items/pmatrix_results_summary.txt")
capture.output(reliability,             file = "./output/37-items/reliability.txt")


