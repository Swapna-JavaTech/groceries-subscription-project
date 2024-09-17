package com.crimsonlogic.groceriessubbookingsystem.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Service
public class FileService {

	private final String uploadDir = "uploaded-images";

	public FileService() {
		File dir = new File(uploadDir);
		if (!dir.exists()) {
			dir.mkdirs(); // Create the directory if it doesn't exist
		}
	}

	public String saveFile(MultipartFile file) throws IOException {
		if (file.isEmpty()) {
			throw new IOException("Failed to upload empty file.");
		}

		String fileName = file.getOriginalFilename();
		Path path = Paths.get(uploadDir, fileName);
		Files.write(path, file.getBytes());
		return fileName; // Return the filename for URL generation
	}
}
