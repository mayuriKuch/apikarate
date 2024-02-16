Feature: API Testing for restful-booker.herokuapp.com

  Background:
    * url 'https://restful-booker.herokuapp.com'

  Scenario: Get all bookings
    Given path '/booking'
    When method get
    Then status 200
    And match response.length() > 0

  Scenario: Create a booking
    Given path '/booking'
    And request { "firstname": "Jim", "lastname": "John", "totalprice": 100, "depositpaid": true, "bookingdates": { "checkin": "2022-01-01", "checkout": "2022-01-10" }, "additionalneeds": "Breakfast" }
    When method post
    Then status 200
    And match response.bookingid > 0

  Scenario: Get booking by ID
    Given path '/booking/{bookingId}'
    And path bookingId
    When method get
    Then status 200
    And match response.firstname == 'Jim'

  Scenario: Update booking
    Given path '/booking/{bookingId}'
    And path bookingId
    And request { "firstname": "UpdatedJim", "lastname": "UpdateJohn", "totalprice": 120, "depositpaid": false, "bookingdates": { "checkin": "2022-02-01", "checkout": "2022-02-10" }, "additionalneeds": "None" }
    When method put
    Then status 200
    And match response.firstname == 'UpdatedJim'

  Scenario: Partially update booking
    Given path '/booking/{bookingId}'
    And path bookingId
    And request { "totalprice": 150, "bookingdates": { "checkout": "2022-02-15" } }
    When method patch
    Then status 200
    And match response.totalprice == 150

  Scenario: Delete booking
    Given path '/booking/{bookingId}'
    And path bookingId
    When method delete
    Then status 200
    And match response == 'Booking Deleted'

