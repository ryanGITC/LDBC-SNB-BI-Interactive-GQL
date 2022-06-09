// Q5. New groups

In the view know_VIEW the path of KNOWS is traversed between person and friend of lenghts of between 1 and 2
and returns the distinct friends

CREATE QUERY know_VIEW as (
MATCH (p:Person { id: $personId })-[:KNOWS]-(f: friend) {1,2}
WHERE
     person <> f
Return DISTINCT f
)

FROM the view know_VIEW the path with the label HAS_MEMBER is traversed from the node friend to the node forum. The traversal is the right
one. Upon that path, all the friends who have joined a forum are accumulated and returned.

CREATE QUERY forum_VIEW AS (
FROM know_VIEW
MATCH (f)<-[m:HAS_MEMBER]-(forum)
WHERE
    m.joinDate > $minDate

AND know_VIEW.f.id == f.id
RETURN
    forum,
    COLLECT(f) AS friends
)

In the Query below from the edge forum, there is a path traversal along the edge of label CONTAINER_OF
to post ( left traversal). Another left traversal is done from the node post to friend along with the edge label
HAS_CREATOR, to see whether a person posted in the forum.
Eventually, the name of the forum and the number of posts posted by a person is returned.

FROM know_VIEW,forum_VIEW
OPTIONAL MATCH (f)<-[:HAS_CREATOR]-(post)<-[:CONTAINER_OF]-(forum)
WHERE
    f IN friends

RETURN
    f.id as person
    forum.title AS nameForum,
    count(post) AS countPost
ORDER BY
    postCount DESC,
    forum.id ASC
LIMIT 20
