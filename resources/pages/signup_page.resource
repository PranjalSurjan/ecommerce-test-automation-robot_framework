*** Settings ***
Resource    ../common/common.resource

*** Variables ***
${SIGNUP_NAME_INPUT}        css:input[name="name"], css:#name, css:input[placeholder*="Name"]
${SIGNUP_EMAIL_INPUT}       css:input[type="email"], css:input[name="email"], css:#email
${SIGNUP_PASSWORD_INPUT}    css:input[type="password"], css:input[name="password"], css:#password
${SIGNUP_CONFIRM_PWD}       css:input[name="confirmPassword"], css:input[name="confirm_password"], css:#confirmPassword
${SIGNUP_SUBMIT_BTN}        css:button[type="submit"], css:.signup-btn, css:input[type="submit"]
${SIGNUP_ERROR_MSG}         css:.error-message, css:.alert-danger, css:.error, css:.invalid-feedback
${SIGNUP_SUCCESS_MSG}       css:.success-message, css:.alert-success
${SIGNUP_FORM}              css:form
${SIGNUP_LOGIN_LINK}        css:a[href*="login"]

# Test Data
${NEW_USER_NAME}            Test User
${NEW_USER_EMAIL}           newuser@example.com
${NEW_USER_PASSWORD}        NewUser@123
${WEAK_PASSWORD}            123

*** Keywords ***
Verify Signup Page Is Loaded
    [Documentation]    Verifies signup page elements are visible
    Wait Until Element Is Visible    ${SIGNUP_FORM}    timeout=${TIMEOUT}

Enter Name
    [Arguments]    ${name}
    [Documentation]    Enters name in the name field
    Wait Until Element Is Visible    ${SIGNUP_NAME_INPUT}    timeout=${TIMEOUT}
    Clear Element Text    ${SIGNUP_NAME_INPUT}
    Input Text    ${SIGNUP_NAME_INPUT}    ${name}

Enter Signup Email
    [Arguments]    ${email}
    [Documentation]    Enters email in the signup email field
    Wait Until Element Is Visible    ${SIGNUP_EMAIL_INPUT}    timeout=${TIMEOUT}
    Clear Element Text    ${SIGNUP_EMAIL_INPUT}
    Input Text    ${SIGNUP_EMAIL_INPUT}    ${email}

Enter Signup Password
    [Arguments]    ${password}
    [Documentation]    Enters password in the signup password field
    Wait Until Element Is Visible    ${SIGNUP_PASSWORD_INPUT}    timeout=${TIMEOUT}
    Clear Element Text    ${SIGNUP_PASSWORD_INPUT}
    Input Text    ${SIGNUP_PASSWORD_INPUT}    ${password}

Enter Confirm Password
    [Arguments]    ${password}
    [Documentation]    Enters password in the confirm password field
    Wait Until Element Is Visible    ${SIGNUP_CONFIRM_PWD}    timeout=${TIMEOUT}
    Clear Element Text    ${SIGNUP_CONFIRM_PWD}
    Input Text    ${SIGNUP_CONFIRM_PWD}    ${password}

Click Signup Button
    [Documentation]    Clicks the signup submit button
    Click Element    ${SIGNUP_SUBMIT_BTN}
    Sleep    1s

Signup With Details
    [Arguments]    ${name}    ${email}    ${password}    ${confirm_password}=${password}
    [Documentation]    Performs complete signup flow
    Enter Name    ${name}
    Enter Signup Email    ${email}
    Enter Signup Password    ${password}
    Enter Confirm Password    ${confirm_password}
    Click Signup Button

Verify Signup Error Is Displayed
    [Documentation]    Checks that an error message is shown
    Wait Until Element Is Visible    ${SIGNUP_ERROR_MSG}    timeout=${TIMEOUT}

Verify Signup Success
    [Documentation]    Checks that signup was successful
    Wait Until Element Is Visible    ${SIGNUP_SUCCESS_MSG}    timeout=${TIMEOUT}

Verify Name Field Is Present
    [Documentation]    Checks name input is visible and enabled
    Element Should Be Visible On Page    ${SIGNUP_NAME_INPUT}
    Element Should Be Enabled    ${SIGNUP_NAME_INPUT}

Verify Email Field Is Present On Signup
    [Documentation]    Checks email input is visible and enabled
    Element Should Be Visible On Page    ${SIGNUP_EMAIL_INPUT}
    Element Should Be Enabled    ${SIGNUP_EMAIL_INPUT}

Verify Password Field Is Present On Signup
    [Documentation]    Checks password input is visible and enabled
    Element Should Be Visible On Page    ${SIGNUP_PASSWORD_INPUT}
    Element Should Be Enabled    ${SIGNUP_PASSWORD_INPUT}

Verify Confirm Password Field Is Present
    [Documentation]    Checks confirm password input is visible and enabled
    Element Should Be Visible On Page    ${SIGNUP_CONFIRM_PWD}
    Element Should Be Enabled    ${SIGNUP_CONFIRM_PWD}

Verify Signup Button Is Present
    [Documentation]    Checks submit button is visible and enabled
    Element Should Be Visible On Page    ${SIGNUP_SUBMIT_BTN}
    Element Should Be Enabled    ${SIGNUP_SUBMIT_BTN}

Get Signup Error Message Text
    [Documentation]    Returns the error message text
    Wait Until Element Is Visible    ${SIGNUP_ERROR_MSG}    timeout=${TIMEOUT}
    ${text}=    Get Text    ${SIGNUP_ERROR_MSG}
    RETURN    ${text}

Clear Signup Form
    [Documentation]    Clears all signup form fields
    Clear Element Text    ${SIGNUP_NAME_INPUT}
    Clear Element Text    ${SIGNUP_EMAIL_INPUT}
    Clear Element Text    ${SIGNUP_PASSWORD_INPUT}
    Clear Element Text    ${SIGNUP_CONFIRM_PWD}

Verify Password Field Masks Input On Signup
    [Documentation]    Verifies password field type is password
    ${type}=    Get Element Attribute    ${SIGNUP_PASSWORD_INPUT}    type
    Should Be Equal    ${type}    password

Verify Confirm Password Field Masks Input
    [Documentation]    Verifies confirm password field type is password
    ${type}=    Get Element Attribute    ${SIGNUP_CONFIRM_PWD}    type
    Should Be Equal    ${type}    password

Submit Signup Form With Enter Key
    [Arguments]    ${name}    ${email}    ${password}    ${confirm_password}=${password}
    [Documentation]    Submits signup form using Enter key
    Enter Name    ${name}
    Enter Signup Email    ${email}
    Enter Signup Password    ${password}
    Enter Confirm Password    ${confirm_password}
    Press Keys    ${SIGNUP_CONFIRM_PWD}    ENTER
    Sleep    1s
