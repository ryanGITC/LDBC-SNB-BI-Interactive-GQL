/*Translation Bi20 query*/

CREATE gds_CYPHER20_VIEW as(
    MATCH (p:Person) RETURN id(p) AS id,
      (personA:Person)-[:KNOWS]-(personB:Person),
      (personA)-[saA:STUDY_AT]->(u:University)<-[saB:STUDY_AT]-(personB)
    RETURN
      id(personA) AS source,
      id(personB) AS target,
      min(abs(saA.classYear - saB.classYear)) + 1 AS weight'
)

FROM gds_CYPHER20_VIEW
MATCH
  (company:Company {name: $company})<-[:WORK_AT]-(person1:Person),
  (person2:Person {id: $person2Id})
CALL ({
  vertex( MATCH (p:Person) RETURN id(p) AS id),
  shortest MATCH (personA:Person)-[:KNOWS]-(personB:Person),
       (personA)-[saA:STUDY_AT]->(u:University)<-[saB:STUDY_AT]-(personB)
     RETURN
       id(personA) AS source,
       id(personB) AS target,
       min(abs(saA.classYear - saB.classYear)) + 1 AS weight',
  source( person1),
  target(person2),
  edge(weight)
})
YIELD totalCost
WHERE person1.id <> $person2Id
RETURN person1.id
     , totalCost AS totalWeight
ORDER BY totalWeight ASC
        ,person1.id ASC
LIMIT 20