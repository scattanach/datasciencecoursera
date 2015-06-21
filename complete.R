complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  fpattern <- ""
  for (i in id) {
    fn <- paste('000', i, sep = '')
    fn <- substr(fn,nchar(fn)-(3-1),nchar(fn))
    fn <- paste(fn, '.csv|', sep = '')
    fpattern <- paste(fpattern, fn, sep = '')
  }
  
  files <- list.files(directory, pattern=substr(fpattern, 1, nchar(fpattern) - 1), full.names=TRUE)
  listOfFiles <- lapply(files, function(x) read.csv(x, header = TRUE)) 
  listOfFiles <- lapply(listOfFiles, function(z) z[c('Date','sulfate','nitrate','ID')])
   
  MyData <- Reduce(function(x,y) {merge(x,y, by = intersect(names(x), names(y)), all.x = TRUE, all.y = TRUE)},
                listOfFiles)
  
  ids <- MyData$ID %in% id
  MyData <- subset(MyData, ids)
  ok <- complete.cases(MyData)
  MyData <- subset(MyData, ok)
  MyData <- aggregate(MyData$ID, by=list(Category=MyData$ID), FUN=length)
  names(MyData) <- c("id", "nobs")

  MyData[match(id, MyData$id),]
}



