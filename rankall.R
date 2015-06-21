# takes two arguments: an outcome name (outcome) and a hospital ranking
# (num). The function reads the outcome-of-care-measures.csv file and returns a 2-column data frame
# containing the hospital in each state that has the ranking specified in num. For example the function call
# rankall("heart attack", "best") would return a data frame containing the names of the hospitals that
# are the best in their respective states for 30-day heart attack death rates. The function should return a value
# for every state (some may be NA). The first column in the data frame is named hospital, which contains
# the hospital name, and the second column is named state, which contains the 2-character abbreviation for
# the state name. Hospitals that do not have data on a particular outcome should be excluded from the set of
# hospitals when deciding the rankings.

rankall <- function(outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  
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
  
  
  MyData <- read.csv("G:/pictures/Coursera/datasciencecoursera/ProgAssignment3/outcome-of-care-measures.csv", 
                     colClasses = "character")
  
  MyData[, cnum] <- suppressWarnings(as.numeric(MyData[, cnum]))
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  MyData <- MyData[ order(MyData[,7], MyData[,cnum], MyData[,2]), ]
  
  MyData <- subset(MyData[, c(7, 2, cnum)] , !is.na(MyData[, c(cnum)]))
  
  EmptyData <- subset(MyData[, c(2, 1)], MyData[, c(1)] == "xx")
  
  MyData <- split(MyData, MyData$State)
  
  for(i in MyData) {
    # handle best/worst/too large
    if(num == "best")
      nr <- 1
    else if (num == "worst")
      nr <- nrow(i)
    else
      nr <- num
    
    if (nr > nrow(i)) {
      i[1, c(2)] <- '<NA>'
      #print(i[1, c(1, 2, 1)])
      EmptyData <- merge(EmptyData, i[1, c(2, 1)], all.x = TRUE, all.y = TRUE)
    }
    else {
      #print(i[nr, c(1, 2, 1)])
      EmptyData <- merge(EmptyData, i[nr, c(2, 1)], all.x = TRUE, all.y = TRUE)
    }
  }
  # change column headings
  names(EmptyData) <- c("hospital", "state")
  EmptyData
}
# head(rankall("heart attack", 20), 10)
#  tail(rankall("pneumonia", "worst"), 3)
#  tail(rankall("heart failure"), 10)