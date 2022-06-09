
Query 2 is a simple query in which there is a path traversal from person to person between whom an interaction
happened. From the node Person, a traversal is traversed to another node person along with the label of edge: KNOWS.
From there on a left path traversal is carried out from the node message to the friend along the edge path: HAS_CREATOR.
The query returns the id, name of the people between who an interaction is carried out, and the date of the post as well as its ID.

FROM LDBC_SNB
MATCH (P:Person {id: $personId })-[:KNOWS]-(f:Person)<-[:HAS_CREATOR]-(m:Message)
    WHERE message.creationDate <= $maxDate
CASE : 
    m.content <> "" 
    THEN 
            result = coalesce(m.content,m.imageFile) 

    ELSE   NULL
            
    RETURN
        f.id AS personId,
        f.firstName AS personFirstName,
        f.lastName AS personLastName,
        m.id AS postID,
        result AS postOrCommentContent,
        m.creationDate AS postDate
    ORDER BY
        postOrCommentContent DESC,
        toInteger(postOrCommentId) ASC
    LIMIT 20
