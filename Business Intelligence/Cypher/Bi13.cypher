/*Translate Bi13 query*/

FROM LDBC_SNB
MATCH (country:Country {name: $country})
<-[:IS_PART_OF]-(:City)
<-[:IS_LOCATED_IN]-(zombie:Person)
WHERE zombie.creationDate < $endDate
RETURN country, zombie
OPTIONAL MATCH (zombie)<-[:HAS_CREATOR]-(message:Message)
WHERE message.creationDate < $endDate
    AND  messageCount / months < 1
RETURN  country
       ,zombie
       ,count(message) AS messageCount


OPTIONAL MATCH
  (zombie)<-[:HAS_CREATOR]-(message:Message)<-[:LIKES]-(likerZombie:Person)
WHERE likerZombie IN zombies
RETURN country,
       collect(zombie) AS zombies
         12 * ($endDate.year  - zombie.creationDate.year )
     + ($endDate.month - zombie.creationDate.month)
     + 1 AS months
     ,messageCount


OPTIONAL MATCH
  (zombie)<-[:HAS_CREATOR]-(message:Message)<-[:LIKES]-(likerPerson:Person)
WHERE likerPerson.creationDate < $endDate
RETURN zombie.id
       ,count(likerZombie) AS zombieLikeCount
       ,zombieLikeCount,
       ,totalLikeCount,
  CASE totalLikeCount
    WHEN 0 THEN 0.0
    ELSE zombieLikeCount / toFloat(totalLikeCount)
  END AS zombieScore
ORDER BY
  zombieScore DESC,
  zombie.id ASC
LIMIT 100
