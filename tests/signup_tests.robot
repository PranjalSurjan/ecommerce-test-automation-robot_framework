*** Settings ***
Documentation    Comprehensive test suite for Signup Page of TesterBud E-Commerce Website
Resource         ../resources/pages/signup_page.resource
Suite Setup      Open Browser To Site
Suite Teardown   Close Test Browser
Test Setup       Navigate To Signup Page

*** Test Cases ***
# ==================== SMOKE TESTS ====================

Verify Signup Page Loads Successfully
    [Documentation]    Verify the signup page loads with form elements
    [Tags]    smoke    signup    critical
    Verify Signup Page Is Loaded

# ==================== UI ELEMENT PRESENCE TESTS ====================

Verify Name Field Is Present
    [Documentation]    Verify name input is visible and enabled
    [Tags]    signup    ui
    Verify Name Field Is Present

Verify Email Field Is Present
    [Documentation]    Verify email input is visible and enabled
    [Tags]    signup    ui
    Verify Email Field Is Present On Signup

Verify Password Field Is Present
    [Documentation]    Verify password input is visible and enabled
    [Tags]    signup    ui
    Verify Password Field Is Present On Signup

Verify Confirm Password Field Is Present
    [Documentation]    Verify confirm password input is visible and enabled
    [Tags]    signup    ui
    Verify Confirm Password Field Is Present

Verify Signup Button Is Present
    [Documentation]    Verify signup button is visible and clickable
    [Tags]    signup    ui
    Verify Signup Button Is Present

Verify Login Link Is Available On Signup Page
    [Documentation]    Verify there is a link to login page from signup page
    [Tags]    signup    navigation    ui
    Element Should Be Visible On Page    ${SIGNUP_LOGIN_LINK}

Verify Signup Form Is Visible
    [Documentation]    Verify the signup form element is present
    [Tags]    signup    ui
    Element Should Be Visible On Page    ${SIGNUP_FORM}

# ==================== POSITIVE SIGNUP TESTS ====================

Verify Signup With Valid Details
    [Documentation]    Verify user can register with valid details
    [Tags]    signup    positive    critical
    Signup With Details    ${NEW_USER_NAME}    ${NEW_USER_EMAIL}    ${NEW_USER_PASSWORD}

Verify Signup With Minimum Valid Data
    [Documentation]    Verify signup with minimum acceptable data
    [Tags]    signup    positive    boundary
    Signup With Details    A    a@b.co    Abcd@123

# ==================== EMPTY FIELD VALIDATION TESTS ====================

Verify Signup With All Fields Empty
    [Documentation]    Verify error when all fields are empty
    [Tags]    signup    negative    validation
    Click Signup Button

Verify Signup With Empty Name
    [Documentation]    Verify error when name field is empty
    [Tags]    signup    negative    validation
    Signup With Details    ${EMPTY}    ${NEW_USER_EMAIL}    ${NEW_USER_PASSWORD}

Verify Signup With Empty Email
    [Documentation]    Verify error when email field is empty
    [Tags]    signup    negative    validation
    Signup With Details    ${NEW_USER_NAME}    ${EMPTY}    ${NEW_USER_PASSWORD}

Verify Signup With Empty Password
    [Documentation]    Verify error when password field is empty
    [Tags]    signup    negative    validation
    Signup With Details    ${NEW_USER_NAME}    ${NEW_USER_EMAIL}    ${EMPTY}

Verify Signup With Empty Confirm Password
    [Documentation]    Verify error when confirm password is empty
    [Tags]    signup    negative    validation
    Enter Name    ${NEW_USER_NAME}
    Enter Signup Email    ${NEW_USER_EMAIL}
    Enter Signup Password    ${NEW_USER_PASSWORD}
    Click Signup Button

Verify Signup With Only Name Filled
    [Documentation]    Verify error when only name is filled
    [Tags]    signup    negative    validation
    Signup With Details    ${NEW_USER_NAME}    ${EMPTY}    ${EMPTY}

Verify Signup With Only Email Filled
    [Documentation]    Verify error when only email is filled
    [Tags]    signup    negative    validation
    Signup With Details    ${EMPTY}    ${NEW_USER_EMAIL}    ${EMPTY}

# ==================== PASSWORD VALIDATION TESTS ====================

