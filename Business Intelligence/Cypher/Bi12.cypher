  /*Translation Bi12 query*/

  FROM  LDBC_SNB
  OPTIONAL MATCH (person: person)<-[:HAS_CREATOR]-(message:Message)-[:REPLY_OF]{0,..}->(post:Post)
  WHERE message.content IS NOT NULL
    AND message.length < 20
    AND message.creationDate > $startDate
    AND post.language IN   ['ar', 'hu']
  RETURN
    messageCount,
    count(person) AS personCount
  ORDER BY
    personCount DESC,
    messageCount DESC

      