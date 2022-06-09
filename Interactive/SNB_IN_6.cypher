// Q6. Tag co-occurrence

In the view below tag_VIEW all the tags-id's are retrieved and returned, within the match clause there is no path 
traversal, just selecting the specific node Tag

Create Query tag_VIEW AS (
MATCH (knowTag:Tag { name: $tagName })
WITH knowTag.id as knownTagId
)

The query knowTag_VIEW traverses from the node person to friend and does at most 2 undirected traversals between 
1 and 2. The traversal along the path with edge label: KNOWS makes sure that each person is not a friend within himself or
herself. In the end, the relatedTagID and the friendID information are returned.

CREATE Query knowTag_VIEW as (
FROM tag_VIEW
MATCH (p:Person { id: $personId })-[:KNOWS]-(f: friend){1,2}
WHERE  p<>f AND tag_VIEW.knownTagId == knownTagId
RETURN
    knownTagId,
    (distinct f) as friends
)
In the final query, the path traversal is carried out from the friend node to the post node along the path HAS_CREATOR.
There is also path traversal from post to TagID. Do note that there are two path traversals from 
post to Tag, indicating that they are two different tags.
At last, the query returns the tag names and the number of posts posted by each person.

FROM tag_VIEW, knowTag_VIEW
MATCH (f)<-[:HAS_CREATOR]-(post:Post),
        (post)-[:HAS_TAG]->(t1:Tag{id: knownTagId}),
        (post)-[:HAS_TAG]->(t2:Tag)
    WHERE  t1 <> t2      
RETURN
   t.name as nametag,
 count(post) as countPost
ORDER BY
    nametag DESC,
    countPost ASC
LIMIT 10
