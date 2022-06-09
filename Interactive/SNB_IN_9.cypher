
The match clause of friends_VIEW verifies the friends of friends and makes sure that the friendship is not a reflexive relationship.
The path traversal is done to a path of at most 2 lengths, with a minimum of 1 length.

CREATE Query friends_VIEW as (
MATCH (p1:Person {id: $personId })-[:KNOWS]-(p2:Person){1,2}
WHERE f<>p1
RETURN  COLLECT (distinct f) as friends
)
The query below is a continuation of the query above, and does a right path traversal from the message node to the friend node.The combination of this query and the constructed view above
verifies to whether a new message has been sent between two friends and the type of message. The RETURN clause returns the details of the owner of that messsage
and the content of the message 


FROM friends_VIEW
MATCH (f) <-[:HAS_CREATOR]-(m:Message)
    WHERE m.creationDate < $maxDate
RETURN
    f.id AS personId,
    f.firstName AS FirstName,
    f.lastName AS LastName,
    m.id AS commentId,
    coalesce(m.content,m.imageFile) AS Content,
    m.creationDate AS contentCreationDate
ORDER BY
    contentCreationDate DESC,
    message.id ASC
LIMIT 20
