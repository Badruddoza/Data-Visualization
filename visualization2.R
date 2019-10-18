library(tidyverse)
library(gganimate)
library(MASS)
library(reshape)

n<-100

cow_share_2008<-97
almond_share_2008<-1
soy_share_2008<-1
other_share_2008<-0

cow_share_2016<-92
almond_share_2016<-5
soy_share_2016<-2
other_share_2016<-1

for(i in c(2008,2016)){
cat("y",i,sep='')<-c(rnorm(n=n*(cat("cow_share_",i,sep="")/100),mean=100,1),
  rnorm(n=n*(cat("almond_share_",i,sep="")/100),mean=75,1),
  rnorm(n=n*(cat("soy_share_",i,sep="")/100),mean=50,1),
  rnorm(n=n*(cat("other_share_",i,sep="")/100),mean=25,1))
}

i=2008
eval(cat("cow_share_",i,sep=''))

a1 = "foo"
a2 = "bar"
a3 = "baz"
for (i in c(a1,a2,a3)) { cat(i) }


y2008<-mvrnorm(n=1,mu=c(100,75,50,25),Sigma=diag(4))
y2016<-mvrnorm(n=1,mu=c(100,75,50,25),Sigma=diag(4))
cbind.data.frame(y2008,y2016)
dat1<-melt(cbind.data.frame(y2008,y2016))
dat1$variable=parse_number(dat1$variable)
half<-length(dat1$variable)/2
dat1$x1[dat1$variable==2008]<-rnorm(half,1,1)
dat1$x1[dat1$variable==2016]<-rnorm(half,99,1)
colnames(dat1)<-c("z1","y1","x1")
dat0<-dat1
dat1

anim<-ggplot(dat0)+
  geom_point(aes(x1,y1))+
  xlim(-10,110)+ylim(-10,110)+
  theme_void()+
  transition_states(z1,wrap=FALSE)+ #set wrap=TRUE if animation is bidirectional
  enter_fade()+exit_fade()
animate(anim,rewind=FALSE)


y1<-c(100,100, 75,75, 50,50, 25,25)
x1<-c(1,99, 1,99, 1,99, 1,99)
z1<-c(2008,2016, 2008,2016, 2008,2016, 2008,2016)
dat0<-cbind.data.frame(x1,y1,z1)
dat0[order(dat0$y1,dat0$z1),]
