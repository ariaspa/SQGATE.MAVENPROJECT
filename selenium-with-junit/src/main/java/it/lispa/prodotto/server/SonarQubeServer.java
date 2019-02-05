package it.lispa.prodotto.server;

/**
 * javadoc di prova
 *
 * @since 1.0
 * @see java.awt
 */

import java.net.MalformedURLException;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.ie.InternetExplorerDriver;

public class SonarQubeServer {
  final static String driverPath = "c:\\tmp\\";
  public static void main(String[] args) throws Exception {
    // TODO Auto-generated method stub
    System.setProperty("webdriver.chrome.driver", driverPath + "chromedriver.exe");
    System.setProperty("webdriver.gecko.driver", driverPath + "geckodriver.exe");

    
  }
  
  public static void SonarQubeForFireFox(String stringFind) throws Exception {
	  System.out.println("SonarQubeServer - SonarQubeForFireFox: "+stringFind);
	  
	  WebDriver driver = new FirefoxDriver();
	    driver.navigate().to("http://cm-maven.adlispa.local/sonar/");
	    WebElement inputField = driver.findElement(By.name("q"));
	    inputField.sendKeys(stringFind);

	    inputField.submit();
	    Thread.sleep(5000);
	    driver.quit();
	    System.out.println("SonarQubeServer - SonarQubeForFireFox: esci ");	    
  }
  public static void SonarQubeForCrome(String stringFind) throws Exception {
	  System.out.println("SonarQubeServer - SonarQubeForCrome: "+stringFind);
	  
	  WebDriver driver = new ChromeDriver();
	  driver.get("http://cm-maven.adlispa.local/sonar/");
	  Thread.sleep(5000);  // Let the user actually see something!
	  WebElement searchBox = driver.findElement(By.name("q"));
	  searchBox.sendKeys("ChromeDriver");
	  searchBox.submit();
	  Thread.sleep(5000);  // Let the user actually see something!
	  driver.quit();
	    System.out.println("SonarQubeServer - SonarQubeForCrome: esci ");	    
  }  
  public static void SonarQubeForExplorer(String stringFind) throws Exception {
	  System.out.println("SonarQubeServer - SonarQubeForExplorer: "+stringFind);
	  
	  WebDriver driver = new InternetExplorerDriver();
	    driver.navigate().to("http://www.google.com");
	    WebElement inputField = driver.findElement(By.name("q"));
	    inputField.sendKeys(stringFind);

	    inputField.submit();
	    Thread.sleep(5000);
	    driver.quit();
	    System.out.println("SonarQubeServer - SonarQubeForExplorer: esci ");	    
  }    
}