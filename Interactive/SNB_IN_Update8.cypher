MATCH (p1:Person {id: $person1Id}), (p2:Person {id: $person2Id})
CREATE (p1)-[:KNOWS {creationDate: $creationDate}]->(p2)

In the match clause the person node is selected,and a relationship is created between the selected nodes and the label :KNOWS 
is given.
