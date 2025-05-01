package com.photobooking.model.gallery;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Represents an image in the Event Photography System gallery
 */
public class Image implements Serializable {
    private static final long serialVersionUID = 1L;

    // Image attributes
    private String imageId;
    private String fileName;
    private String filePath;
    private String thumbnailPath;
    private String title;
    private String description;
    private String galleryId;
    private LocalDateTime uploadDate;
    private String uploadedBy; // User ID of uploader
    private int width;
    private int height;
    private long fileSize; // in bytes
    private String mimeType;
    private String cameraModel;
    private String exposureSettings;
    private LocalDateTime captureDate;
    private String tags;
    private boolean isFavorite;
    private int viewCount;
    private int downloadCount;
    private boolean isProcessed; // Indicates if image has been processed

    // Constructors
    public Image() {
        this.imageId = UUID.randomUUID().toString();
        this.uploadDate = LocalDateTime.now();
        this.viewCount = 0;
        this.downloadCount = 0;
        this.isFavorite = false;
        this.isProcessed = false;
    }

    public Image(String fileName, String filePath, String galleryId, String uploadedBy) {
        this();
        this.fileName = fileName;
        this.filePath = filePath;
        this.galleryId = galleryId;
        this.uploadedBy = uploadedBy;
    }

    // Getters and Setters
    public String getImageId() {
        return imageId;
    }

    public void setImageId(String imageId) {
        this.imageId = imageId;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getThumbnailPath() {
        return thumbnailPath;
    }

    public void setThumbnailPath(String thumbnailPath) {
        this.thumbnailPath = thumbnailPath;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getGalleryId() {
        return galleryId;
    }

    public void setGalleryId(String galleryId) {
        this.galleryId = galleryId;
    }

    public LocalDateTime getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(LocalDateTime uploadDate) {
        this.uploadDate = uploadDate;
    }

    public String getUploadedBy() {
        return uploadedBy;
    }

    public void setUploadedBy(String uploadedBy) {
        this.uploadedBy = uploadedBy;
    }

    public int getWidth() {
        return width;
    }

    public void setWidth(int width) {
        this.width = width;
    }

    public int getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }

    public long getFileSize() {
        return fileSize;
    }

    public void setFileSize(long fileSize) {
        this.fileSize = fileSize;
    }

    public String getMimeType() {
        return mimeType;
    }

    public void setMimeType(String mimeType) {
        this.mimeType = mimeType;
    }

    public String getCameraModel() {
        return cameraModel;
    }

    public void setCameraModel(String cameraModel) {
        this.cameraModel = cameraModel;
    }

    public String getExposureSettings() {
        return exposureSettings;
    }

    public void setExposureSettings(String exposureSettings) {
        this.exposureSettings = exposureSettings;
    }

    public LocalDateTime getCaptureDate() {
        return captureDate;
    }

    public void setCaptureDate(LocalDateTime captureDate) {
        this.captureDate = captureDate;
    }

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }

    public boolean isFavorite() {
        return isFavorite;
    }

    public void setFavorite(boolean favorite) {
        isFavorite = favorite;
    }

