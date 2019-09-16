package com.techbeamers.test;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;



public class HomePageTitle {
	
	private static WebDriver driver; 
	String URL = "https://wcs.demoqaauth.ibm.com/wcs/shop/en/auroraesite";

	@BeforeClass
	public void testSetUp() {
		try{
		System.setProperty("webdriver.firefox.driver","/data/wcscode/geckodriver"); // <â€“ Change this path
		driver = new FirefoxDriver();
			   }
		catch(Exception e)
		{
			e.printStackTrace();  
		}
	}
	
	@Test(priority = 0)
	public void verifyPageTittle() throws Exception  {
		try{
		driver.navigate().to(URL);
		//String getTitle = driver.getTitle();
		//Assert.assertEquals(getTitle, "Welcome to AuroraESite");
		//Assert.assertEquals(getTitle, "GGG");
		String Expectedtitle = "Welcome to AuroraESite";
        //it will fetch the actual title 
        String Actualtitle = driver.getTitle();
        System.out.println("\nBefore Assetion= " + Expectedtitle + Actualtitle);
        //it will compare actual title and expected title
        Assert.assertEquals(Actualtitle, Expectedtitle);
        //print out the result
        System.out.println("After Assertion= " + Expectedtitle + Actualtitle + "\nTitle matched ");
		}
		catch(Exception e)
		{
			e.printStackTrace();  
		}
	}
	
	@Test(priority = 1)
	public static void Search() throws Exception  {
		try{
			Thread.sleep(5000);
			driver.findElement(By.id("SimpleSearchForm_SearchTerm")).click();
//			driver.findElement(By.id("SimpleSearchForm_SearchTerm")).clear();
			driver.findElement(By.id("SimpleSearchForm_SearchTerm")).sendKeys("Shoes");
			driver.findElement(By.xpath("//*[@id=\"searchBox\"]/a[2]")).click();
			Thread.sleep(5000);
			String ActualText = driver.findElement(By.xpath("//*[@id='widget_breadcrumb']/ul/li[2]")).getText();
			Assert.assertEquals(ActualText, "Search: Shoes","Expected text not found on page!");
			System.out.print("\nSearch Executed");
		}
		catch(Exception e)
		{
			e.printStackTrace();  
		}
	}
	
	@Test(priority = 2)
	public static void PDP() throws Exception  {  
		try{
			driver.findElement(By.id("WC_CatalogEntryDBThumbnailDisplayJSPF_11948_link_9b")).click();
			driver.findElement(By.id("productPageAdd2Cart")).click();
			
			System.out.print("\nAdd to Cart Executed\n");

		}
		catch(Exception e)
		{
			e.printStackTrace();  
		}
	}
	
	//@AfterClass
	//public void tearDown() {
	//	driver.quit();
	//}
}
