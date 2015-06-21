corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
  
  files <- list.files(directory, pattern="*.csv", full.names=TRUE)
  listOfFiles <- lapply(files, function(x) read.csv(x, header = TRUE)) 
  listOfFiles <- lapply(listOfFiles, function(z) z[c('Date','sulfate','nitrate','ID')])
  
  listOfFiles <- lapply(listOfFiles, function(z) subset(z, complete.cases(z)))
   
  RawData <- Reduce(function(x,y) {merge(x,y, by = intersect(names(x), names(y)), all.x = TRUE, all.y = TRUE)},
                listOfFiles)
  
  MyData <- aggregate(RawData$ID, by=list(Category=RawData$ID), FUN=length)
  
  MyData <- subset(MyData, x > threshold)
  
  v <- as.vector(MyData$Category) 
  RawData <- subset(RawData, RawData$ID %in% v)
  #cor(RawData[, 2:3])
  #cor(RawData['sulfate'],RawData['nitrate'])
  res <- c()
  for (i in v) {
    MyData <- subset(RawData, RawData$ID == i)
    res <- c(res, (cor(MyData['sulfate'],MyData['nitrate'])[1,1]))
  }
  
  res
}




