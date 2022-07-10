CREATE QUERY messageCount_VIEW AS {
FROM LDBC_SNB
MATCH (message:Message)
WHERE message.creationDate < $datetime
Return count(message) AS totalMessageCountInt}


CREATE  QUERY messagePrep_View AS (
From message 
MATCH(message:message)
WHERE  creationDate < :datetime
    AND content IS NOT NULL
   SELECT extract(year from creationDate) AS messageYear
         , ParentMessageId IS NOT NULL AS isComment
             
Return ParentMessageId IS NOT NULL AS isComment,
       , CASE
             WHEN length <  40 THEN 0 -- short
             WHEN length <  80 THEN 1 -- one liner
             WHEN length < 160 THEN 2 -- tweet
             ELSE                   3 -- long
           END AS lengthCategory
         , length
     
      
)

FROM messagePrep_VIEW, messageCount_VIEW
MATCH(message:message)
Return messageYear,
       isComment, 
       lengthCategory,
       count(message) AS messageCount, 
       sum(message.length)/toFloat (count(message)) AS averageMessageLength, 
       sum(length) AS sumMessageLength, 
       messageCount / toFloat(totalMessageCountInt) AS percentageOfMessages

 GROUP BY messageYear, 
          isComment, 
          lengthCategory, 
 ORDER BY messageYear DESC, 
          isComment ASC,
          lengthCategory ASC

