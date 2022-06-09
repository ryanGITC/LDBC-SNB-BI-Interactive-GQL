FROM LDBC_SNB
MATCH
  (:Country {country: $country})<-[:IS_PART_OF]-(:City)<-[:IS_LOCATED_IN]-
  (person:Person)<-[:HAS_MODERATOR]-(f:FORUM)-[:CONTAINER_OF]->
  (post:Post)<-[:REPLY_OF]{0,...}-(message:Message)-[:HAS_TAG]->(:Tag)-[:HAS_TYPE]->(:TagClass {name: $tagClass})
RETURN 
f.id            AS "f.id"
f.title         AS "f.title"
f.creationDate   AS "f.creationDate"
f.ModeratorPersonId AS "person.id"
 count(DISTINCT MessageThread.MessageId) AS messageCount
GROUP BY f.id
        ,f.title
        ,f.creationDate
        ,f.ModeratorPersonId
 ORDER BY messageCount DESC, 
          f.id
 LIMIT 20