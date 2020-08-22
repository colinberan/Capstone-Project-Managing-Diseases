rm(list=ls()); gc()
setwd('C:/Users/waahw/Downloads/Phase1Deliverables_Group8')
student_dat = read.csv('R_StudentData_Cleaned_Sample.csv', head=T, stringsAsFactors=F) 

#file use to store avg data (total exemptions normalized) by county
AVG_EXEMP_NORM_COUNTIES <- unique(student_dat[,3:4])
colnames(AVG_EXEMP_NORM_COUNTIES)<- c("COUNTY","size_of_county")


for (i in 2006:2015){
  
  
  ##obtain all data from 2006 to 2015 and save to student_dat_loop 
  student_dat_loop <- student_dat[which(student_dat$year==i),]
  ##summary of means 
  agg_mean_per_county_loop <- aggregate(student_dat_loop$total_exemptions_normalized,by=list(student_dat_loop$COUNTY),FUN=mean)
  colnames(agg_mean_per_county_loop) <- c("COUNTY", sprintf("AVG in %d",i))
  
  ##Merge all the averages from 2006 to 2015
  AVG_EXEMP_NORM_COUNTIES <- merge(x=AVG_EXEMP_NORM_COUNTIES,y=agg_mean_per_county_loop,by="COUNTY",all=TRUE)
  
}

write.csv(AVG_EXEMP_NORM_COUNTIES, "AVG_EXEMP_NORM_COUNTIES_FROM_R.csv", na = "", row.names = FALSE)
