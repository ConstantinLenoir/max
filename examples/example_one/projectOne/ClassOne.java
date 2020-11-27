package projectOne;

import projectTwo.ClassTwo;

public class ClassOne {
    public static void main (String[] args) {
	System.out.println("I am ClassOne.");
	ClassTwo.main(new String[]{});
    }
}
