
# Simple Deployment
#####################

# JAR files and JMOD files are Java modules.

# Here, you compile source files (.java) to class (bytecode) files
# (.class) and you run the program. The .java file name has to be the
# same as the contained public class.

# source simple_deployment.sh

rm -R ./build
mkdir build
javac -d ./build -verbose ./src/*.java 

# With javac, dotted paths in package statements are converted into
# URL path by javac (directories are created on the fly).

# -sourcepath doesn't work like -classpath. You still have to specify
# the relative path of source files (.java) with respect to the
# working directory. What -sourcepath does is to instruct the
# compilator not to search the class paths for source files. Moreover,
# the compiler sometimes uses the source paths to automatically
# compile unspecified source files.

# -classpath is used to specify the dependencies of the source files
# you want to compile. javac is similar to GNU Make in many respects.



# Test
java -classpath $CLASSPATH:$PWD/build \
     max.Max a usa baby 10 44 3 1 2 33 +1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000



# Alternative
###############

# export CLASSPATH=$CLASSPATH:$PWD/build/
# java max.Max 1 10 30 7


# JAR Deployment
#################


# Manifest file: MANIFEST.MF.

# jar mimics tar.

# A jar archive can be used as a class path entry, whether or not it
# is compressed.

# jar can be used to speed up recursive file transfer remotely
# (download time is improved by using 'a single HTTP transaction,
# rather than a new connection for each piece') or locally:

# $(cd dir1; jar c .) | (cd dir2; jar x).

# When you create a JAR file, the time of creation is stored in the
# JAR file. It's good to know for versionning.

# 'm' stands for 'manifest file'.

# jar operates on already compiled files.

# Only the package directory name is passed as the 'inputfiles'
# argument. To do that, the -C option is used. If we had passed the
# path of the package without -C, jar would have considered all the
# path components as packages...

jar  cmfv ./src/MY_HEADERS.txt ./build/max.jar -C ./build max

java -jar ./build/max.jar a usa baby 10 44 3 1 2 33

