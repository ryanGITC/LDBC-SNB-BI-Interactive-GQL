# Description
Conversion the GSQL SNB Interactive and Business Intelligence queries to the Cypher and SQL style of GQL

# Benchmark
The Interactive and Business intelligence benchmark belong to the LDBC community. More info on how to generate the data can be found on [https://github.com/ldbc/ldbc_snb_datagen_spark]

# Tool
In order to test the pattern match the GQL parser is utilized. Instruction on how to use the parser can be found in [https://github.com/OlofMorra/GQL-parser]
Incase there is an error in running the parser on windows the following commands can be used:

clean install: mvn clean install '-Dmaven.test.skip=true' <br />
running : mvn clean install '-Dmaven.test.skip=true'
