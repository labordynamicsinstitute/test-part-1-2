/* $Id: 01_stata.do 1259 2014-12-10 14:37:31Z lv39 $ */
/* This file reads in Alaska PUMS data */
/* SRC: http://doi.org/10.3886/ICPSR13568.v1 */
/* Source program:  "ICPSR_13568/13568-Setup.do" was used
   as a template,  */
/* Author: Lars Vilhuber */


  clear
  infile using "/home/vilhuber/Workspace/git/LDI/test-part-1-2/programs/housing.dct" if rectype=="H", using ("/ramdisk/ICPSR_13568/DS0002/13568-0002-Data.txt")
  sort serialno   /* sort data by Serial Number */
  saveold "/home/vilhuber/Workspace/git/LDI/test-part-1-2/data/cleaned/housing.dta", version(12)  /* save housing unit data */

  clear
  infile using "/home/vilhuber/Workspace/git/LDI/test-part-1-2/programs/person.dct" if rectype=="P", using ("/ramdisk/ICPSR_13568/DS0002/13568-0002-Data.txt")
  sort serialno   /* sort data by Serial Number */
  saveold "/home/vilhuber/Workspace/git/LDI/test-part-1-2/data/cleaned/person.dta", version(12) /* save person data */

  merge serialno using "/home/vilhuber/Workspace/git/LDI/test-part-1-2/data/cleaned/housing.dta" /* merge person and housing unit data */
  drop _merge
  /* keep only relevant information */
  keep pweight race2 race1 numrace
  /* code a dummy to the four tribes */
  gen specific_ak=(race2 == "31" | race2 == "32" | race2 == "33" | race2 == "34")
  /* convert weights */
  destring pweight, gen(pweight_num)
  /* label variables */
  label variable specific_ak "Identifying with one of the four tribes"
  label variable pweight_num "Person weight"
  saveold "/home/vilhuber/Workspace/git/LDI/test-part-1-2/data/cleaned/merged.dta"  , version(12) /* save merged data */
  
  