package com.sultan.Vitek;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.io.File;
import java.io.IOException;

@SpringBootApplication
public class VitekApplication {

	public static void main(String[] args) throws IOException {
		SpringApplication.run(VitekApplication.class, args);
		//ObjectMapper obj = new ObjectMapper();
	}

}
