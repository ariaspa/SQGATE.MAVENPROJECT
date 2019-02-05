package it.lispa.prodotto.seriouscomponent;


import org.testng.annotations.Test;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.AfterTest;

public class SeriousComponentLispaTest {
  @Test
  public void test1() {
	  assert SeriousComponentLispa.verificaContieneword("FUNNY");
  }
  @Test
  public void test2() { 
	  assert SeriousComponentLispa.verificaNonContieneword("FUN");
  }
  @Test
  public void test3() { 
	  System.out.println(SeriousComponentLispa.addWord("INFORMATICA"));
  }
  @BeforeTest
  public void beforeTest() {
	  System.out.println("********SeriousComponentLispa BEFORE********");
  }

  @AfterTest
  public void afterTest() {
	  System.out.println("********SeriousComponentLispa AFTER********");
	  
  }

}
