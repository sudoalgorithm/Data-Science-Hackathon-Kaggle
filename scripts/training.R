# This file is generated and can be overwritten.
# This is generated base on training.csv
suppressWarnings(library("v2viz"))
library(dplyr)
library(stringr)

refine_dataframe <-function(df) {
  df_new <- df %>% 
      mutate_all(funs(as.character)) %>%
      select(-`Financial_Year`) %>%
      select(-`Branch_Code`) %>%
      select(-`Donation_Date`) %>%
      filter(!is.na(`Row_ID`) & `Row_ID` != '') %>%
      mutate(`Row_ID` = as.integer(`Row_ID`)) %>%
      filter(!is.na(`Sequence_1`) & `Sequence_1` != '') %>%
      mutate(`Sequence_1` = as.double(`Sequence_1`)) %>%
      filter(!is.na(`Sequence_2`) & `Sequence_2` != '') %>%
      mutate(`Sequence_2` = as.double(`Sequence_2`)) %>%
      filter(!is.na(`Donor_Age`) & `Donor_Age` != '') %>%
      mutate(`Donor_Age` = as.integer(`Donor_Age`)) %>%
      filter(!is.na(`Gender`) & `Gender` != '') %>%
      mutate(`Gender` = stringr::str_replace_all(`Gender`, stringr::fixed("M"), "1")) %>%
      mutate(`Gender` = stringr::str_replace_all(`Gender`, stringr::fixed("F"), "2")) %>%
      mutate(`Gender` = as.double(`Gender`)) %>%
      mutate(`Gender` = as.integer(`Gender`)) %>%
      filter(!is.na(`Blood_Group_Code`) & `Blood_Group_Code` != '') %>%
      mutate(`Blood_Group_Code` = as.double(`Blood_Group_Code`)) %>%
      filter(!is.na(`Donor_Weight`) & `Donor_Weight` != '') %>%
      mutate(`Donor_Weight` = as.integer(`Donor_Weight`)) %>%
      mutate(`Donor_Temperature` = as.integer(`Donor_Temperature`)) %>%
      mutate(`Donor_Pulse` = stringr::str_replace_all(`Donor_Pulse`, stringr::fixed("789.0"), "78.0")) %>%
      mutate(`Donor_Pulse` = as.double(`Donor_Pulse`)) %>%
      mutate(`Donor_Hemoglobin` = stringr::str_replace_all(`Donor_Hemoglobin`, stringr::fixed("143.0"), "14.0")) %>%
      mutate(`Donor_Hemoglobin` = as.double(`Donor_Hemoglobin`)) %>%
      mutate(`Test_1` = as.double(`Test_1`)) %>%
      mutate(`Test_2` = as.double(`Test_2`)) %>%
      mutate(`Test_3` = stringr::str_replace_all(`Test_3`, stringr::fixed("N"), "1")) %>%
      mutate(`Test_4` = stringr::str_replace_all(`Test_4`, stringr::fixed("N"), "1")) %>%
      mutate(`Y` = as.integer(`Y`)) %>%
      mutate(`Test_3` = stringr::str_replace_all(`Test_3`, stringr::fixed("R"), "2")) %>%
      mutate(`Test_3` = as.integer(`Test_3`)) %>%
      mutate(`Test_4` = as.integer(`Test_4`)) 
  return (df_new)
}

# output file if NULL return df, otherwise, write to file 
refine_file <- function (input, output=NULL, overwrite="FALSE") { 
  if (is.na(overwrite)) { overwrite = "FALSE"}
  if (is.na(output)) { output = NULL}
  if(!file.exists(input)) { 
    return (paste(input, "file does not exist")); 
  } 
  if (!is.null(output) && file.exists(output) && !(overwrite == "TRUE")) { 
    return (paste(output, "already exists.")); 
  } 
  df <- read.csv(input, check.names=FALSE, stringsAsFactors=FALSE) 
  df <- refine_dataframe(df) 
  if (!is.null(output)) { 
    write.csv(df, file = output, row.names=FALSE) 
    return(paste("Writing to", output, "file is complete")) 
  } else { 
    return (df) 
  } 
}

# main entry for Rscript
args <- commandArgs(trailingOnly = TRUE)
opts<-c();
for (arg in args) {
   x <- lapply(strsplit(arg, split="="), trimws);
   opts[x[[1]][1]] <-x[[1]][2];
}
# validate
required <- c(opts['input']);
missingRequired <- any(is.na(required));
if (missingRequired) {
   print("Missing required parameter");
} else {
   refine_file(opts['input'], opts['output'], opts['overwrite']);
}
