MATCH (p:Person {id: $authorPersonId}), (country:Country {id: $countryId}), (forum:Forum {id: $forumId})
CREATE (author)<-[:HAS_CREATOR]-(pm:Post:Message {
    id: $postId,
    creationDate: $creationDate,
    locationIP: $locationIP,
    browserUsed: $browserUsed,
    content: CASE $content WHEN '' THEN NULL ELSE $content END,
    imageFile: CASE $imageFile WHEN '' THEN NULL ELSE $imageFile END,
    length: $length
  })<-[:CONTAINER_OF]-(forum), (p)-[:IS_LOCATED_IN]->(country)
 
RETURN $tagIds AS tagId

In the first query, a selection is done on the person node, country, and forum node. In the CREATE clause a left traversal 
relationship is created from the forum node towards the constructed message node, and then towards the person node.
The first left path is traversed through the path with the label CONTAINER_OF. The second traversal happens through the: HAS_CREATOR label.
Do note that there is a second match clause that traverses a path from the person node towards to country node in the right manner through the label
of IS_LOCATED_IN.
The second query continues from the results which are returned by the first and constructs a relationship
from the person node to the tag node with the path label : HAS_TAG
  
MATCH (t:Tag {id: tagId})
CREATE (p)-[:HAS_TAG]->(t)