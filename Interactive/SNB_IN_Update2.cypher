From LDBC_SNB
MATCH (person:Person {id: $personId}), (comment:Comment {id: $commentId})
CREATE (person)-[:LIKES {creationDate: $creationDate}]->(comment)

The query above first select the person node and the commentnode and then creates path traversal from the person 
node towards the comment node in an right traversal manner carried out through the constructed path named 
:LIKES.
