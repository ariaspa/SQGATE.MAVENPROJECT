package it.lispa.prodotto.seriouscomponent;

/**
 * classe di test che serve a utilizzare junit per testare la classe SeriousComponentLispa
 *
 * @since 1.0
 * @see java.awt
 */

import junit.framework.TestCase;

public class SeriousComponentLispaTest extends TestCase  {
 

public SeriousComponentLispaTest(String name) {
     super( name );
   }

public void testSeriousness() throws Exception {
    assertTrue( SeriousComponentLispa.seriousness1( "SAD" ) );
    assertTrue( SeriousComponentLispa.seriousness1( "SERIOUS" ) );
    assertTrue( SeriousComponentLispa.seriousness1( "CRAZY" ) );
    assertTrue( !SeriousComponentLispa.seriousness1( "FUNNY" ) );
  }
public void testSeriousness2() throws Exception {
	System.out.println("testSeriousness2 "+SeriousComponentLispa.seriousness2( "INFORMATICA" ).equals("LOMBARDIA INFORMATICA") );
    assertFalse( SeriousComponentLispa.seriousness2( "INFORMATICA" ).equals("LOMBARDIA INFORMATICA")  );
    

  }
}
