import MySQLdb
import pandas as pd
import numpy as np
from random import sample
from bs4 import BeautifulSoup, NavigableString

#create a connection with MySQLdb
def connectToDB():
    conn = MySQLdb.Connection(host = "localhost", user = "root", db = "serverfault");
    return conn;

def strip_tags(html):
    soup = BeautifulSoup(html,'html.parser')

    for match in soup.findAll(True):
        if match.name != "code":
            match.unwrap()

    return soup


#Connect to database
dbConn = connectToDB();

query = "SELECT q_postID, q_title, q_body FROM questions_mv"

#Get raw questions
print("Getting questions...");
allQuestions = pd.read_sql(query, con=dbConn);

# create random index
rindex =  np.array(sample(range(len(allQuestions)), 400))

# get 400 random rows from allQuestions
questions = allQuestions.ix[rindex]

finalQuestions = pd.DataFrame(columns=['Title','Body'])

for i in range(0,400):
    q_title = questions.iloc[i]['q_title']
    q_body = questions.iloc[i]['q_body'].replace("&#xA;", " ")
    q_body = strip_tags(q_body)

    finalQuestions.loc[i] = [q_title, q_body]


# get 60 random questions
#otherQuestions = allQuestions[~allQuestions.index.isin(finalQuestions.index)]
#toAnalyzeQuestions = otherQuestions.tail(60)

#Add Comment column
finalQuestions['Comment'] = np.nan;

print("Saving questions on csv file...");

#Save final questions on csv file
finalQuestions.to_csv(path_or_buf = '/home/giuseppe/TesiStackExchange/Serverfault/Dataset/400Questions.csv',
sep=';', index = False, quotechar='"', encoding = 'utf-8', escapechar="\\", na_rep=" ");

#Save final questions on csv file
#toAnalyzeQuestions.to_csv(path_or_buf = '/home/giuseppe/TesiStackExchange/Serverfault/Dataset/60Questions.csv',
#sep=';', index = False, quotechar='"', encoding = 'utf-8', escapechar="\\", na_rep=" ");




