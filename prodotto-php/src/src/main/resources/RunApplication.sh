
# Fabrizio Fatta
# 19/05/2011

echo
echo
echo Run application

cd jar
java -Djava.util.logging.config.file=../ApplicationLogging.properties -Xmx530M -jar *.jar

echo
echo
sleep

# java -Djava.util.logging.config.file=../ApplicationLogging.properties -jar *.jar
# java -Djava.util.logging.config.file=../ApplicationLogging.properties -Xmx530M -jar *.jar
# java -Djava.util.logging.config.file=../ApplicationLogging.properties -Xmx1059M -jar *.jar
# java -Djava.util.logging.config.file=../ApplicationLogging.properties -Xmx1059M -Xms512M -jar *.jar
