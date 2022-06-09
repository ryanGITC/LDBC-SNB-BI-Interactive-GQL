// IS7. Replies of a message
FROM LDBC_SNBI
MATCH (m:Message {id: $messageId })<-[:REPLY_OF]-(c:Comment)-[:HAS_CREATOR]->(p:Person)
OPTIONAL MATCH (m)-[:HAS_CREATOR]->(p2:Person)-[r:KNOWS]-(p1)
RETURN c.id AS commentId,
c.content AS content,
c.creationDate AS creationDate,
p.id AS AuthorId,
p.firstName AS AuthorFirstName,
p.lastName AS AuthorLastName,
CASE r
     WHEN null THEN false
    ELSE true
        END AS replyAuthorKnowsOriginalMessageAuthor
ORDER BY commentCreationDate DESC, AuthorId

In the match clause the query looks whether there is a reply of a message or not by carrying out
a left path traversal from the comment node to the message node along the path of :REPLY_OF. From the comment node also
a right traversal is done from the comment node to the person node through the path of :HAS_CREATOR.Furthermore there is 
an OPTIONAL MATCH from another person to another one to see if the message exchanged beteen two people do know each other.



