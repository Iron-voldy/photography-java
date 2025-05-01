<div class="time-slot" data-time="14:00">2:00 PM</div>
                            <div class="time-slot" data-time="15:00">3:00 PM</div>
                            <div class="time-slot" data-time="16:00">4:00 PM</div>
                            <div class="time-slot" data-time="17:00">5:00 PM</div>
                            <div class="time-slot" data-time="18:00">6:00 PM</div>
                            <div class="time-slot" data-time="19:00">7:00 PM</div>
                            <div class="time-slot" data-time="20:00">8:00 PM</div>
                        </div>

                        <div class="d-grid mt-4">
                            <button class="btn btn-primary-custom" id="saveAvailability">
                                <i class="bi bi-check-circle me-2"></i>Save Availability
                            </button>
                        </div>
                    </div>

                    <div class="empty-state-message text-center" id="emptyStateMessage">
                        <img src="${pageContext.request.contextPath}/assets/images/calendar-icon.svg" alt="Calendar" width="80" class="mb-3">
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
                        <a href="${pageContext.request.contextPath}/booking/booking_list.jsp" class="btn btn-sm btn-outline-custom">View All</a>
                    </div>

                    <div class="upcoming-bookings">
                        <!-- Booking 1 -->
                        <div class="unavailable-date-item">
                            <div class="unavailable-date-info">
                                <span class="unavailable-date">Dec 15, 2023</span>
                                <span class="unavailable-time">Wedding Photography</span>
                            </div>
                            <a href="${pageContext.request.contextPath}/booking/booking_details.jsp?id=b001" class="btn btn-sm btn-outline-custom">Details</a>
                        </div>

                        <!-- Booking 2 -->
                        <div class="unavailable-date-item">
                            <div class="unavailable-date-info">
                                <span class="unavailable-date">Jan 20, 2024</span>
                                <span class="unavailable-time">Corporate Headshots</span>
                            </div>
                            <a href="${pageContext.request.contextPath}/booking/booking_details.jsp?id=b004" class="btn btn-sm btn-outline-custom">Details</a>
                        </div>

                        <!-- Booking 3 -->
                        <div class="unavailable-date-item">
                            <div class="unavailable-date-info">
                                <span class="unavailable-date">Feb 5, 2024</span>
                                <span class="unavailable-time">Product Photoshoot</span>
                            </div>
                            <a href="${pageContext.request.contextPath}/booking/booking_details.jsp?id=b005" class="btn btn-sm btn-outline-custom">Details</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Block Dates Modal -->
    <div class="modal fade modal-style" id="blockDatesModal" tabindex="-1" aria-labelledby="blockDatesModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="blockDatesModalLabel">Block Off Dates</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="blockDatesForm">
                        <div class="mb-3">
                            <label for="blockDateStart" class="form-label">Start Date</label>
                            <input type="date" class="form-control" id="blockDateStart" required>
                        </div>
                        <div class="mb-3">
                            <label for="blockDateEnd" class="form-label">End Date (Optional)</label>
                            <input type="date" class="form-control" id="blockDateEnd">
                            <div class="form-text">Leave empty to block a single day.</div>
                        </div>
                        <div class="mb-3">
                            <label for="blockReason" class="form-label">Reason (Optional)</label>
                            <input type="text" class="form-control" id="blockReason" placeholder="Personal, Holiday, etc.">
                        </div>
                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" id="blockAllDay" checked>
                            <label class="form-check-label" for="blockAllDay">
                                Block entire day(s)
                            </label>
                        </div>
                        <div id="blockTimeContainer" style="display: none;">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="blockTimeStart" class="form-label">Start Time</label>
                                    <select class="form-select" id="blockTimeStart">
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
                                    <select class="form-select" id="blockTimeEnd">
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
                    <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary-custom" id="blockDatesSubmit">Block Dates</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Unavailable Dates Modal -->
    <div class="modal fade modal-style" id="unavailableDatesModal" tabindex="-1" aria-labelledby="unavailableDatesModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="unavailableDatesModalLabel">Unavailable Dates</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="unavailable-dates" id="unavailableDatesList">
                        <!-- Unavailable Date 1 -->
                        <div class="unavailable-date-item">
                            <div class="unavailable-date-info">
                                <span class="unavailable-date">Dec 24, 2023</span>
                                <span class="unavailable-time">All Day • Holiday</span>
                            </div>
                            <div class="remove-date" data-date="2023-12-24">
                                <i class="bi bi-x-circle"></i>
                            </div>
                        </div>

                        <!-- Unavailable Date 2 -->
                        <div class="unavailable-date-item">
                            <div class="unavailable-date-info">
                                <span class="unavailable-date">Dec 25, 2023</span>
                                <span class="unavailable-time">All Day • Holiday</span>
                            </div>
                            <div class="remove-date" data-date="2023-12-25">
                                <i class="bi bi-x-circle"></i>
                            </div>
                        </div>

                        <!-- Unavailable Date 3 -->
                        <div class="unavailable-date-item">
                            <div class="unavailable-date-info">
                                <span class="unavailable-date">Dec 31, 2023</span>
                                <span class="unavailable-time">All Day • Personal</span>
                            </div>
                            <div class="remove-date" data-date="2023-12-31">
                                <i class="bi bi-x-circle"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-custom" data-bs-dismiss="modal">Close</button>
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
                events: [
                    // Existing bookings (confirmed) - cannot be changed
                    {
                        id: 'booking-1',
                        title: 'Wedding Photography',
                        start: '2023-12-15',
                        end: '2023-12-16',
                        className: 'booking-event',
                        extendedProps: {
                            type: 'booking',
                            bookingId: 'b001'
                        }
                    },
                    {
                        id: 'booking-2',
                        title: 'Corporate Headshots',
                        start: '2024-01-20',
                        className: 'booking-event',
                        extendedProps: {
                            type: 'booking',
                            bookingId: 'b004'
                        }
                    },
                    {
                        id: 'booking-3',
                        title: 'Product Photoshoot',
                        start: '2024-02-05',
                        className: 'booking-event',
                        extendedProps: {
                            type: 'booking',
                            bookingId: 'b005'
                        }
                    },

                    // Unavailable dates (blocked by photographer)
                    {
                        id: 'unavailable-1',
                        title: 'Unavailable',
                        start: '2023-12-24',
                        end: '2023-12-26',
                        className: 'unavailable-event',
                        extendedProps: {
                            type: 'unavailable',
                            reason: 'Holiday'
                        }
                    },
                    {
                        id: 'unavailable-2',
                        title: 'Unavailable',
                        start: '2023-12-31',
                        className: 'unavailable-event',
                        extendedProps: {
                            type: 'unavailable',
                            reason: 'Personal'
                        }
                    }
                ],
                dateClick: function(info) {
                    selectDate(info.dateStr);
                },
                eventClick: function(info) {
                    const eventType = info.event.extendedProps.type;

                    if (eventType === 'booking') {
                        // Redirect to booking details
                        window.location.href = '${pageContext.request.contextPath}/booking/booking_details.jsp?id=' + info.event.extendedProps.bookingId;
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

                    if (event.extendedProps.type === 'unavailable') {
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
                const selectedSlots = document.querySelectorAll('.time-slot.selected');

                // In a real application, you would send this data to the server
                // For demo purposes, we'll just show a success message
                const selectedTimes = Array.from(selectedSlots).map(slot => slot.textContent);

                if (selectedTimes.length === 0) {
                    // Mark the entire day as available
                    showToast('All times for ' + selectedDate + ' marked as available.', 'success');
                } else if (selectedTimes.length === timeSlots.length) {
                    // Mark the entire day as unavailable
                    addUnavailableDay(document.getElementById('selectedDateDisplay').textContent);
                    showToast(selectedDate + ' marked as unavailable.', 'success');
                } else {
                    // Mark specific times as unavailable
                    showToast('Availability for ' + selectedDate + ' has been updated.', 'success');
                }

                // Reset the form
                document.getElementById('selectedDateContainer').style.display = 'none';
                document.getElementById('emptyStateMessage').style.display = 'block';

                // Refresh the calendar (in a real app, this would be done with actual data)
                calendar.refetchEvents();
            });

            // Toggle Block All Day Checkbox
            document.getElementById('blockAllDay').addEventListener('change', function() {
                const timeContainer = document.getElementById('blockTimeContainer');
                timeContainer.style.display = this.checked ? 'none' : 'block';
            });

            // Block Dates Submit
            document.getElementById('blockDatesSubmit').addEventListener('click', function() {
                const startDate = document.getElementById('blockDateStart').value;
                const endDate = document.getElementById('blockDateEnd').value;
                const reason = document.getElementById('blockReason').value;
                const allDay = document.getElementById('blockAllDay').checked;

                if (!startDate) {
                    alert('Please select a start date.');
                    return;
                }

                // In a real application, you would send this data to the server
                // For demo purposes, we'll just show a success message and update the UI

                // Format dates for display
                const formattedStartDate = new Date(startDate).toLocaleDateString('en-US', { year: 'numeric', month: 'short', day: 'numeric' });
                let message = '';

                if (endDate && endDate !== startDate) {
                    const formattedEndDate = new Date(endDate).toLocaleDateString('en-US', { year: 'numeric', month: 'short', day: 'numeric' });
                    message = `Dates from ${formattedStartDate} to ${formattedEndDate} have been blocked.`;

                    // Add to the unavailable dates list
                    addUnavailableDay(formattedStartDate + ' - ' + formattedEndDate, reason);
                } else {
                    message = `${formattedStartDate} has been blocked.`;

                    // Add to the unavailable dates list
                    addUnavailableDay(formattedStartDate, reason);
                }

                // Show the toast notification
                showToast(message, 'success');

                // Close the modal
                const modal = bootstrap.Modal.getInstance(document.getElementById('blockDatesModal'));
                modal.hide();

                // Reset the form
                document.getElementById('blockDatesForm').reset();

                // Refresh the calendar (in a real app, this would be done with actual data)
                calendar.refetchEvents();
            });

            // Remove unavailable date
            const removeButtons = document.querySelectorAll('.remove-date');
            removeButtons.forEach(function(button) {
                button.addEventListener('click', function() {
                    const date = this.getAttribute('data-date');
                    const dateItem = this.closest('.unavailable-date-item');

                    // Remove from UI
                    dateItem.remove();

                    // In a real app, you would send this data to the server
                    // For demo, just show a success message
                    showToast('Date has been removed from unavailable dates.', 'success');

                    // Refresh the calendar (in a real app, this would be done with actual data)
                    calendar.refetchEvents();
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
                    listItem.remove();
                    showToast('Date has been removed from unavailable dates.', 'success');
                    calendar.refetchEvents();
                });
            }

            // Helper function to show toast messages
            function showToast(message, type = 'info') {
                // Check if showToast function exists in the main.js
                if (typeof window.showToast === 'function') {
                    window.showToast(message, type);
                } else {
                    alert(message);
                }
            }
        });
    </script>
</body>
</html>