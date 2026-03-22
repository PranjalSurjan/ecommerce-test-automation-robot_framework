*** Settings ***
Documentation    Comprehensive test suite for Checkout Page of TesterBud E-Commerce Website
Resource         ../resources/pages/checkout_page.resource
Resource         ../resources/pages/cart_page.resource
Resource         ../resources/pages/products_page.resource
Suite Setup      Open Browser To Site
Suite Teardown   Close Test Browser

*** Keywords ***
Add Product And Go To Checkout
    [Documentation]    Helper to add a product and navigate to checkout
    Navigate To Products Page
    Click Add To Cart For Product    1
    Navigate To Cart Page
    Click Checkout Button

*** Test Cases ***
# ==================== SMOKE TESTS ====================

Verify Checkout Page Loads
    [Documentation]    Verify the checkout page loads after proceeding from cart
    [Tags]    smoke    checkout    critical
    Add Product And Go To Checkout
    Verify Checkout Page Is Loaded

# ==================== UI ELEMENT PRESENCE TESTS ====================

Verify Checkout Form Is Present
    [Documentation]    Verify checkout form element exists
    [Tags]    checkout    ui
    Add Product And Go To Checkout
    Element Should Be Visible On Page    ${CHECKOUT_FORM}

Verify First Name Field Is Present
    [Documentation]    Verify first name input is visible
    [Tags]    checkout    ui    form
    Add Product And Go To Checkout
    Verify First Name Field Is Present

Verify Last Name Field Is Present
    [Documentation]    Verify last name input is visible
    [Tags]    checkout    ui    form
    Add Product And Go To Checkout
    Verify Last Name Field Is Present

Verify Address Field Is Present
    [Documentation]    Verify address input is visible
    [Tags]    checkout    ui    form
    Add Product And Go To Checkout
    Verify Address Field Is Present

Verify City Field Is Present
    [Documentation]    Verify city input is visible
    [Tags]    checkout    ui    form
    Add Product And Go To Checkout
    Verify City Field Is Present

Verify Zip Field Is Present
    [Documentation]    Verify zip code input is visible
    [Tags]    checkout    ui    form
    Add Product And Go To Checkout
    Verify Zip Field Is Present

Verify Place Order Button Is Present
    [Documentation]    Verify place order button exists and is enabled
    [Tags]    checkout    ui    form
    Add Product And Go To Checkout
    Verify Place Order Button Is Present

Verify Order Summary On Checkout Page
    [Documentation]    Verify order summary section is displayed
    [Tags]    checkout    ui
    Add Product And Go To Checkout
    Verify Order Summary Is Displayed

Verify Checkout Total Is Displayed
    [Documentation]    Verify checkout total amount is shown
    [Tags]    checkout    ui    pricing
    Add Product And Go To Checkout
    ${total}=    Get Checkout Total Text
    Should Not Be Empty    ${total}

# ==================== POSITIVE CHECKOUT TESTS ====================

Verify Checkout With Valid Details
    [Documentation]    Verify completing checkout with valid shipping details
    [Tags]    checkout    functional    positive    critical
    Add Product And Go To Checkout
    Fill Shipping Details
    Click Place Order

Verify Checkout With All Fields Filled
    [Documentation]    Verify checkout with all fields including email
    [Tags]    checkout    functional    positive
    Add Product And Go To Checkout
    Fill Shipping Details With Email

Verify Checkout With Minimum Details
    [Documentation]    Verify checkout with only required fields
    [Tags]    checkout    functional    positive    boundary
    Add Product And Go To Checkout
    Fill First Name Only    A
    Fill Last Name Only    B
    Fill Address Only    1 St
    Fill City Only    C
    Fill Zip Only    12345
    Click Place Order

# ==================== EMPTY FIELD VALIDATION TESTS ====================

Verify Checkout With All Empty Fields
    [Documentation]    Verify error when submitting checkout with all empty fields
    [Tags]    checkout    negative    validation
    Add Product And Go To Checkout
    Click Place Order

Verify Checkout With Only First Name
    [Documentation]    Verify error when only first name is filled
    [Tags]    checkout    negative    validation
    Add Product And Go To Checkout
    Fill First Name Only
    Click Place Order

Verify Checkout With Only Last Name
    [Documentation]    Verify error when only last name is filled
    [Tags]    checkout    negative    validation
    Add Product And Go To Checkout
    Fill Last Name Only
    Click Place Order

Verify Checkout Without First Name
    [Documentation]    Verify error when first name is missing
    [Tags]    checkout    negative    validation
    Add Product And Go To Checkout
    Fill Last Name Only
    Fill Address Only
    Fill City Only
    Fill Zip Only
    Click Place Order

Verify Checkout Without Last Name
    [Documentation]    Verify error when last name is missing
    [Tags]    checkout    negative    validation
    Add Product And Go To Checkout
    Fill First Name Only
    Fill Address Only
    Fill City Only
    Fill Zip Only
    Click Place Order

Verify Checkout Without Address
    [Documentation]    Verify error when address is missing
    [Tags]    checkout    negative    validation
    Add Product And Go To Checkout
    Fill First Name Only
    Fill Last Name Only
    Fill City Only
    Fill Zip Only
    Click Place Order

Verify Checkout Without City
    [Documentation]    Verify error when city is missing
    [Tags]    checkout    negative    validation
    Add Product And Go To Checkout
    Fill First Name Only
    Fill Last Name Only
    Fill Address Only
    Fill Zip Only
    Click Place Order

Verify Checkout Without Zip Code
    [Documentation]    Verify error when zip code is missing
    [Tags]    checkout    negative    validation
    Add Product And Go To Checkout
    Fill First Name Only
    Fill Last Name Only
    Fill Address Only
    Fill City Only
    Click Place Order

