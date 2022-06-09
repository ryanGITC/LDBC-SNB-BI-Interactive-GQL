// Q16. Fake news detection
// These parameters return a 'false positive' as the maxKnowsLimit is set too high.
/*Translate Bi16 query*/

CREATE QUERY param1_VIEW AS (
 FROM Person
 MATCH (person1:Person)<-[:HAS_CREATOR]-(message1:Message)-[:HAS_TAG]->(tag:Tag {name: paramTagX})
  WHERE date(message1.creationDate) = date(paramDateX)
  RETURN    [
    [{letter: 'A', tag: $tagA, date: $dateA}],
    [{letter: 'B', tag: $tagB, date: $dateB}] AS param
      $letter = 'A' AS paramLetter
        $tag = 'Meryl_Stre AS paramDateX

)
 // filter out Persons with more than $maxKnowsLimit friends who created the same kind of Message
 Create param2_VIEW as (
  OPTIONAL MATCH (person1)-[:KNOWS]-(person2:Person)<-[:HAS_CREATOR]-(message2:Message)-[:HAS_TAG]->(tag)
  WHERE date(message2.creationDate) = date(paramDateX) 
        AND  count(DISTINCT person2)  <= $maxKnowsLimit
  // return count
  RETURN person1
         ,person1
         ,count(DISTINCT message1) AS cm
         ,count(DISTINCT person2) AS cp2
 )
CALL {
param1_VIEW
JOIN param2_VIEW
}
WHERE size(results) = 2
RETURN
  person1.id,
  [({letter: paramLetter, messageCount: cm})]AS results
  [r IN results WHERE r.letter = 'A' | r.messageCount][0] AS messageCountA,
  [r IN results WHERE r.letter = 'B' | r.messageCount][0] AS messageCountB
ORDER BY messageCountA + messageCountB DESC
        ,person1.id ASC
LIMIT 20
