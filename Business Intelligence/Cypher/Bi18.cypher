/*Translation Bi18*/

CREATE QUERY Friend_recommendation_VIEW AS (
FROM  Person_knows_Person
MATCH (tag:Tag {name: $tag})<-[:HAS_INTEREST]-(person1:Person)-[:KNOWS]-(mutualFriend:Person)-[:HAS_INTEREST]->(tag)
/*Reason for an optional match is the left join in sql*/
OPTIONAL MATCH (mutualFriend:Person)-[:KNOWS]-(person2:Person)

WHERE person1 <> person2
  AND NOT (person1)-[:KNOWS]-(person2)
RETURN person1.id AS person1Id
      ,person2.id AS person2Id
      ,count(DISTINCT mutualFriend) AS mutualFriendCount
ORDER BY mutualFriendCount DESC, person1Id ASC, person2Id ASC
LIMIT 20
)