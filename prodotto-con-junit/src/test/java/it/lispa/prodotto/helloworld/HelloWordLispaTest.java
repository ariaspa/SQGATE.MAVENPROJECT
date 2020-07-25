package it.lispa.prodotto.helloworld;
import junit.framework.TestCase;
/**
 * classe di test che serve a utilizzare junit per testare la classe HelloWorldLispa
 *
 * @since 1.0
 * @see java.awt
 */
public class HelloWordLispaTest extends TestCase  {
	
	public HelloWordLispaTest(String name) {
	     super( name );
	   }	
	
	public void test1() throws Exception {
		HelloWorldLispa hwl= new HelloWorldLispa();
	    assertTrue( hwl.helloWord().equals("HelloWorld") );
	  }
	
	public void test2() throws Exception {
		HelloWorldLispa hwl= new HelloWorldLispa();
		System.out.println("test2 "+hwl.helloWordLispa("Lispa"));
		assertTrue( hwl.helloWordLispa("Lispa") );
	  }
}
