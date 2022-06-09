FROM LDBC_SNB
MATCH (p:Person {id: $moderatorPersonId})
CREATE (f:Forum {id: $forumId, title: $forumTitle, creationDate: $creationDate})-[:HAS_MODERATOR]->(p)
Return $tagIds AS tagId

The construction of views is omitted. The first query selects the person node and then creates a path traversal
from the forum node towards the person node, along the path of :HAS_MODERATOR. 
From the returned values of the query above, query 2 continues or starts with the tag node and from there
on a traversal is created along the path of :HAS_TAG from the forum node towards to the tag node.

MATCH (tag:Tag {id: tagId})
CREATE (f)-[:HAS_TAG]->(tag)

