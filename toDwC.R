# Script for converting a survey by species contingency table into simple DwC 
# using a site by species matrix and survey description table
#
# Author: Vaughn M. Shirey

library(dplyr) # functions require dplyr

yukonSpecies <- read.table(text = "SurveyCode Boloria_polaris Boloria_chariclea Parnassius_eversmanni
                           AA_2019-07-13  1 2 0
                           AA_2019-08-13  1 1 3
                           BB_2019-08-13  2 4 4", header = TRUE, stringsAsFactors = FALSE)
yukonSurveys <- read.table(text = "SurveyCode  eventDate observer
                           AA_2019-07-13  07/13/2019  Green Team
                           AA_2019-08-13  08/13/2019  Blue Team
                           BB_2019-08-13  08/13/2019  Green Team", header = TRUE, stringsAsFactors = FALSE)

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
  
}

# Example usage:

newDwCData <- toSimpleDwC(surveyBySpecies = yukonSpecies, surveys = yukonSurveys)