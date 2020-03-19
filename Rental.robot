*** Settings ***
Documentation                           Infotiv Car Rental, labbarbete
Library                                 SeleniumLibrary
Resource                                ../Resources/Keywords.robot
Test Setup                              Begin Web Test
Test Teardown                           End Web Test

*** Test Cases ***
Valid Login
    [Documentation]                     Test login function with valid inputs, given valid user exist
    [Tags]                              LOGIN_01
    Input Text                          id:email  ${VALID_MAIL}
    Input Text                          id:password  ${VALID_PASSWORD}
    Click Button                        ${LOGIN_BUTTON}
    Element Should Contain              id:welcomePhrase    You are signed in as

Invalid Login, invalid mail w/ valid pass
    [Documentation]                     Test login funtion with invalid email
    [Tags]                              LOGIN_02
    Input Text                          id:email  ${INVALID_MAIL}
    Input Text                          id:password  ${VALID_PASSWORD}
    Click Button                        ${LOGIN_BUTTON}
    Element Should Contain              id:signInError      Wrong e-mail or password

Invalid Login, valid mail w/ invalid pass
    [Documentation]                     Test login funtion with invalid password,with Gherkin syntax
    [Tags]                              LOGIN_03
    Given that the user is on the right page
    And inputs a valid mail and an invalid password
    When the user clicks the login button
    Then user should not be logged in

Invalid Login, invalid inputs
    [Documentation]                     Test login funtion with invalid inputs
    [Tags]                              LOGIN_04
    Input Text                          id:email  ${INVALID_MAIL}
    Input Text                          id:password  ${INVALID_PASSWORD}
    Click Button                        ${LOGIN_BUTTON}
    Element Should Contain              id:signInError      Wrong e-mail or password

Valid Login, from car selection page
    [Documentation]                     Test login function with valid inputs, given valid user exist
    [Tags]                              LOGIN_05
    Click Continue
    Input Text                          id:email  ${VALID_MAIL}
    Input Text                          id:password  ${VALID_PASSWORD}
    Click Button                        ${LOGIN_BUTTON}
    Element Should Contain              id:welcomePhrase    You are signed in as

Book a car, logged in
    [Documentation]                     Book a car with logged in existing user
    [Tags]                              BOOK_01
    Log in
    ${start_date}                       Get Time     month day  NOW
    ${end_date}                         Get Time     month day  NOW + 9 days
    Input Text                          ${BOOK_START}    ${start_date}
    Input Text                          ${BOOK_END}      ${end_date}
    Click Continue
    Click Button                        ${BOOK_TESLA_R}
    Input Text                          id:cardNum  ${CARD_NUMBER}
    Input Text                          id:fullName    Bob Doe
    Click Element                       xpath://*[@id="confirmSelection"]/form/select[1]
    Click Element                       id:month6
    Click Element                       xpath://*[@id="confirmSelection"]/form/select[2]
    Click Element                       id:month2023
    Input Text                          id:cvc          123
    Click Button                        id:confirm
    Page should contain                 A Tesla Roadster is now ready for pickup
    Clean-up

Book a car, not logged in
    [Documentation]                     Try to book a car without being logged in
    [Tags]                              BOOK_02
    Click Continue
    Wait Until Page Contains Element    ${BOOK_TESLA_R}
    Click Button                        ${BOOK_TESLA_R}
    Alert Should Be Present             text=You need to be logged in to continue.

Book a car, old start date
    [Documentation]                     To make sure we cant book a car from a date thats already been
    [Tags]                              BOOK_03
    ${datepick}                         Get Time     month day  NOW - 1 day
    Input Text                          ${BOOK_START}      ${datepick}
    Click Continue
    Page Should Contain                 When do you want to make your trip?

Book a car, invalid due date
    [Documentation]                     To make sure we cant book a car for too long, 1 month from start date
    [Tags]                              BOOK_04
    Set Selenium Speed                  1
    ${datepick}                         Get Time     month day  NOW + 32 days
    Input Text                          ${BOOK_END}      ${datepick}
    Click Continue
    Page Should Contain                 When do you want to make your trip?

Gherkin, date match
    [Documentation]                     Correct date for pickup and dropoff,car is Opel Vivaro, startdate is current, end is 6 days
    [Tags]                              VG_test_01
    Given that user is logged in and book car with set parameters
    When the user gets to his/hers bookings ('My Page')
    Then model and dates should be equal to input


