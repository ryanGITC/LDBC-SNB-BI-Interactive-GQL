/*Translation Bi19*/

CREATE gds_CYPHER19_VIEW as(
    FROM Person
    MATCH (p:Person) RETURN id(p) AS id,
    MATCH(personA:Person)-[:KNOWS]-(personB:Person)
    ,personA)<-[:HAS_CREATOR]-(:Message)-[replyOf:REPLY_OF]-(:Message)-[:HAS_CREATOR]->(personB)
    RETURN
      id(personA) AS source,
      id(personB) AS target,
      1.0/count(replyOf) AS weight
)

FROM gds_CYPHER19_VIEW
MATCH
  (person1:Person)-[:IS_LOCATED_IN]->(city1:City {id: $city1Id}),
  (person2:Person)-[:IS_LOCATED_IN]->(city2:City {id: $city2Id})
CALL{
  vertex( 'MATCH (p:Person) RETURN id(p) AS id'),
  /*relationshipQuery:*/
    SHORTEST MATCH
       (personA:Person)-[:KNOWS]-(personB:Person),
       (personA)<-[:HAS_CREATOR]-(:Message)-[replyOf:REPLY_OF]-(:Message)-[:HAS_CREATOR]->(personB)
     RETURN
       id(personA) AS source,
       id(personB) AS target,
       1.0/count(replyOf) AS weight',
  source( person1),
  target( person2),
  edge(weight)
})
YIELD totalCost
RETURN person1.id, person2.id, totalCost AS totalWeight
ORDER BY totalWeight ASC, person1.id ASC, person2.id ASC
LIMIT 20
