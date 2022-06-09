// Q4. New topics

The construction of a view is omitted since there is only one MATCH clause. In the MATCH clause 
a path is traversed from the node Person to another person traversing the first edge label named KNOWS. 
Afterward, a left traversal is done from the node post to person along the label named HAS_CREATOR.
From the node post, there is another traversal going out or coming in from post to tag and is a right traversal along the edge
to tag. In short, this query verifies whether a new post or comment is interchanged between two people


FROM LDBC_SNB
MATCH (p:Person {id: $personId })-[:KNOWS]-(f:Person) <-[:HAS_CREATOR]-(post:Post)-[:HAS_TAG]->(tag)
CASE $tag :
       WHEN $endDate > post.creationDate >= $startDate THEN 1
       ELSE 0
     END AS valid,
     CASE
       WHEN $startDate > post.creationDate THEN 1
       ELSE 0
     END AS inValid
WHERE countOfPost>0 AND inValidCountOfPost=0
RETURN tag.name AS tagName, 
       ,sum(valid) AS countOfPost
       ,sum(inValid) AS inValidCountOfPost
ORDER BY postCount DESC
         ,tagName ASC
LIMIT 10
