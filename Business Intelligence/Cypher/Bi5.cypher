
FROM LDBC_SNB
MATCH (tag:Tag {name: $tag})<-[:HAS_TAG]-(message:Message)-[:HAS_CREATOR]->(p:Person)
OPTIONAL MATCH (message)<-[likes:LIKES]-(:Person)
OPTIONAL MATCH (message)<-[:REPLY_OF]-(reply:Comment)
REUTRN CreatorPerson.id AS person.id
     , count(DISTINCT Comment.Id)  AS replyCount
     , count(DISTINCT Person_likes_Message.MessageId||' '||Person_likes_Message.PersonId) AS likeCount
     , count(DISTINCT Message.Id)  AS messageCount
     ,1*messageCount + 2*replyCount + 10*likeCount AS score

 GROUP BY CreatorPerson.id
 ORDER BY score DESC, CreatorPersonId
 LIMIT 100
