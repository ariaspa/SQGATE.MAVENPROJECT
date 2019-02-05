package it.lispa.prodotto.suitetest;

import org.apache.log4j.xml.DOMConfigurator;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;
import it.lispa.prodotto.server.SonarQubeServer;

public class SonarQubeServerSuite01{
	
	
  @BeforeMethod
  public void beforeMethod() throws Exception {
		 System.out.println("SonarQubeServerSuite01 - beforeMethod");

        }
  
  // This is the starting of the Main Test Case
  @Test
  public void main() throws Exception {
		 System.out.println("SonarQubeServerSuite01 - main");
		 SonarQubeServer.SonarQubeForFireFox("cartaes");
		 //GoogleServer.GoogleForCrome("Lispa");
		 //GoogleServer.GoogleForExplorer("Lispa");

		
  }
		
  // Its time to close the finish the test case		
  @AfterMethod
  public void afterMethod() {
	 System.out.println("SonarQubeServerSuite01 - afterMetod");

  		}

}
