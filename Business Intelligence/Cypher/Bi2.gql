CREATE QUERY TAG1_VIEW as (
FROM LDBC_SNB
OPTIONAL MATCH (message1:Message)-[:HAS_TAG]->(tag)
  WHERE $date <= message1.creationDate
    AND message1.creationDate < $date + duration({days: 100})
Return count(message1) AS countWindow1
)


CREATE QUERY TAG2_VIEW as (
FROM LDBC_SNB
OPTIONAL MATCH (message2:Message)-[:HAS_TAG]->(tag)
WHERE $date + duration({days: 100}) <= message2.creationDate
    AND message2.creationDate < $date + duration({days: 200})
Return 
       count(DISTINCT CASE WHEN Message.creationDate >= :date + INTERVAL
       
       '100 days' THEN Message.id ELSE NULL END) 
       AS countMonth2
)

FROM TAG1_VIEW,TAG2_VIEW,LDBC
MATCH (tag:Tag)-[:HAS_TYPE]->(:TagClass {name: $tagClass})
RETURN tag.name
       countWindow1,
       countWindow2,
       abs(countWindow1 - countWindow2) AS diff
ORDER BY diff desc,
         tag.name ASC
LIMIT 100

