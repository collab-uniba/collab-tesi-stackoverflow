#Compute the logistic regression

set <- read.csv(file="path/metrics_for_regression.csv", sep=";", na.strings=c(""))

train.data <- set

train.data$PostId <- NULL

#Setting default variables for regression
train.data <- within(train.data, SentimentPositiveScore <- relevel(SentimentPositiveScore, ref = "Neutral"))
train.data <- within(train.data, SentimentNegativeScore <- relevel(SentimentNegativeScore, ref = "Neutral"))
train.data <- within(train.data, CommentSentimentPositiveScore <- relevel(CommentSentimentPositiveScore, ref = "Neutral"))
train.data <- within(train.data, CommentSentimentNegativeScore <- relevel(CommentSentimentNegativeScore, ref = "Neutral"))
train.data <- within(train.data, Weekday <- relevel(Weekday, ref = "Weekday"))
train.data <- within(train.data, GMTHour <- relevel(GMTHour, ref = "Morning"))
train.data <- within(train.data, BodyLength <- relevel(BodyLength, ref = "Short"))
train.data <- within(train.data, TitleLength <- relevel(TitleLength, ref = "Short"))
train.data <- within(train.data, NTag <- relevel(NTag, ref = "Single"))

#Fitting the model
model <- glm(formula=Successful ~ CodeSnippet + Weekday + GMTHour + BodyLength + TitleLength 
             + SentimentPositiveScore + SentimentNegativeScore + CommentSentimentPositiveScore 
             + CommentSentimentNegativeScore + Gratitude + NTag + AvgUpperCharsPPost + URL 
             +IsTheSameTopicBTitle, data=train.data, family=binomial())
options(scipen=999)
summary(model)

oddsratio <- exp(model$coefficients)
estimates <- model$coefficients

table <- data.frame(estimates, oddsratio)

no_rounded_table <- table

table$estimates <- round(table$estimates, 2)
table$oddsratio <- round(table$oddsratio, 2)

#write.table(file="path/no_rounded_results_table.csv", sep=";", x = no_rounded_table, row.names = T)
#write.table(file="path/results_table.csv", sep=";", x = table, row.names = T)

