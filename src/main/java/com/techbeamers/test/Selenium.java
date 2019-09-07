package com.techbeamers.test;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
public class Selenium {
public static void main(String[] args) {
System.setProperty("webdriver.firefox.driver","/opt/fawad/geckodriver"); // <– Change this path
WebDriver driver = new FirefoxDriver();
String baseUrl = "https://experitest.com/free-trial/";
String expectedTitle = "Free trial";
String actualTitle = "";
driver.get(baseUrl);
actualTitle = driver.getTitle();
if (actualTitle.contentEquals(expectedTitle)){
System.out.println("TEST PASSED!");
} else {
System.out.println("TEST FAILED");
}
driver.close();
}
}
