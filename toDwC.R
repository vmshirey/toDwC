# Script for converting a survey by species contingency table into simple DwC 
# using a site by species matrix and survey description table
#
# Author: Vaughn M. Shirey

library(dplyr) # functions may require dplyr

yukonSpecies <- read.table(text = "SurveyCode,Boloria polaris,Boloria chariclea,Parnassius eversmanni
                           AA_2019-07-13,1,2,0
                           AA_2019-08-13,1,1,3
                           BB_2019-08-13,2,4,4", header = TRUE, stringsAsFactors = FALSE, sep = ",")
yukonSurveys <- read.table(text = "SurveyCode,eventDate,observer
                           AA_2019-07-13,2019/07/13,Green Team
                           AA_2019-08-13,2019/08/13,Blue Team
                           BB_2019-08-13,2019/08/13,Green Team", header = TRUE, stringsAsFactors = FALSE, sep = ",")

toSimpleDwC <- function(surveyBySpecies, surveys, transect = FALSE, transectWidth = 0.0, gpsPoint = FALSE, gpsPointError = 0.0){
  
  # Accepts two data frames (surveyBySpecies, surveys) and several option paramters:
  #
  #   transect (boolean): specifies if these data are from transect-style surveys 
  #   transectWidth (double): transect width
  #   gpsPoint (boolean): specifies if a GPS point should be included with these data
  #   gpsPointError (double): GPS error radius
  #   
  # Converts a survey by species matrix and survey information into a simple DwC conforming dataframe
  # Returns the simple DwC conforming dataframe
  
  merged <- merge(x = surveyBySpecies, y = surveys, by = "SurveyCode")
  merged$eventDate <- as.Date(merged$eventDate, format="%Y/%m/%d") 
  dOutput <- data.frame(scientificName = character(0), eventDate = character(0), individualCount = numeric(0), stringsAsFactors = FALSE)
  
  print("Creating simple DwC records from matrix data...")
  
  for(i in 1:(nrow(surveyBySpecies))){
    
    for(j in 2:(ncol(surveyBySpecies))){
      
      # If occurrence count is non-zero, append a new occurrence record to the output dataframe
      if(merged[i,j] != 0){
        dOutput[nrow(dOutput) + 1,] = c(colnames(merged[j]), as.character(merged[i,]$eventDate), merged[i,j])
      }
    }
  }
  
  dOutput$scientificName <- gsub('.', ' ', dOutput$scientificName, fixed=TRUE)
  return(dOutput)
}

# Example usage:

newDwCData <- toSimpleDwC(surveyBySpecies = yukonSpecies, surveys = yukonSurveys)
newDwCData