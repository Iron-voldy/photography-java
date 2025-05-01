package com.photobooking.model.photographer;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Represents a service add-on offered by a photographer
 */
public class PhotographerServiceAddon implements Serializable {
    private static final long serialVersionUID = 1L;

    // Add-on attributes
    private String addonId;
    private String photographerId;
    private String name;
    private String description;
    private double price;
    private List<String> applicableServiceIds; // IDs of services this add-on can be applied to
    private boolean isAllServices; // If true, this add-on applies to all services
    private int purchaseCount;

    // Constructors
    public PhotographerServiceAddon() {
        this.addonId = UUID.randomUUID().toString();
        this.applicableServiceIds = new ArrayList<>();
        this.isAllServices = false;
        this.purchaseCount = 0;
    }

    public PhotographerServiceAddon(String photographerId, String name, String description, double price) {
        this();
        this.photographerId = photographerId;
        this.name = name;
        this.description = description;
        this.price = price;
    }

    // Getters and Setters
    public String getAddonId() {
        return addonId;
    }

    public void setAddonId(String addonId) {
        this.addonId = addonId;
    }

    public String getPhotographerId() {
        return photographerId;
    }

    public void setPhotographerId(String photographerId) {
        this.photographerId = photographerId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public List<String> getApplicableServiceIds() {
        return applicableServiceIds;
    }

    public void setApplicableServiceIds(List<String> applicableServiceIds) {
        this.applicableServiceIds = applicableServiceIds;
    }

    public boolean isAllServices() {
        return isAllServices;
    }

    public void setAllServices(boolean allServices) {
        isAllServices = allServices;
    }

    public int getPurchaseCount() {
        return purchaseCount;
    }

    public void setPurchaseCount(int purchaseCount) {
        this.purchaseCount = purchaseCount;
    }

    // Business methods
    /**
     * Add an applicable service ID
     * @param serviceId Service ID to add
     */
    public void addApplicableService(String serviceId) {
        if (serviceId != null && !serviceId.trim().isEmpty()) {
            applicableServiceIds.add(serviceId);
        }
    }

    /**
     * Check if this add-on applies to a service
     * @param serviceId Service ID to check
     * @return true if applicable, false otherwise
     */
    public boolean isApplicableToService(String serviceId) {
        if (serviceId == null) {
            return false;
        }

        return isAllServices || applicableServiceIds.contains(serviceId);
    }

    /**
     * Increment purchase count
     */
    public void incrementPurchaseCount() {
        this.purchaseCount++;
    }

    /**
     * Convert add-on to file string representation
     * @return String representation for file storage
     */
    public String toFileString() {
        StringBuilder sb = new StringBuilder();
        sb.append(addonId).append(",");
        sb.append(photographerId != null ? photographerId : "").append(",");
        sb.append(name != null ? name.replace(",", ";;") : "").append(",");
        sb.append(description != null ? description.replace(",", ";;") : "").append(",");
        sb.append(price).append(",");

        // Join applicable service IDs with |
        sb.append(String.join("|", applicableServiceIds)).append(",");

        sb.append(isAllServices).append(",");
        sb.append(purchaseCount);

        return sb.toString();
    }

    /**
     * Create add-on from file string
     * @param fileString String representation from file
     * @return PhotographerServiceAddon object
     */
    public static PhotographerServiceAddon fromFileString(String fileString) {
        String[] parts = fileString.split(",");
        if (parts.length < 7) {
            return null; // Not enough parts for a valid add-on
        }

        PhotographerServiceAddon addon = new PhotographerServiceAddon();
        int index = 0;

        addon.setAddonId(parts[index++]);
        addon.setPhotographerId(parts[index++]);
        addon.setName(parts[index++].replace(";;", ","));
        addon.setDescription(parts[index++].replace(";;", ","));
        addon.setPrice(Double.parseDouble(parts[index++]));

        // Parse applicable service IDs
        String serviceIdsStr = parts[index++];
        if (!serviceIdsStr.isEmpty()) {
            String[] serviceIdsArr = serviceIdsStr.split("\\|");
            for (String serviceId : serviceIdsArr) {
                addon.addApplicableService(serviceId);
            }
        }

        addon.setAllServices(Boolean.parseBoolean(parts[index++]));

        if (index < parts.length) {
            addon.setPurchaseCount(Integer.parseInt(parts[index]));
        }

        return addon;
    }

    @Override
    public String toString() {
        return "PhotographerServiceAddon{" +
                "addonId='" + addonId + '\'' +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", isAllServices=" + isAllServices +
                '}';
    }
}