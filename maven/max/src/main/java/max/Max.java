package max;

import java.util.ArrayList;
import java.util.StringJoiner;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class Max {

    private String[] args;
    private int argCount = 0; // Once and for all.

    private int numberOfExceptions = 0;
    
    private double max = Double.NEGATIVE_INFINITY;

    private StringJoiner response = new StringJoiner(System.lineSeparator());
    // See also StringBuilder.

    private int currentIndex = 0;

    // The default name is the name of the enclosing class.
    private static final Logger logger = LogManager.getFormatterLogger("myLogger");
    
    public static void main(String [] args) {
	// Non-static variables cannot directly be referenced from a
	// static context.
	// System.setProperty("log4j2.configurationFile", "")
	Max maxProcess = new Max(args);
	System.out.println(maxProcess.getResponse());
	System.exit(0);
	
    }
    /**
     * To construct an object exposing two elements: the
     * maximum number found in {@code args} and a diagnostic message,
     * the {@code response}.
     *
     * @param args {@code args} is a string containing a list of blank
     * separated values which represent numbers. The allowed decimal
     * separator is {@code .} (not {@code ,}). A future release could
     * be more flexible about this convention which depends on the
     * locale. {@code Max()} doesn't support all existing ways of
     * formatting, encoding a number. This program is
     * fault-tolerant. Faults are reported in the diagnostic message.
     *
     * 
     */
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
	    logger.trace("Fault: %1$s", args[currentIndex]);
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
