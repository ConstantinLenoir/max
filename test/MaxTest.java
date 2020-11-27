import max.Max;
import org.junit.Test;
import org.junit.BeforeClass;
import static org.junit.Assert.assertEquals;


public class MaxTest {


    private static String[] args;
    private static String[] corruptedArgs;
    private static double theMax;

    
    @BeforeClass
    public static void setUpClass() {
	// Setting up a test fixture.
	// More complex test datasets could be built.
	args = new String[] {"1", "7.5", "-2", "3"};
	corruptedArgs = new String[] {"1", "3", "blabla", "-2", " ...", "7.5"};
	theMax = 7.5;
    }

    
    @Test
    public void testAccuracy() {
	Max maxProcess = new Max(args);
	// Different signatures for assertEquals() are available.
	assertEquals(theMax, maxProcess.getMax(), Double.MIN_VALUE);
    }

    @Test
    public void testFaultTolerance() {
	Max maxProcess = new Max(corruptedArgs);
	assertEquals(theMax, maxProcess.getMax(), Double.MIN_VALUE);
    }
}
