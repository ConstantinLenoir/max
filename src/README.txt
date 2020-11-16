
TODO
=====

A scalable fault-tolerant max program.


NOTES
======

The Runtime class.

The Java security managers can exert a great control over the JVM
operations.


A FINITE STATE MACHINE TO CONSTRUCT THE RESPONSE
==================================================

The string response of the program depends on many aspects of the
arguments.

A graph of states connected by transitions.

The Spring (Spring is a framework) state machine.

The State design pattern (GoF).

The if-else if-else nested design.

The enum-while(true)-switch design.

BIG DATA
=========

When all arguments can't fit to memory.

At the lowest level, all streams are driven by a spliterator.

java.util.stream: stream-bearing methods, stream pipeline, at the
lowest level, all streams are driven by a spliterator,
DoubleStream.max().

The package java.util.function
********************************

Functional interfaces provide target types for lambda expressions and method references. Each functional interface has a single abstract method, called the functional method for that functional interface, to which the lambda expression's parameter and return types are matched or adapted. Functional interfaces can provide a target type in multiple contexts, such as assignment context, method invocation, or cast context:


     // Assignment context
     Predicate<String> p = String::isEmpty;

     // Method invocation context
     stream.filter(e -> e.getSize() > 10)...

     // Cast context
     stream.map((ToIntFunction) e -> e.getSize())...
 
