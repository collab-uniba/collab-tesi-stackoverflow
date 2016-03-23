SELECT
  q.q_postID AS QuestionID,
  q.q_postDate AS CreationDate,
  q.q_title AS Title,
  q.q_body AS Body,
  q.q_tags AS Tags,
  COALESCE(v.CreationDate, 'Null') AS AcceptedDate,
  IF(ucq.q_Id, COUNT(*), 0) AS NumberOfComments,
  COALESCE(GROUP_CONCAT(ucq.c_text SEPARATOR ' '), '') AS CommentsTexts,
  IF(q.q_acceptedAnswerId, 'yes', 'no') AS Successful

FROM questions_mv AS q
LEFT OUTER JOIN Votes AS v ON q.q_acceptedAnswerId = v.PostId AND v.VoteTypeId = 1
LEFT OUTER JOIN userscommentsquestions_mv AS ucq ON q.q_postID = ucq.q_Id AND (v.Id IS NULL OR ucq.c_ts_creationDate < v.CreationDate)

WHERE q_postID

NOT IN (
    SELECT PostId FROM PostHistory WHERE PostHistory.CreationDate = (select MAX(CreationDate) from PostHistory a  where PostHistory.postID = a.PostId
    Group by a.PostId 
    Order by a.CreationDate desc LIMIT 1)
    AND PostHistoryTypeId ='10'
 
    UNION

    SELECT PostId FROM PostHistory WHERE PostHistoryTypeId = 4 OR PostHistoryTypeId = 5

    UNION

    SELECT PostId FROM PostHistory 
    WHERE PostHistory.CreationDate = 
    (select MAX(CreationDate)  
    from PostHistory a  where PostHistory.PostId = a.PostId
    Group by a.PostId 
    Order by a.CreationDate desc LIMIT 1)
    AND PostHistoryTypeId ='12'
)

GROUP BY QuestionID


