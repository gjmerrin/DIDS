rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. 
cat("\f") # clear console when working in RStudio

# ---- load-packages -----------------------------------------------------------
library(haven)
library(mokken)
library(psych)

# ---- declare-globals ---------------------------------------------------------
# Assigns file path to path_input
path_input1 <- ("./data/derived/DIDSFinal_35i.sav")

# ---- load-data ---------------------------------------------------------------
# reads the path input
ds1 <- haven::read_sav(path_input1)

# View column names
names(ds1) 

# descriptive table
descriptive35 <- psych::describe(ds1)

# ---- Automated Item Selection Procedure ----------------------------------------
AISP1 <- mokken::aisp(ds1)

# ---- Scalability Coefficients H -----------------------------------------------
COEFH1 <- mokken::coefH(ds1)
COEFH1$Hij
COEFH1$Hi
COEFH1$H

# ---- Check of Invariant Item Ordering ----------------------------------------
iio_results1 <- mokken::check.iio(ds1, method = "MS-CPM")
iio_summary1 <- summary(iio_results1)
iio_results1$HT

# Plot Invariant Item Ordering
monotonicity_results1 <- iio_results1
# plot(monotonicity_results)

# ---- Check of Monotonicity -----------------------------------------------------
pmatrix_results1 <- check.monotonicity(ds1)
pmatrix_results_summary1 <- summary(pmatrix_results1)
# plot(pmatrix_results)

# ---- Computation of reliability statistics --------------------------------------
reliability1 <- check.reliability(ds1)

# ---- Write to Disk --------------------------------------------------------------

# write descriptive to csv file
write.csv(descriptive35, file = "./output/35-items/Descriptive35.csv", row.names = TRUE)

# write OMEGA to text file
capture.output(COEFH1,                   file = "./output/35-items/COEFH.txt")
capture.output(iio_results1,             file = "./output/35-items/iio_results.txt")
capture.output(iio_summary1,             file = "./output/35-items/iio_summary.txt")
capture.output(monotonicity_results1,    file = "./output/35-items/monotonicity_results.txt")
capture.output(pmatrix_results1,         file = "./output/35-items/pmatrix_results.txt")
capture.output(pmatrix_results_summary1, file = "./output/35-items/pmatrix_results_summary.txt")
capture.output(reliability1,             file = "./output/35-items/reliability.txt")

