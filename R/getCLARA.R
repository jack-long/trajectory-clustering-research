getCLARA<-function(data,N) #data is the list of GPS coordinates, N is the MAX number of clusters to apply kmeans
{
  bestDB = 999
  for(i in 2:N)
  {
    #Calculate Kmeans for i
    set.seed(38)
    km = suppressWarnings( clara(data,i))
    
    #Claculate Davies Bouldin
    db = index.DB(data,km$clustering)
    
    if (db$DB < bestDB)
      {
      bestKM = km  
      bestDB = db$DB
      clusterNumber = i
      }
  }
  resultList = list("cluster" = bestKM, "DB" = bestDB, "clusterNumber"=clusterNumber)
  return(resultList)
}