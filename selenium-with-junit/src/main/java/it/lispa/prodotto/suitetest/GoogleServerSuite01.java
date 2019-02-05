package it.lispa.prodotto.suitetest;

import org.apache.log4j.xml.DOMConfigurator;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;
import it.lispa.prodotto.server.GoogleServer;

public class GoogleServerSuite01{
	
	
  @BeforeMethod
  public void beforeMethod() throws Exception {
		 System.out.println("GoogleServerSuite01 - beforeMethod");

        }
  
  // This is the starting of the Main Test Case
  @Test
  public void main() throws Exception {
		 System.out.println("GoogleServerSuite01 - main");
	  
		 GoogleServer.GoogleForFireFox("LombardiaInformatica");
		 //GoogleServer.GoogleForCrome("LombardiaInformatica lispa");
		 //GoogleServer.GoogleForExplorer("LombardiaInformatica");
  }
		
  // Its time to close the finish the test case		
  @AfterMethod
  public void afterMethod() {
	 System.out.println("GoogleServerSuite01 - afterMetod");

  		}

}
