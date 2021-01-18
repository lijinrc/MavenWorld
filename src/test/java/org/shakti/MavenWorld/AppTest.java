package org.shakti.MavenWorld;

import java.util.List;

import org.testng.TestNG;
import org.testng.annotations.AfterTest;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;
import org.testng.collections.Lists;

public class AppTest {
	
	@BeforeTest
	public static void beforeTest() {
		 System.out.println( "Hello World from BeforeTest Tester!" );
	}

	@Test
	public static void test() {
		 System.out.println( "Hello World from Tester!" );
	}
	
	@AfterTest
	public static void afterTest() {
		System.out.println( "Hello World from AfterTest Tester!" );
	}
	
	public static void main(String[] args) throws Exception {
	    TestNG testng = new TestNG();
	    List<String> suites = Lists.newArrayList();
	    suites.add(args[1]);
	    testng.setTestSuites(suites);
	    testng.run();
	}
}
