# load packages
library(stringr)
library(lubridate)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(tidyr)
library(tidytext)
library(ggraph)
library(widyr)
library(wordcloud)
library(RColorBrewer)
library(knitr)
library(stats)
library(arm)
library(tidyverse)
library(dplyr)
library(lme4)
library(plotly)
library(sentimentr)
library(VGAM)
library(wesanderson)
library(rstanarm)
library(igraph)
library(tibble)
library(rjson)

# load data
df_tip <- read.csv("yelp_academic_dataset_tip.csv",header = T, stringsAsFactors = F)
df_business_attributes <- read.csv("yelp_academic_dataset_business.csv",header = T, stringsAsFactors = F)
checkin <- read.csv("yelp_academic_dataset_checkin.csv",header = T, stringsAsFactors = F)
review <- read.csv("yelp_academic_dataset_review.csv",header = T, stringsAsFactors = F)

###########################
#### Data Manipulation ####
###########################
business.id <- data.frame(unique(df_business_attributes$business_id))
a = data.frame(business.id[sample(nrow(business.id), 5775), ])
colnames(a) <- "business_id"

yelp.us <- left_join(a,review)
yelp.us <- na.omit(yelp.us)

tip <- df_tip%>%
  dplyr::select(-likes)

tip.us <- dplyr::left_join(a,tip)
tip.us <- na.omit(tip.us)

business.id <- data.frame(unique(yelp.us$business_id))
colnames(business.id) <- "business_id"

attr.us <- left_join(business.id,df_business_attributes,by="business_id")

# creat one single indicator for parking availability
attr.us$business.parking <- ifelse(attr.us$BusinessParking.garage==TRUE|attr.us$BusinessParking.street==TRUE|attr.us$BusinessParking.street==TRUE|attr.us$BusinessParking.validated==TRUE|attr.us$BusinessParking.lot==TRUE|attr.us$BusinessParking.valet==TRUE,1,0)

attr.us <- attr.us%>%
  select(business_id,RestaurantsPriceRange2,business.parking,BikeParking,NoiseLevel,RestaurantsGoodForGroups,RestaurantsDelivery,HasTV,WiFi,RestaurantsTakeOut,RestaurantsReservations,RestaurantsTableService)

# combine restaurants' attributes with their ratings
rating.us <- yelp.us %>%
  group_by(business_id)%>%
  arrange(date)%>%
  summarise(rating = mean(stars)) #average users' rating per restaurant

rating.us <- merge(rating.us,attr.us,by="business_id")

write.table(rating.us, file = "rating.csv",sep=',', row.names = F, col.names = T)

review.us <- dplyr::left_join(a,review)
review.us <- na.omit(review.us)

write.table(rating.us, file = "review.csv",sep=',', row.names = F, col.names = T)

review.us <- dplyr::left_join(a,review)
review.us <- na.omit(review.us)

review.Japan.word <- review.us %>%
  group_by(id)%>%
  mutate(linenumber = row_number())%>%
  unnest_tokens(word, text)%>%
  filter(str_detect(word, "^[a-z']+$"))%>%
  ungroup()

word.freq <- review.Japan.word%>%
  count(word,sort=TRUE)
write.table(review.us, file = "word_freq.csv",sep=',', row.names = F, col.names = T)


