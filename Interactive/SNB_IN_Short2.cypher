// IS2. Recent messages of a person

In the query below the view carries out a left traversal from the unlabeled message node to the person node in a left manner.
This traversal is done to obtain all the people who are the creator of a message.
Create Query message_VIEW as (
MATCH (:Person {id: $personId})<-[:HAS_CREATOR]-(:message)
Return
 message,
 message.id AS messageId,
 message.creationDate AS messageCreationDate
ORDER BY messageCreationDate DESC, messageId ASC
LIMIT 10
)


From message_VIEW, LDBC_SNB
MATCH (message)-[:REPLY_OF]->(post:Post)-[:HAS_CREATOR]->(person)
RETURN  messageId,
 ,coalesce(message.imageFile,message.content) AS messageContent
,messageCreationDate
 ,post.id AS postId,
 ,person.id AS personId,
 ,person.firstName AS FirstName,
 ,person.lastName AS LastName
ORDER BY messageCreationDate DESC
        ,messageId ASC

From the Match clause above in query 2 there is a traversal from message node to the post node traveled along
the :REPLY_OF label. Do note that this is a left path traversal.
 After the left path traversal there is an left traversal from the person node to the post node along the 
path of HAS_CREATOR to the person node. This traversal looks for the people that replied on a message.
