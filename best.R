# Takes two arguments: the 2-character abbreviated name of a state and an
# outcome name. The function reads the outcome-of-care-measures.csv file and returns a character vector
# with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specified outcome
# in that state. The hospital name is the name provided in the Hospital.Name variable. The outcomes can
# be one of "heart attack", "heart failure", or "pneumonia". Hospitals that do not  have data on a particular
#outcome should be excluded from the set of hospitals when deciding the rankings.

best <- function (state,  outcome) {
  
  ## Read outcome data 
  MyData <- read.csv("G:/pictures/Coursera/datasciencecoursera/ProgAssignment3/outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  
  MyData<-subset(MyData, State==state)
  
  if (nrow(MyData) == 0)
    stop("invalid state")
  
  cnum <- 0
  
  # The outcomes can be one of "heart attack", "heart failure", or "pneumonia".
  if(outcome == "heart attack")
    cnum <- 11
  else if(outcome == "heart failure")
    cnum <- 17
  else if(outcome == "pneumonia")
    cnum <- 23
  
  if (cnum == 0)
    stop("invalid outcome")
  
  MyData[, cnum] <- suppressWarnings(as.numeric(MyData[, cnum]))
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  MyData <- MyData[ order(MyData[,cnum], MyData[,2]), ]
  
  as.vector(MyData[1, 2]) 
  
}

# best("TX", "heart attack")
# best("TX", "heart failure")
# best("MD", "heart attack")
# best("MD", "pneumonia")
# best("BB", "heart attack")
# best("NY", "hert attack")

# best("TX", "heart failure")