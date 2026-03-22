*** Settings ***
Documentation    Comprehensive test suite for Login Page of TesterBud E-Commerce Website
Resource         ../resources/pages/login_page.resource
Suite Setup      Open Browser To Site
Suite Teardown   Close Test Browser
Test Setup       Navigate To Login Page

*** Test Cases ***
# ==================== SMOKE TESTS ====================

Verify Login Page Loads Successfully
    [Documentation]    Verify the login page loads with form elements
    [Tags]    smoke    login    critical
    Verify Login Page Is Loaded

# ==================== UI ELEMENT PRESENCE TESTS ====================

Verify Email Field Is Visible And Enabled
    [Documentation]    Verify email input field is present and interactive
    [Tags]    login    ui
    Verify Email Field Is Present

Verify Password Field Is Visible And Enabled
    [Documentation]    Verify password input field is present and interactive
    [Tags]    login    ui
    Verify Password Field Is Present

Verify Login Button Is Visible And Enabled
    [Documentation]    Verify login button is present and clickable
    [Tags]    login    ui
    Verify Login Button Is Present

Verify Email Field Has Placeholder Text
    [Documentation]    Verify email field displays placeholder text
    [Tags]    login    ui    ux
    Verify Email Field Placeholder

Verify Password Field Has Placeholder Text
    [Documentation]    Verify password field displays placeholder text
    [Tags]    login    ui    ux
    Verify Password Field Placeholder

Verify Signup Link Is Available On Login Page
    [Documentation]    Verify there is a link to signup page from login page
    [Tags]    login    navigation    ui
    Element Should Be Visible On Page    ${SIGNUP_REDIRECT_LINK}

Verify Forgot Password Link Is Present
    [Documentation]    Verify forgot password link is visible
    [Tags]    login    ui    navigation
    Verify Forgot Password Link Is Present

Verify Login Form Is Visible
    [Documentation]    Verify the login form element is present
    [Tags]    login    ui
    Element Should Be Visible On Page    ${LOGIN_FORM}

# ==================== POSITIVE LOGIN TESTS ====================

Verify Login With Valid Credentials
    [Documentation]    Verify user can login with valid email and password
    [Tags]    smoke    login    positive    critical
    Login With Credentials    ${VALID_EMAIL}    ${VALID_PASSWORD}
    Wait For Page To Load

# ==================== NEGATIVE LOGIN TESTS ====================

Verify Login With Invalid Email
    [Documentation]    Verify error is shown when logging in with invalid email
    [Tags]    login    negative
    Login With Credentials    ${INVALID_EMAIL}    ${VALID_PASSWORD}
    Verify Login Error Is Displayed

Verify Login With Invalid Password
    [Documentation]    Verify error is shown when logging in with wrong password
    [Tags]    login    negative
    Login With Credentials    ${VALID_EMAIL}    ${INVALID_PASSWORD}
    Verify Login Error Is Displayed

Verify Login With Both Invalid Credentials
    [Documentation]    Verify error when both email and password are wrong
    [Tags]    login    negative
    Login With Credentials    ${INVALID_EMAIL}    ${INVALID_PASSWORD}
    Verify Login Error Is Displayed

Verify Login With Empty Email
    [Documentation]    Verify error is shown when email field is empty
    [Tags]    login    negative    validation
    Login With Credentials    ${EMPTY_STRING}    ${VALID_PASSWORD}

Verify Login With Empty Password
    [Documentation]    Verify error is shown when password field is empty
    [Tags]    login    negative    validation
    Login With Credentials    ${VALID_EMAIL}    ${EMPTY_STRING}

Verify Login With Both Fields Empty
    [Documentation]    Verify error is shown when both fields are empty
    [Tags]    login    negative    validation
    Login With Credentials    ${EMPTY_STRING}    ${EMPTY_STRING}

# ==================== EMAIL VALIDATION TESTS ====================

