package com.techbeamers.test;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;


public class GoogleHomePageTitle {
	
	private WebDriver driver; 
	String URL = "https://wcs.demoqaauth.ibm.com/wcs/shop/en/auroraesite";

	@BeforeClass
	public void testSetUp() {
		System.setProperty("webdriver.firefox.driver","/data/wcscode/geckodriver"); // <– Change this path
		
		driver = new FirefoxDriver();
	}
	
	@Test
	public void verifyGooglePageTittle() {
		driver.navigate().to(URL);
		String getTitle = driver.getTitle();
		Assert.assertEquals(getTitle, "Gsss");
	}
	
	@AfterClass
	public void tearDown() {
		driver.quit();
	}
}
