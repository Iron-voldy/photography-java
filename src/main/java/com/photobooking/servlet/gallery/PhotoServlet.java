package com.photobooking.servlet.gallery;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet to handle serving photo files
 */
@WebServlet(urlPatterns = {"/image/photos/*", "/image/thumbnails/*"})
public class PhotoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(PhotoServlet.class.getName());

    private static final String PHOTOS_DIRECTORY = "photos";
    private static final String THUMBNAILS_DIRECTORY = "thumbnails";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Determine which directory to use based on the request URL path
        String requestPath = request.getRequestURI();
        String baseDirectory;

        if (requestPath.startsWith(request.getContextPath() + "/image/photos/")) {
            baseDirectory = PHOTOS_DIRECTORY;
        } else if (requestPath.startsWith(request.getContextPath() + "/image/thumbnails/")) {
            baseDirectory = THUMBNAILS_DIRECTORY;
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Extract the requested filename from the path
        String fileName = requestPath.substring(requestPath.lastIndexOf('/') + 1);

        if (fileName.isEmpty()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Create the file path
        File contextDir = new File(request.getServletContext().getRealPath("/"));
        String filePath = contextDir + File.separator + baseDirectory + File.separator + fileName;

        // Log for debugging
        LOGGER.info("Serving file: " + filePath);

        File file = new File(filePath);

        // Check if file exists
        if (!file.exists() || !file.isFile()) {
            // Try alternate location (webapp/WEB-INF/data)
            filePath = contextDir + File.separator + "WEB-INF" + File.separator + "data" +
                    File.separator + baseDirectory + File.separator + fileName;
            file = new File(filePath);

            if (!file.exists() || !file.isFile()) {
                LOGGER.warning("File not found: " + filePath);
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
        }

        // Set content type based on file extension
        String contentType = getServletContext().getMimeType(fileName);
        if (contentType == null) {
            // Default to binary if MIME type is unknown
            contentType = "application/octet-stream";
        }
        response.setContentType(contentType);

        // Set content length
        response.setContentLength((int) file.length());

        // Set cache headers (optional)
        response.setHeader("Cache-Control", "public, max-age=86400"); // Cache for 1 day

        // Stream the file to the response
        try (InputStream in = new FileInputStream(file);
             OutputStream out = response.getOutputStream()) {

            byte[] buffer = new byte[4096];
            int bytesRead;

            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }

            out.flush();
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error serving file: " + e.getMessage(), e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}