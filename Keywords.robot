*** Variables ***
${BROWSER}                      chrome
${URL}                          http://rental3.infotiv.net/
${VALID_MAIL}                   fredrik.wallgren@iths.se
${INVALID_MAIL}                 password123
${VALID_PASSWORD}               123456
${INVALID_PASSWORD}             9999999999
${LOGIN_BUTTON}                 id:login
${CARD_NUMBER}                  1234567890123456
${BOOK_TESLA_R}                 id:bookRoadsterpass2
${BOOK_START}                   id:start
${BOOK_END}                     id:end
${START_RESULT}
${END_RESULT}


*** Keywords ***
Begin Web Test
    Open Browser                                ${URL}  ${BROWSER}
    Maximize Browser Window
    Verify page

Verify page
    page should contain     When do you want to make your trip?

End Web Test
    Close Browser

that the user is on the right page
    Page Should Contain Element         ${LOGIN_BUTTON}

inputs a valid mail and an invalid password
    Input Text                          id:email  ${VALID_MAIL}
    Input Text                          id:password  ${INVALID_PASSWORD}

When the user clicks the login button
    Click Button                        ${LOGIN_BUTTON}

user should not be logged in
    Element Should Contain              id:signInError      Wrong e-mail or password

Log in
    Input Text                          id:email  ${VALID_MAIL}
    Input Text                          id:password  ${VALID_PASSWORD}
    Click Button                        ${LOGIN_BUTTON}

Clean-up
    Click Button                        id:mypage
    Click Button                        id:unBook1
    Handle Alert                        accept
    Page Should Contain                 has been Returned

Click Continue
    Click Button                        id:continue

enter valid card details
    Input Text                          id:cardNum  ${CARD_NUMBER}
    Input Text                          id:fullName    Bob Doe
    Click Element                       xpath://*[@id="confirmSelection"]/form/select[1]
    Click Element                       id:month6
    Click Element                       xpath://*[@id="confirmSelection"]/form/select[2]
    Click Element                       id:month2023
    Input Text                          id:cvc          123

that user is logged in and book car with set parameters
    Verify page
    Log in
    Element Should Contain              id:welcomePhrase    You are signed in as
    ${start_date}                       Get Time     month day  NOW
    ${end_date}                         Get Time     month day  NOW + 6 days
    Input Text                          ${BOOK_START}    ${start_date}
    Input Text                          ${BOOK_END}      ${end_date}
    ${START_RESULT}                     Get Value        ${BOOK_START}
    ${END_RESULT}                       Get Value        ${BOOK_END}
    Click Continue
    Click Button                        id:bookVivaropass9
    enter valid card details
    Click Button                        id:confirm

the user gets to his/hers bookings ('My Page')
    Click Button                        id:mypage

model and dates should be equal to input
    Page Should Contain                 Opel  Vivaro
    Element Should Contain              id:startDate1   ${START_RESULT}
    Element Should Contain              id:endDate1     ${END_RESULT}
    #Then we clear the data
    Clean-up