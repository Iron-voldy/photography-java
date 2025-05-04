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
    private static final String DATA_DIRECTORY = "data";

    // Prevent instantiation
    private FileHandler() {
        throw new AssertionError("Cannot be instantiated");
    }

    /**
     * Initialize the data directory
     */
    static {
        File directory = new File(DATA_DIRECTORY);
        if (!directory.exists()) {
            boolean created = directory.mkdirs();
            if (created) {
                LOGGER.info("Created data directory: " + directory.getAbsolutePath());
            } else {
                LOGGER.warning("Failed to create data directory: " + directory.getAbsolutePath());
            }
        }
    }

    /**
     * Ensures a file exists, creating it if necessary
     * @param filePath Path to the file
     * @return true if file exists or was created successfully
     */
    public static boolean ensureFileExists(String filePath) {
        try {
            // Add data directory prefix if not already present
            String fullPath = filePath;
            if (!filePath.startsWith(DATA_DIRECTORY + File.separator) && !new File(filePath).isAbsolute()) {
                fullPath = DATA_DIRECTORY + File.separator + filePath;
            }

            File file = new File(fullPath);

            // Create parent directory if it doesn't exist
            if (file.getParentFile() != null && !file.getParentFile().exists()) {
                boolean dirCreated = file.getParentFile().mkdirs();
                if (!dirCreated) {
                    LOGGER.warning("Could not create directory: " + file.getParentFile().getAbsolutePath());
                }
            }

            // Create file if it doesn't exist
            if (!file.exists()) {
                boolean created = file.createNewFile();
                if (created) {
                    LOGGER.info("Created new file: " + filePath);
                } else {
                    LOGGER.warning("Could not create file: " + filePath);
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
            // Add data directory prefix if not already present
            String fullPath = filePath;
            if (!filePath.startsWith(DATA_DIRECTORY + File.separator) && !new File(filePath).isAbsolute()) {
                fullPath = DATA_DIRECTORY + File.separator + filePath;
            }

            // Ensure file exists
            if (!ensureFileExists(fullPath)) {
                LOGGER.warning("Could not create file: " + filePath);
                return false;
            }

            // Write content
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(fullPath, append))) {
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
            // Add data directory prefix if not already present
            String fullPath = filePath;
            if (!filePath.startsWith(DATA_DIRECTORY + File.separator) && !new File(filePath).isAbsolute()) {
                fullPath = DATA_DIRECTORY + File.separator + filePath;
            }

            File file = new File(fullPath);

            // Check if file exists
            if (!file.exists()) {
                // Create the file if it doesn't exist
                ensureFileExists(filePath);
                return lines; // Return empty list for newly created file
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
            // Add data directory prefix if not already present
            String fullPath = filePath;
            if (!filePath.startsWith(DATA_DIRECTORY + File.separator) && !new File(filePath).isAbsolute()) {
                fullPath = DATA_DIRECTORY + File.separator + filePath;
            }

            File file = new File(fullPath);

            // Check if file exists
            if (!file.exists()) {
                ensureFileExists(filePath);
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
        // Add data directory prefix if not already present
        String fullPath = filePath;
        if (!filePath.startsWith(DATA_DIRECTORY + File.separator) && !new File(filePath).isAbsolute()) {
            fullPath = DATA_DIRECTORY + File.separator + filePath;
        }

        File file = new File(fullPath);

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
        // Add data directory prefix if not already present
        String fullPath = directoryPath;
        if (!directoryPath.startsWith(DATA_DIRECTORY + File.separator) && !new File(directoryPath).isAbsolute()) {
            fullPath = DATA_DIRECTORY + File.separator + directoryPath;
        }

        File directory = new File(fullPath);

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
        // Add data directory prefix if not already present
        String fullPath = filePath;
        if (!filePath.startsWith(DATA_DIRECTORY + File.separator) && !new File(filePath).isAbsolute()) {
            fullPath = DATA_DIRECTORY + File.separator + filePath;
        }

        return new File(fullPath).exists();
    }

    /**
     * Safely reads a CSV file
     * @param filePath Path to the CSV file
     * @param delimiter CSV delimiter
     * @return List of rows, where each row is a list of columns
     */
    public static List<List<String>> readCSV(String filePath, String delimiter) {
        List<List<String>> data = new ArrayList<>();

        try {
            // Add data directory prefix if not already present
            String fullPath = filePath;
            if (!filePath.startsWith(DATA_DIRECTORY + File.separator) && !new File(filePath).isAbsolute()) {
                fullPath = DATA_DIRECTORY + File.separator + filePath;
            }

            if (!fileExists(fullPath)) {
                ensureFileExists(fullPath);
                return data;
            }

            try (BufferedReader br = new BufferedReader(new FileReader(fullPath))) {
                String line;
                while ((line = br.readLine()) != null) {
                    String[] values = line.split(delimiter);
                    data.add(Arrays.asList(values));
                }
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
        try {
            // Add data directory prefix if not already present
            String fullPath = filePath;
            if (!filePath.startsWith(DATA_DIRECTORY + File.separator) && !new File(filePath).isAbsolute()) {
                fullPath = DATA_DIRECTORY + File.separator + filePath;
            }

            ensureFileExists(fullPath);

            try (BufferedWriter bw = new BufferedWriter(new FileWriter(fullPath))) {
                for (List<String> row : data) {
                    String csvLine = String.join(delimiter, row);
                    bw.write(csvLine);
                    bw.newLine();
                }
                return true;
            }
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
        // Add data directory prefix if not already present
        String fullSourcePath = sourcePath;
        if (!sourcePath.startsWith(DATA_DIRECTORY + File.separator) && !new File(sourcePath).isAbsolute()) {
            fullSourcePath = DATA_DIRECTORY + File.separator + sourcePath;
        }

        String fullDestPath = destinationPath;
        if (!destinationPath.startsWith(DATA_DIRECTORY + File.separator) && !new File(destinationPath).isAbsolute()) {
            fullDestPath = DATA_DIRECTORY + File.separator + destinationPath;
        }

        File sourceFile = new File(fullSourcePath);
        File destFile = new File(fullDestPath);

        // Ensure destination directory exists
        if (destFile.getParentFile() != null) {
            destFile.getParentFile().mkdirs();
        }

        boolean success = sourceFile.renameTo(destFile);
        if (success) {
            LOGGER.info("Successfully moved file from " + sourcePath + " to " + destinationPath);
        } else {
            LOGGER.warning("Failed to move file from " + sourcePath + " to " + destinationPath);
        }

        return success;
    }

    /**
     * Copies a file from one location to another
     * @param sourcePath Source file path
     * @param destinationPath Destination file path
     * @return true if copy was successful, false otherwise
     */
    public static boolean copyFile(String sourcePath, String destinationPath) {
        try {
            // Add data directory prefix if not already present
            String fullSourcePath = sourcePath;
            if (!sourcePath.startsWith(DATA_DIRECTORY + File.separator) && !new File(sourcePath).isAbsolute()) {
                fullSourcePath = DATA_DIRECTORY + File.separator + sourcePath;
            }

            String fullDestPath = destinationPath;
            if (!destinationPath.startsWith(DATA_DIRECTORY + File.separator) && !new File(destinationPath).isAbsolute()) {
                fullDestPath = DATA_DIRECTORY + File.separator + destinationPath;
            }

            File sourceFile = new File(fullSourcePath);
            File destFile = new File(fullDestPath);

            // Ensure source file exists
            if (!sourceFile.exists()) {
                LOGGER.warning("Source file does not exist: " + sourcePath);
                return false;
            }

            // Ensure destination directory exists
            if (destFile.getParentFile() != null) {
                destFile.getParentFile().mkdirs();
            }

            try (
                    FileInputStream inputStream = new FileInputStream(sourceFile);
                    FileOutputStream outputStream = new FileOutputStream(destFile)
            ) {
                byte[] buffer = new byte[1024];
                int length;
                while ((length = inputStream.read(buffer)) > 0) {
                    outputStream.write(buffer, 0, length);
                }

                LOGGER.info("Successfully copied file from " + sourcePath + " to " + destinationPath);
                return true;
            }
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error copying file from " + sourcePath + " to " + destinationPath, e);
            return false;
        }
    }
}