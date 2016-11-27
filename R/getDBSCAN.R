library(fpc)
library(clusterSim)
getDBSCAN<-function(data) #data is the list of GPS coordinates, N is the MAX number of clusters to apply kmeans
{
  #eps=0.002 old value. It merged the clusters because it is too big
  eps=0.002
  bestDBSCAN = suppressWarnings(fpc::dbscan(data, eps, MinPts = 5, scale = FALSE, method = "raw", seeds = TRUE, showplot = 1, countmode = NULL))
  #Claculate Davies Bouldin
  bestDB = index.DB(data,bestDBSCAN$cluster)
  bestDB = bestDB$DB
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