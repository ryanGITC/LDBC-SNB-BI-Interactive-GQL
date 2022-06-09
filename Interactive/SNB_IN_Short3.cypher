// IS3. Friends of a person


FROM LDBC_SNB
MATCH (n:Person {id: $personId })-[r:KNOWS]-(f:friend)
RETURN
    f.id AS personId,
    f.firstName AS firstName,
    f.lastName AS lastName,
    r.creationDate AS friendshipDate
ORDER BY
    friendshipDate DESC,
    CAST(personId AS INTEGER) ASC

This query retrieves all the friends of a person through the undirected traversal between node person and the
other node friend by traversing the path r:KNOWS.
