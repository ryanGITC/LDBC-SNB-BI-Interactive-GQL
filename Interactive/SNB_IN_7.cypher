// IS7. Replies of a message

MATCH (m:Message {id: $messageId })<-[:REPLY_OF]-(c:Comment)-[:HAS_CREATOR]->(p:Person)
OPTIONAL MATCH (m)-[:HAS_CREATOR]->(a:Person)-[r:KNOWS]-(p)
RETURN c.id AS commentId,
        c.content AS Content,
        c.creationDate AS CreationDate,
        p.id AS AuthorId,
        p.firstName AS replyFirstName,
        p.lastName AS replyLastName,
        CASE r
            WHEN null THEN false
            ELSE true
       END AS KnowsOriginalMessageAuthor
ORDER BY creationDate DESC
         ,AuthorId


For the query above there is no view necessary since it consists of out of one query. There are two match clauses.
In the first match clause, a left traversal is done from comment to messageId and comment also a right traversal
to the node person along with the edge label HAS_CREATOR. In the second match, which is the optional match a right 
traversal is carried out from the message node to the person node and then another right traversal to the person
node along the path HAS_CREATOR. From the node person, there is another traversal to the node person. This might seems confusing
but the query translates to verifying whether a reply was given from a person A to a person B and further verifies whether those two people know each other.
