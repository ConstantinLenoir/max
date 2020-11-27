# Managing a Java project with sh scripting.

# Notes
# ######

# The local man pages for javac, java, jar can be out-of-date. The
# modular JARs are a game changer.

# The JAVA_HOME env. variable points to the default JVM.


# Building, Testing, Documenting and Deploying
# ##############################################

# The story of package managers, compilation helpers and utility tools
# for repetitive tasks. Project management
# tools. pip. Make. apt-get. brew. mvn.


# Console (CLI, text-based pipelines or flows) versus IDE (GUI)
# ##############################################################

# The console complies more with the principle of factorization (aka
# the principle of the separation of the concerns or the principle of
# the single source of truth or the DRY principle).

# 2x2 + 2x3 = 2x(2 + 3)


# Output format and look-and-feel
# ################################

# How to design draw lines and titles in the output to separate the
# different parts of the deployment in a factorized way? A shell
# function (FUNCTIONS section in man bash) ? A printf seems to be more
# appropriate.

# echo $'\n'\ "Tests"\ $'\n' # A special pattern is needed to use \n
# with echo.

# A format for printf.
sep_format="\n\
######################################################################\n\
%$1s\n\
######################################################################\n\n"



# Simple Deployment
# ###################

# JAR files, WAR files and JMOD files represent Java modules as
# archive files.


# javac
# ******

printf $sep_format "Javac (building)"

# Here, you compile source files (.java) to class (bytecode) files
# (.class) and you run the program. The .java file name has to be the
# same as the contained public class.

# source simple_deployment.sh

# .java files have to be specified, optionally with a special-purpose
# file refered to as @my_file. You are not required to organise your
# source files in a way reflecting the package structure ! It's only a
# recommendation.  "You should arrange source files in a directory
# tree that reflects their package tree.  For example, if you keep all
# your source files in /workspace, the source code for
# com.mysoft.mypack.MyClass should be in
# /workspace/com/mysoft/mypack/MyClass.java."  Therefore, dotted paths
# in package statements(inside source files) are converted into URL
# path by javac (directories are created on the fly).

# find (the UNIX program) could be very useful to gather all source
# file paths in a simple way under a given directory. find is used
# below to manage dependencies.

# The javac command supports the new Java Compiler API defined by the
# classes and interfaces in the javax.tools package. For code
# generation ?

# -sourcepath doesn't work like -classpath. You still have to specify
# the relative path of source files (.java) with respect to the
# working directory. What -sourcepath does is to instruct the
# compilator not to search the class paths for source files. Moreover,
# the compiler sometimes uses the source paths to automatically
# compile unspecified source files.

# -classpath (or -cp) is used to specify the dependencies of the
# source files you want to compile. javac is similar to GNU Make in
# many respects.



# Dependencies
# ************

# With gunzip, tar -xf, in the lib/ directory.

# Manual programmatic download
# $curl https://search.maven.org/remotecontent?filepath=junit/junit/4.13.1/junit-4.13.1.jar

# Using the option -newerct of find with the cvs date format ('15
# minutes ago').

# SEE ALSO wget

# paths are separated by : in CLASSPATH. A more verbose alternative is
# to set the -classpath otption with a list of blank separated
# paths. This latter option should be used to isolate Java programs in
# the fashion of python virtual environments.
DEPENDENCIES=$(find $PWD/lib -name "*.jar" | awk 'BEGIN{ORS=":"} {print}')

# CLASSPATH is used by both javac (for validation needs) and java (for
# concrete calls).
export CLASSPATH=$PWD/build/:$DEPENDENCIES

# To keep existing paths, you can use the following command. But this
# naive command can add a path that is already there.

# export CLASSPATH=$CLASSPATH:$PWD/build/:$DEPENDENCIES

rm -R ./build
mkdir ./build

javac -d ./build -verbose $(find ./src -name "*.java")
#./src/max/*.java 


# java
# *****

printf $sep_format "Java (running)"

# java is now (2020) able to both compile and run a single source file.

# You can pass system properties to java -DpropertyName=value

# Log settings
# *************

export LOG4J_CONFIGURATION_FILE=$PWD/log4j_conf.json

export MAX_LOG_PATH=$PWD/log/max # SEE log4j_conf.json

# Running
# ********

java max.Max  10 ":)" 44 3 blabla 1 2 33 +1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000


     

