package max;

import java.util.ArrayList;
import java.util.StringJoiner;
    
public class Max {

    private String[] args;
    private int argCount = 0; // Once and for all.

    private int numberOfExceptions = 0;
    
    private double max = Double.NEGATIVE_INFINITY;

    private StringJoiner response = new StringJoiner(System.lineSeparator());
    // See also StringBuilder.

    private int currentIndex = 0;
    
    public static void main(String [] args) {
	// Non-static variables cannot directly be referenced from a
	// static context.
	Max maxProcess = new Max(args);
	System.out.println(maxProcess.getResponse());
	System.exit(0);
	
    }

    public Max(String[] args){
	this.args = args;
	argCount = args.length;
	
	runFaultTolerantProcess();

	buildResponse();
    }
	
    private void runFaultTolerantProcess() {
	// Recursive function.
	
	// This function has many side effects and operates on the
	// attributes of the enclosing class.
	try {
	    while (currentIndex < argCount) {
		double currentNumber = Double.parseDouble(args[currentIndex]);
		if (currentNumber > max) {
		    max = currentNumber;
		}
		currentIndex++;
	    }
	}
	catch(NumberFormatException e) {
	    numberOfExceptions++;
	    currentIndex++; // Fix: the item is skipped.
	    runFaultTolerantProcess();
	}	
    }

    private void buildResponse() {
	// Template string.
	// docs/api/java.base/java/util/Formatter.html#syntax

	// One benefit of formatted strings is to adapt to the locale.
	if (argCount == 0) {
	    response.add("There is no arguments to process.");
	}
	else {
	    if (numberOfExceptions > 0) {
		String aTemplateString = "Percentage of successfully parsed arguments: %1$1.1f%%.";
		// '%%', as a format string, returns '%'.
		double aPercentage = 100 * (1 - ((double) numberOfExceptions) / argCount);
		response.add(new String().format(aTemplateString,
						 aPercentage));
	    }

	    if (numberOfExceptions == argCount) {
		response.add("Unfortunately, none of the arguments have been successfully parsed.");
	    }
	    else {
		if (max == Double.NEGATIVE_INFINITY) {
		    response.add(new String().format("The max is smaller than %1g.",
						     Double.MIN_VALUE));
		}
		else if (max == Double.POSITIVE_INFINITY) {
		    response.add(new String().format("The max is greater than %1g.",
						     Double.MAX_VALUE));
		}
		else {
		    response.add(new String().format("The max is %1f.",
						     max));
		}
	    }
	}
	
    }

    public double getMax() {
	if (numberOfExceptions < argCount) {
	    return max;
	}
	else {
	    return Double.NaN;
	}
    }
    
    public StringJoiner getResponse(){
	return response;
    }
}
