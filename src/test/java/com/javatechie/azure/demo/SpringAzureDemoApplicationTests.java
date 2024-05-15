package com.javatechie.azure.demo;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class SpringAzureDemoApplicationTests {

	@Test
	public void contextLoads() {
	        SpringAzureDemoApplication app = new SpringAzureDemoApplication();
	        String result = app.message();
	        assertEquals("Congrats ! your application deployed successfully in Azure Platform with private network access.!!!", result);
	}

}
