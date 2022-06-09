The query below first selects the city node, without any traversal to another node. After the selection
a temporary view node is constructed that includes the person its details and path is traversed from that entitity 
to the city node in the match clause which selected the city node. The path which is traversed is named :IS_LOCATED_IN l

CREATE QUERY tag_VIEW AS {
FROM LDBC_SNBI
MATCH (c:City {id: $cityId})
CREATE (p:Person {
    id: $personId,
    firstName: $personFirstName,
    lastName: $personLastName,
    gender: $gender,
    birthday: $birthday,
    creationDate: $creationDate,
    locationIP: $locationIP,
    browserUsed: $browserUsed,
    languages: $languages,
    email: $emails
  })-[:IS_LOCATED_IN]->(c)
RETURN  $tagIds AS tagId
}

After a retrieval of the id's with their respect tag's ,the following query selects the results obtained, which are id's of the tag 
and creates another node view which is traversed from the person to the tag node, along the path named :HAS_INTEREST

Create Query as  interest_VIEW AS {
FROM tag_VIEW
  MATCH (t:Tag {id: tagId})
  CREATE (p)-[:HAS_INTEREST]->(t)
 Return p, count(*) AS times,
        $studyAt AS place
}

FROM interest_VIEW,LDBC_SNB
MATCH (o:Organisation {id: s[0]})
CREATE (p)-[:STUDY_AT {classYear: s[1]}]->(o)
Return p
      ,count(*) AS times2
      ,$workAt AS w
   
MATCH (comp:Organisation {id: w[0]})
  CREATE (p)-[:WORKS_AT {workFrom: w[1]}]->(comp)

In the interest_VIEW there is a selection of the organisation node. Also in that subquery another nodeview is created 
from the node p where threre is a traversal from the person node to the organisation node, at which a traversal is done 
along the path of :STUDY_AT. In addition there is another path created from the person node to the organisation
node, and a path traversal is done through the WORKS_AT path.
