// Q12. Expert search\

MATCH (baseTagClass:TagClass)<-[:HAS_TYPE|IS_SUBCLASS_OF]{0,..}-(tag:Tag)
WHERE tag.name = $tagClassName OR baseTagClass.name = $tagClassName
RETURN collect(tag.id) as tags


MATCH (:Person {id: $personId })-[:KNOWS]-(friend:Person)
<-[:HAS_CREATOR]-(comment:Comment)-[:REPLY_OF]->(:Post)-[:HAS_TAG]->(tag:Tag)
WHERE tag.id in tags
RETURN
    friend.id AS personId,
    friend.firstName AS personFirstName,
    friend.lastName AS personLastName,
    COLLECT(DISTINCT tag.name) AS tagNames,
    COUNT(DISTINCT comment) AS replyCount
ORDER BY
    replyCount DESC,
    toInteger(personId) ASC
LIMIT 20

In the query above we have the match clause that does a traversal from the baseTagclass that
comes from the tag node in a left manner and traveled through the  HAS_TYPE label.
During traversal, at least one path is traveled.
In the second query, we have the traversal from the comment node towards the friend node first through the label
HAS_CREATOR. From the friend nodes, there is also an undirected traversal towards the person node. Moreover, there
are two right traversals from the comment node towards the post node, which is the first through the POST label.
 The second traversal is the traversal from the comment node towards the post node, that travels through the 
 path REPLY_OF. Afterward, a second traversal is done from the post node towards the tag node through the 
 HAS_TAG path.

