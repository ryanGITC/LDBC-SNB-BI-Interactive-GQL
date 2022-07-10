
CREATE QUERY detail_VIEW as (
FROM LDBC_SNB
MATCH (tag:Tag {name: $tag})<-[:HAS_TAG]-(message:Message)-[:HAS_CREATOR]->(person:Person)
OPTIONAL MATCH [:REPLY_OF]-(reply:Comment)->(message)<-[likes:LIKES]-(:Person)
REUTRN CreatorPerson.id AS CreatorPersonId
     , count(DISTINCT Comment.Id)  AS replyCount
     , count(DISTINCT Person_likes_Message.MessageId||' '||Person_likes_Message.PersonId) AS likeCount
     , count(DISTINCT Message.Id)  AS messageCount
     , NULL as score
GROUP BY CreatorPerson.id
)

Create Query poster_w_liker_VIEW AS(
FROM detail_VIEW,LDBC_SNB
MATCH (tag:Tag {name: $tag})<-[:HAS_TAG]-(message1:Message)-[:HAS_CREATOR]->(person1:Person)
OPTIONAL MATCH (message1)<-[:LIKES]-(person2:Person)
RETURN    DISTINCT   m1.CreatorPersonId AS posterPersonid
         ,l2.PersonId AS likerPersonid
)

CREATE QUERY popularity_score_VIEW AS (
FROM LDBC_SNB,poster_w_liker_VIEW
OPTIONAL MATCH (person2)<-[:HAS_CREATOR]-(message2:Message)<-[like:LIKES]-(person3:Person)
RETURN  CreatorPersonId AS PersonId, count(*) AS popularityScore
GROUP BY m3.CreatorPersonId
)

/*Final Query*/
FROM poster_w_liker_VIEW,popularity_score_VIEW,Query poster_w_liker_VIEW ,detail_VIEW
MATCH (pl: likerPersonid) <- [:POPULARITY_SCORE]-(ps:Person)
RETURN  pl.posterPersonid AS "person1.id"
     , sum(coalesce(ps.popularityScore, 0)) AS authorityScore
 GROUP BY pl.posterPersonid
 ORDER BY authorityScore DESC, pl.posterPersonid ASC
 LIMIT 100