    public int getViewCount() {
        return viewCount;
    }

    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }

    public int getDownloadCount() {
        return downloadCount;
    }

    public void setDownloadCount(int downloadCount) {
        this.downloadCount = downloadCount;
    }

    public boolean isProcessed() {
        return isProcessed;
    }

    public void setProcessed(boolean processed) {
        isProcessed = processed;
    }

    // Business methods
    /**
     * Increment the view count
     */
    public void incrementViewCount() {
        this.viewCount++;
    }

    /**
     * Increment the download count
     */
    public void incrementDownloadCount() {
        this.downloadCount++;
    }

    /**
     * Toggle favorite status
     * @return New favorite status
     */
    public boolean toggleFavorite() {
        isFavorite = !isFavorite;
        return isFavorite;
    }

    /**
     * Get image extension from filename
     * @return File extension or empty string if none
     */
    public String getFileExtension() {
        if (fileName == null || !fileName.contains(".")) {
            return "";
        }

        return fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
    }

    /**
     * Get formatted file size
     * @return Human-readable file size
     */
    public String getFormattedFileSize() {
        if (fileSize < 1024) {
            return fileSize + " B";
        } else if (fileSize < 1024 * 1024) {
            return String.format("%.2f KB", fileSize / 1024.0);
        } else if (fileSize < 1024 * 1024 * 1024) {
            return String.format("%.2f MB", fileSize / (1024.0 * 1024));
        } else {
            return String.format("%.2f GB", fileSize / (1024.0 * 1024 * 1024));
        }
    }

    /**
     * Get image resolution
     * @return Resolution as width x height
     */
    public String getResolution() {
        return width + " x " + height;
    }

    /**
     * Convert image to file string representation
     * @return String representation for file storage
     */
    public String toFileString() {
        StringBuilder sb = new StringBuilder();
        sb.append(imageId).append(",");
        sb.append(fileName != null ? fileName.replace(",", ";;") : "").append(",");
        sb.append(filePath != null ? filePath.replace(",", ";;") : "").append(",");
        sb.append(thumbnailPath != null ? thumbnailPath.replace(",", ";;") : "").append(",");
        sb.append(title != null ? title.replace(",", ";;") : "").append(",");
        sb.append(description != null ? description.replace(",", ";;") : "").append(",");
        sb.append(galleryId != null ? galleryId : "").append(",");
        sb.append(uploadDate != null ? uploadDate.toString() : "").append(",");
        sb.append(uploadedBy != null ? uploadedBy : "").append(",");
        sb.append(width).append(",");
        sb.append(height).append(",");
        sb.append(fileSize).append(",");
        sb.append(mimeType != null ? mimeType : "").append(",");
        sb.append(cameraModel != null ? cameraModel.replace(",", ";;") : "").append(",");
        sb.append(exposureSettings != null ? exposureSettings.replace(",", ";;") : "").append(",");
        sb.append(captureDate != null ? captureDate.toString() : "").append(",");
        sb.append(tags != null ? tags.replace(",", ";;") : "").append(",");
        sb.append(isFavorite).append(",");
        sb.append(viewCount).append(",");
        sb.append(downloadCount).append(",");
        sb.append(isProcessed);

        return sb.toString();
    }

    /**
     * Create image from file string
     * @param fileString String representation from file
     * @return Image object
     */
    public static Image fromFileString(String fileString) {
        String[] parts = fileString.split(",");
        if (parts.length < 20) {
            return null; // Not enough parts for a valid image
        }

        Image image = new Image();
        int index = 0;

        image.setImageId(parts[index++]);
        image.setFileName(parts[index++].replace(";;", ","));
        image.setFilePath(parts[index++].replace(";;", ","));

        String thumbnailPathStr = parts[index++];
        if (!thumbnailPathStr.isEmpty()) {
            image.setThumbnailPath(thumbnailPathStr.replace(";;", ","));
        }

        image.setTitle(parts[index++].replace(";;", ","));
        image.setDescription(parts[index++].replace(";;", ","));

        String galleryIdStr = parts[index++];
        if (!galleryIdStr.isEmpty()) {
            image.setGalleryId(galleryIdStr);
        }

        String uploadDateStr = parts[index++];
        if (!uploadDateStr.isEmpty()) {
            image.setUploadDate(LocalDateTime.parse(uploadDateStr));
        }

        image.setUploadedBy(parts[index++]);

        image.setWidth(Integer.parseInt(parts[index++]));
        image.setHeight(Integer.parseInt(parts[index++]));
        image.setFileSize(Long.parseLong(parts[index++]));

        image.setMimeType(parts[index++]);
        image.setCameraModel(parts[index++].replace(";;", ","));
        image.setExposureSettings(parts[index++].replace(";;", ","));

        String captureDateStr = parts[index++];
        if (!captureDateStr.isEmpty()) {
            image.setCaptureDate(LocalDateTime.parse(captureDateStr));
        }

        image.setTags(parts[index++].replace(";;", ","));
        image.setFavorite(Boolean.parseBoolean(parts[index++]));
        image.setViewCount(Integer.parseInt(parts[index++]));
        image.setDownloadCount(Integer.parseInt(parts[index++]));
        image.setProcessed(Boolean.parseBoolean(parts[index]));

        return image;
    }

    @Override
    public String toString() {
        return "Image{" +
                "imageId='" + imageId + '\'' +
                ", fileName='" + fileName + '\'' +
                ", title='" + title + '\'' +
                ", galleryId='" + galleryId + '\'' +
                ", resolution=" + width + "x" + height +
                ", size=" + getFormattedFileSize() +
                '}';
    }
}