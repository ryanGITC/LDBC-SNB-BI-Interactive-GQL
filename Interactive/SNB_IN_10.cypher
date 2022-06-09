
In the first query view below we do two-match clauses. 
In the first match clause, there is an undirected path traversal from both the person node to the friend node traversed
along the path: KNOWS that traverses between 1 or 2 paths. In the second match clause, 
a traversal is done from the person node to the friend node along the path of KNOWS.

Create Query friend_VIEW as (
MATCH (p:Person {id: $personId})-[:KNOWS]-(friend){2,..}
       (friend)-[:IS_LOCATED_IN]->(city:City)
OPTIONAL MATCH   (friend where friend <> person)-[:KNOWS]-(person)
WHERE  (birthday.month=$month AND birthday.day>=21) OR
        (birthday.month=($month%12)+1 AND birthday.day<22)
RETURN 
      person
      ,city
      ,friend
      ,datetime({f.birthday}) as birthday
)

Create Query post_VIEW as (
OPTIONAL MATCH (friend)<-[:HAS_CREATOR]-(post:Post)
RETURN friend
       ,city
       ,COLLECT(post) AS posts
       ,person
)

Create Query postExtend_VIEW as (
FROM post_VIEW
Return city,
     size(posts) AS postCount,
     friend.id AS personId,
     friend.firstName AS personFirstName,
     friend.lastName AS personLastName,
     commonPostCount - (postCount - commonPostCount) AS commonInterestScore,
     friend.gender AS personGender,
     city.name AS personCityName
WHERE EXIST{
  FROM LBC_SNB
  MATCH
  (p)-[:HAS_TAG]->()<-[:HAS_INTEREST]-(person))
  
  Return  AS commonPostCount
   }
ORDER BY commonInterestScore DESC
        , personId ASC
LIMIT 10
)

Do notice that the postExtend_VIEW query is an extension of the post_View. The post_View first returns the friend, city
and posts values through the optional match, which is a right traversal from the post node to the edge node along the path
of the edge label HAS_CREATOR.Afterward, the extended view carries out an inner match by traversing the path 
from person node to another person node. This, initially might not make sense. But this inner traversal is done 
to see whether person1 might know person2 based on their location, posts, and comments.



