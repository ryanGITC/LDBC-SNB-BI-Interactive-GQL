
The view retrieves people who are friends. The construction of this is done by first  traversing the 
path with edge label KNOWS from predicate p1 (person node 1) to p2(another person).

Create Query personFriend_VIEW AS (
FROM LDBC_SNB
MATCH (p1:Person {id: $personId })-[:KNOWS]-(p2:Person){1,2}
WHERE not(person <> p2)
RETURN DISTINCT friend
)



FROM LDBC_SNB,personFriend_VIEW
MATCH (:Country {name: $countryName }) <-[:IS_LOCATED_IN] <- (friend) -[workAt:WORK_AT] -(company:Company)
WHERE workAt.workFrom < $workFromYear
RETURN
        f.id AS personId,
        f.firstName AS personFirstName,
        f.lastName AS personLastName,
        company.name AS organizationName,
        workAt.workFrom AS organizationWorkFromYear
ORDER BY
        organizationWorkFromYear ASC,
        toInteger(personId) ASC,
        organizationName DESC
LIMIT 10

The query above traverses the path from company to country name along the path IS_LOCATED_IN to the node country,which is a left traversal.
There is also an undirected traversal from the friend node towards the company node.In short, the query retrieves the
job referals.

