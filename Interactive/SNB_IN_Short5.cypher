// IS5. Creator of a message
FROM LDBC_SNBI
MATCH (m:Message {id:  $messageId })-[:HAS_CREATOR]->(p1:Person)
RETURN
    p1.id AS personId,
    p1.firstName AS firstName,
    p1.lastName AS lastName

The query traverses from the node message to person in a left manner along the path HAS_CREATOR
in retrieving the details of the creator of a message.
