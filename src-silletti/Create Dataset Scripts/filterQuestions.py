import MySQLdb
import pandas as pd
import numpy as np

"""

This script get all the questions from the database and save the two cvs files
used for the topic computation.

"""

#create a connection with MySQLdb
def connectToDB():
    conn = MySQLdb.Connection(host = "localhost", user = "root", db = "DBname");
    return conn;

#Connect to database
dbConn = connectToDB();

#Read the query
file = open('./queries/QUERY.sql', 'r');
query = file.read();

#Get raw questions
print("Getting questions...");
finalQuestions = pd.read_sql(query, con=dbConn);

#Add IsTheSameTopicBTitle
finalQuestions['IsTheSameTopicBTitle'] = np.nan;

print("Saving questions on csv file...");

#Save final questions on csv file
finalQuestions.to_csv(path_or_buf = 'path/finalQuestions.csv',
 sep=';', index = False, quotechar='"', encoding = 'utf-8', escapechar="\\", na_rep=" ");
 
#Save csvs for topic analysis
titleTags = finalQuestions[['QuestionID', 'Title', 'Tags']];
titleTags.to_csv(path_or_buf = 'path/titleTags.csv',
 sep=';', index = False, quotechar='"', encoding = 'utf-8', escapechar="\\");

bodyTags = finalQuestions[['QuestionID', 'Body', 'Tags']]
bodyTags.to_csv(path_or_buf = 'path/bodyTags.csv',
 sep=';', index = False, quotechar='"', encoding = 'utf-8', escapechar="\\");

dbConn.close();