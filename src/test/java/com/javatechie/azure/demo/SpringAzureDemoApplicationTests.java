package com.javatechie.azure.demo;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class SpringAzureDemoApplicationTests {

    @Test
    public void testMessage() {
        // Arrange
        SpringAzureDemoApplication app = new SpringAzureDemoApplication();

        // Act
        String result = app.message();

        // Assert
        assertEquals("Congrats ! your application deployed successfully in Azure Platform.", result);
    }
}
