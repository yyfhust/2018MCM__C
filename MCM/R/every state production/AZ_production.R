options(width=100)
knitr::opts_chunk$set(out.width='1000px',dpi=200,message=FALSE,warning=FALSE)

#load packages and csv file
library(ggplot2)
library(dplyr)
library(gridExtra)
library(grid)
library(choroplethr)
library(choroplethrMaps)
library(RColorBrewer)
library(knitr)

df<-read.csv('C:\\Users\\yyf\\Desktop\\MCM\\production.csv',sep=',')

calEnergies<-data.frame(df %>% dplyr::filter(StateCode=='TX'))
ggplot(data=calEnergies,aes(x=Year,y=introduction)) + 
  geom_tile(aes(fill = Data),colour = "white") + 
  theme(axis.title.y=element_blank(),axis.title.x=element_blank(),legend.position="right") + 
  scale_fill_gradientn(colours=rev(brewer.pal(11,'Spectral')))+
  labs(x="Year", y="State", title="Texas Energy Production")