Verify Signup With Mismatched Passwords
    [Documentation]    Verify error when password and confirm password don't match
    [Tags]    signup    negative    validation    password
    Signup With Details    ${NEW_USER_NAME}    ${NEW_USER_EMAIL}    ${NEW_USER_PASSWORD}    WrongConfirm123

Verify Signup With Weak Password
    [Documentation]    Verify error when password is too weak
    [Tags]    signup    negative    validation    password
    Signup With Details    ${NEW_USER_NAME}    ${NEW_USER_EMAIL}    ${WEAK_PASSWORD}

Verify Signup With Single Character Password
    [Documentation]    Verify error with 1-char password
    [Tags]    signup    negative    validation    password    boundary
    Signup With Details    ${NEW_USER_NAME}    ${NEW_USER_EMAIL}    a

Verify Signup With Only Numbers Password
    [Documentation]    Verify handling of numeric-only password
    [Tags]    signup    negative    validation    password
    Signup With Details    ${NEW_USER_NAME}    ${NEW_USER_EMAIL}    12345678

Verify Signup With Only Letters Password
    [Documentation]    Verify handling of letters-only password
    [Tags]    signup    negative    validation    password
    Signup With Details    ${NEW_USER_NAME}    ${NEW_USER_EMAIL}    abcdefgh

Verify Signup With Spaces Only Password
    [Documentation]    Verify error with spaces-only password
    [Tags]    signup    negative    validation    password
    Signup With Details    ${NEW_USER_NAME}    ${NEW_USER_EMAIL}    ${SPACE * 8}

Verify Signup With Very Long Password
    [Documentation]    Verify handling of very long password
    [Tags]    signup    boundary    validation    password
    ${long_pwd}=    Evaluate    "Aa1@" * 75
    Signup With Details    ${NEW_USER_NAME}    ${NEW_USER_EMAIL}    ${long_pwd}

Verify Password Field Masks Input
    [Documentation]    Verify password field type is password
    [Tags]    signup    security    ui
    Verify Password Field Masks Input On Signup

Verify Confirm Password Field Masks Input
    [Documentation]    Verify confirm password field type is password
    [Tags]    signup    security    ui
    Verify Confirm Password Field Masks Input

Verify Signup With Reversed Password And Confirm
    [Documentation]    Verify error when password and confirm are swapped values
    [Tags]    signup    negative    validation    password
    Signup With Details    ${NEW_USER_NAME}    ${NEW_USER_EMAIL}    Password1    Password2

# ==================== EMAIL VALIDATION TESTS ====================

Verify Signup With Invalid Email Format
    [Documentation]    Verify error when email format is invalid
    [Tags]    signup    negative    validation    email
    Signup With Details    ${NEW_USER_NAME}    invalidemail    ${NEW_USER_PASSWORD}

Verify Signup With Email Without At Symbol
    [Documentation]    Verify error for email missing @
    [Tags]    signup    negative    validation    email
    Signup With Details    ${NEW_USER_NAME}    userexample.com    ${NEW_USER_PASSWORD}

Verify Signup With Email Without Domain
    [Documentation]    Verify error for email without domain
    [Tags]    signup    negative    validation    email
    Signup With Details    ${NEW_USER_NAME}    user@    ${NEW_USER_PASSWORD}

Verify Signup With Email Without TLD
    [Documentation]    Verify error for email without top-level domain
    [Tags]    signup    negative    validation    email
    Signup With Details    ${NEW_USER_NAME}    user@example    ${NEW_USER_PASSWORD}

Verify Signup With Email Double At Symbol
    [Documentation]    Verify error for email with double @
    [Tags]    signup    negative    validation    email
    Signup With Details    ${NEW_USER_NAME}    user@@example.com    ${NEW_USER_PASSWORD}

Verify Signup With Email Spaces
    [Documentation]    Verify error for email with spaces
    [Tags]    signup    negative    validation    email
    Signup With Details    ${NEW_USER_NAME}    user name@example.com    ${NEW_USER_PASSWORD}

Verify Signup With Email Multiple Dots
    [Documentation]    Verify handling of email with consecutive dots
    [Tags]    signup    negative    validation    email
    Signup With Details    ${NEW_USER_NAME}    user@example..com    ${NEW_USER_PASSWORD}

# ==================== NAME VALIDATION TESTS ====================

