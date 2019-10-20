rm(list=ls())

#library(tidyverse)
library(gganimate)
#library(MASS)
#install.packages("reshape")
library(reshape)

n<-1000

cow_share_2008<-97
almond_share_2008<-1
soy_share_2008<-1
other_share_2008<-1

cow_share_2016<-92
almond_share_2016<-5
soy_share_2016<-2
other_share_2016<-1

y2008<-c(rnorm(n=n*(other_share_2008/100),mean=25,1),
         rnorm(n=n*(almond_share_2008/100),mean=75,1),
         rnorm(n=n*(cow_share_2008/100),mean=100,1),
         rnorm(n=n*(soy_share_2008/100),mean=50,1)
         )
y2016<-c(rnorm(n=n*(other_share_2016/100),mean=25,1),
         rnorm(n=n*(almond_share_2016/100),mean=75,1),
         rnorm(n=n*(cow_share_2016/100),mean=100,1),
         rnorm(n=n*(soy_share_2016/100),mean=50,1))

cbind.data.frame(y2008,y2016)
dat1<-melt(cbind.data.frame(y2008,y2016))
dat1
dat1$variable=parse_number(as.character(dat1$variable))
half<-length(dat1$variable)/2
half
dat1$x1[dat1$variable==2008]<-rnorm(half,2000,1)
dat1$x1[dat1$variable==2016]<-rnorm(half,2024,1)
head(dat1)
colnames(dat1)<-c("z1","y1","x1")
dat0<-data.frame(dat1)
dat0

anim<-ggplot(dat0)+
  geom_point(aes(x1,y1))+
  #xlim(1995,2029)+ylim(0,120)+
  annotate(geom="label",fill="white",x=2000,y=25,label="Other (1%)")+
  annotate(geom="label",fill="white",x=2000,y=75,label="Almond (1%)")+
  annotate(geom="label",fill="white",x=2000,y=50,label="Soy (1%)")+
  annotate(geom="label",fill="white",x=2000,y=100,label="Cow (97%)")+
  annotate(geom="label",fill="white",x=2024,y=25,label="Other (1%)")+
  annotate(geom="label",fill="white",x=2024,y=75,label="Almond (5%)")+
  annotate(geom="label",fill="white",x=2024,y=50,label="Soy (2%)")+
  annotate(geom="label",fill="white",x=2024,y=100,label="Cow (92%)")+
  annotate(geom="text",x=2000,y=108,label="2008",colour="red",fontface="bold",size=4)+
  annotate(geom="text",x=2024,y=108,label="2016",colour="red",fontface="bold",size=4)+
  annotate("rect",xmin=2003,xmax=2021,
           ymin=20,ymax=110,alpha=0.2,
           color="black")+
  labs(title="1000 consumers of milk & substitutes",caption="Simulated using Badruddoza, Carlson, and McCluskey 2019") +
  theme(plot.title=element_text(family="Times", face="bold", size=20))+
  theme_void()+
  transition_states(z1,wrap=FALSE)+ #set wrap=TRUE if animation is bidirectional
  enter_fade()+exit_fade()
animate(anim,nframes=100,end_pause=0,rewind=FALSE)