Verify Login With Email Without At Symbol
    [Documentation]    Verify error for email without @ symbol
    [Tags]    login    negative    validation    email
    Login With Credentials    invalidemail.com    ${VALID_PASSWORD}

Verify Login With Email Without Domain
    [Documentation]    Verify error for email without domain
    [Tags]    login    negative    validation    email
    Login With Credentials    user@    ${VALID_PASSWORD}

Verify Login With Email Without Username
    [Documentation]    Verify error for email without username part
    [Tags]    login    negative    validation    email
    Login With Credentials    @example.com    ${VALID_PASSWORD}

Verify Login With Email With Spaces
    [Documentation]    Verify error for email containing spaces
    [Tags]    login    negative    validation    email
    Login With Credentials    user name@example.com    ${VALID_PASSWORD}

Verify Login With Email Double At Symbol
    [Documentation]    Verify error for email with double @
    [Tags]    login    negative    validation    email
    Login With Credentials    user@@example.com    ${VALID_PASSWORD}

Verify Login With Email Special Characters
    [Documentation]    Verify handling of special chars in email
    [Tags]    login    negative    validation    email
    Login With Credentials    user!#$@example.com    ${VALID_PASSWORD}

# ==================== PASSWORD FIELD TESTS ====================

Verify Password Field Masks Input
    [Documentation]    Verify the password field masks the entered text
    [Tags]    login    ui    security
    ${type}=    Get Element Attribute    ${LOGIN_PASSWORD_INPUT}    type
    Should Be Equal    ${type}    password

Verify Password With Only Spaces
    [Documentation]    Verify login with password containing only spaces
    [Tags]    login    negative    validation
    Login With Credentials    ${VALID_EMAIL}    ${SPACE * 5}

Verify Very Long Password
    [Documentation]    Verify login handles very long password input
    [Tags]    login    boundary    validation
    ${long_pwd}=    Evaluate    "a" * 300
    Login With Credentials    ${VALID_EMAIL}    ${long_pwd}

Verify Password With Special Characters
    [Documentation]    Verify login with password full of special chars
    [Tags]    login    boundary    validation
    Login With Credentials    ${VALID_EMAIL}    !@#$%^&*()_+-=[]{}|;:,.<>?

# ==================== INPUT FIELD BEHAVIOR TESTS ====================

Verify Email Field Accepts Input
    [Documentation]    Verify the email input field accepts text
    [Tags]    login    ui    functional
    Enter Email    test@example.com
    ${value}=    Get Value    ${LOGIN_EMAIL_INPUT}
    Should Be Equal    ${value}    test@example.com

Verify Password Field Accepts Input
    [Documentation]    Verify the password input field accepts text
    [Tags]    login    ui    functional
    Enter Password    testpassword
    ${value}=    Get Value    ${LOGIN_PASSWORD_INPUT}
    Should Not Be Empty    ${value}

Verify Email Field Can Be Cleared
    [Documentation]    Verify the email field can be cleared after input
    [Tags]    login    functional
    Enter Email    test@example.com
    Clear Element Text    ${LOGIN_EMAIL_INPUT}
    ${value}=    Get Value    ${LOGIN_EMAIL_INPUT}
    Should Be Empty    ${value}

Verify Password Field Can Be Cleared
    [Documentation]    Verify the password field can be cleared after input
    [Tags]    login    functional
    Enter Password    testpassword
    Clear Element Text    ${LOGIN_PASSWORD_INPUT}
    ${value}=    Get Value    ${LOGIN_PASSWORD_INPUT}
    Should Be Empty    ${value}

Verify Tab Key Moves Focus Between Fields
    [Documentation]    Verify Tab key navigates from email to password
    [Tags]    login    ux    keyboard
    Click Element    ${LOGIN_EMAIL_INPUT}
    Press Keys    ${LOGIN_EMAIL_INPUT}    TAB

Verify Enter Key Submits Login Form
    [Documentation]    Verify pressing Enter submits the login form
    [Tags]    login    ux    keyboard
    Submit Login Form With Enter Key    ${VALID_EMAIL}    ${VALID_PASSWORD}

