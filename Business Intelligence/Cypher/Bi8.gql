/*Translation Bi8 query*/

CREATE Query Person_VIEW as (
FROM  Person
MATCH (tag:Tag {name: $tag})
// score
MATCH (tag)<-[interest:HAS_INTEREST]-(person:Person)
tag, collect(person) AS interestedPersons
WHERE EXIST{ 
    MATCH (tag)<-[:HAS_TAG]-(message:Message)-[:HAS_CREATOR]->(person:Person)
}
RETURN DISTINCT tag
       ,DISTINCT(interestedPersons + COLLECT (person) )AS persons
)

FROM Person_VIEW
 MATCH (person)-[:KNOWS]-(friend)

RETURN 
 tag,
  person,
  100 * size([(tag)<-[interest:HAS_INTEREST]-(person) | interest]) + size([(tag)<-[:HAS_TAG]-(message:Message)-[:HAS_CREATOR]->(person) WHERE message.creationDate > $date | message])
  AS score
  ,sum(score) AS friendScore

ORDER BY
  score + friendsScore DESC,
  person.id ASC
LIMIT 100



