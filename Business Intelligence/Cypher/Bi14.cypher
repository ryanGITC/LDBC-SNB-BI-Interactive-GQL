// Q14. International dialog
/*Translate Bi14 query*/
CREATE QUERY internal_dialog_VIEW AS (
FROM LBC_SNB
MATCH
  (country1:Country {name: $country1})<-[:IS_PART_OF]-(city1:City)<-[:IS_LOCATED_IN]-(person1:Person),
  (country2:Country {name: $country2})<-[:IS_PART_OF]-(city2:City)<-[:IS_LOCATED_IN]-(person2:Person),
  (person1)-[:KNOWS]-(person2)
Return person1
       ,person2
       ,city1
       ,0 AS score
)



// case 1 // Ommitt FROM since it needs to be on the first 
OPTIONAL MATCH (person1)<-[:HAS_CREATOR]-(c:Comment)-[:REPLY_OF]->(:Message)-[:HAS_CREATOR]->(person2)
Return DISTINCT person1
               ,person2
               ,city1
               ,score + (CASE c WHEN null THEN 0 ELSE  4 END) AS score

// case 2// Ommit FROM, it requires person from the first tag
OPTIONAL MATCH (person1)<-[:HAS_CREATOR]-(m:Message)<-[:REPLY_OF]-(:Comment)-[:HAS_CREATOR]->(person2)
RETURN DISTINCT person1
                ,person2
                ,city1
                ,score + (CASE m WHEN null THEN 0 ELSE  1 END) AS score
// case 3
OPTIONAL MATCH (person1)-[:LIKES]->(m:Message)-[:HAS_CREATOR]->(person2)
RETURN  DISTINCT person1
                ,person2
                ,city1
                ,score + (CASE m WHEN null THEN 0 ELSE 10 END) AS score
// case 4
OPTIONAL MATCH (person1)<-[:HAS_CREATOR]-(m:Message)<-[:LIKES]-(person2)
RETRURN DISTINCT person1.id
                ,person2.id
                ,city1.name
                ,score + (CASE m WHEN null THEN 0 ELSE  1 END) AS score DESC
  

  // using a list might be faster, but the browser query editor does not like it
 // collect({score: score, person1: person1, person2: person2})[0] AS top

ORDER BY
  top.score DESC,
  top.person1.id ASC,
  top.person2.id ASC
