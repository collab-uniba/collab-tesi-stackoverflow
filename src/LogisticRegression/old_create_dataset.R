#library(Amelia)

set <- read.csv(file="/home/giuseppe/TesiStackExchange/AskUbuntu/Dataset/final_metrics.csv", sep=";")

#For visualizing missing values
#missmap(set, main ="Missing values vs observed")

#Scale and center body lenght and title lenght
set$BodyLength<-scale(set$BodyLength, center = TRUE, scale = TRUE) 
set$TitleLength<-scale(set$TitleLength, center = TRUE, scale = TRUE)

#Computing medians of SentimentPositiveScore and SentimentNegativeScore and replacing data with them
sentPositive <- set$SentimentPositiveScore
sentPosMed <- median(sentPositive)

sentNegative <- set$SentimentNegativeScore
sentNegMed <- median(sentNegative)

#Replacing
set$SentimentPositiveScore <- as.character(set$SentimentPositiveScore)
set$SentimentPositiveScore[set$SentimentPositiveScore > sentPosMed] <- T
set$SentimentPositiveScore[set$SentimentPositiveScore <= sentPosMed] <- F

set$SentimentNegativeScore <- as.character(set$SentimentNegativeScore)
set$SentimentNegativeScore[set$SentimentNegativeScore > sentNegMed] <- T
set$SentimentNegativeScore[set$SentimentNegativeScore <= sentNegMed] <- F

#Computing medians of CommentSentimentPositiveScore and CommentSentimentNegativeScore
ComSentPositive <- set$CommentSentimentPositiveScore
ComSenPositiveMed <- median(ComSentPositive, na.rm = T)

ComSentNegative <- set$CommentSentimentNegativeScore
ComSentNegativeMed <- median(ComSentNegative, na.rm = T)

#Replacing
set$CommentSentimentPositiveScore <- as.character(set$CommentSentimentPositiveScore)
set$CommentSentimentPositiveScore[set$CommentSentimentPositiveScore > ComSenPositiveMed] <- T
set$CommentSentimentPositiveScore[set$CommentSentimentPositiveScore <= ComSenPositiveMed] <- F

set$CommentSentimentNegativeScore <- as.character(set$CommentSentimentNegativeScore)
set$CommentSentimentNegativeScore[set$CommentSentimentNegativeScore > ComSentNegativeMed] <- T
set$CommentSentimentNegativeScore[set$CommentSentimentNegativeScore <= ComSentNegativeMed] <-F

#Replacing NAs with F
set$CommentSentimentPositiveScore[is.na(set$CommentSentimentPositiveScore)] <- F
set$CommentSentimentNegativeScore[is.na(set$CommentSentimentNegativeScore)] <- F

write.table(file="/home/giuseppe/TesiStackExchange/AskUbuntu/Dataset/new_final_metrics.csv", sep=";", x = set, row.names = F)



