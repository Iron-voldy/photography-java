package com.photobooking.model.photographer;

import com.photobooking.util.FileHandler;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Manages service add-ons offered by photographers
 */
public class PhotographerServiceAddonManager {
    private static final String ADDON_FILE = "service_addons.txt";
    private List<PhotographerServiceAddon> addons;

    /**
     * Constructor initializes the manager and loads add-ons
     */
    public PhotographerServiceAddonManager() {
        this.addons = loadAddons();
    }

    /**
     * Load add-ons from file
     * @return List of add-ons
     */
    private List<PhotographerServiceAddon> loadAddons() {
        List<String> lines = FileHandler.readLines(ADDON_FILE);
        List<PhotographerServiceAddon> loadedAddons = new ArrayList<>();

        for (String line : lines) {
            if (!line.trim().isEmpty()) {
                PhotographerServiceAddon addon = PhotographerServiceAddon.fromFileString(line);
                if (addon != null) {
                    loadedAddons.add(addon);
                }
            }
        }

        return loadedAddons;
    }

    /**
     * Save all add-ons to file
     * @return true if successful, false otherwise
     */
    private boolean saveAddons() {
        try {
            // Delete existing file content
            FileHandler.deleteFile(ADDON_FILE);

            // Write each add-on to file
            for (PhotographerServiceAddon addon : addons) {
                FileHandler.appendLine(ADDON_FILE, addon.toFileString());
            }
            return true;
        } catch (Exception e) {
            System.err.println("Error saving add-ons: " + e.getMessage());
            return false;
        }
    }

    /**
     * Add a new add-on
     * @param addon The add-on to add
     * @return true if successful, false otherwise
     */
    public boolean addAddon(PhotographerServiceAddon addon) {
        if (addon == null || addon.getPhotographerId() == null) {
            return false;
        }

        addons.add(addon);
        return saveAddons();
    }

    /**
     * Get add-on by ID
     * @param addonId The add-on ID
     * @return The add-on or null if not found
     */
    public PhotographerServiceAddon getAddonById(String addonId) {
        if (addonId == null) return null;

        return addons.stream()
                .filter(a -> a.getAddonId().equals(addonId))
                .findFirst()
                .orElse(null);
    }

    /**
     * Get add-ons by photographer
     * @param photographerId The photographer ID
     * @return List of add-ons for the photographer
     */
    public List<PhotographerServiceAddon> getAddonsByPhotographer(String photographerId) {
        if (photographerId == null) return new ArrayList<>();

        return addons.stream()
                .filter(a -> a.getPhotographerId().equals(photographerId))
                .collect(Collectors.toList());
    }

    /**
     * Get add-ons applicable to a service
     * @param serviceId The service ID
     * @return List of add-ons applicable to the service
     */
    public List<PhotographerServiceAddon> getAddonsForService(String serviceId) {
        if (serviceId == null) return new ArrayList<>();

        PhotographerServiceManager serviceManager = new PhotographerServiceManager();
        PhotographerService service = serviceManager.getServiceById(serviceId);

        if (service == null) {
            return new ArrayList<>();
        }

        String photographerId = service.getPhotographerId();

        return addons.stream()
                .filter(a -> a.getPhotographerId().equals(photographerId))
                .filter(a -> a.isApplicableToService(serviceId))
                .collect(Collectors.toList());
    }

    /**
     * Update an existing add-on
     * @param updatedAddon The updated add-on
     * @return true if successful, false otherwise
     */
    public boolean updateAddon(PhotographerServiceAddon updatedAddon) {
        if (updatedAddon == null || updatedAddon.getAddonId() == null) {
            return false;
        }

        for (int i = 0; i < addons.size(); i++) {
            if (addons.get(i).getAddonId().equals(updatedAddon.getAddonId())) {
                addons.set(i, updatedAddon);
                return saveAddons();
            }
        }

        return false; // Add-on not found
    }

    /**
     * Delete an add-on
     * @param addonId The add-on ID
     * @return true if successful, false otherwise
     */
    public boolean deleteAddon(String addonId) {
        if (addonId == null) {
            return false;
        }

        boolean removed = addons.removeIf(a -> a.getAddonId().equals(addonId));
        if (removed) {
            return saveAddons();
        }

        return false; // Add-on not found
    }

    /**
     * Get top add-on by purchase count
     * @param photographerId The photographer ID
     * @return The top add-on or null if no add-ons
     */
    public PhotographerServiceAddon getTopAddon(String photographerId) {
        List<PhotographerServiceAddon> photographerAddons = getAddonsByPhotographer(photographerId);

        if (photographerAddons.isEmpty()) {
            return null;
        }

        return photographerAddons.stream()
                .max((a1, a2) -> Integer.compare(a1.getPurchaseCount(), a2.getPurchaseCount()))
                .orElse(null);
    }

    /**
     * Increment purchase count for an add-on
     * @param addonId The add-on ID
     * @return true if successful, false otherwise
     */
    public boolean incrementPurchaseCount(String addonId) {
        if (addonId == null) {
            return false;
        }

        PhotographerServiceAddon addon = getAddonById(addonId);
        if (addon == null) {
            return false;
        }

        addon.incrementPurchaseCount();
        return updateAddon(addon);
    }

    /**
     * Create default add-ons for a new photographer
     * @param photographerId The photographer ID
     * @return true if successful, false otherwise
     */
    public boolean createDefaultAddons(String photographerId) {
        if (photographerId == null) {
            return false;
        }

        // Check if photographer already has add-ons
        if (!getAddonsByPhotographer(photographerId).isEmpty()) {
            return false; // Photographer already has add-ons
        }

        // Create extra coverage hour add-on
        PhotographerServiceAddon extraHourAddon = new PhotographerServiceAddon(
                photographerId,
                "Extra Coverage Hour",
                "Additional hour of photography coverage",
                250.00
        );
        extraHourAddon.setAllServices(true);
        addAddon(extraHourAddon);

        // Create second photographer add-on
        PhotographerServiceAddon secondPhotographerAddon = new PhotographerServiceAddon(
                photographerId,
                "Second Photographer",
                "Additional photographer for 6 hours",
                400.00
        );
        secondPhotographerAddon.setAllServices(true);
        addAddon(secondPhotographerAddon);

        // Create engagement session add-on
        PhotographerServiceAddon engagementSessionAddon = new PhotographerServiceAddon(
                photographerId,
                "Engagement Session",
                "1-hour pre-wedding photo session",
                350.00
        );

        // Get service IDs for applicable services
        PhotographerServiceManager serviceManager = new PhotographerServiceManager();
        List<PhotographerService> services = serviceManager.getServicesByPhotographer(photographerId);

        for (PhotographerService service : services) {
            if ("WEDDING".equals(service.getCategory())) {
                engagementSessionAddon.addApplicableService(service.getServiceId());
            }
        }

        addAddon(engagementSessionAddon);

        // Create wedding album add-on
        PhotographerServiceAddon weddingAlbumAddon = new PhotographerServiceAddon(
                photographerId,
                "Wedding Album",
                "10x10, 30 pages, premium quality",
                600.00
        );

        for (PhotographerService service : services) {
            if ("WEDDING".equals(service.getCategory())) {
                weddingAlbumAddon.addApplicableService(service.getServiceId());
            }
        }

        addAddon(weddingAlbumAddon);

        // Create express editing add-on
        PhotographerServiceAddon expressEditingAddon = new PhotographerServiceAddon(
                photographerId,
                "Express Editing",
                "3-day rush turnaround",
                200.00
        );
        expressEditingAddon.setAllServices(true);
        addAddon(expressEditingAddon);

        return true;
    }
}