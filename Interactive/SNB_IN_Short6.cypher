// IS6. Forum of a message

FROM LDBC_SNBI
OPTIONAL MATCH (m:Message {id: $messageId })-[:REPLY_OF]{0,}->(p:Post)<-[:CONTAINER_OF]-(f:Forum)-[:HAS_MODERATOR]->(p1:Person)
RETURN
    f.id AS forumId,
    f.title AS forumTitle,
    mod.id AS moderatorId,
    mod.firstName AS FirstName,
    mod.lastName AS LastName

An optional match is used in the query rather than an if clause in GSQL.The use of an OPTIONAL MATCH will result in a returned NULL value if there is no value found for such. From the message node, there is a right traversal to the post node along the path of REPLY_OF. In addition a left path traversal is present, and travels along the path CONTAINER_OF from the forum node to the post node. Addtionally another right traversal is doen from the forum node towards the person node, through the path
HAS_MODERATOR . Since Comments are not directly contained in Forums, for Comments, the Forum containing the original Post in the thread to which the Comment is replying is returned.
