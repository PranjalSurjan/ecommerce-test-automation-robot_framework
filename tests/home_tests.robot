*** Settings ***
Documentation    Comprehensive test suite for Home Page of TesterBud E-Commerce Website
Resource         ../resources/pages/home_page.resource
Suite Setup      Open Browser To Site
Suite Teardown   Close Test Browser
Test Setup       Navigate To Home Page

*** Test Cases ***
# ==================== SMOKE TESTS ====================

Verify Home Page Loads Successfully
    [Documentation]    Verify the home page loads without errors
    [Tags]    smoke    home    critical
    Verify Home Page Is Loaded

Verify Page Title Is Not Empty
    [Documentation]    Verify the browser tab title is set
    [Tags]    smoke    home
    ${title}=    Get Title
    Should Not Be Empty    ${title}

# ==================== NAVIGATION BAR TESTS ====================

Verify Navigation Bar Is Visible
    [Documentation]    Verify the navigation bar is displayed on home page
    [Tags]    home    navigation    ui
    Verify Navigation Bar Is Present

Verify Logo Is Displayed
    [Documentation]    Verify the brand logo/name is visible in navbar
    [Tags]    home    navigation    ui
    Verify Logo Is Visible

Verify Clicking Logo Navigates To Home
    [Documentation]    Verify clicking the logo redirects to home page
    [Tags]    home    navigation
    Navigate To Products Page
    Click Logo To Go Home
    Verify Home Page Is Loaded

Verify Home Navigation Link Is Present
    [Documentation]    Verify Home link exists in navbar
    [Tags]    home    navigation
    Element Should Be Visible On Page    ${NAV_HOME}

Verify Products Navigation Link Is Present
    [Documentation]    Verify Products link exists in navbar
    [Tags]    home    navigation
    Element Should Be Visible On Page    ${NAV_PRODUCTS}

Verify Cart Navigation Link Is Present
    [Documentation]    Verify Cart link exists in navbar
    [Tags]    home    navigation
    Element Should Be Visible On Page    ${NAV_CART}

Verify Login Navigation Link Is Present
    [Documentation]    Verify Login link exists in navbar
    [Tags]    home    navigation
    Element Should Be Visible On Page    ${NAV_LOGIN}

Verify Signup Navigation Link Is Present
    [Documentation]    Verify Signup link exists in navbar
    [Tags]    home    navigation
    Element Should Be Visible On Page    ${NAV_SIGNUP}

Verify Products Link Navigates Correctly
    [Documentation]    Verify clicking Products link goes to products page
    [Tags]    home    navigation
    Navigate To Products Page
    Verify Current URL Contains    product

Verify Cart Link Navigates Correctly
    [Documentation]    Verify clicking Cart link goes to cart page
    [Tags]    home    navigation
    Navigate To Cart Page
    Verify Current URL Contains    cart

Verify Login Link Navigates Correctly
    [Documentation]    Verify clicking Login link goes to login page
    [Tags]    home    navigation
    Navigate To Login Page
    Verify Current URL Contains    login

Verify Signup Link Navigates Correctly
    [Documentation]    Verify clicking Signup link goes to signup page
    [Tags]    home    navigation
    Navigate To Signup Page
    Verify Current URL Contains    signup

# ==================== FOOTER TESTS ====================

Verify Footer Section Is Visible
    [Documentation]    Verify the footer is displayed on the home page
    [Tags]    home    ui    footer
    Scroll To Element    ${HOME_FOOTER}
    Verify Footer Is Present

# ==================== PRODUCT DISPLAY TESTS ====================

Verify Products Are Displayed On Home Page
    [Documentation]    Verify that product cards are shown on the home page
    [Tags]    home    products
    Verify Products Are Displayed

Verify Product Card Count Is Greater Than Zero
    [Documentation]    Verify there is at least one product card
    [Tags]    home    products
    ${count}=    Get Number Of Product Cards
    Should Be True    ${count} > 0    Expected products but found ${count}

Verify All Product Cards Have Images
    [Documentation]    Verify every product card has an image element
    [Tags]    home    products    ui
    Verify All Product Cards Have Images

Verify Clicking On Product Navigates To Detail Page
    [Documentation]    Verify clicking a product card navigates to detail page
    [Tags]    home    products    navigation
    Click On First Product
    Title Should Not Be    ${EMPTY}

# ==================== SEARCH FUNCTIONALITY TESTS ====================

Verify Search Input Is Present On Home Page
    [Documentation]    Verify the search bar is visible
    [Tags]    home    search    ui
    Verify Search Input Is Present

Verify Search Functionality With Valid Term
    [Documentation]    Verify user can search for products from home page
    [Tags]    home    search    functional
    Search For Product    shirt
    Wait For Page To Load

Verify Search With Partial Product Name
    [Documentation]    Verify search works with partial product names
    [Tags]    home    search    functional
    Search For Product    sho
    Wait For Page To Load

Verify Search With Empty Query
    [Documentation]    Verify submitting empty search handles gracefully
    [Tags]    home    search    negative
    Verify Search With Empty Query

Verify Search With Special Characters
    [Documentation]    Verify search handles special characters safely
    [Tags]    home    search    negative    security
    Verify Search With Special Characters    !@#$%^&*()

Verify Search With XSS Attempt
    [Documentation]    Verify search is safe against XSS injection
    [Tags]    home    search    security
    Verify Search With Special Characters    <script>alert(1)</script>

Verify Search With SQL Injection Attempt
    [Documentation]    Verify search is safe against SQL injection
    [Tags]    home    search    security
    Verify Search With Special Characters    ' OR 1=1 --

Verify Search With Very Long String
    [Documentation]    Verify search handles long input strings
    [Tags]    home    search    boundary
    ${long_string}=    Evaluate    "a" * 500
    Verify Search With Special Characters    ${long_string}

Verify Search With Non-Existent Product
    [Documentation]    Verify appropriate response for no-result searches
    [Tags]    home    search    negative
    Verify Search With No Results Term    xyznonexistent99999

Verify Search With Numeric Input
    [Documentation]    Verify search works with numbers
    [Tags]    home    search    boundary
    Search For Product    12345
    Wait For Page To Load

Verify Search With Unicode Characters
    [Documentation]    Verify search handles unicode characters
    [Tags]    home    search    boundary
    Verify Search With Special Characters    \u00e9\u00e8\u00ea\u00f1

# ==================== CATEGORY TESTS ====================

Verify Category Links Are Present
    [Documentation]    Verify category links/filters exist on home page
    [Tags]    home    categories    ui
    Verify Category Links Are Present

# ==================== PAGE INTEGRITY TESTS ====================

Verify No Broken Images On Home Page
    [Documentation]    Verify all images on home page have loaded properly
    [Tags]    home    ui    integrity
    Verify No Broken Images On Page

Verify All Links Have Valid Href
    [Documentation]    Verify all anchor tags have href attributes
    [Tags]    home    ui    integrity
    Verify All Links Have Href

Verify Page Loads After Refresh
    [Documentation]    Verify home page loads correctly after browser refresh
    [Tags]    home    functional
    Refresh Page
    Verify Home Page Is Loaded

Verify Browser Back Button Works
    [Documentation]    Verify back button returns to home from another page
    [Tags]    home    navigation
    Navigate To Products Page
    Navigate Back
    Verify Home Page Is Loaded
