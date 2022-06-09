/*Translation Bi7 query*/
FROM LDBC_SNB
MATCH
  (tag:Tag {name: $tag})<-[:HAS_TAG]-(m:Message),
  (m)<-[:REPLY_OF]-(c:Comment)-[:HAS_TAG]->(rTag:Tag)
    WHERE NOT (c)-[:HAS_TAG]->(tag)

RETURN RelatedTag.name AS "relatedTag.name"
       , count(*) AS count
 GROUP BY RelatedTag.name
 ORDER BY count DESC
          ,RelatedTag.name
 LIMIT 100