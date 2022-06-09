
As in Query 7, there is also no view needed because of one query.
Here the match clause has 4 nodes. First, from p1 indicating the person node, there is a path traversal to the message node, which is a left traversal. 
Also from the message node, there is a left traversal from comment to message and at last from comment node to person node there is a right traversal
along with the: HAS_CREATOR label.
In short, the match clause in principle is a follow-up of the query executed before. The clause looks up at all the replies between two people.

FROM LDBC_SNB
MATCH (p1:Person {id: $personId})<-[:HAS_CREATOR]-(:Message)<-[:REPLY_OF]-(c:Comment)-[:HAS_CREATOR]->(p2:Person)
RETURN
    p1.id AS personId,
    p1.firstName AS personFirstName,
    p1.lastName AS personLastName,
    c.creationDate AS commentCreationDate,
    c.id AS commentId,
    c.content AS content
ORDER BY
    commentCreationDate DESC,
    commentId ASC
LIMIT 20

