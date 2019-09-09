package com.techbeamers.test;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;


public class HomePageTitle {
	
	private WebDriver driver; 
	String URL = "https://wcs.demoqaauth.ibm.com/wcs/shop/en/auroraesite";

	@BeforeClass
	public void testSetUp() {
		System.setProperty("webdriver.firefox.driver","/data/wcscode/geckodriver"); // <– Change this path
		
		driver = new FirefoxDriver();
	}
	
	@Test
	public void verifyPageTittle() {
		driver.navigate().to(URL);
		//String getTitle = driver.getTitle();
		//Assert.assertEquals(getTitle, "Welcome to AuroraESite");
		//Assert.assertEquals(getTitle, "GGG");
		String Expectedtitle = "FAWAd";
//it will fetch the actual title 
String Actualtitle = driver.getTitle();
System.out.println("Before Assetion " + Expectedtitle + Actualtitle);
//it will compare actual title and expected title
Assert.assertEquals(Actualtitle, Expectedtitle);
//print out the result
System.out.println("After Assertion " + Expectedtitle + Actualtitle + " Title matched ");
	}
	
	//@AfterClass
	//public void tearDown() {
	//	driver.quit();
	//}
}

