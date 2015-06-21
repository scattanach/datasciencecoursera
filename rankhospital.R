# Takes three arguments: the 2-character abbreviated name of a
# state (state), an outcome (outcome), and the ranking of a hospital in that state for that outcome (num).
# The function reads the outcome-of-care-measures.csv file and returns a character vector with the name
# of the hospital that has the ranking specified by the num argument.

rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  
  ## Read outcome data 
  MyData <- read.csv("G:/pictures/Coursera/datasciencecoursera/ProgAssignment3/outcome-of-care-measures.csv", 
                     colClasses = "character")
  
  ## Check that state and outcome are valid
  
  MyData<-subset(MyData, State==state)
  
  nr <- nrow(MyData)
  
  if (nr == 0)
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
  
  MyData <- MyData[ order(MyData[,cnum], MyData[,2]), ]
  
  MyData <- subset(MyData[, c(2, cnum)] , !is.na(MyData[, c(cnum)]))
  
  nr <- nrow(MyData)
  
  # handle best/worst/too large
  if(num == "best")
    num <- 1
  else if (num == "worst")
    num <- nr 
  
  MyData[num, 1]
  #as.vector(MyData[nr, 1]) 
}

# rankhospital("TX", "heart failure", 4)
# rankhospital("MD", "heart attack", "worst")
# rankhospital("MN", "heart attack", 5000)