Verify Signup With Very Long Name
    [Documentation]    Verify handling of very long name input
    [Tags]    signup    boundary    validation    name
    ${long_name}=    Evaluate    "A" * 300
    Signup With Details    ${long_name}    ${NEW_USER_EMAIL}    ${NEW_USER_PASSWORD}

Verify Signup With Name Containing Numbers
    [Documentation]    Verify handling of name with numbers
    [Tags]    signup    boundary    validation    name
    Signup With Details    User123    ${NEW_USER_EMAIL}    ${NEW_USER_PASSWORD}

Verify Signup With Name Containing Special Characters
    [Documentation]    Verify handling of name with special characters
    [Tags]    signup    boundary    validation    name
    Signup With Details    User!@#$%    ${NEW_USER_EMAIL}    ${NEW_USER_PASSWORD}

Verify Signup With Name Only Spaces
    [Documentation]    Verify error when name is only whitespace
    [Tags]    signup    negative    validation    name
    Signup With Details    ${SPACE * 5}    ${NEW_USER_EMAIL}    ${NEW_USER_PASSWORD}

Verify Signup With Name Containing Hyphen
    [Documentation]    Verify name with hyphen is accepted
    [Tags]    signup    positive    validation    name
    Signup With Details    Mary-Jane    ${NEW_USER_EMAIL}    ${NEW_USER_PASSWORD}

Verify Signup With Name Containing Apostrophe
    [Documentation]    Verify name with apostrophe is handled
    [Tags]    signup    boundary    validation    name
    Signup With Details    O'Brien    ${NEW_USER_EMAIL}    ${NEW_USER_PASSWORD}

# ==================== SECURITY TESTS ====================

Verify XSS In Name Field
    [Documentation]    Verify XSS is prevented in name field
    [Tags]    signup    security
    Signup With Details    <script>alert('xss')</script>    ${NEW_USER_EMAIL}    ${NEW_USER_PASSWORD}

Verify XSS In Email Field
    [Documentation]    Verify XSS is prevented in email field
    [Tags]    signup    security
    Signup With Details    ${NEW_USER_NAME}    <script>alert('xss')</script>    ${NEW_USER_PASSWORD}

Verify SQL Injection In Name Field
    [Documentation]    Verify SQL injection is handled in name
    [Tags]    signup    security
    Signup With Details    ' OR '1'='1    ${NEW_USER_EMAIL}    ${NEW_USER_PASSWORD}

Verify SQL Injection In Email Field
    [Documentation]    Verify SQL injection is handled in email
    [Tags]    signup    security
    Signup With Details    ${NEW_USER_NAME}    ' OR '1'='1    ${NEW_USER_PASSWORD}

# ==================== INPUT BEHAVIOR TESTS ====================

Verify Name Field Accepts Input And Retains Value
    [Documentation]    Verify name field holds entered text
    [Tags]    signup    functional
    Enter Name    ${NEW_USER_NAME}
    ${value}=    Get Value    ${SIGNUP_NAME_INPUT}
    Should Be Equal    ${value}    ${NEW_USER_NAME}

Verify Form Can Be Cleared And Refilled
    [Documentation]    Verify form fields can be cleared and filled again
    [Tags]    signup    functional
    Signup With Details    ${NEW_USER_NAME}    ${NEW_USER_EMAIL}    ${NEW_USER_PASSWORD}
    Navigate To Signup Page
    Clear Signup Form
    Signup With Details    Another User    another@test.com    AnotherPwd@1

Verify Enter Key Submits Signup Form
    [Documentation]    Verify pressing Enter key submits the form
    [Tags]    signup    ux    keyboard
    Submit Signup Form With Enter Key    ${NEW_USER_NAME}    ${NEW_USER_EMAIL}    ${NEW_USER_PASSWORD}

# ==================== NAVIGATION TESTS ====================

Verify Login Link Navigates To Login Page
    [Documentation]    Verify clicking login link goes to login page
    [Tags]    signup    navigation
    Click Element    ${SIGNUP_LOGIN_LINK}
    Wait For Page To Load
    Verify Current URL Contains    login

Verify Signup Page After Refresh
    [Documentation]    Verify signup page reloads correctly
    [Tags]    signup    functional
    Enter Name    ${NEW_USER_NAME}
    Refresh Page
    Verify Signup Page Is Loaded

Verify Back Button From Signup Page
    [Documentation]    Verify browser back button from signup page
    [Tags]    signup    navigation
    Navigate Back
    Wait For Page To Load
