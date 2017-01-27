setwd("/Users/Desktop/free") ## set your work directory
dat <- read.csv("Inter.csv") ## the original data set
data<-dat[,3:82]
data<-data[1:13,]

##function to generate transient matrix for each intersection
transition_matrix_function<-function(c){
transition_matrix<-matrix(0,nrow=16,ncol=16)
##[a,b], C is the row number
fraction_caculation<-function(a,b){
total=0
counter<-matrix(0,nrow=1,ncol=4)
n<-(ncol(df)-2)
for(i in 1:n){
  if ((df[c,i]==a) && (df[c,i+1]==b)){
     total=total+1
     if(df[c,i+2]==1)
     {
       counter[,1]=counter[,1]+1
     }
    else if(df[c,i+2]==2)
     {
      counter[,2]=counter[,2]+1
    }
     else if(df[c,i+2]==3)
     {
       counter[,3]=counter[,3]+1
     }
     else
     {
       counter[,4]=counter[,4]+1
     }
     
  }
}
fraction<-matrix(0,nrow=1,ncol=4)
for(i in 1:4){
  fraction[1,i]<-counter[1,i]/total
}
return(fraction)
}

for(i in 1:4)
{
  for (j in 1:4) {
    fraction_1<-fraction_caculation(i,j)
    ##recall fraction matrix caculation for creating transition matrix
    transition_matrix[(i-1)*4+j,(j*4-3):(j*4)]<-fraction_1[1,1:4]
  }
}
for (i in 1:nrow(transition_matrix)) 
  {
  for(j in 1:ncol(transition_matrix))
    {
    if(transition_matrix[i,j]== 'NaN')## transfer NaN to 0
      {
      transition_matrix[i,j]<-0 
    }
  }
}
return(transition_matrix)
}
##Transition Matrix simplify
##function for out simplified transition matrix
transitionsimple<-function(d,output){
transition<-transition_matrix_function(d)
transition_matrix<-data.frame(transition)
colnames(transition_matrix)<-c("E=1,E=1","E=1,E=2","E=1,E=3","E=1,E=4+","E=2,E=1","E=2,E=2","E=2,E=3","E=2,E=4+",
                               "E=3,E=1","E=3,E=2","E=3,E=3","E=3,E=4+","E=4+,E=1","E=4+,E=2","E=4+,E=3","E=4+,E=4")
rownames(transition_matrix)<-c("E=1,E=1","E=1,E=2","E=1,E=3","E=1,E=4+","E=2,E=1","E=2,E=2","E=2,E=3","E=2,E=4+",
                               "E=3,E=1","E=3,E=2","E=3,E=3","E=3,E=4+","E=4+,E=1","E=4+,E=2","E=4+,E=3","E=4+,E=4+")
transition_simple<-subset(transition_matrix,rowSums(transition_matrix)!=0)
transition_simple<-transition_simple[,colSums(transition_simple)!=0]
write.csv(transition_simple,file = output)
}

## east
 ##convert all number >=4 into 4
east<-matrix(0,nrow=nrow(data),ncol=(ncol(data)/2))
j=1
while(j<=80)
{
  east[,(j+1)/2]<-data[,j]
  j=j+2
}
for(i in 1:nrow(east))
{
  for(j in 1:ncol(east)){
    if(east[i,j]>=4){
      east[i,j]=4
    }
  }
}

df<-east
#outputdata
transitionsimple(1,"./east/east_1to2.csv") 
transitionsimple(2,"./east/east_2to3.csv")
transitionsimple(3,"./east/east_3toL.csv")
transitionsimple(4,"./east/east_LtoP.csv")
transitionsimple(5,"./east/east_PtoM.csv")
transitionsimple(6,"./east/east_Mto5.csv")
transitionsimple(7,"./east/east_5to6.csv")
transitionsimple(8,"./east/east_6to7.csv")
transitionsimple(9,"./east/east_7to8.csv")
transitionsimple(10,"./east/east_8to9.csv")
transitionsimple(11,"./east/east_9to10.csv")
transitionsimple(12,"./east/east_10to11.csv")
transitionsimple(13,"./east/east_11to12.csv")


##west
 ##convert all number >=4 into 4
west<-matrix(0,nrow=nrow(data),ncol=40)
j=2
while(j<=80)
{
  west[,j/2]<-data[,j]
  j=j+2
}
for(i in 1:nrow(west))
{
  for(j in 1:ncol(west)){
    if(west[i,j]>=4){
      west[i,j]=4
    }
  }
}

df<-west
transitionsimple(1,"./west/west_1to2.csv")
transitionsimple(2,"./west/west_2to3.csv")
transitionsimple(3,"./west/west_3toL.csv")
transitionsimple(4,"./west/west_LtoP.csv")
transitionsimple(5,"./west/west_PtoM.csv")
transitionsimple(6,"./west/west_Mto5.csv")
transitionsimple(7,"./west/west_5to6.csv")
transitionsimple(8,"./west/west_6to7.csv")
transitionsimple(9,"./west/west_7to8.csv")
transitionsimple(10,"./west/west_8to9.csv")
transitionsimple(11,"./west/west_9to10.csv")
transitionsimple(12,"./west/west_10to11.csv")
transitionsimple(13,"./west/west_11to12.csv")