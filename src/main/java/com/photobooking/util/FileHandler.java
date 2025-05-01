package com.photobooking.util;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.util.*;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 * Comprehensive File Handling Utility for the Event Photography System
 * Provides robust methods for file operations with extensive error handling
 */
public class FileHandler {
    private static final Logger LOGGER = Logger.getLogger(FileHandler.class.getName());

    // Prevent instantiation
    private FileHandler() {
        throw new AssertionError("Cannot be instantiated");
    }

    /**
     * Ensures a file exists, creating it if necessary
     * @param filePath Path to the file
     * @return true if file exists or was created successfully
     */
    public static boolean ensureFileExists(String filePath) {
        try {
            File file = new File(filePath);

            // Create parent directory if it doesn't exist
            if (file.getParentFile() != null) {
                file.getParentFile().mkdirs();
            }

            // Create file if it doesn't exist
            if (!file.exists()) {
                boolean created = file.createNewFile();
                if (created) {
                    LOGGER.info("Created new file: " + filePath);
                }
                return created;
            }
            return true;
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error ensuring file exists: " + filePath, e);
            return false;
        }
    }

    /**
     * Writes content to a file
     * @param filePath Path to the file
     * @param content Content to write
     * @param append Whether to append or overwrite
     * @return true if write was successful
     */
    public static boolean writeToFile(String filePath, String content, boolean append) {
        try {
            // Ensure file exists
            if (!ensureFileExists(filePath)) {
                LOGGER.warning("Could not create file: " + filePath);
                return false;
            }

            // Write content
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, append))) {
                writer.write(content);
            }

            LOGGER.info("Successfully wrote to file: " + filePath);
            return true;
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error writing to file: " + filePath, e);
            return false;
        }
    }

    /**
     * Reads all lines from a file
     * @param filePath Path to the file
     * @return List of lines, empty list if file doesn't exist or error occurs
     */
    public static List<String> readLines(String filePath) {
        List<String> lines = new ArrayList<>();

        try {
            File file = new File(filePath);

            // Check if file exists
            if (!file.exists()) {
                LOGGER.warning("File does not exist: " + filePath);
                return lines;
            }

            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    lines.add(line);
                }
            }
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error reading file: " + filePath, e);
        }

        return lines;
    }

    /**
     * Reads entire file content as a string
     * @param filePath Path to the file
     * @return File content as string, empty string if error occurs
     */
    public static String readFileContent(String filePath) {
        try {
            File file = new File(filePath);

            // Check if file exists
            if (!file.exists()) {
                LOGGER.warning("File does not exist: " + filePath);
                return "";
            }

            // Read all bytes
            byte[] bytes = new byte[(int) file.length()];
            try (FileInputStream fis = new FileInputStream(file)) {
                fis.read(bytes);
            }

            return new String(bytes, StandardCharsets.UTF_8);
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error reading file content: " + filePath, e);
            return "";
        }
    }

    /**
     * Appends a line to a file
     * @param filePath Path to the file
     * @param line Line to append
     * @return true if successful, false otherwise
     */
    public static boolean appendLine(String filePath, String line) {
        return writeToFile(filePath, line + System.lineSeparator(), true);
    }

    /**
     * Deletes a file
     * @param filePath Path to the file
     * @return true if file was deleted or didn't exist
     */
    public static boolean deleteFile(String filePath) {
        File file = new File(filePath);

        if (!file.exists()) {
            LOGGER.info("File does not exist: " + filePath);
            return true;
        }

        boolean deleted = file.delete();
        if (deleted) {
            LOGGER.info("Successfully deleted file: " + filePath);
        } else {
            LOGGER.warning("Failed to delete file: " + filePath);
        }

        return deleted;
    }

    /**
     * Creates a directory if it doesn't exist
     * @param directoryPath Path of the directory to create
     * @return true if directory exists or was created successfully
     */
    public static boolean createDirectory(String directoryPath) {
        File directory = new File(directoryPath);

        if (!directory.exists()) {
            boolean created = directory.mkdirs();
            if (created) {
                LOGGER.info("Created directory: " + directoryPath);
            } else {
                LOGGER.warning("Failed to create directory: " + directoryPath);
            }
            return created;
        }

        return true;
    }

    /**
     * Checks if a file exists
     * @param filePath Path to the file
     * @return true if file exists, false otherwise
     */
    public static boolean fileExists(String filePath) {
        return new File(filePath).exists();
    }

    /**
     * Safely reads a CSV file
     * @param filePath Path to the CSV file
     * @param delimiter CSV delimiter
     * @return List of rows, where each row is a list of columns
     */
    public static List<List<String>> readCSV(String filePath, String delimiter) {
        List<List<String>> data = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] values = line.split(delimiter);
                data.add(Arrays.asList(values));
            }
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error reading CSV file: " + filePath, e);
        }

        return data;
    }

    /**
     * Writes data to a CSV file
     * @param filePath Path to the CSV file
     * @param data List of rows to write
     * @param delimiter CSV delimiter
     * @return true if write was successful, false otherwise
     */
    public static boolean writeCSV(String filePath, List<List<String>> data, String delimiter) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath))) {
            for (List<String> row : data) {
                String csvLine = String.join(delimiter, row);
                bw.write(csvLine);
                bw.newLine();
            }
            return true;
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error writing CSV file: " + filePath, e);
            return false;
        }
    }

    /**
     * Moves a file from one location to another
     * @param sourcePath Source file path
     * @param destinationPath Destination file path
     * @return true if move was successful, false otherwise
     */
    public static boolean moveFile(String sourcePath, String destinationPath) {
        File sourceFile = new File(sourcePath);
        File destFile = new File(destinationPath);

        // Ensure destination directory exists
        if (destFile.getParentFile() != null) {
            destFile.getParentFile().mkdirs();
        }

        return sourceFile.renameTo(destFile);
    }

    /**
     * Copies a file from one location to another
     * @param sourcePath Source file path
     * @param destinationPath Destination file path
     * @return true if copy was successful, false otherwise
     */
    public static boolean copyFile(String sourcePath, String destinationPath) {
        try (
                FileInputStream inputStream = new FileInputStream(new File(sourcePath));
                FileOutputStream outputStream = new FileOutputStream(new File(destinationPath))
        ) {
            byte[] buffer = new byte[1024];
            int length;
            while ((length = inputStream.read(buffer)) > 0) {
                outputStream.write(buffer, 0, length);
            }
            return true;
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error copying file", e);
            return false;
        }
    }
}