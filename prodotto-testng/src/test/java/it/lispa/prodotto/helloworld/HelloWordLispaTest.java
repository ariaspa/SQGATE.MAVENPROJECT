package it.lispa.prodotto.helloworld;
import org.testng.annotations.Test;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.AfterTest;

public class HelloWordLispaTest {
	HelloWordLispa helloWord= null;
  @Test
  public void f() {
	  helloWord.App();

  }
  @BeforeTest
  public void beforeTest() {
	  System.out.println("********HelloWordLispaTest BEFORE********");
	 
	  helloWord = new HelloWordLispa();
	  helloWord.beforeApp();
  }

  @AfterTest
  public void afterTest() {
	  System.out.println("********HelloWordLispaTest AFTER********");
	  
	  helloWord.AfterApp();
  }

}
