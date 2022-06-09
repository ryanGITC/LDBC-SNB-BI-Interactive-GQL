FROM LDBC_SNB
MATCH (country:Country {name: $country}),
 (person1:Person)-[:IS_LOCATED_IN]->(:City)-[:IS_PART_OF]->(country), 
 (person2:Person)-[:IS_LOCATED_IN]->(:City)-[:IS_PART_OF]->(country),
 (person3:Person)-[:IS_LOCATED_IN]->(:City)-[:IS_PART_OF]->(country), 
 (person1)-[k1:KNOWS]-(person2)-[k2:KNOWS]-(person3)-[k3:KNOWS]-(a)
WHERE a.id < b.id
  AND b.id < c.id
  AND $startDate <= k1.creationDate <= k1.creationDate
  AND $startDate <= k2.creationDate
  AND $startDate <= k3.creationDate
RETURN count(*) AS count 
       ,person1
       ,person2
       ,person3





