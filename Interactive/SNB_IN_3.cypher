
At first a view is created to select the nodes countryXname and countryYName and the person 

CREAATE QUERY country_VIEW1 as (
FROM LDBC_SNB
MATCH (x:Country {name: $countryXName }),
      (y:Country {name: $countryYName }),
      (p:Person {id: $personId })
RETURN person
       ,x AS countryA
       ,y AS countryB

LIMIT 1
)

In city_VIEW1 the path between city and country nodes is traversed right along the path IS_PART_OF.
From the previous view we do need the variables countryA and countryB, to see in which cities a person is or has been 
After the path traversal the cities a person has been to are returned with their respective country

CREATE QUERY city_VIEW2 as (
FROM country_VIEW1
MATCH (c:City)-[:IS_PART_OF]->(c:Country)
WHERE country IN [countryA, countryB]
RETURN person
       ,countryA
       ,countryB
       ,COLLECT(c) AS cities
)
In the view  hereunder, we have a path traversal from the predicate p indicating the node person
to a city along the edge with the label IS_LOCATED_IN. After the path traversal, the friend its id is returned along with the
country.

CREATE QUERY city_VIEW3 as (
FROM city_VIEW2 
MATCH (p:Person where  p.id <> f:friend.id)-[:IS_LOCATED_IN]->(c:City WHERE c.id <> c.id)
WHERE p.id == country_VIEW1.p.id 
RETURN DISTINCT f
               ,countryA
               ,countryB
)

In the query below there are two distinct path traversals. In the first path traversal, there is a left path traversal
from the node message to a friend to see to which individual the message belongs, and traverses along the edge with the label 
: HAS_CREATOR. The second path traversal is a right path traversal to retrieve the country from where the message is sent
.After traversal, the id is retrieved from the friend and to the related country a value of 1 is assigned  if the message is sent from the same country
as the location of a person  or 0 if the message is sent from a different location.

FROM LDBC_SNB,city_VIEW3,city_VIEW2,city_VIEW1
MATCH (f:Friend)<-[:HAS_CREATOR]-(m:message),
      (m:message)-[:IS_LOCATED_IN]->(c:country)
WHERE $endDate > m.creationDate >= $startDate AND
      country IN [countryA, countryB] AND city_VIEW3.f.id == f.id
RETURN f,
     CASE WHEN country=countryA THEN 1 ELSE 0 END AS messageA,
     CASE WHEN country=countryB THEN 1 ELSE 0 END AS messageB
     sum(messageA) AS countA, sum(messageB) AS countB

GROUP BY f.id 
HAVING countA >0 AND countB>0
     
The last query is a union of union of all the views together that retrieves the  respective varaibles

CALL {
country_VIEW1
UNION
country_VIEW2
UNION
country_VIEW3

RETURN country_VIEW1.f.id AS friend,
       country_VIEW2.f.firstName AS friend_FirstName,
       country_VIEW2.f.lastName AS friend_LastName,
       countA,
       countB,
       countA + countA AS ABCount
}
ORDER BY ABCount DESC
        , friend ASC
LIMIT 20
