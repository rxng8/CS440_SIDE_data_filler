// Generated by Selenium IDE
import org.junit.Test;
import org.junit.Before;
import org.junit.After;
import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.core.IsNot.not;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Alert;
import org.openqa.selenium.Keys;
import java.util.*;
import java.net.MalformedURLException;
import java.net.URL;
public class Simplegoogletest1Test {
  private WebDriver driver;
  private Map<String, Object> vars;
  JavascriptExecutor js;
  @Before
  public void setUp() {
    driver = new ChromeDriver();
    js = (JavascriptExecutor) driver;
    vars = new HashMap<String, Object>();
  }
  @After
  public void tearDown() {
    driver.quit();
  }
  @Test
  public void simplegoogletest1() {
    driver.get("https://docs.google.com/forms/d/e/1FAIpQLSdPjHkWERxA1G_yuTXwvFRLeZJY4cYr4_1OHuzwapvqyQGKVA/viewform");
    driver.manage().window().setSize(new Dimension(1200, 782));
    driver.findElement(By.cssSelector(".freebirdFormviewerViewNumberedItemContainer:nth-child(1) .quantumWizTextinputPaperinputInput")).click();
    driver.findElement(By.cssSelector(".freebirdFormviewerViewNumberedItemContainer:nth-child(1) .quantumWizTextinputPaperinputInput")).sendKeys("@firstName");
    driver.findElement(By.cssSelector(".freebirdFormviewerViewNumberedItemContainer:nth-child(2) .quantumWizTextinputPaperinputInput")).click();
    driver.findElement(By.cssSelector(".freebirdFormviewerViewNumberedItemContainer:nth-child(2) .quantumWizTextinputPaperinputInput")).sendKeys("@lastName");
    driver.findElement(By.cssSelector(".freebirdFormviewerViewNumberedItemContainer:nth-child(3) .quantumWizTextinputPaperinputInput")).click();
    driver.findElement(By.cssSelector(".freebirdFormviewerViewNumberedItemContainer:nth-child(3) .quantumWizTextinputPaperinputInput")).sendKeys("@email");
    driver.findElement(By.cssSelector(".freebirdFormviewerViewNumberedItemContainer:nth-child(4) .quantumWizTextinputPaperinputInput")).click();
    driver.findElement(By.cssSelector(".freebirdFormviewerViewNumberedItemContainer:nth-child(4) .quantumWizTextinputPaperinputInput")).sendKeys("@phoneNum");
    driver.findElement(By.cssSelector(".freebirdFormviewerViewNumberedItemContainer:nth-child(5) .quantumWizTextinputPaperinputInput")).click();
    driver.findElement(By.cssSelector(".freebirdFormviewerViewNumberedItemContainer:nth-child(5) .quantumWizTextinputPaperinputInput")).sendKeys("@street");
    driver.findElement(By.cssSelector(".freebirdFormviewerViewNumberedItemContainer:nth-child(6) .quantumWizTextinputPaperinputInput")).click();
    driver.findElement(By.cssSelector(".freebirdFormviewerViewNumberedItemContainer:nth-child(6) .quantumWizTextinputPaperinputInput")).sendKeys("@city");
    driver.findElement(By.cssSelector(".freebirdFormviewerViewNumberedItemContainer:nth-child(7) .quantumWizTextinputPaperinputInput")).click();
    driver.findElement(By.cssSelector(".freebirdFormviewerViewNumberedItemContainer:nth-child(7) .quantumWizTextinputPaperinputInput")).sendKeys("@state");
    driver.findElement(By.cssSelector(".freebirdFormviewerViewNumberedItemContainer:nth-child(8) .quantumWizTextinputPaperinputInput")).click();
    driver.findElement(By.cssSelector(".freebirdFormviewerViewNumberedItemContainer:nth-child(8) .quantumWizTextinputPaperinputInput")).sendKeys("@zip");
    driver.findElement(By.cssSelector(".appsMaterialWizButtonPaperbuttonLabel")).click();
  }
}