library(clusterSim)
processOPTICS<-function(rawDir,opticsDir,outDir)
{
  DBList = list()
  fileList = list.files(path = rawDir)
  
  for (i in 1:length(fileList))
  {
    #print(fileList[i])
    rawFilePath = paste(rawDir,fileList[i],sep = '')
    opticsFilePath = paste(opticsDir,fileList[i],sep = '')
    outFilePath = paste(outDir,fileList[i],sep = '')
    
    assign(fileList[i], read.csv(rawFilePath)) # Open file
    assign(paste(fileList[i],"final",sep=''), read.csv(opticsFilePath)) # Open file
    
    #Merge files and store result in outDir
    caca = cbind(get(fileList[i]), get(paste(fileList[i],"final",sep='')))
    write.table(caca,file = outFilePath,sep = ",", row.names = FALSE, col.names = FALSE)
    
    #Calculate DB for file i and append result to DBList
    #DBList has to columns, filename and DB value
    
    #if (fileList[i] != "072" & fileList[i] != "107")
    #{
      DBValue = clusterSim::index.DB(caca[1:2],caca[3])
      DBList = rbind(DBList, list(fileList[i],DBValue$DB))  
    #}else{
    #  DBList = rbind(DBList, list(fileList[i],0))  
    #}
    
    
  }
  #Write file DBInfo with DBList
  write.table(DBList,file = paste(outDir,"DBInfo",sep = ''),sep = ",", row.names = FALSE, col.names = FALSE)
  print(DBList[,2])
  return(mean(as.numeric(DBList[,2]),na.rm = TRUE))
}
