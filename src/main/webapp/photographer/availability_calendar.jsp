<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.photobooking.model.user.User" %>
<%@ page import="com.photobooking.model.booking.Booking" %>
<%@ page import="com.photobooking.model.photographer.UnavailableDate" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonArray" %>

<%
    // Ensure user is logged in and is a photographer
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || currentUser.getUserType() != User.UserType.PHOTOGRAPHER) {
        response.sendRedirect(request.getContextPath() + "/user/login.jsp");
        return;
    }

    // Retrieve data set by the servlet
    List<Booking> upcomingBookings = (List<Booking>) request.getAttribute("upcomingBookings");
    List<UnavailableDate> unavailableDates = (List<UnavailableDate>) request.getAttribute("unavailableDates");
    String calendarEventsJson = (String) request.getAttribute("calendarEventsJson");

    // Fallback for null values
    if (upcomingBookings == null) upcomingBookings = new ArrayList<>();
    if (unavailableDates == null) unavailableDates = new ArrayList<>();
    if (calendarEventsJson == null) calendarEventsJson = "[]";

    // Debug logging
    System.out.println("Upcoming Bookings: " + upcomingBookings.size());
    System.out.println("Unavailable Dates: " + unavailableDates.size());
    System.out.println("Calendar Events JSON: " + calendarEventsJson);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Availability Calendar - SnapEvent</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <!-- FullCalendar CSS -->
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css" rel="stylesheet">

    <style>
        body { background-color: #f4f6f9; }
        .calendar-container { 
            background-color: white; 
            border-radius: 10px; 
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            padding: 20px;
        }
        .time-slot {
            cursor: pointer;
            padding: 8px;
            margin: 5px 0;
            border: 1px solid #dee2e6;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .time-slot:hover { background-color: #f8f9fa; }
        .time-slot.selected { 
            background-color: #dc3545; 
            color: white; 
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/includes/header.jsp" />

    <div class="container-fluid mt-4">
        <div class="row">
            <div class="col-lg-8 offset-lg-2">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h3 class="mb-0">Availability Calendar</h3>
                        <div>
                            <button class="btn btn-primary me-2" data-bs-toggle="modal" data-bs-target="#blockDatesModal">
                                <i class="bi bi-calendar-x me-1"></i>Block Dates
                            </button>
                            <button class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#unavailableDatesModal">
                                <i class="bi bi-calendar-minus me-1"></i>View Blocked
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-lg-8">
                                <div class="calendar-container">
                                    <div id="calendar"></div>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div id="timeSlots" style="display:none;">
                                    <h5 id="selectedDateTitle" class="mb-3">Select a Date</h5>
                                    <div class="time-slots-container">
                                        <div class="time-slot" data-time="09:00">9:00 AM</div>
                                        <div class="time-slot" data-time="10:00">10:00 AM</div>
                                        <div class="time-slot" data-time="11:00">11:00 AM</div>
                                        <div class="time-slot" data-time="12:00">12:00 PM</div>
                                        <div class="time-slot" data-time="13:00">1:00 PM</div>
                                        <div class="time-slot" data-time="14:00">2:00 PM</div>
                                        <div class="time-slot" data-time="15:00">3:00 PM</div>
                                        <div class="time-slot" data-time="16:00">4:00 PM</div>
                                        <div class="time-slot" data-time="17:00">5:00 PM</div>
                                        <div class="time-slot" data-time="18:00">6:00 PM</div>
                                        <div class="time-slot" data-time="19:00">7:00 PM</div>
                                        <div class="time-slot" data-time="20:00">8:00 PM</div>
                                    </div>
                                    <button id="saveAvailability" class="btn btn-success w-100 mt-3">
                                        Save Availability
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Unavailable Dates Modal -->
    <div class="modal fade" id="unavailableDatesModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Blocked Dates</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="unavailableDatesList">
                    <c:choose>
                        <c:when test="${not empty unavailableDates}">
                            <c:forEach var="unavailableDate" items="${unavailableDates}">
                                <div class="card mb-2">
                                    <div class="card-body d-flex justify-content-between align-items-center">
                                        <div>
                                            <h6 class="card-title mb-1">
                                                <fmt:formatDate value="${unavailableDate.date}" pattern="MMM dd, yyyy" />
                                            </h6>
                                            <p class="text-muted mb-0">
                                                <c:choose>
                                                    <c:when test="${unavailableDate.allDay}">
                                                        Blocked entire day
                                                    </c:when>
                                                    <c:otherwise>
                                                        Blocked from ${unavailableDate.startTime} to ${unavailableDate.endTime}
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:if test="${not empty unavailableDate.reason}">
                                                    • ${unavailableDate.reason}
                                                </c:if>
                                            </p>
                                        </div>
                                        <button class="btn btn-sm btn-outline-danger remove-blocked-date" 
                                                data-date-id="${unavailableDate.id}">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center text-muted">
                                <i class="bi bi-calendar-check fs-1 mb-3"></i>
                                <p>No blocked dates</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Block Dates Modal -->
    <div class="modal fade" id="blockDatesModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Block Dates</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="blockDatesForm">
                        <div class="mb-3">
                            <label class="form-label">Start Date</label>
                            <input type="date" class="form-control" id="blockStartDate" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">End Date (Optional)</label>
                            <input type="date" class="form-control" id="blockEndDate">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Reason (Optional)</label>
                            <input type="text" class="form-control" id="blockReason" placeholder="Holiday, Personal, etc.">
                        </div>
                        <div class="form-check mb-3">
                            <input type="checkbox" class="form-check-input" id="blockAllDay" checked>
                            <label class="form-check-label">Block Entire Day</label>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="confirmBlockDates">Block Dates</button>
                </div>
            </div>
        </div>
    </div>

    <!-- FullCalendar JS -->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js"></script>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Debug: Log calendar events from server
            console.log('Calendar Events (JSON):', <%= calendarEventsJson %>);

            // Calendar Initialization
            const calendarEl = document.getElementById('calendar');
            const calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                height: 'auto',
                selectable: true,
                events: <%= calendarEventsJson %>,
                eventClick: function(info) {
                    // Optional: Handle event clicks if needed
                    console.log('Event clicked:', info.event);
                },
                dateClick: function(info) {
                    selectDate(info.dateStr);
                }
            });
            calendar.render();

            // Date Selection
            function selectDate(dateStr) {
                const timeSlots = document.getElementById('timeSlots');
                const selectedDateTitle = document.getElementById('selectedDateTitle');
                
                selectedDateTitle.textContent = new Date(dateStr).toLocaleDateString('en-US', { 
                    weekday: 'long', 
                    year: 'numeric', 
                    month: 'long', 
                    day: 'numeric' 
                });
                
                timeSlots.style.display = 'block';
                
                // Reset time slots
                document.querySelectorAll('.time-slot').forEach(slot => {
                    slot.classList.remove('selected');
                });
            }

            // Time Slot Selection
            document.querySelectorAll('.time-slot').forEach(slot => {
                slot.addEventListener('click', function() {
                    this.classList.toggle('selected');
                });
            });

            // Save Availability
            document.getElementById('saveAvailability').addEventListener('click', function() {
                const selectedDate = document.getElementById('selectedDateTitle').textContent;
                const dateStr = new Date(selectedDate).toISOString().split('T')[0];
                const selectedTimeSlots = Array.from(
                    document.querySelectorAll('.time-slot.selected')
                ).map(slot => slot.getAttribute('data-time'));

                // Call backend to save availability
                fetch('${pageContext.request.contextPath}/photographer/save-availability', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({
                        date: dateStr,
                        unavailableTimeSlots: selectedTimeSlots

                    })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // Refresh calendar and show success message
                        calendar.refetchEvents();
                        alert('Availability saved successfully!');
                        document.getElementById('timeSlots').style.display = 'none';
                    } else {
                        alert('Error: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An error occurred while saving availability.');
                });
            });

            // Block Dates
            document.getElementById('confirmBlockDates').addEventListener('click', function() {
                const startDate = document.getElementById('blockStartDate').value;
                const endDate = document.getElementById('blockEndDate').value;
                const blockAllDay = document.getElementById('blockAllDay').checked;
                const blockReason = document.getElementById('blockReason').value || 'Unavailable';

                // Prepare form data
                const formData = new FormData();
                formData.append('startDate', startDate);
                if (endDate) formData.append('endDate', endDate);
                if (blockAllDay) formData.append('allDay', 'on');
                formData.append('reason', blockReason);

                // Call backend to block dates
                fetch('${pageContext.request.contextPath}/photographer/block-dates', {
                    method: 'POST',
                    body: formData
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // Refresh calendar and show success message
                        calendar.refetchEvents();

                        // Update unavailable dates list in modal
                        updateUnavailableDatesList(data.blockedDates || []);

                        // Close modal
                        const modal = bootstrap.Modal.getInstance(document.getElementById('blockDatesModal'));
                        modal.hide();

                        alert('Dates blocked successfully!');
                    } else {
                        alert('Error: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An error occurred while blocking dates.');
                });
            });

            // Remove Blocked Date
            document.querySelectorAll('.remove-blocked-date').forEach(button => {
                button.addEventListener('click', function() {
                    const dateId = this.getAttribute('data-date-id');

                    // Call backend to remove blocked date
                    fetch('${pageContext.request.contextPath}/photographer/remove-blocked-date', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: 'dateId=' + dateId
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            // Remove date from list and refresh calendar
                            this.closest('.card').remove();
                            calendar.refetchEvents();
                            alert('Blocked date removed successfully!');
                        } else {
                            alert('Error: ' + data.message);
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('An error occurred while removing blocked date.');
                    });
                });
            });

            // Helper function to update unavailable dates list
            function updateUnavailableDatesList(blockedDates) {
                const listContainer = document.getElementById('unavailableDatesList');

                // Clear existing list
                listContainer.innerHTML = '';

                // If no blocked dates, show no data message
                if (!blockedDates || blockedDates.length === 0) {
                    listContainer.innerHTML = `
                        <div class="text-center text-muted">
                            <i class="bi bi-calendar-check fs-1 mb-3"></i>
                            <p>No blocked dates</p>
                        </div>
                    `;
                    return;
                }

                // Populate list with new blocked dates
                blockedDates.forEach(dateObj => {
                    const dateItem = document.createElement('div');
                    dateItem.classList.add('card', 'mb-2');

                    const formattedDate = new Date(dateObj.date).toLocaleDateString('en-US', {
                        month: 'short',
                        day: 'numeric',
                        year: 'numeric'
                    });

                    dateItem.innerHTML = `
                        <div class="card-body d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="card-title mb-1">${formattedDate}</h6>
                                <p class="text-muted mb-0">
                                    ${dateObj.allDay ? 'Blocked entire day' : 'Blocked time slots'}
                                    ${dateObj.reason ? '• ' + dateObj.reason : ''}
                                </p>
                            </div>
                            <button class="btn btn-sm btn-outline-danger remove-blocked-date"
                                    data-date-id="${dateObj.id}">
                                <i class="bi bi-trash"></i>
                            </button>
                        </div>
                    `;

                    listContainer.appendChild(dateItem);

                    // Add event listener to new remove buttons
                    const removeButton = dateItem.querySelector('.remove-blocked-date');
                    removeButton.addEventListener('click', function() {
                        const dateId = this.getAttribute('data-date-id');

                        // Call backend to remove blocked date
                        fetch('${pageContext.request.contextPath}/photographer/remove-blocked-date', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                            },
                            body: 'dateId=' + dateId
                        })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                // Remove date from list and refresh calendar
                                this.closest('.card').remove();
                                calendar.refetchEvents();
                                alert('Blocked date removed successfully!');
                            } else {
                                alert('Error: ' + data.message);
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('An error occurred while removing blocked date.');
                        });
                    });
                });
            }
        });
    </script>
</body>
</html>