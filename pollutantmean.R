pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  ## NOTE: Do not round the result!
  
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
  #if (pollutant == 's')
    MyData <-subset(MyData, ids)[, pollutant]
  #else
  #  MyData <-subset(MyData, ids)[, 'nitrate']
  
  mean(MyData, na.rm=TRUE)
}


