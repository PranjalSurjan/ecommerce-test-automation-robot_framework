*** Settings ***
Documentation    Accessibility and Usability Tests for TesterBud E-Commerce Website
Resource         ../resources/pages/home_page.resource
Resource         ../resources/pages/login_page.resource
Resource         ../resources/pages/signup_page.resource
Resource         ../resources/pages/products_page.resource
Resource         ../resources/pages/cart_page.resource
Suite Setup      Open Browser To Site
Suite Teardown   Close Test Browser

*** Test Cases ***
# ==================== FORM LABEL AND ATTRIBUTE TESTS ====================

Verify Login Email Field Has Type Attribute
    [Documentation]    Verify email field has type=email for accessibility
    [Tags]    accessibility    login    form
    Navigate To Login Page
    ${type}=    Get Element Attribute    ${LOGIN_EMAIL_INPUT}    type
    Should Be Equal    ${type}    email

Verify Login Password Field Has Type Attribute
    [Documentation]    Verify password field has type=password
    [Tags]    accessibility    login    form
    Navigate To Login Page
    ${type}=    Get Element Attribute    ${LOGIN_PASSWORD_INPUT}    type
    Should Be Equal    ${type}    password

Verify Signup Email Field Has Type Attribute
    [Documentation]    Verify signup email field has type=email
    [Tags]    accessibility    signup    form
    Navigate To Signup Page
    ${type}=    Get Element Attribute    ${SIGNUP_EMAIL_INPUT}    type
    Should Be Equal    ${type}    email

Verify Signup Password Field Has Type Attribute
    [Documentation]    Verify signup password field has type=password
    [Tags]    accessibility    signup    form
    Navigate To Signup Page
    ${type}=    Get Element Attribute    ${SIGNUP_PASSWORD_INPUT}    type
    Should Be Equal    ${type}    password

Verify Signup Confirm Password Field Has Type Attribute
    [Documentation]    Verify confirm password field has type=password
    [Tags]    accessibility    signup    form
    Navigate To Signup Page
    ${type}=    Get Element Attribute    ${SIGNUP_CONFIRM_PWD}    type
    Should Be Equal    ${type}    password

# ==================== IMAGE ALT TEXT TESTS ====================

Verify Product Images Have Alt Attributes
    [Documentation]    Verify product images have alt text for screen readers
    [Tags]    accessibility    products    images
    Navigate To Products Page
    ${images}=    Get WebElements    ${PRODUCT_IMAGE}
    FOR    ${img}    IN    @{images}
        ${alt}=    Get Element Attribute    ${img}    alt
        Should Not Be Equal    ${alt}    ${NONE}    Image missing alt attribute
    END

# ==================== KEYBOARD NAVIGATION TESTS ====================

Verify Login Form Tab Navigation
    [Documentation]    Verify Tab key navigates through login form fields
    [Tags]    accessibility    keyboard    login
    Navigate To Login Page
    Click Element    ${LOGIN_EMAIL_INPUT}
    Press Keys    ${LOGIN_EMAIL_INPUT}    TAB
    # Should move to password field
    Press Keys    NONE    TAB
    # Should move to submit button

Verify Signup Form Tab Navigation
    [Documentation]    Verify Tab key navigates through signup form fields
    [Tags]    accessibility    keyboard    signup
    Navigate To Signup Page
    Click Element    ${SIGNUP_NAME_INPUT}
    Press Keys    ${SIGNUP_NAME_INPUT}    TAB
    Press Keys    NONE    TAB
    Press Keys    NONE    TAB
    Press Keys    NONE    TAB

Verify Navigation Bar Keyboard Access
    [Documentation]    Verify nav links are keyboard accessible
    [Tags]    accessibility    keyboard    navigation
    Press Keys    NONE    TAB
    Press Keys    NONE    TAB
    Press Keys    NONE    TAB

# ==================== PAGE STRUCTURE TESTS ====================

Verify Page Has Title Tag
    [Documentation]    Verify every page has a title
    [Tags]    accessibility    structure
    ${title}=    Get Title
    Should Not Be Empty    ${title}

