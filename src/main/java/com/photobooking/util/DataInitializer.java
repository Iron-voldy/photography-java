package com.photobooking.util;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.io.File;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 * Ensures the data directory structure is created when the application starts
 */
@WebListener
public class DataInitializer implements ServletContextListener {
    private static final Logger LOGGER = Logger.getLogger(DataInitializer.class.getName());

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            ServletContext context = sce.getServletContext();
            LOGGER.info("Initializing data directory structure");

            // Initialize FileHandler with the ServletContext
            FileHandler.setServletContext(context);

            // Create the data directory in the webapp location
            String webAppPath = context.getRealPath("/");
            String dataPath = webAppPath + File.separator + "WEB-INF" + File.separator + "data";
            File dataDir = new File(dataPath);
            if (!dataDir.exists()) {
                boolean created = dataDir.mkdirs();
                LOGGER.info("Data directory created: " + created + " at " + dataPath);
            } else {
                LOGGER.info("Data directory already exists at " + dataPath);
            }

            // Ensure required files exist
            String[] requiredFiles = {
                    "users.txt",
                    "photographers.txt",
                    "services.txt",
                    "bookings.txt",
                    "reviews.txt",
                    "galleries.txt",
                    "photos.txt",
                    "unavailable_dates.txt"
            };

            for (String fileName : requiredFiles) {
                String filePath = dataPath + File.separator + fileName;
                File file = new File(filePath);
                if (!file.exists()) {
                    boolean created = file.createNewFile();
                    LOGGER.info("File created: " + created + " at " + filePath);
                } else {
                    LOGGER.info("File already exists at " + filePath);
                }
            }

            LOGGER.info("Data directory structure initialized successfully");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error initializing data directory structure", e);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Cleanup if needed
        LOGGER.info("Application context destroyed");
    }
}