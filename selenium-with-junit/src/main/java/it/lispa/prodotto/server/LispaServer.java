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

public class LispaServer {
  final static String driverPath = "c:\\tmp\\";
  public static void main(String[] args) throws Exception {
    // TODO Auto-generated method stub
	  
    System.setProperty("webdriver.chrome.driver", driverPath + "chromedriver.exe");
    System.setProperty("webdriver.gecko.driver", driverPath + "geckodriver.exe");

    
  }
  
  public static void LispaForSelenium(String stringFind) throws Exception {
	  System.out.println("LispaServer - LispaForSelenium: "+stringFind);
	  
    WebDriver driver = new FirefoxDriver();
    driver.navigate().to("http://http://www.lispa.it/");
    WebElement inputField = driver.findElement(By.name("q"));
    inputField.sendKeys(stringFind);
    inputField.submit();
    Thread.sleep(5000);
    inputField.clear(); 
    driver.quit();
  }
  
}