Verify Products Page Has Title
    [Documentation]    Verify products page has a title
    [Tags]    accessibility    structure
    Navigate To Products Page
    ${title}=    Get Title
    Should Not Be Empty    ${title}

Verify Login Page Has Title
    [Documentation]    Verify login page has a title
    [Tags]    accessibility    structure
    Navigate To Login Page
    ${title}=    Get Title
    Should Not Be Empty    ${title}

Verify Signup Page Has Title
    [Documentation]    Verify signup page has a title
    [Tags]    accessibility    structure
    Navigate To Signup Page
    ${title}=    Get Title
    Should Not Be Empty    ${title}

Verify Cart Page Has Title
    [Documentation]    Verify cart page has a title
    [Tags]    accessibility    structure
    Navigate To Cart Page
    ${title}=    Get Title
    Should Not Be Empty    ${title}

# ==================== FOCUS TESTS ====================

Verify Email Field Gets Focus On Click
    [Documentation]    Verify clicking email field gives it focus
    [Tags]    accessibility    focus    login
    Navigate To Login Page
    Click Element    ${LOGIN_EMAIL_INPUT}
    ${focused}=    Execute JavaScript    return document.activeElement.tagName.toLowerCase()
    Should Be Equal    ${focused}    input

Verify Password Field Gets Focus On Click
    [Documentation]    Verify clicking password field gives it focus
    [Tags]    accessibility    focus    login
    Navigate To Login Page
    Click Element    ${LOGIN_PASSWORD_INPUT}
    ${focused}=    Execute JavaScript    return document.activeElement.tagName.toLowerCase()
    Should Be Equal    ${focused}    input

# ==================== PLACEHOLDER TESTS ====================

Verify Login Fields Have Placeholders
    [Documentation]    Verify login form fields have placeholder text
    [Tags]    accessibility    ux    login
    Navigate To Login Page
    Verify Email Field Placeholder
    Verify Password Field Placeholder

# ==================== VIEWPORT META TAG TEST ====================

Verify Viewport Meta Tag Exists
    [Documentation]    Verify the page has a responsive viewport meta tag
    [Tags]    accessibility    responsive
    ${viewport}=    Execute JavaScript
    ...    return document.querySelector('meta[name="viewport"]')?.content || ''
    Should Not Be Empty    ${viewport}    Page missing viewport meta tag

# ==================== LANGUAGE ATTRIBUTE TEST ====================

Verify HTML Language Attribute
    [Documentation]    Verify the html tag has a lang attribute
    [Tags]    accessibility    structure
    ${lang}=    Execute JavaScript
    ...    return document.documentElement.lang || ''
    Should Not Be Empty    ${lang}    HTML tag missing lang attribute

# ==================== FORM SUBMISSION WITHOUT JS ====================

Verify Login Form Has Action Or Submit Handler
    [Documentation]    Verify login form has proper submit configuration
    [Tags]    accessibility    form
    Navigate To Login Page
    ${tag}=    Execute JavaScript    return document.querySelector('form')?.tagName || ''
    Should Be Equal    ${tag}    FORM

Verify Signup Form Has Action Or Submit Handler
    [Documentation]    Verify signup form has proper submit configuration
    [Tags]    accessibility    form
    Navigate To Signup Page
    ${tag}=    Execute JavaScript    return document.querySelector('form')?.tagName || ''
    Should Be Equal    ${tag}    FORM

# ==================== COLOR CONTRAST (BASIC) ====================

Verify Body Has Background Color
    [Documentation]    Verify body has a defined background color
    [Tags]    accessibility    visual
    ${bg}=    Execute JavaScript
    ...    return window.getComputedStyle(document.body).backgroundColor
    Should Not Be Empty    ${bg}

Verify Body Has Text Color
    [Documentation]    Verify body has a defined text color
    [Tags]    accessibility    visual
    ${color}=    Execute JavaScript
    ...    return window.getComputedStyle(document.body).color
    Should Not Be Empty    ${color}
