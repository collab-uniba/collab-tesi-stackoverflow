set <- read.csv(file="/home/giuseppe/TesiStackExchange/AskUbuntu/Dataset/new_final_metrics.csv", sep=";")

levels(set$CodeSnippet) <- c(0,1)
set$CodeSnippet[set$CodeSnippet == "yes"] <- 1
set$CodeSnippet[set$CodeSnippet == "no"] <- 0

levels(set$Gratitude) <- c(0,1)
set$Gratitude[set$Gratitude == "yes"] <- 1
set$Gratitude[set$Gratitude == "no"] <- 0

set$SentimentPositiveScore[set$SentimentPositiveScore == T] <- 1
set$SentimentPositiveScore[set$SentimentPositiveScore == F] <- 0

set$SentimentNegativeScore[set$SentimentNegativeScore == T] <- 1
set$SentimentNegativeScore[set$SentimentNegativeScore == F] <- 0

set$CommentSentimentPositiveScore[set$CommentSentimentPositiveScore == T] <- 1
set$CommentSentimentPositiveScore[set$CommentSentimentPositiveScore == F] <- 0

set$CommentSentimentNegativeScore[set$CommentSentimentNegativeScore == T] <- 1
set$CommentSentimentNegativeScore[set$CommentSentimentNegativeScore == F] <- 0

set$IsTheSameTopicBTitle[set$IsTheSameTopicBTitle == T] <- 1
set$IsTheSameTopicBTitle[set$IsTheSameTopicBTitle == F] <- 0

levels(set$Successful) <- c(0,1)
set$Successful[set$Successful == "yes"] <- 1
set$Successful[set$Successful == "no"] <- 0

levels(set$Weekday) <- c(0,1)
set$Weekday[set$Weekday == "Weekday"] <- 0
set$Weekday[set$Weekday == "Weekend"] <- 1

levels(set$GMTHour) <- c(0,1,2,3)
set$GMTHour[set$GMTHour == "Morning"] <- 0
set$GMTHour[set$GMTHour == "Afternoon"] <- 1
set$GMTHour[set$GMTHour == "Evening"] <- 2
set$GMTHour[set$GMTHour == "Night"] <- 3

write.table(file="/home/giuseppe/TesiStackExchange/AskUbuntu/Dataset/new_final_metrics_numeric.csv", sep=";", x = set, row.names = F)


