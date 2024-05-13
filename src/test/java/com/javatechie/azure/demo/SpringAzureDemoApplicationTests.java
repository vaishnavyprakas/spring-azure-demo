package com.javatechie.azure.demo;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class SpringAzureDemoApplicationTests {

	@Test
	void contextLoads() {
        // Arrange
        SpringAzureDemoApplication app = new SpringAzureDemoApplication();

        // Act
        String result = app.message();

        // Assert
        assertEquals("Congrats ! your application deployed successfully in Azure Platform.", result);
	}

}
