rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. 
cat("\f") # clear console when working in RStudio

# ---- load-packages -----------------------------------------------------------
library(haven)
library(psych)
library(tidyverse)
library(epiDisplay)

# ---- declare-globals ---------------------------------------------------------
# Assigns file path to path_input
path_input1 <- ("./data/derived/DIDSFinal_35i.sav")

# ---- load-data ---------------------------------------------------------------
# reads the path input
ds2 <- haven::read_sav(path_input1)

# View column names
names(ds2) 

# ---- creating sum score ------------------------------------------

ds2 <- ds2 |> dplyr::mutate(
  dids_S1 = (r30e + r47i  +  r51i + a7i  + a1i   + a67i  + e76m + e98m  + r56i + 
             a22i + a69i  +  r50i + r52i + e86a  + a28i  + a131 + e100a + a11i +
             e91f + a26ee + e88a  + r66i + a2i   + e80a  + e93s + e77m  + r62i +
             e82m + r61i  +  e85s + a68i + e102m + a74ee + r54i + a72ee),
  
  dids_M1 = (r30e + r47i  + r51i + a7i  + a1i   + a67i  + e76m + e98m  + r56i +
             a22i + a69i  + r50i + r52i + e86a  + a28i  + a131 + e100a + a11i +
             e91f + a26ee + e88a + r66i + a2i   + e80a  + e93s + e77m  + r62i +
             e82m + r61i  + e85s + a68i + e102m + a74ee + r54i + a72ee)/35,
  
  dids_S = (dids_S1 - 35), # making 0 a meaning value
  dids_M = (dids_M1 - 1)   # making 0 a meaning value
)

# select variables

ds3 <- ds2 |> dplyr::select(
  dids_S, dids_M)

# descriptive table
descriptive  <- psych::describe(ds3)

sum_dids     <- ds3$dids_S   
percentiles1 <- quantile(sum_dids, c(.25, .50, .75)) # 25% increments 
percentiles2 <- quantile(sum_dids, prob = seq(0, 1, length = 11), type = 5) # 10% increments

# Plot
epiDisplay::tab1(ds3$dids_S, main = "Sum DIDS", cum.percent = TRUE, missing = FALSE)
epiDisplay::tab1(ds3$dids_M, main = "Sum DIDS", cum.percent = TRUE, missing = FALSE)

# ---- Write to Disk --------------------------------------------------------------

# write descriptives to csv file
write.csv(descriptive, file = "./output/measure/Descriptive_DIDS.csv", row.names = TRUE)

# write OMEGA to text file
capture.output(percentiles1, file = "./output/measure/Percentile1.txt")
capture.output(percentiles2, file = "./output/measure/Percentile2.txt")