# ==================== SECURITY TESTS ====================

Verify XSS In Email Field
    [Documentation]    Verify XSS attack is prevented in email field
    [Tags]    login    security
    Login With Credentials    <script>alert('xss')</script>    ${VALID_PASSWORD}

Verify XSS In Password Field
    [Documentation]    Verify XSS attack is prevented in password field
    [Tags]    login    security
    Login With Credentials    ${VALID_EMAIL}    <script>alert('xss')</script>

Verify SQL Injection In Email Field
    [Documentation]    Verify SQL injection is handled in email field
    [Tags]    login    security
    Login With Credentials    ' OR '1'='1    ${VALID_PASSWORD}

Verify SQL Injection In Password Field
    [Documentation]    Verify SQL injection is handled in password field
    [Tags]    login    security
    Login With Credentials    ${VALID_EMAIL}    ' OR '1'='1

# ==================== NAVIGATION TESTS ====================

Verify Signup Link Navigates To Signup Page
    [Documentation]    Verify clicking signup link navigates correctly
    [Tags]    login    navigation
    Click Signup Redirect Link
    Verify Current URL Contains    signup

Verify Forgot Password Link Works
    [Documentation]    Verify clicking forgot password navigates correctly
    [Tags]    login    navigation
    Click Forgot Password Link

Verify Login Page After Refresh
    [Documentation]    Verify login page state after browser refresh
    [Tags]    login    functional
    Enter Email    test@example.com
    Refresh Page
    Verify Login Page Is Loaded

Verify Back Button From Login Page
    [Documentation]    Verify browser back button from login page
    [Tags]    login    navigation
    Navigate Back
    Wait For Page To Load

# ==================== MULTIPLE ATTEMPT TESTS ====================

Verify Multiple Failed Login Attempts
    [Documentation]    Verify system handles multiple failed login attempts
    [Tags]    login    negative    security
    Login With Credentials    ${INVALID_EMAIL}    ${INVALID_PASSWORD}
    Navigate To Login Page
    Login With Credentials    ${INVALID_EMAIL}    ${INVALID_PASSWORD}
    Navigate To Login Page
    Login With Credentials    ${INVALID_EMAIL}    ${INVALID_PASSWORD}

Verify Login After Failed Attempt
    [Documentation]    Verify user can still login after a failed attempt
    [Tags]    login    functional
    Login With Credentials    ${INVALID_EMAIL}    ${INVALID_PASSWORD}
    Navigate To Login Page
    Login With Credentials    ${VALID_EMAIL}    ${VALID_PASSWORD}

# ==================== CASE SENSITIVITY TESTS ====================

Verify Login With Uppercase Email
    [Documentation]    Verify login with uppercase email
    [Tags]    login    boundary
    Login With Credentials    TESTUSER@EXAMPLE.COM    ${VALID_PASSWORD}

Verify Login With Mixed Case Email
    [Documentation]    Verify login with mixed case email
    [Tags]    login    boundary
    Login With Credentials    TestUser@Example.COM    ${VALID_PASSWORD}

# ==================== WHITESPACE TESTS ====================

Verify Login With Leading Spaces In Email
    [Documentation]    Verify login with leading spaces in email
    [Tags]    login    boundary    validation
    Login With Credentials    ${SPACE}${VALID_EMAIL}    ${VALID_PASSWORD}

Verify Login With Trailing Spaces In Email
    [Documentation]    Verify login with trailing spaces in email
    [Tags]    login    boundary    validation
    Login With Credentials    ${VALID_EMAIL}${SPACE}    ${VALID_PASSWORD}

Verify Login With Leading Spaces In Password
    [Documentation]    Verify login with leading spaces in password
    [Tags]    login    boundary    validation
    Login With Credentials    ${VALID_EMAIL}    ${SPACE}${VALID_PASSWORD}
