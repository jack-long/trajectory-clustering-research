# Process all the files located at inDir and return in outDir
# one clustered file per input file and a davies bouldin file
# containing the number of clusters used at K-Means for each
# input file plus the davies boulding number obtained.
library(clusterSim)
source(file = "getDBSCAN.R")
calculateDBSCAN<-function(inDir,outDir)
{
  fileList = list.files(path = inDir)
  fileList = fileList[1:5] # use only first 5 files
  
  bestDBVector = numeric(length(fileList)) #Create DB vector
  clusterNumberVector = numeric(length(fileList)) #Create number of used clusters vector
  
  for (i in 1:length(fileList))
  {
    inFilePath = paste(inDir,fileList[i],sep = '')
    outFilePath = paste(outDir,fileList[i],sep = '')
    
    assign(fileList[i], read.csv(inFilePath)) # Open file
    
    #CHANGE NUMBER OF CLUSTERS TO TRY TO 10!!!!!!!!!!!!!!!!!!!!!!!
    KM = getKM(get(fileList[i]),2) # Obtain best cluster for file i
    
    # Save cluster to file in output directory
    cluster = cbind(get(fileList[i])[1:2],KM$cluster$cluster);
    colnames(cluster) <- c("latitude", "longitude", "cluster")
    write.table(cluster,file = outFilePath,sep = ",", row.names = FALSE, col.names = FALSE)
    
    # Save Davies-Bouldin info
    bestDBVector[i] = KM$DB
    clusterNumberVector[i] = KM$clusterNumber
    
    # remove file from memory
    #rm(list = fileList[i]) #Remove the object to free memory
  }
  
  # Save Davies-Bouldin info to output dir with filename 'DBinfo'
  DBInfo = cbind(bestDBVector,clusterNumberVector);
  colnames(DBInfo) <- c("DBValues", "clusterNumber")
  write.table(DBInfo,file = paste(outDir,"DBInfo",sep = ''),sep = ",", row.names = FALSE, col.names = FALSE)
}