library(fpc)
getDBSCAN<-function(data) #data is the list of GPS coordinates, N is the MAX number of clusters to apply kmeans
{
  bestDBSCAN = dbscan(data, eps, MinPts = 10, scale = FALSE, method = "dist", seeds = TRUE, showplot = 1, countmode = NULL)
  #Claculate Davies Bouldin
  bestDB = index.DB(data,bestDBSCAN$cluster)
  
  "bestDB = 999
  for(i in 2:N)
  {
    #Calculate Kmeans for i
    set.seed(38)
    km = suppressWarnings( kmeans(data,i,nstart = 25))
    
    #Claculate Davies Bouldin
    db = index.DB(data,km$cluster)
    
    if (db$DB < bestDB)
    {
      bestKM = km  
      bestDB = db$DB
      clusterNumber = i
    }
  }"
  resultList = list("cluster" = bestDBSCAN, "DB" = bestDB)
  return(resultList)
}