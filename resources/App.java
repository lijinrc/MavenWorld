package org.shakti.MavenWorld;

import java.util.List;

import org.testng.TestNG;
import org.testng.collections.Lists;

public class App {
	public static void main(String[] args) {

		System.out.println("Hello World from Developer!");
		TestNG testng = new TestNG();
		List<String> suites = Lists.newArrayList();
		suites.add("testng.xml");
		testng.setTestSuites(suites);
		testng.run();
	}
}