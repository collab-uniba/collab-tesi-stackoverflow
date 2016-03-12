library(arules)

#Prepare the dataset for the logistic regression.

set <- read.csv(file="path/final_metrics.csv", sep=";")

sentPositive <- set$SentimentPositiveScore
sentNegative <- set$SentimentNegativeScore
ComSentPositive <- set$CommentSentimentPositiveScore
ComSentNegative <- set$CommentSentimentNegativeScore
bodyLength <- set$BodyLength
titleLength <- set$TitleLength

#Replacing sentiment positive score metric
set$SentimentPositiveScore[set$SentimentPositiveScore == 0] <- "Neutral"
set$SentimentPositiveScore[is.na(set$SentimentPositiveScore)] <- "Neutral"
set$SentimentPositiveScore[set$SentimentPositiveScore == 1] <- "Mild"
set$SentimentPositiveScore[set$SentimentPositiveScore == 2] <- "Mild"
set$SentimentPositiveScore[set$SentimentPositiveScore == 3] <- "Strong"
set$SentimentPositiveScore[set$SentimentPositiveScore == 4] <- "Strong"

#Replacing sentiment negative score metric
set$SentimentNegativeScore[set$SentimentNegativeScore == 0] <- "Neutral"
set$SentimentNegativeScore[is.na(set$SentimentNegativeScore)] <- "Neutral"
set$SentimentNegativeScore[set$SentimentNegativeScore == 1] <- "Mild"
set$SentimentNegativeScore[set$SentimentNegativeScore == 2] <- "Mild"
set$SentimentNegativeScore[set$SentimentNegativeScore == 3] <- "Strong"
set$SentimentNegativeScore[set$SentimentNegativeScore == 4] <- "Strong"

#Replacing comment sentiment positive score metric
set$CommentSentimentPositiveScore[set$CommentSentimentPositiveScore == 0] <- "Neutral"
set$CommentSentimentPositiveScore[is.na(set$CommentSentimentPositiveScore)] <- "Neutral"
set$CommentSentimentPositiveScore[set$CommentSentimentPositiveScore == 1] <- "Mild"
set$CommentSentimentPositiveScore[set$CommentSentimentPositiveScore == 2] <- "Mild"
set$CommentSentimentPositiveScore[set$CommentSentimentPositiveScore == 3] <- "Strong"
set$CommentSentimentPositiveScore[set$CommentSentimentPositiveScore == 4] <- "Strong"

#Replacing comment sentiment negative score metric
set$CommentSentimentNegativeScore[set$CommentSentimentNegativeScore == 0] <- "Neutral"
set$CommentSentimentNegativeScore[is.na(set$CommentSentimentNegativeScore)] <- "Neutral"
set$CommentSentimentNegativeScore[set$CommentSentimentNegativeScore == 1] <- "Mild"
set$CommentSentimentNegativeScore[set$CommentSentimentNegativeScore == 2] <- "Mild"
set$CommentSentimentNegativeScore[set$CommentSentimentNegativeScore == 3] <- "Strong"
set$CommentSentimentNegativeScore[set$CommentSentimentNegativeScore == 4] <- "Strong"

#Replacing url metric
set$URL[set$URL >= 1] <- "TRUE"
set$URL[set$URL == 0] <- "FALSE"

#Replasing Code Snippet metric
levels(set$CodeSnippet) <- c(F,T)
set$CodeSnippet[set$CodeSnippet == "yes"] <- T
set$CodeSnippet[set$CodeSnippet == "no"] <- F

#Replasing Gratitude metric
levels(set$Gratitude) <- c(F,T)
set$Gratitude[set$Gratitude == "yes"] <- T
set$Gratitude[set$Gratitude == "no"] <- F

#Replacing Tags metric
set$NTag[set$NTag >= 2] <- "Multiple"
set$NTag[set$NTag <= 1] <- "Single"

#Discretize body and title length to clusters
set$BodyLength <- discretize(bodyLength, method="cluster", labels=c("Short","Medium","Long"))
set$TitleLength <- discretize(titleLength, method="cluster", labels=c("Short","Medium","Long"))

write.table(file="path/metrics_for_regression.csv", sep=";", x = set, row.names = F)





