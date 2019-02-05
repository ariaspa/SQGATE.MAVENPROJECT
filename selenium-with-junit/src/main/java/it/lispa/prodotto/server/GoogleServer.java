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

public class GoogleServer {
  final static String driverPath = "c:\\tmp\\";
  public static void main(String[] args) throws Exception {
    // TODO Auto-generated method stub
    System.setProperty("webdriver.chrome.driver", driverPath + "chromedriver.exe");
    System.setProperty("webdriver.gecko.driver", driverPath + "geckodriver.exe");

    
  }
  
  public static void GoogleForFireFox(String stringFind) throws Exception {
	  System.out.println("GoogleServer - GoogleForFireFox: "+stringFind);
	  
	  WebDriver driver = new FirefoxDriver();
	    driver.navigate().to("http://www.google.com");
	    WebElement inputField = driver.findElement(By.name("q"));
	    inputField.sendKeys(stringFind);

	    inputField.submit();
	    Thread.sleep(5000);
	    driver.quit();
	    System.out.println("GoogleServer - GoogleForFireFox: esci ");	    
  }
  public static void GoogleForCrome(String stringFind) throws Exception {
	  System.out.println("GoogleServer - GoogleForCrome: "+stringFind);
	  
	  System.setProperty("webdriver.chrome.driver", driverPath + "chromedriver.exe");
	  WebDriver driver = new ChromeDriver();
	  
	  driver = new ChromeDriver();
	  driver.manage().window().maximize();
	  driver.navigate().to("http://www.google.com");
	  String strPageTitle = driver.getTitle();
	  System.out.println("Page title: - "+strPageTitle);
	  
	  driver.get("http://www.google.com/xhtml");
	  Thread.sleep(5000);  // Let the user actually see something!
	  WebElement searchBox = driver.findElement(By.name("q"));
	  searchBox.sendKeys(stringFind);
	  searchBox.submit();
	  Thread.sleep(5000);  // Let the user actually see something!
	  driver.quit();
	    System.out.println("GoogleServer - GoogleForCrome: esci ");	    
  }  
  public static void GoogleForExplorer(String stringFind) throws Exception {
	  System.out.println("GoogleServer - GoogleForExplorer: "+stringFind);
	  
	  WebDriver driver = new InternetExplorerDriver();
	    driver.navigate().to("http://www.google.com");
	    WebElement inputField = driver.findElement(By.name("q"));
	    inputField.sendKeys(stringFind);

	    inputField.submit();
	    Thread.sleep(5000);
	    driver.quit();
	    System.out.println("GoogleServer - GoogleForExplorer: esci ");	    
  }    
}