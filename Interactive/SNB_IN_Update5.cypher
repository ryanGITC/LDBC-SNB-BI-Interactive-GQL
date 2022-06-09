FROM LDBC_SNB
MATCH (forum:Forum {id: $forumId}), (person:Person {id: $personId})
CREATE (forum)-[:HAS_MEMBER {joinDate: $joinDate}]->(person)

A selection is made in the match clause, selecting the forum node and the person node. After that, a path is 
created from the forum node towards the person node in a right manner along the path of :HAS_MEMBER.
