package com.photobooking.model.user;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.ServletContext;

import com.photobooking.util.FileHandler;
import com.photobooking.util.ValidationUtil;

/**
 * UserManager handles user-related operations for the Event Photography System
 */
public class UserManager {
    private static final String USER_FILE_NAME = "users.txt";
    private List<User> users;
    private ServletContext servletContext;
    private String dataFilePath;

    // Constructors
    public UserManager() {
        this(null);
    }

    public UserManager(ServletContext servletContext) {
        this.servletContext = servletContext;
        this.users = new ArrayList<>();
        initializeFilePath();
        loadUsers();
    }

    // Initialize file path for storing users
    private void initializeFilePath() {
        if (servletContext != null) {
            // Use WEB-INF/data within the application context
            String webInfDataPath = "/WEB-INF/data";
            dataFilePath = servletContext.getRealPath(webInfDataPath) + File.separator + USER_FILE_NAME;

            // Ensure directory exists
            File dataDir = new File(servletContext.getRealPath(webInfDataPath));
            if (!dataDir.exists()) {
                boolean created = dataDir.mkdirs();
                System.out.println("Created WEB-INF/data directory: " + dataDir.getAbsolutePath() + " - Success: " + created);
            }
        } else {
            // Fallback to simple data directory if not in web context
            String dataPath = "data";
            dataFilePath = dataPath + File.separator + USER_FILE_NAME;

            // Ensure directory exists
            File dataDir = new File(dataPath);
            if (!dataDir.exists()) {
                boolean created = dataDir.mkdirs();
                System.out.println("Created fallback data directory: " + dataPath + " - Success: " + created);
            }
        }

        System.out.println("UserManager: Using data file path: " + dataFilePath);
    }

    // Load users from file
    private void loadUsers() {
        // Ensure file exists
        FileHandler.ensureFileExists(dataFilePath);

        // Read lines from file
        List<String> lines = FileHandler.readLines(dataFilePath);

        for (String line : lines) {
            if (line.trim().isEmpty()) continue;

            User user = User.fromFileString(line);
            if (user != null) {
                users.add(user);
            }
        }

        System.out.println("Total users loaded: " + users.size());
    }

    // Save users to file
    private boolean saveUsers() {
        // Delete existing file content
        FileHandler.deleteFile(dataFilePath);

        // Write each user to file
        for (User user : users) {
            FileHandler.appendLine(dataFilePath, user.toFileString());
        }

        return true;
    }

    // Add a new user
    public boolean addUser(User user) {
        // Validate input
        if (!validateUserInput(user)) {
            return false;
        }

        // Check if username already exists
        if (getUserByUsername(user.getUsername()) != null) {
            System.out.println("Username already exists: " + user.getUsername());
            return false;
        }

        // Add user
        users.add(user);
        return saveUsers();
    }

    // Validate user input
    private boolean validateUserInput(User user) {
        // Validate username
        if (!ValidationUtil.isValidUsername(user.getUsername())) {
            System.out.println("Invalid username format");
            return false;
        }

        // Validate email
        if (!ValidationUtil.isValidEmail(user.getEmail())) {
            System.out.println("Invalid email format");
            return false;
        }

        // Validate password (if applicable)
        if (user.getPassword() != null && !ValidationUtil.isValidPassword(user.getPassword())) {
            System.out.println("Invalid password format");
            return false;
        }

        return true;
    }

    // Get user by ID
    public User getUserById(String userId) {
        for (User user : users) {
            if (user.getUserId().equals(userId)) {
                return user;
            }
        }
        return null;
    }

    // Get user by username
    public User getUserByUsername(String username) {
        for (User user : users) {
            if (user.getUsername().equals(username)) {
                return user;
            }
        }
        return null;
    }

    // Update user details
    public boolean updateUser(User updatedUser) {
        // Validate input
        if (!validateUserInput(updatedUser)) {
            return false;
        }

        // Find and update user
        for (int i = 0; i < users.size(); i++) {
            if (users.get(i).getUserId().equals(updatedUser.getUserId())) {
                users.set(i, updatedUser);
                return saveUsers();
            }
        }

        return false;
    }

    // Delete user
    public boolean deleteUser(String userId) {
        boolean removed = false;
        for (int i = 0; i < users.size(); i++) {
            if (users.get(i).getUserId().equals(userId)) {
                users.remove(i);
                removed = true;
                break;
            }
        }
        return removed && saveUsers();
    }

    // Authenticate user
    public User authenticateUser(String username, String password) {
        User user = getUserByUsername(username);
        if (user != null && user.authenticate(password) && user.isActive()) {
            return user;
        }
        return null;
    }

    // Get all users
    public List<User> getAllUsers() {
        return new ArrayList<>(users);
    }

    // Get users by type
    public List<User> getUsersByType(User.UserType userType) {
        List<User> filteredUsers = new ArrayList<>();
        for (User user : users) {
            if (user.getUserType() == userType) {
                filteredUsers.add(user);
            }
        }
        return filteredUsers;
    }

    // Set ServletContext (can be used to update the context after initialization)
    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
        initializeFilePath();
        // Reload users with the new file path
        users.clear();
        loadUsers();
    }
}