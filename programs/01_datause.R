
# Author: Lars Vilhuber 
# This uses Stata data from a previous run and merges it in R

housing <- read.dta("/home/vilhuber/Workspace/git/LDI/test-part-1-2/data/other/housing.dta")
person <- read.dta("/home/vilhuber/Workspace/git/LDI/test-part-1-2/data/other/person.dta")
merged <- left_join(housing,person,by="serialno") %>%
       select(pweight,race2,race1,numrace) %>%
       mutate(specific_ak=(race2 == "31" | race2 == "32" | race2 == "33" | race2 == "34")) %>%
       mutate(pweight_num = as.numeric(pweight))
write.dta(merged, "/home/vilhuber/Workspace/git/LDI/test-part-1-2/data/cleaned/merged.dta", version=12)

