*** Settings ***
Resource    ../common/common.resource

*** Variables ***
${LOGIN_EMAIL_INPUT}        css:input[type="email"], css:input[name="email"], css:#email
${LOGIN_PASSWORD_INPUT}     css:input[type="password"], css:input[name="password"], css:#password
${LOGIN_SUBMIT_BTN}         css:button[type="submit"], css:.login-btn, css:input[type="submit"]
${LOGIN_ERROR_MSG}          css:.error-message, css:.alert-danger, css:.error, css:.invalid-feedback
${LOGIN_SUCCESS_MSG}        css:.success-message, css:.alert-success
${LOGIN_FORM}               css:form
${LOGIN_PAGE_HEADING}       css:h1, css:h2, css:.login-title
${FORGOT_PASSWORD_LINK}     css:a[href*="forgot"], css:.forgot-password
${SIGNUP_REDIRECT_LINK}     css:a[href*="signup"], css:a[href*="register"]

# Test Data
${VALID_EMAIL}              testuser@example.com
${VALID_PASSWORD}           Test@1234
${INVALID_EMAIL}            invalid@test.com
${INVALID_PASSWORD}         wrongpassword
${EMPTY_STRING}             ${EMPTY}

*** Keywords ***
Verify Login Page Is Loaded
    [Documentation]    Verifies login page elements are visible
    Wait Until Element Is Visible    ${LOGIN_FORM}    timeout=${TIMEOUT}

Enter Email
    [Arguments]    ${email}
    [Documentation]    Enters email in the email field
    Wait Until Element Is Visible    ${LOGIN_EMAIL_INPUT}    timeout=${TIMEOUT}
    Clear Element Text    ${LOGIN_EMAIL_INPUT}
    Input Text    ${LOGIN_EMAIL_INPUT}    ${email}

Enter Password
    [Arguments]    ${password}
    [Documentation]    Enters password in the password field
    Wait Until Element Is Visible    ${LOGIN_PASSWORD_INPUT}    timeout=${TIMEOUT}
    Clear Element Text    ${LOGIN_PASSWORD_INPUT}
    Input Text    ${LOGIN_PASSWORD_INPUT}    ${password}

Click Login Button
    [Documentation]    Clicks the login submit button
    Click Element    ${LOGIN_SUBMIT_BTN}
    Sleep    1s

Login With Credentials
    [Arguments]    ${email}    ${password}
    [Documentation]    Performs complete login flow
    Enter Email    ${email}
    Enter Password    ${password}
    Click Login Button

Verify Login Error Is Displayed
    [Documentation]    Checks that an error message is shown
    Wait Until Element Is Visible    ${LOGIN_ERROR_MSG}    timeout=${TIMEOUT}
    Element Should Be Visible    ${LOGIN_ERROR_MSG}

Verify Login Success
    [Documentation]    Checks that login was successful
    Wait Until Element Is Visible    ${LOGIN_SUCCESS_MSG}    timeout=${TIMEOUT}

Click Forgot Password Link
    [Documentation]    Clicks the forgot password link
    Click Element    ${FORGOT_PASSWORD_LINK}
    Wait For Page To Load

Click Signup Redirect Link
    [Documentation]    Clicks the signup/register link on login page
    Click Element    ${SIGNUP_REDIRECT_LINK}
    Wait For Page To Load

Verify Email Field Is Present
    [Documentation]    Verifies email input is visible and enabled
    Element Should Be Visible On Page    ${LOGIN_EMAIL_INPUT}
    Element Should Be Enabled    ${LOGIN_EMAIL_INPUT}

Verify Password Field Is Present
    [Documentation]    Verifies password input is visible and enabled
    Element Should Be Visible On Page    ${LOGIN_PASSWORD_INPUT}
    Element Should Be Enabled    ${LOGIN_PASSWORD_INPUT}

Verify Login Button Is Present
    [Documentation]    Verifies submit button is visible and enabled
    Element Should Be Visible On Page    ${LOGIN_SUBMIT_BTN}
    Element Should Be Enabled    ${LOGIN_SUBMIT_BTN}

Get Login Error Message Text
    [Documentation]    Returns the error message text
    Wait Until Element Is Visible    ${LOGIN_ERROR_MSG}    timeout=${TIMEOUT}
    ${text}=    Get Text    ${LOGIN_ERROR_MSG}
    RETURN    ${text}

Verify Email Field Placeholder
    [Documentation]    Checks the email field has placeholder text
    ${placeholder}=    Get Element Attribute    ${LOGIN_EMAIL_INPUT}    placeholder
    Should Not Be Empty    ${placeholder}

Verify Password Field Placeholder
    [Documentation]    Checks the password field has placeholder text
    ${placeholder}=    Get Element Attribute    ${LOGIN_PASSWORD_INPUT}    placeholder
    Should Not Be Empty    ${placeholder}

Clear Login Form
    [Documentation]    Clears both email and password fields
    Clear Element Text    ${LOGIN_EMAIL_INPUT}
    Clear Element Text    ${LOGIN_PASSWORD_INPUT}

Verify Login Button Is Clickable
    [Documentation]    Verifies login button is enabled
    Element Should Be Enabled    ${LOGIN_SUBMIT_BTN}

Submit Login Form With Enter Key
    [Arguments]    ${email}    ${password}
    [Documentation]    Submits form using Enter key instead of button
    Enter Email    ${email}
    Enter Password    ${password}
    Press Keys    ${LOGIN_PASSWORD_INPUT}    ENTER
    Sleep    1s

Verify Forgot Password Link Is Present
    [Documentation]    Verifies forgot password link exists
    Element Should Be Visible On Page    ${FORGOT_PASSWORD_LINK}
