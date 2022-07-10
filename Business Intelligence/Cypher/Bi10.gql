// Q10. Experts in social circle
L
/*Translation Bi10 query*/
FROM LDBC_SNB
MATCH (Person1:Person {id: $personId})
CALL apoc.path.subgraphNodes(startPerson, {
	relationshipFilter: "KNOWS",
    minLevel: 1,
    maxLevel: $minPathDistance-1
})
YIELD node
RETURN startPerson, 
       collect(DISTINCT node) AS nodesCloserThanMinPathDistance


CALL apoc.path.subgraphNodes(startPerson, {
	relationshipFilter: "KNOWS",
    minLevel: 1,
    maxLevel: $maxPathDistance
})
YIELD node
RETURN  nodesCloserThanMinPathDistance
        ,collect(DISTINCT node) AS nodesCloserThanMaxPathDistance

// compute the difference of sets: nodesCloserThanMaxPathDistance - nodesCloserThanMinPathDistance

MATCH
  (expertCandidatePerson)-[:IS_LOCATED_IN]->(:City)-[:IS_PART_OF]->(:Country {name: $country}),
  (expertCandidatePerson)<-[:HAS_CREATOR]-(message:Message)-[:HAS_TAG]->(:Tag)-[:HAS_TYPE]->
  (:TagClass {name: $tagClass},
  (message)-[:HAS_TAG]->(tag:Tag)
RETURN
  [n IN nodesCloserThanMaxPathDistance WHERE NOT n IN nodesCloserThanMinPathDistance] AS expertCandidatePersons
  expertCandidatePerson.id,
  tag.name,
  count(DISTINCT message) AS messageCount
ORDER BY
  messageCount DESC,
  tag.name ASC,
  expertCandidatePerson.id ASC
LIMIT 100
\end{}
\newline\newline
