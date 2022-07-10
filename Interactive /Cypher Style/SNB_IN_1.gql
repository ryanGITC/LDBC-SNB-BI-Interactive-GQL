

CREATE QUERY friend_VIEW1  AS ( 
FROM LDBC_SNB
MATCH (p:Person {id: $personId}) ~[:friend] ~ (Person {firstName: $firstName})
RETURN p 
      ,friend
)

CREATE QUERY  friend_VIEW2 AS (
FROM LDBC_SNB, friend_VIEW1
MATCH path = shortestPath((p)-[:KNOWS]-(f:friend)) {1,3}
WHERE p.id == friend_VIEW1.p.id
Return min(length(path)) AS distance
       , f
ORDER BY
    distance ASC,
    f.lastName ASC,
    toInteger(f.id) ASC
LIMIT 20

CREATE QUERY friend_VIEW3 as (
MATCH (f:friend)-[:IS_LOCATED_IN]->(friendCity:City)
OPTIONAL MATCH (friend)-[studyAt:STUDY_AT]->(uni:University)-[:IS_LOCATED_IN]->(uniCity:City)
CASE uni.name
        WHEN null T
        THEN null
        ELSE [uni.name, studyAt.classYear, uniCity.name]
 END ) AS 
WHERE f.id == friend_VIEW1.f.id
 Return  unis
        ,friendCity
        ,distance
)

FROM friend_VIEW1,friend_VIEW2,friend_VIEW3
OPTIONAL MATCH (f:friend)-[workAt:WORK_AT]->(company:Company)-[:IS_LOCATED_IN]->(companyCountry:Country)
CASE company.name
        WHEN null THEN null
        ELSE [company.name, workAt.workFrom, companyCountry.name]
END ) AS companies
WHERE f.id = friend_VIEW1.id 
Return
        p.id AS friendId,
        f.lastName AS friendLastName,
        distance   AS distanceFromPerson,
        p.birthday AS friendBirthday,
        p.creationDate AS friendCreationDate,
        p.gender AS friendGender,
        p.browserUsed AS friendBrowserUsed,
        p.locationIp AS friendLocationIp,
        p.email AS friendEmails,
        p.speaks AS friendSpeaks,
        friendCityName AS friendCityName,
        companies AS friendCompanies,
        universities as friendUniversities


