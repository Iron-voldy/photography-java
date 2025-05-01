package com.photobooking.model.photographer;

import java.util.List;

/**
 * Represents an agency photographer in the Event Photography System
 */
public class AgencyPhotographer extends Photographer {
    private static final long serialVersionUID = 1L;

    // Additional attributes specific to agency photographers
    private String agencyName;
    private String agencyId;
    private double commissionPercentage;
    private boolean hasAssistant;
    private boolean providesEditingServices;
    private int deliveryTimeInDays;
    private boolean hasBackupPhotographer;

    // Constructors
    public AgencyPhotographer() {
        super();
        this.commissionPercentage = 30.0; // Default 30% commission
        this.hasAssistant = false;
        this.providesEditingServices = true;
        this.deliveryTimeInDays = 14; // Default 2 weeks delivery
        this.hasBackupPhotographer = true;
    }

    public AgencyPhotographer(String userId, String businessName, String biography,
                              List<String> specialties, String location, double basePrice,
                              String agencyName, String agencyId) {
        super(userId, businessName, biography, specialties, location, basePrice);
        this.agencyName = agencyName;
        this.agencyId = agencyId;
        this.commissionPercentage = 30.0;
        this.hasAssistant = false;
        this.providesEditingServices = true;
        this.deliveryTimeInDays = 14;
        this.hasBackupPhotographer = true;
    }

    // Getters and Setters
    public String getAgencyName() {
        return agencyName;
    }

    public void setAgencyName(String agencyName) {
        this.agencyName = agencyName;
    }

    public String getAgencyId() {
        return agencyId;
    }

    public void setAgencyId(String agencyId) {
        this.agencyId = agencyId;
    }

    public double getCommissionPercentage() {
        return commissionPercentage;
    }

    public void setCommissionPercentage(double commissionPercentage) {
        this.commissionPercentage = commissionPercentage;
    }

    public boolean isHasAssistant() {
        return hasAssistant;
    }

    public void setHasAssistant(boolean hasAssistant) {
        this.hasAssistant = hasAssistant;
    }

    public boolean isProvidesEditingServices() {
        return providesEditingServices;
    }

    public void setProvidesEditingServices(boolean providesEditingServices) {
        this.providesEditingServices = providesEditingServices;
    }

    public int getDeliveryTimeInDays() {
        return deliveryTimeInDays;
    }

    public void setDeliveryTimeInDays(int deliveryTimeInDays) {
        this.deliveryTimeInDays = deliveryTimeInDays;
    }

    public boolean isHasBackupPhotographer() {
        return hasBackupPhotographer;
    }

    public void setHasBackupPhotographer(boolean hasBackupPhotographer) {
        this.hasBackupPhotographer = hasBackupPhotographer;
    }

    // Overridden methods
    @Override
    public double calculatePrice(int hours, String bookingType) {
        // Start with base calculation from parent class
        double price = super.calculatePrice(hours, bookingType);

        // Add assistant fee if applicable (20% surcharge)
        if (hasAssistant) {
            price *= 1.20;
        }

        // Add editing services fee if applicable (15% surcharge)
        if (providesEditingServices) {
            price *= 1.15;
        }

        // Add backup photographer guarantee (5% surcharge)
        if (hasBackupPhotographer) {
            price *= 1.05;
        }

        return price;
    }

    /**
     * Calculate agency commission
     *
     * @param totalPrice Total booking price
     * @return Commission amount
     */
    public double calculateCommission(double totalPrice) {
        return totalPrice * (commissionPercentage / 100.0);
    }

    /**
     * Calculate photographer's earnings after commission
     *
     * @param totalPrice Total booking price
     * @return Photographer's earnings
     */
    public double calculateEarnings(double totalPrice) {
        return totalPrice - calculateCommission(totalPrice);
    }

    /**
     * Check if rush delivery is available
     *
     * @param requestedDays Requested delivery time in days
     * @return true if rush delivery is available, false otherwise
     */
    public boolean isRushDeliveryAvailable(int requestedDays) {
        // Rush delivery is available if requested days is less than standard
        // but not less than half of standard delivery time
        return requestedDays < deliveryTimeInDays && requestedDays >= (deliveryTimeInDays / 2);
    }

