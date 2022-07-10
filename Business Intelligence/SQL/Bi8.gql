/*Translation Bi8 query*/

//
SELECT DISTINCT tag
       ,DISTINCT(interestedPersons + COLLECT (person) )AS persons
FROM  LDBC_SNB
      MATCH (tag:Tag {name: $tag}),(tag)<-[interest:HAS_INTEREST]-(person:Person)
             tag, collect(person) AS interestedPersons
WHERE EXIST{ 
    MATCH (tag)<-[:HAS_TAG]-(message:Message)-[:HAS_CREATOR]->(person:Person)
}


//final query
SELECT tag, person,
  100 * size([(tag)<-[interest:HAS_INTEREST]-(person) | interest]) + size([(tag)<-[:HAS_TAG]-(message:Message)-[:HAS_CREATOR]->(person) WHERE message.creationDate > $date | message])
  AS score
  ,sum(score) AS friendScore
FROM LDBC_SNB,Person_VIEW
     MATCH (person)-[:KNOWS]-(friend)
ORDER BY
  score + friendsScore DESC,
  person.id ASC
LIMIT 100



