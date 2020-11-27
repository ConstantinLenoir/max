
lib/ gathers the dependencies (third-party libraries) of max.

log4j
======
======

How to install log4j.
https://logging.apache.org/log4j/2.x/download.html
https://logging.apache.org/log4j/2.x/manual/architecture.html

The use of a json config file requires to install three other jar
dependencies (com.fasterxml.jackson.core:{jackson-core,
jackson-databind, jackson-annotations}).

Log4j 2 is broken up between an API and an implementation, the primary
purpose of doing so was to clearly define what classes and methods are
safe to use in "normal" application code.

Log4j provides other jar files implementing the interface between
log4j and special systems like MongoDB, various databases etc.


You shouldn't make the code feel like it is more about logging than
the actual task at hand.

Features
*********

The ability to selectively enable or disable logging requests based on
their logger is only part of the picture. Log4j allows logging
requests to print to multiple destinations. In log4j speak, an output
destination is called an Appender.

Pattern Layout
***************

https://logging.apache.org/log4j/2.x/manual/layouts.html#PatternLayout

A flexible layout configurable with pattern string. The goal of this
class is to format a LogEvent and return the results. The format of
the result depends on the conversion pattern.
The conversion pattern is closely related to the conversion pattern of
the printf function in C. A conversion pattern is composed of literal
text and format control expressions called conversion specifiers.

Configuration
****************

Environment variables.

System properties with System.setProperty().

'additivity', refers to the right of a logger to handle an event
whereas another logger has already handled it.


SEE ALSO the Simple Logging Facade for Java (SLF4J) which serves as a
simple facade or abstraction for various logging frameworks, such as
java.util.logging, logback and log4j.

The the 'includeLocation' attribute of loogers: capturing location
information is time-consuming and should be limited.


JUnit
======
======

Questions and documentation fragments
https://junit.org/junit4/faq.html

Tutorials
The fundamentals don't change, whatever the version is.
http://junit.sourceforge.net/doc/testinfected/testing.htm
http://junit.sourceforge.net/doc/cookstour/cookstour.htm

The Test annotation tells JUnit that the public void method to which
it is attached can be run as a test case. To run the method, JUnit
first constructs a fresh instance of the class then invokes the
annotated method.

The default JUnit runner treats tests with failing assumptions
(assumeBlabla()) as ignored.

Four ways to test throwed exception:
with a try/catch,
with a special @Rule (JUnit4),
with @Test(expected=MyException.class) (JUnit4),
with assertTrhows() (JUnit5).

The first one is the oldest and the simplest in my view.

Using annotations everywhere is the new black. JUnit 4, for example,
implements test suites with a placeholder (empty) class decorated by
special annotations specifying a suite of test classes which are
defined by elsewhere.

Using the assertBlabla() with a String as the first argument is an
alternative to parameterized tests. There are other solutions.

The Hamcrest matching library (SEE the RELATED LIBRARIES section
below) help developers to implement assumptions in tests.

When setting a fixture with a static method, non local variables need
to be static.


JUnit 4
*********

https://github.com/junit-team/junit4/wiki


JUnit 5
*********

Unlike previous versions of JUnit, JUnit 5 is composed of several different modules from three different sub-projects.

JUnit 5 = JUnit Platform + JUnit Jupiter + JUnit Vintage

JUnit Platform
****************

One of the prominent goals of JUnit 5 is to make the interface between
JUnit and its programmatic clients – build tools and IDEs – more
powerful and stable. The purpose is to decouple the internals of
discovering and executing tests from all the filtering and
configuration that’s necessary from the outside.

The console is considered as both a programmatic client (sh scripts)
and an CLI interactive client.


The standalone JAR
*******************

JUunit 5 provides a standalone JAR that serves as an automatic module
for compilation and test running.

java -jar junit-platform-console-standalone-1.7.0.jar <Options>


https://stackoverflow.com/questions/46696451/using-junit-5-with-java-9-without-maven-or-gradle


Related libraries
******************

AssertJ

Hamcrest: a library for matching. 'Matching' means ensuring that an
object match a range of requirements before being tested.
