
FROM LDBC_SNB
MATCH(p1:Person {id: $person1Id}),(p2:Person {id: $person2Id}),
    path = shortest((p1)-[:KNOWS]-(p2)){*}
RETURN
    CASE path IS NULL
        WHEN true THEN -1
        ELSE length(path)
    END AS shortestPathLength

The shortest path available \textbf{ SCHRIJF DIE PAGINA NUMMER OP OF REFERENCE} fucntionality is used here and is traversed at most between 0 or more repetitions.
As a final result the length of the path is returned.