# Testing
# #########

printf $sep_format "Testing"

javac -d build test/*.java

java org.junit.runner.JUnitCore MaxTest

echo $'\n' "Jar" $'\n'

# JUnit 5 and modular JARs
# ***************************

# Using modular JARs with JUnit without Maven entails using more
# complicated options to override the rules of module-info.java. When
# the test engine library is not modular and is not considered as a
# dependency of the modular tested library.

# https://stackoverflow.com/questions/46696451/using-junit-5-with-java-9-without-maven-or-gradle



# Classic (non-modular) JAR Deployment
# ######################################

printf $sep_format "JAR deployment"

# Manifest file: MANIFEST.MF.

# jar mimics tar.

# A jar archive can be used as a class path entry, whether or not it
# is compressed.

# jar can be used to speed up recursive file transfer remotely
# (download time is improved by using 'a single HTTP transaction,
# rather than a new connection for each piece') or locally:

# $(cd dir1; jar c .) | (cd dir2; jar x).

# jar operates on already compiled files.

# Only the package directory name is passed as the 'inputfiles'
# argument. To do that, the -C option is used. If we had passed the
# path of the package without -C, jar (the program jar) would have
# considered all the path components as packages...

# The manifest file
# *******************

# When you create a JAR file, the time of creation is stored in the
# JAR file. It's good to know for versionning.

# 'm' stands for 'manifest file'.

# Note: The Class-Path header points to classes or JAR files on the
# local network, not JAR files within the JAR file or classes
# accessible over Internet protocols. To load classes in JAR files
# within a JAR file into the class path, you must write custom code to
# load those classes. For example, if MyJar.jar contains another JAR
# file called MyUtils.jar, you cannot use the Class-Path header in
# MyJar.jar's manifest to load classes in MyUtils.jar into the class
# path.

# But you can easily solve this probem in placing the content of the
# JAR dependencies under the root of your JAR (see the project
# example_one in examples/). Or you can use Maven (see below).

# One could make a JAR file aware of its content in using a special
# part of the Java standard library (ClassLoader).

# The i option is used to speed up the application's class loading
# time with respect to the 'Class-Path' header (an INDEX.LIST file is
# created).

# SEE ALSO
# https://docs.oracle.com/javase/tutorial/deployment/jar/apiindex.html.

# Once the main class is loaded, the reflection API of the
# java.lang.reflect package is used to pass the arguments to the class
# and launch it.

# Maven is the solution to go further (uber JARs aka fat JARs or JARs
# with dependencies).


# A single '>' (truncating, the file size becomes 0). This means that
# the content is erased.
echo $'Main-Class: max.Max' > ./src/MY_HEADERS.txt

header_class_path=$(find $PWD/lib -name "*.jar" | awk 'BEGIN{ORS=" "; OFS=""} {n=split($1, arr, "/"); print "./", arr[n] }')

# A double '>>' (appending).
echo "Class-Path: " $header_class_path >> ./src/MY_HEADERS.txt


# Multiple '-C path/to/a/dir another/path/to/a/file' statements can be
# passed to jar. MY_HEADERS.txt is used to add entries to the manifest
# file.
jar  cmfv ./src/MY_HEADERS.txt ./build/max.jar -C build max


cp $(find ./lib -name "*.jar") ./build

printf $sep_format "Java -jar (running)"

java -jar ./build/max.jar joujou 10 44 3 1 2 33 extra    777




# JavaDoc
# #########


printf $sep_format "JavaDoc"

# A package is a directory whose name matches the dotted package name
# you specified on the CLI.

rm -R ./docs
mkdir ./docs

javadoc -verbose -d ./docs -sourcepath ./src/ max


# Modular JAR deployment 
# #######################

# The module system is the most important new software engineering
# technology in Java since its inception. Distinction between modular
# JARs and non-modular JARs. The 'Automatic-Module-Name' header in the
# manifest file. The new Module class of java.lang.Object with
# anInstance.getClass().getModule(). The module system creates a
# module from every JAR it finds on the module path. For plain
# (non-modular) JARs (no module descriptor) this approach doesn't
# work, so what should the module system do instead? It automatically
# creates a module - an automatic module, so to speak - and takes the
# safest guesses for the three properties.

# The jdeps CLI tool to analyse module dependencies. The new
# --describe-module option of jar.

# https://www.oracle.com/corporate/features/understanding-java-9-modules.html

# https://stackoverflow.com/questions/46741907/what-is-an-automatic-module

# $java --list-modules

# javac and java have new options to use modular JAR and modify the
# rules of module-info.java on the fly: --add-modules, --list-modules,
# --module-path, --add-reads, --add-exports, --add-opens. For example,
# you need those options to link JUnit with your module.


# SEE ALSO the WAR format which is a special JAR for web applications.

# The JMOD format
# ****************

# For most development tasks, including deploying modules on the
# module path or publishing them to a Maven repository, continue to
# package modules in modular JAR files. The jmod tool is intended for
# modules that have native libraries or other configuration files or
# for modules that you intend to link, with the jlink tool, to a
# runtime image.

# The JMOD file format lets you aggregate files other than .class
# files, metadata, and resources. This format is transportable but not
# executable, which means that you can use it during compile time or
# link time but not at run time.


# Maven deployment
# ##################

printf $sep_format "Maven deployment"

# Both a build tool and a package manager involving concepts like
# group IDs and artifact IDs. The concept of POM (project object
# model). Sharing JARs across several projects. Project metadata. Test
# coverage. Reflection (introspection) capabilities. Cookicutters and
# best practices.

# http://maven.apache.org/background/philosophy-of-maven.html

# On a very high level all projects need to be built, tested,
# packaged, documented and deployed.

# http://maven.apache.org/guides/getting-started/index.html

# This is a reference for the Maven project descriptors used in Maven.
# http://maven.apache.org/ref/3.6.3/maven-model/maven.html


# Building an executable uber JAR with the shade plugin.
# https://maven.apache.org/plugins/maven-shade-plugin/examples/executable-jar.html

# src/main/java/ and src/test/java/ are required by the specification
# of the standard directory layout but you can design your own layout
# at the expense of extra code. A new archetype is a Maven project on
# its own...

# http://maven.apache.org/guides/introduction/introduction-to-the-standard-directory-layout.html


# When building the uber executable JAR, overlapping resources (not
# classes) are detected because of the META-INF directory in the JAR
# dependencies. This is obviously not a subject of concern.

# Stackoverflow only keep the first charecters of the subject's name.
# https://stackoverflow.com/questions/64110058/maven-shade-plugin-how-resolve-the-warning-message-define-1-overlapping-resour

# There is a problem of integration between Java 11 and Log4J
# concerning refection classes. A warning is fired up about a possible
# performance issue. It is speculative. This explains why, in 2020,
# enterprises still use Java 8.

# The minimizeJar option seems to be unsafe, unstable.

# maven-assembly-plugin is an alternative to build the executable jar.


# Generating the project archetype in batch mode.
# http://maven.apache.org/archetype/maven-archetype-plugin/examples/generate-batch.html

# mvn archetype:generate -B\
#     -DarchetypeGroupId=org.apache.maven.archetypes\
#     -DarchetypeArtifactId=maven-archetype-simple\
#     -DgroupId=com.plateaunoir\
#     -DartifactId=max\
#     -Dversion=1.0-SNAPSHOT\
#     -Dpackage=max

# This command generates sample Java source files (for illustration
# needs) and, in particular, a pom.xml which you can customize. You
# remove the generated source files and copy yours.

# rm -R maven/max/src/main/java/*
# cp -R src/* maven/max/src/main/java/

# rm -R maven/max/src/test/java/*
# cp -R test/* maven/max/src/test/java/


# We need to temporarily set your working directory to maven/max/ to
# run mvn commands. To do that, you can use the pattern pushd-cd-popd
# or a subshell in using parenthesis which are Bash metacharacters.

# $( cd ... my_command )

# Do no forget blank spaces after '(' and before ')'.

pushd .
cd maven/max

mvn clean
mvn package

popd

# Dependencies included.
printf $sep_format "Java -jar with the executable uber JAR (running)"

java -jar maven/max/target/*uber* 4 100 -45 something

# Related deployment technologies
# #################################

# Jenkins
# ********

# CI/CD


# Docker
# *******

# Puppet
# *******

# Puppet is model-driven, requiring limited programming knowledge to
# use. An open-core software configuration management tool. It runs on
# many Unix-like systems as well as on Microsoft Windows, and includes
# its own declarative language to describe system configuration.
