
javac -d ./target -verbose $(find ./projectTwo -name "*.java")

javac -d ./target -verbose $(find ./projectOne -name "*.java")

# Right.
jar  cmfv MY_HEADERS.txt ./target/projectOne.jar -C ./target projectOne -C ./target projectTwo

# Wrong.
# jar  cmfv MY_HEADERS.txt ./target/projectOne.jar -C ./target projectOne

java -jar target/projectOne.jar
