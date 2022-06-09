// IS1. Profile of a person




The query below returns the results of a single person by traversing the path labeled IS_LOCATED_IN to the left 
from person  to city node.

MATCH (p1:Person {id: $personId })-[:IS_LOCATED_IN]->(c:City)
RETURN
    p1.firstName AS firstName,
    p1.lastName AS lastName,
    p1.birthday AS birthday,
    p1.locationIP AS locationIP,
    p1.browserUsed AS browserUsed,
    p1.id AS cityId,
    p1.gender AS gender,
    p1.creationDate AS creationDate
