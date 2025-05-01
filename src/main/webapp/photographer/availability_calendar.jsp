<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

    <!-- Custom CSS -->
    <style>
        .time-slot {
            border: 1px solid #ddd;
            border-radius: 6px;
            padding: 8px 12px;
            margin-bottom: 8px;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .time-slot:hover {
            background-color: #f8f9fa;
        }

        .time-slot.selected {
            background-color: #4361ee;
            color: white;
            border-color: #3a56d4;
        }

        .content-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.05);
            padding: 20px;
            margin-bottom: 20px;
        }

        .card-header-custom {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
        }

        .card-title-custom {
            font-weight: 600;
            color: #4361ee;
            margin-bottom: 0;
        }

        .selected-date-container {
            border-left: 4px solid #4361ee;
            padding-left: 15px;
        }

        .quick-access-buttons {
            margin-bottom: 15px;
        }

        .time-slots-container {
            max-height: 300px;
            overflow-y: auto;
        }

        .empty-state-message {
            padding: 40px 20px;
            color: #6c757d;
        }

        .unavailable-date-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #eee;
            padding: 12px 0;
        }

        .unavailable-date-item:last-child {
            border-bottom: none;
        }

        .unavailable-date {
            font-weight: 500;
        }

        .unavailable-time {
            color: #6c757d;
            font-size: 0.9rem;
        }

        .remove-date {
            cursor: pointer;
            color: #dc3545;
        }

        .remove-date:hover {
            color: #c82333;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/includes/header.jsp" />

    <div class="container-fluid">
        <div class="row">
            <!-- Include Sidebar with "availability" as active page -->
            <c:set var="activePage" value="availability" scope="request"/>
            <jsp:include page="/includes/sidebar.jsp" />

            <!-- Main Content Area -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Availability Calendar</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <button type="button" class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#blockDatesModal">
                                <i class="bi bi-calendar-x me-1"></i>Block Dates
                            </button>
                            <button type="button" class="btn btn-sm btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#unavailableDatesModal">
                                <i class="bi bi-calendar-minus me-1"></i>View Blocked Dates
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Include Messages -->
                <jsp:include page="/includes/messages.jsp" />

                <div class="row g-4">
                    <!-- Calendar Column -->
                    <div class="col-lg-8">
                        <div class="content-card">
                            <div id="calendar"></div>
                        </div>
                    </div>

                    <!-- Availability Settings Column -->
                    <div class="col-lg-4">
                        <!-- Date Availability Card -->
                        <div class="content-card">
                            <div id="selectedDateContainer" style="display: none;">
                                <div class="selected-date-container mb-4">
                                    <h5 id="selectedDateDisplay">Selected Date</h5>
                                    <p class="text-muted">Select your availability for this date</p>
                                </div>

                                <div class="quick-access-buttons d-flex flex-wrap gap-2 mb-3">
                                    <button class="btn btn-sm btn-outline-primary" id="selectAllTimes">
                                        <i class="bi bi-check-all me-1"></i>Select All
                                    </button>
                                    <button class="btn btn-sm btn-outline-secondary" id="deselectAllTimes">
                                        <i class="bi bi-x-lg me-1"></i>Deselect All
                                    </button>
                                    <button class="btn btn-sm btn-outline-info" id="selectMorningTimes">
                                        <i class="bi bi-sunrise me-1"></i>Morning
                                    </button>
                                    <button class="btn btn-sm btn-outline-info" id="selectAfternoonTimes">
                                        <i class="bi bi-sun me-1"></i>Afternoon
                                    </button>
                                    <button class="btn btn-sm btn-outline-info" id="selectEveningTimes">
                                        <i class="bi bi-sunset me-1"></i>Evening
                                    </button>
                                </div>

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

                                <div class="d-grid mt-4">
                                    <button class="btn btn-primary" id="saveAvailability">
                                        <i class="bi bi-check-circle me-2"></i>Save Availability
                                    </button>
                                </div>
                            </div>

                            <div class="empty-state-message text-center" id="emptyStateMessage">
                                <i class="bi bi-calendar2-plus fs-1 text-muted mb-3"></i>
                                <h6>Select a Date</h6>
                                <p class="text-muted small">Click on a date in the calendar to set your availability for that day.</p>
                            </div>
                        </div>

                        <!-- Upcoming Bookings Card -->
                        <div class="content-card">
                            <div class="card-header-custom">
                                <h5 class="card-title-custom">
                                    <i class="bi bi-bookmarks me-2"></i>Upcoming Bookings
                                </h5>
                                <a href="${pageContext.request.contextPath}/booking/booking_list.jsp" class="btn btn-sm btn-outline-primary">View All</a>
                            </div>

                            <div class="upcoming-bookings">
                                <c:choose>
                                    <c:when test="${not empty upcomingBookings}">
                                        <c:forEach var="booking" items="${upcomingBookings}">
                                            <div class="unavailable-date-item">
                                                <div class="unavailable-date-info">
                                                    <span class="unavailable-date">
                                                        <fmt:formatDate value="${booking.eventDateTime}" pattern="MMM d, yyyy" />
                                                    </span>
                                                    <span class="unavailable-time">${booking.eventType}</span>
                                                </div>
                                                <a href="${pageContext.request.contextPath}/booking/booking_details.jsp?id=${booking.bookingId}"
                                                   class="btn btn-sm btn-outline-primary">Details</a>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Sample bookings if none in database -->
                                        <div class="unavailable-date-item">
                                            <div class="unavailable-date-info">
                                                <span class="unavailable-date">Dec 15, 2023</span>
                                                <span class="unavailable-time">Wedding Photography</span>
                                            </div>
                                            <a href="${pageContext.request.contextPath}/booking/booking_details.jsp?id=b001"
                                               class="btn btn-sm btn-outline-primary">Details</a>
                                        </div>

                                        <div class="unavailable-date-item">
                                            <div class="unavailable-date-info">
                                                <span class="unavailable-date">Jan 20, 2024</span>
                                                <span class="unavailable-time">Corporate Headshots</span>
                                            </div>
                                            <a href="${pageContext.request.contextPath}/booking/booking_details.jsp?id=b004"
                                               class="btn btn-sm btn-outline-primary">Details</a>
                                        </div>

                                        <div class="unavailable-date-item">
                                            <div class="unavailable-date-info">
                                                <span class="unavailable-date">Feb 5, 2024</span>
                                                <span class="unavailable-time">Product Photoshoot</span>
                                            </div>
                                            <a href="${pageContext.request.contextPath}/booking/booking_details.jsp?id=b005"
                                               class="btn btn-sm btn-outline-primary">Details</a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Block Dates Modal -->
    <div class="modal fade" id="blockDatesModal" tabindex="-1" aria-labelledby="blockDatesModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="blockDatesModalLabel">Block Off Dates</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="blockDatesForm" action="${pageContext.request.contextPath}/photographer/block-dates" method="post">
                        <div class="mb-3">
                            <label for="blockDateStart" class="form-label">Start Date</label>
                            <input type="date" class="form-control" id="blockDateStart" name="startDate" required>
                        </div>
                        <div class="mb-3">
                            <label for="blockDateEnd" class="form-label">End Date (Optional)</label>
                            <input type="date" class="form-control" id="blockDateEnd" name="endDate">
                            <div class="form-text">Leave empty to block a single day.</div>
                        </div>
                        <div class="mb-3">
                            <label for="blockReason" class="form-label">Reason (Optional)</label>
                            <input type="text" class="form-control" id="blockReason" name="reason" placeholder="Personal, Holiday, etc.">
                        </div>
                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" id="blockAllDay" name="allDay" checked>
                            <label class="form-check-label" for="blockAllDay">
                                Block entire day(s)
                            </label>
                        </div>
                        <div id="blockTimeContainer" style="display: none;">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="blockTimeStart" class="form-label">Start Time</label>
                                    <select class="form-select" id="blockTimeStart" name="startTime">
                                        <option value="09:00">9:00 AM</option>
                                        <option value="10:00">10:00 AM</option>
                                        <option value="11:00">11:00 AM</option>
                                        <option value="12:00">12:00 PM</option>
                                        <option value="13:00">1:00 PM</option>
                                        <option value="14:00">2:00 PM</option>
                                        <option value="15:00">3:00 PM</option>
                                        <option value="16:00">4:00 PM</option>
                                        <option value="17:00">5:00 PM</option>
                                        <option value="18:00">6:00 PM</option>
                                        <option value="19:00">7:00 PM</option>
                                        <option value="20:00">8:00 PM</option>
                                    </select>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="blockTimeEnd" class="form-label">End Time</label>
                                    <select class="form-select" id="blockTimeEnd" name="endTime">
                                        <option value="10:00">10:00 AM</option>
                                        <option value="11:00">11:00 AM</option>
                                        <option value="12:00">12:00 PM</option>
                                        <option value="13:00">1:00 PM</option>
                                        <option value="14:00">2:00 PM</option>
                                        <option value="15:00">3:00 PM</option>
                                        <option value="16:00">4:00 PM</option>
                                        <option value="17:00">5:00 PM</option>
                                        <option value="18:00">6:00 PM</option>
                                        <option value="19:00">7:00 PM</option>
                                        <option value="20:00">8:00 PM</option>
                                        <option value="21:00">9:00 PM</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" form="blockDatesForm" class="btn btn-primary">Block Dates</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Unavailable Dates Modal -->
    <div class="modal fade" id="unavailableDatesModal" tabindex="-1" aria-labelledby="unavailableDatesModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="unavailableDatesModalLabel">Unavailable Dates</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="unavailable-dates" id="unavailableDatesList">
                        <c:choose>
                            <c:when test="${not empty unavailableDates}">
                                <c:forEach var="unavailableDate" items="${unavailableDates}">
                                    <div class="unavailable-date-item">
                                        <div class="unavailable-date-info">
                                            <span class="unavailable-date">
                                                <fmt:formatDate value="${unavailableDate.date}" pattern="MMM d, yyyy" />
                                            </span>
                                            <span class="unavailable-time">
                                                All Day
                                                <c:if test="${not empty unavailableDate.reason}">
                                                    • ${unavailableDate.reason}
                                                </c:if>
                                            </span>
                                        </div>
                                        <div class="remove-date" data-date-id="${unavailableDate.id}">
                                            <i class="bi bi-x-circle"></i>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <!-- Sample unavailable dates if none in database -->
                                <div class="unavailable-date-item">
                                    <div class="unavailable-date-info">
                                        <span class="unavailable-date">Dec 24, 2023</span>
                                        <span class="unavailable-time">All Day • Holiday</span>
                                    </div>
                                    <div class="remove-date" data-date="2023-12-24">
                                        <i class="bi bi-x-circle"></i>
                                    </div>
                                </div>

                                <div class="unavailable-date-item">
                                    <div class="unavailable-date-info">
                                        <span class="unavailable-date">Dec 25, 2023</span>
                                        <span class="unavailable-time">All Day • Holiday</span>
                                    </div>
                                    <div class="remove-date" data-date="2023-12-25">
                                        <i class="bi bi-x-circle"></i>
                                    </div>
                                </div>

                                <div class="unavailable-date-item">
                                    <div class="unavailable-date-info">
                                        <span class="unavailable-date">Dec 31, 2023</span>
                                        <span class="unavailable-time">All Day • Personal</span>
                                    </div>
                                    <div class="remove-date" data-date="2023-12-31">
                                        <i class="bi bi-x-circle"></i>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="/includes/footer.jsp" />

    <!-- FullCalendar JS -->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js"></script>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize FullCalendar
            const calendarEl = document.getElementById('calendar');

            const calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek'
                },
                height: '100%',
                selectable: true,
                selectMirror: true,
                dayMaxEvents: true,
                events: ${calendarEventsJson != null ? calendarEventsJson : '[
                    // Default events if none in database
                    // Existing bookings (confirmed) - cannot be changed
                    {
                        id: "booking-1",
                        title: "Wedding Photography",
                        start: "2023-12-15",
                        end: "2023-12-16",
                        className: "booking-event",
                        backgroundColor: "#28a745",
                        borderColor: "#28a745"
                    },
                    {
                        id: "booking-2",
                        title: "Corporate Headshots",
                        start: "2024-01-20",
                        className: "booking-event",
                        backgroundColor: "#28a745",
                        borderColor: "#28a745"
                    },
                    {
                        id: "booking-3",
                        title: "Product Photoshoot",
                        start: "2024-02-05",
                        className: "booking-event",
                        backgroundColor: "#ffc107",
                        borderColor: "#ffc107"
                    },

                    // Unavailable dates (blocked by photographer)
                    {
                        id: "unavailable-1",
                        title: "Unavailable",
                        start: "2023-12-24",
                        end: "2023-12-26",
                        className: "unavailable-event",
                        backgroundColor: "#dc3545",
                        borderColor: "#dc3545"
                    },
                    {
                        id: "unavailable-2",
                        title: "Unavailable",
                        start: "2023-12-31",
                        className: "unavailable-event",
                        backgroundColor: "#dc3545",
                        borderColor: "#dc3545"
                    }
                ]'},
                dateClick: function(info) {
                    selectDate(info.dateStr);
                },
                eventClick: function(info) {
                    const eventType = info.event.id ? (info.event.id.startsWith('booking') ? 'booking' : 'unavailable') : 'unavailable';

                    if (eventType === 'booking') {
                        // Redirect to booking details
                        const bookingId = info.event.id.replace('booking-', 'b00');
                        window.location.href = '${pageContext.request.contextPath}/booking/booking_details.jsp?id=' + bookingId;
                    } else if (eventType === 'unavailable') {
                        // Show unavailable date details
                        selectDate(info.event.startStr);
                    }
                }
            });

            calendar.render();

            // Date Selection function
            function selectDate(dateStr) {
                // Format date for display
                const selectedDate = new Date(dateStr);
                const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
                const formattedDate = selectedDate.toLocaleDateString('en-US', options);

                // Update display
                document.getElementById('selectedDateDisplay').textContent = formattedDate;
                document.getElementById('selectedDateContainer').style.display = 'block';
                document.getElementById('emptyStateMessage').style.display = 'none';

                // Check if date is already unavailable
                let isUnavailable = false;
                const events = calendar.getEvents();

                events.forEach(function(event) {
                    const eventStart = event.start.toISOString().split('T')[0];
                    const eventEnd = event.end ? event.end.toISOString().split('T')[0] : null;

                    if (event.id && event.id.startsWith('unavailable')) {
                        if (eventStart === dateStr ||
                            (eventEnd && dateStr >= eventStart && dateStr < eventEnd)) {
                            isUnavailable = true;

                            // If unavailable, select all time slots
                            document.querySelectorAll('.time-slot').forEach(function(slot) {
                                slot.classList.add('selected');
                            });
                        }
                    }
                });

                // If date is not unavailable, reset time slots
                if (!isUnavailable) {
                    document.querySelectorAll('.time-slot').forEach(function(slot) {
                        slot.classList.remove('selected');
                    });
                }

                // Call backend to get time slots for this date
                fetch('${pageContext.request.contextPath}/photographer/get-availability?date=' + dateStr)
                    .then(response => response.json())
                    .then(data => {
                        if (data.success && data.availableTimeSlots) {
                            // Update time slots based on available times
                            document.querySelectorAll('.time-slot').forEach(function(slot) {
                                const timeSlot = slot.getAttribute('data-time');
                                if (data.availableTimeSlots.includes(timeSlot)) {
                                    slot.classList.remove('selected');
                                } else {
                                    slot.classList.add('selected');
                                }
                            });
                        }
                    })
                    .catch(error => {
                        console.log('Error fetching availability:', error);
                    });
            }

            // Time Slot Selection
            const timeSlots = document.querySelectorAll('.time-slot');
            timeSlots.forEach(function(slot) {
                slot.addEventListener('click', function() {
                    this.classList.toggle('selected');
                });
            });

            // Quick Access Buttons
            document.getElementById('selectAllTimes').addEventListener('click', function() {
                timeSlots.forEach(function(slot) {
                    slot.classList.add('selected');
                });
            });

            document.getElementById('deselectAllTimes').addEventListener('click', function() {
                timeSlots.forEach(function(slot) {
                    slot.classList.remove('selected');
                });
            });

            document.getElementById('selectMorningTimes').addEventListener('click', function() {
                timeSlots.forEach(function(slot) {
                    const time = slot.getAttribute('data-time');
                    if (time <= '12:00') {
                        slot.classList.add('selected');
                    }
                });
            });

            document.getElementById('selectAfternoonTimes').addEventListener('click', function() {
                timeSlots.forEach(function(slot) {
                    const time = slot.getAttribute('data-time');
                    if (time > '12:00' && time <= '17:00') {
                        slot.classList.add('selected');
                    }
                });
            });

            document.getElementById('selectEveningTimes').addEventListener('click', function() {
                timeSlots.forEach(function(slot) {
                    const time = slot.getAttribute('data-time');
                    if (time > '17:00') {
                        slot.classList.add('selected');
                    }
                });
            });

            // Save Availability
            document.getElementById('saveAvailability').addEventListener('click', function() {
                const selectedDate = document.getElementById('selectedDateDisplay').textContent;
                const date = new Date(selectedDate);
                const dateStr = date.toISOString().split('T')[0];

                // Get unavailable time slots (selected ones)
                const unavailableSlots = [];
                document.querySelectorAll('.time-slot.selected').forEach(function(slot) {
                    unavailableSlots.push(slot.getAttribute('data-time'));
                });

                // Call backend to save availability
                fetch('${pageContext.request.contextPath}/photographer/save-availability', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({
                        date: dateStr,
                        unavailableTimeSlots: unavailableSlots
                    })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // Show success message
                        alert("Availability saved successfully!");

                        // Refresh calendar
                        calendar.refetchEvents();

                        // Reset the selection
                        document.getElementById('selectedDateContainer').style.display = 'none';
                        document.getElementById('emptyStateMessage').style.display = 'block';
                    } else {
                        alert("Error saving availability: " + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error saving availability:', error);
                    alert("An error occurred while saving availability.");
                });
            });

            // Toggle Block All Day Checkbox
            document.getElementById('blockAllDay').addEventListener('change', function() {
                const timeContainer = document.getElementById('blockTimeContainer');
                timeContainer.style.display = this.checked ? 'none' : 'block';
            });

            // Block Dates Form Submission
            document.getElementById('blockDatesForm').addEventListener('submit', function(e) {
                e.preventDefault();

                const formData = new FormData(this);

                fetch('${pageContext.request.contextPath}/photographer/block-dates', {
                    method: 'POST',
                    body: formData
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // Close modal
                        const modal = bootstrap.Modal.getInstance(document.getElementById('blockDatesModal'));
                        modal.hide();

                        // Reset form
                        this.reset();

                        // Show success message
                        alert("Dates blocked successfully!");

                        // Refresh calendar
                        calendar.refetchEvents();

                        // Add to unavailable dates list
                        if (data.blockedDates) {
                            data.blockedDates.forEach(function(blockedDate) {
                                addUnavailableDay(blockedDate.date, blockedDate.reason);
                            });
                        }
                    } else {
                        alert("Error blocking dates: " + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error blocking dates:', error);
                    alert("An error occurred while blocking dates.");
                });
            });

            // Remove unavailable date
            const removeButtons = document.querySelectorAll('.remove-date');
            removeButtons.forEach(function(button) {
                button.addEventListener('click', function() {
                    const dateId = this.getAttribute('data-date-id');
                    const date = this.getAttribute('data-date');
                    const dateToRemove = dateId || date; // Use date ID if available, otherwise use date string

                    if (confirm("Are you sure you want to remove this unavailable date?")) {
                        // Call backend to remove date
                        fetch('${pageContext.request.contextPath}/photographer/remove-blocked-date', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                            },
                            body: 'dateId=' + dateToRemove
                        })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                // Remove from UI
                                this.closest('.unavailable-date-item').remove();

                                // Refresh calendar
                                calendar.refetchEvents();

                                // Show success message
                                alert("Date has been removed from unavailable dates.");
                            } else {
                                alert("Error removing date: " + data.message);
                            }
                        })
                        .catch(error => {
                            console.error('Error removing date:', error);
                            alert("An error occurred while removing the date.");
                        });
                    }
                });
            });

            // Helper function to add unavailable day to the list
            function addUnavailableDay(dateText, reason = '') {
                const unavailableDatesList = document.getElementById('unavailableDatesList');
                const listItem = document.createElement('div');
                listItem.classList.add('unavailable-date-item');

                const timeText = reason ? `All Day • ${reason}` : 'All Day';

                listItem.innerHTML = `
                    <div class="unavailable-date-info">
                        <span class="unavailable-date">${dateText}</span>
                        <span class="unavailable-time">${timeText}</span>
                    </div>
                    <div class="remove-date" data-date="${dateText}">
                        <i class="bi bi-x-circle"></i>
                    </div>
                `;

                unavailableDatesList.prepend(listItem);

                // Add click event to the new remove button
                listItem.querySelector('.remove-date').addEventListener('click', function() {
                    if (confirm("Are you sure you want to remove this unavailable date?")) {
                        // Call backend to remove date
                        fetch('${pageContext.request.contextPath}/photographer/remove-blocked-date', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                            },
                            body: 'date=' + dateText
                        })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                // Remove from UI
                                listItem.remove();

                                // Refresh calendar
                                calendar.refetchEvents();

                                // Show success message
                                alert("Date has been removed from unavailable dates.");
                            } else {
                                alert("Error removing date: " + data.message);
                            }
                        })
                        .catch(error => {
                            console.error('Error removing date:', error);
                            alert("An error occurred while removing the date.");
                        });
                    }
                });
            }
        });
    </script>
</body>
</html>