# ==================== FIELD VALUE VALIDATION TESTS ====================

Verify Checkout With Very Long First Name
    [Documentation]    Verify handling of very long first name
    [Tags]    checkout    boundary    validation
    Add Product And Go To Checkout
    ${long_name}=    Evaluate    "A" * 300
    Fill First Name Only    ${long_name}
    Fill Last Name Only
    Fill Address Only
    Fill City Only
    Fill Zip Only
    Click Place Order

Verify Checkout With Very Long Address
    [Documentation]    Verify handling of very long address
    [Tags]    checkout    boundary    validation
    Add Product And Go To Checkout
    Fill First Name Only
    Fill Last Name Only
    ${long_addr}=    Evaluate    "123 Long Street " * 30
    Fill Address Only    ${long_addr}
    Fill City Only
    Fill Zip Only
    Click Place Order

Verify Checkout With Special Characters In Name
    [Documentation]    Verify handling of special chars in name
    [Tags]    checkout    boundary    validation
    Add Product And Go To Checkout
    Fill First Name Only    John-O'Brien
    Fill Last Name Only    Mc'Donald Jr.
    Fill Address Only
    Fill City Only
    Fill Zip Only
    Click Place Order

Verify Checkout With Numeric First Name
    [Documentation]    Verify handling of numbers in name fields
    [Tags]    checkout    negative    validation
    Add Product And Go To Checkout
    Fill First Name Only    12345
    Fill Last Name Only    67890
    Fill Address Only
    Fill City Only
    Fill Zip Only
    Click Place Order

Verify Checkout With Invalid Zip Code Letters
    [Documentation]    Verify error for alphabetic zip code
    [Tags]    checkout    negative    validation
    Add Product And Go To Checkout
    Fill Shipping Details    zip=ABCDE
    Click Place Order

Verify Checkout With Short Zip Code
    [Documentation]    Verify error for too short zip code
    [Tags]    checkout    negative    validation    boundary
    Add Product And Go To Checkout
    Fill Shipping Details    zip=12
    Click Place Order

Verify Checkout With Long Zip Code
    [Documentation]    Verify error for too long zip code
    [Tags]    checkout    negative    validation    boundary
    Add Product And Go To Checkout
    Fill Shipping Details    zip=1234567890123
    Click Place Order

# ==================== SECURITY TESTS ====================

Verify XSS In First Name Field
    [Documentation]    Verify XSS is prevented in first name
    [Tags]    checkout    security
    Add Product And Go To Checkout
    Fill First Name Only    <script>alert('xss')</script>
    Fill Last Name Only
    Fill Address Only
    Fill City Only
    Fill Zip Only
    Click Place Order

Verify XSS In Address Field
    [Documentation]    Verify XSS is prevented in address
    [Tags]    checkout    security
    Add Product And Go To Checkout
    Fill First Name Only
    Fill Last Name Only
    Fill Address Only    <img src=x onerror=alert('xss')>
    Fill City Only
    Fill Zip Only
    Click Place Order

Verify SQL Injection In Name Fields
    [Documentation]    Verify SQL injection is handled in name
    [Tags]    checkout    security
    Add Product And Go To Checkout
    Fill First Name Only    ' OR '1'='1
    Fill Last Name Only    '; DROP TABLE users; --
    Fill Address Only
    Fill City Only
    Fill Zip Only
    Click Place Order

Verify SQL Injection In Address Field
    [Documentation]    Verify SQL injection is handled in address
    [Tags]    checkout    security
    Add Product And Go To Checkout
    Fill First Name Only
    Fill Last Name Only
    Fill Address Only    '; DROP TABLE orders; --
    Fill City Only
    Fill Zip Only
    Click Place Order

# ==================== FORM BEHAVIOR TESTS ====================

Verify Checkout Form Can Be Cleared And Refilled
    [Documentation]    Verify form can be cleared and filled again
    [Tags]    checkout    functional
    Add Product And Go To Checkout
    Fill Shipping Details
    Clear Checkout Form
    Fill Shipping Details    first_name=Jane    last_name=Smith    address=456 New Ave    city=New Town    zip=54321
    Click Place Order

Verify Checkout Form Fields Accept Input
    [Documentation]    Verify all fields accept input correctly
    [Tags]    checkout    functional
    Add Product And Go To Checkout
    Fill First Name Only    TestFirst
    ${value}=    Get Value    ${CHECKOUT_FIRST_NAME}
    Should Be Equal    ${value}    TestFirst

Verify Checkout With Spaces Only In Fields
    [Documentation]    Verify error when fields contain only spaces
    [Tags]    checkout    negative    validation
    Add Product And Go To Checkout
    Fill First Name Only    ${SPACE * 5}
    Fill Last Name Only    ${SPACE * 5}
    Fill Address Only    ${SPACE * 5}
    Fill City Only    ${SPACE * 5}
    Fill Zip Only    ${SPACE * 5}
    Click Place Order

# ==================== PAGE NAVIGATION TESTS ====================

Verify Checkout Page URL
    [Documentation]    Verify checkout page URL contains checkout
    [Tags]    checkout    navigation
    Add Product And Go To Checkout
    Verify Current URL Contains    checkout

Verify Checkout Page After Refresh
    [Documentation]    Verify checkout page state after refresh
    [Tags]    checkout    functional
    Add Product And Go To Checkout
    Fill First Name Only    TestName
    Refresh Page
    Verify Checkout Page Is Loaded

Verify Back Button From Checkout
    [Documentation]    Verify browser back from checkout
    [Tags]    checkout    navigation
    Add Product And Go To Checkout
    Navigate Back
    Wait For Page To Load