    /**
     * Calculate rush delivery fee
     *
     * @param requestedDays Requested delivery time in days
     * @param basePrice     Base price of booking
     * @return Rush delivery fee, or -1 if rush delivery not available
     */
    public double calculateRushDeliveryFee(int requestedDays, double basePrice) {
        if (!isRushDeliveryAvailable(requestedDays)) {
            return -1.0;
        }

        // Fee increases as delivery time decreases
        double rushFactor = (double) (deliveryTimeInDays - requestedDays) / deliveryTimeInDays;
        return basePrice * 0.25 * rushFactor; // Up to 25% of base price
    }

    // Extended file string format
    @Override
    public String toFileString() {
        // Start with the parent class's implementation
        String baseString = super.toFileString();

        // Append agency-specific attributes
        return baseString + "," +
                "AGENCY" + "," +
                (agencyName != null ? agencyName.replace(",", ";;") : "") + "," +
                (agencyId != null ? agencyId : "") + "," +
                commissionPercentage + "," +
                hasAssistant + "," +
                providesEditingServices + "," +
                deliveryTimeInDays + "," +
                hasBackupPhotographer;
    }

    /**
     * Create AgencyPhotographer from file string
     *
     * @param fileString String representation from file
     * @return AgencyPhotographer object
     */
    public static AgencyPhotographer fromFileString(String fileString) {
        // Split the string into base part and agency part
        String[] parts = fileString.split("AGENCY,");
        if (parts.length < 2) {
            return null; // Not a valid agency photographer string
        }

        // Parse the base photographer first
        Photographer basePhotographer = Photographer.fromFileString(parts[0]);
        if (basePhotographer == null) {
            return null;
        }

        // Create a new AgencyPhotographer and copy properties from base
        AgencyPhotographer agencyPhotographer = new AgencyPhotographer();
        agencyPhotographer.setPhotographerId(basePhotographer.getPhotographerId());
        agencyPhotographer.setUserId(basePhotographer.getUserId());
        agencyPhotographer.setBusinessName(basePhotographer.getBusinessName());
        agencyPhotographer.setBiography(basePhotographer.getBiography());
        agencyPhotographer.setSpecialties(basePhotographer.getSpecialties());
        agencyPhotographer.setLocation(basePhotographer.getLocation());
        agencyPhotographer.setBasePrice(basePhotographer.getBasePrice());
        agencyPhotographer.setRating(basePhotographer.getRating());
        agencyPhotographer.setReviewCount(basePhotographer.getReviewCount());
        agencyPhotographer.setAvailability(basePhotographer.getAvailability());
        agencyPhotographer.setPortfolioImageUrls(basePhotographer.getPortfolioImageUrls());
        agencyPhotographer.setAvailableWeekends(basePhotographer.isAvailableWeekends());
        agencyPhotographer.setAvailableWeekdays(basePhotographer.isAvailableWeekdays());
        agencyPhotographer.setVerified(basePhotographer.isVerified());
        agencyPhotographer.setContactPhone(basePhotographer.getContactPhone());
        agencyPhotographer.setWebsiteUrl(basePhotographer.getWebsiteUrl());
        agencyPhotographer.setSocialMediaLinks(basePhotographer.getSocialMediaLinks());
        agencyPhotographer.setYearsOfExperience(basePhotographer.getYearsOfExperience());
        agencyPhotographer.setEmail(basePhotographer.getEmail());

        // Parse agency-specific properties
        String[] agencyParts = parts[1].split(",");
        if (agencyParts.length >= 7) {
            agencyPhotographer.setAgencyName(agencyParts[0].replace(";;", ","));
            agencyPhotographer.setAgencyId(agencyParts[1]);
            agencyPhotographer.setCommissionPercentage(Double.parseDouble(agencyParts[2]));
            agencyPhotographer.setHasAssistant(Boolean.parseBoolean(agencyParts[3]));
            agencyPhotographer.setProvidesEditingServices(Boolean.parseBoolean(agencyParts[4]));
            agencyPhotographer.setDeliveryTimeInDays(Integer.parseInt(agencyParts[5]));
            agencyPhotographer.setHasBackupPhotographer(Boolean.parseBoolean(agencyParts[6]));
        }

        return agencyPhotographer;
    }
}