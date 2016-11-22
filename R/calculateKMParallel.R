# Process all the files located at inDir and return in outDir
# one clustered file per input file and a davies bouldin file
# containing the number of clusters used at K-Means for each
# input file plus the davies boulding number obtained.
library(clusterSim)
library(foreach)
library(doMC)
registerDoMC(4)

source(file = "getKM.R")
calculateKM<-function(inDir,outDir)
{
  fileList = list.files(path = inDir)
   #fileList = fileList[1:7] # use only first 5 files

  caca<-foreach(i=1:length(fileList),.combine = rbind) %dopar%
    {
    inFilePath = paste(inDir,fileList[i],sep = '')
    outFilePath = paste(outDir,fileList[i],sep = '')
    
    assign(fileList[i], read.csv(inFilePath)) # Open file
    
    #CHANGE NUMBER OF CLUSTERS TO TRY TO 10!!!!!!!!!!!!!!!!!!!!!!!
    KM = getKM(get(fileList[i]),10) # Obtain best cluster for file i
    
    # Save cluster to file in output directory
    cluster = cbind(get(fileList[i])[1:2],KM$cluster$cluster);
    colnames(cluster) <- c("latitude", "longitude", "cluster")
    write.table(cluster,file = outFilePath,sep = ",", row.names = FALSE, col.names = FALSE)
    
    # return Davies-Bouldin info
    return(c(KM$DB, KM$clusterNumber))

    # remove file from memory
    #rm(list = fileList[i]) #Remove the object to free memory
  }
  
  # Save Davies-Bouldin info to output dir with filename 'DBinfo'
  colnames(caca) <- c("DBValues", "clusterNumber")
  write.table(caca,file = paste(outDir,"DBInfo",sep = ''),sep = ",", row.names = FALSE, col.names = FALSE)
}
