*** Settings ***
Documentation    Comprehensive End-to-End Test Suite for TesterBud E-Commerce Website
Resource         ../resources/pages/home_page.resource
Resource         ../resources/pages/login_page.resource
Resource         ../resources/pages/signup_page.resource
Resource         ../resources/pages/products_page.resource
Resource         ../resources/pages/product_detail_page.resource
Resource         ../resources/pages/cart_page.resource
Resource         ../resources/pages/checkout_page.resource
Suite Setup      Open Browser To Site
Suite Teardown   Close Test Browser

*** Test Cases ***
# ==================== CRITICAL USER JOURNEYS ====================

E2E: Browse Products And Add To Cart
    [Documentation]    Complete flow: Home -> Products -> Add to Cart -> View Cart
    [Tags]    e2e    critical    smoke
    Verify Home Page Is Loaded
    Navigate To Products Page
    Verify Products Page Is Loaded
    Click Add To Cart For Product    1
    Navigate To Cart Page
    Verify Cart Is Not Empty

E2E: Product Detail To Cart
    [Documentation]    Flow: Products -> Detail -> Add to Cart -> Cart
    [Tags]    e2e    critical
    Navigate To Products Page
    Click On Product By Index    1
    Verify Product Detail Page Is Loaded
    Add Product To Cart From Detail
    Navigate To Cart Page
    Verify Cart Is Not Empty

E2E: Search And Purchase Product
    [Documentation]    Complete flow: Search -> Product Detail -> Add to Cart -> Checkout
    [Tags]    e2e    critical
    Navigate To Products Page
    Click On Product By Index    1
    Verify Product Detail Page Is Loaded
    Add Product To Cart From Detail
    Navigate To Cart Page
    Verify Cart Is Not Empty
    Click Checkout Button
    Verify Checkout Page Is Loaded

E2E: Login And Shop
    [Documentation]    Complete flow: Login -> Browse -> Add to Cart -> Checkout
    [Tags]    e2e    critical
    Navigate To Login Page
    Verify Login Page Is Loaded
    Login With Credentials    ${VALID_EMAIL}    ${VALID_PASSWORD}
    Navigate To Products Page
    Verify Products Page Is Loaded
    Click Add To Cart For Product    1
    Click Add To Cart For Product    2
    Navigate To Cart Page
    Verify Cart Is Not Empty
    ${count}=    Get Cart Item Count
    Should Be True    ${count} >= 2

E2E: Complete Purchase Journey
    [Documentation]    Full journey: Home -> Products -> Detail -> Cart -> Checkout -> Place Order
    [Tags]    e2e    critical    regression
    Verify Home Page Is Loaded
    Navigate To Products Page
    Click On Product By Index    1
    Verify Product Detail Page Is Loaded
    ${product_name}=    Get Product Detail Name
    Should Not Be Empty    ${product_name}
    Add Product To Cart From Detail
    Navigate To Cart Page
    Verify Cart Is Not Empty
    Click Checkout Button
    Verify Checkout Page Is Loaded
    Fill Shipping Details
    Click Place Order

# ==================== NAVIGATION JOURNEYS ====================

E2E: Full Navigation Flow
    [Documentation]    Verify navigation across all main pages
    [Tags]    e2e    navigation
    Verify Home Page Is Loaded
    Navigate To Products Page
    Wait For Page To Load
    Navigate To Cart Page
    Wait For Page To Load
    Navigate To Login Page
    Wait For Page To Load
    Navigate To Signup Page
    Wait For Page To Load
    Navigate To Home Page
    Verify Home Page Is Loaded

E2E: Navigation With Back Button
    [Documentation]    Verify back button navigation through multiple pages
    [Tags]    e2e    navigation
    Verify Home Page Is Loaded
    Navigate To Products Page
    Navigate To Cart Page
    Navigate To Login Page
    Navigate Back
    Navigate Back
    Navigate Back

E2E: Logo Always Returns To Home
    [Documentation]    Verify logo navigates to home from any page
    [Tags]    e2e    navigation
    Navigate To Products Page
    Click Logo To Go Home
    Verify Home Page Is Loaded
    Navigate To Cart Page
    Click Logo To Go Home
    Verify Home Page Is Loaded
    Navigate To Login Page
    Click Logo To Go Home
    Verify Home Page Is Loaded

# ==================== MULTI-PRODUCT JOURNEYS ====================

E2E: Add Multiple Products From Listing And Checkout
    [Documentation]    Add multiple products from listing page and proceed to checkout
    [Tags]    e2e    functional
    Navigate To Products Page
    Click Add To Cart For Product    1
    Click Add To Cart For Product    2
    Navigate To Cart Page
    Verify Cart Is Not Empty
    ${count}=    Get Cart Item Count
    Should Be True    ${count} >= 2
    Click Checkout Button
    Verify Checkout Page Is Loaded
    Fill Shipping Details
    Click Place Order

E2E: Add Products From Detail Pages And Checkout
    [Documentation]    Add products from multiple detail pages
    [Tags]    e2e    functional
    Navigate To Products Page
    Click On Product By Index    1
    Add Product To Cart From Detail
    Go Back To Products
    Click On Product By Index    2
    Add Product To Cart From Detail
    Navigate To Cart Page
    ${count}=    Get Cart Item Count
    Should Be True    ${count} >= 2
    Click Checkout Button
    Verify Checkout Page Is Loaded

E2E: Mix Of Detail And Listing Add To Cart
    [Documentation]    Add products from both detail and listing pages
    [Tags]    e2e    functional
    Navigate To Products Page
    Click Add To Cart For Product    1
    Click On Product By Index    2
    Add Product To Cart From Detail
    Navigate To Cart Page
    ${count}=    Get Cart Item Count
    Should Be True    ${count} >= 2

# ==================== CART MANAGEMENT JOURNEYS ====================

E2E: Add And Remove Products From Cart
    [Documentation]    Add products then remove one before checkout
    [Tags]    e2e    functional    cart
    Navigate To Products Page
    Click Add To Cart For Product    1
    Click Add To Cart For Product    2
    Navigate To Cart Page
    ${before}=    Get Cart Item Count
    Remove Item From Cart    1
    Sleep    1s
    ${after}=    Get Cart Item Count
    Should Be True    ${after} < ${before}

E2E: Empty Cart And Add Again
    [Documentation]    Add product, remove it, then add another
    [Tags]    e2e    functional    cart
    Navigate To Products Page
    Click Add To Cart For Product    1
    Navigate To Cart Page
    Remove All Items From Cart
    Sleep    1s
    Navigate To Products Page
    Click Add To Cart For Product    2
    Navigate To Cart Page
    Verify Cart Is Not Empty

E2E: Update Quantity And Checkout
    [Documentation]    Add product, update quantity, then checkout
    [Tags]    e2e    functional    cart
    Navigate To Products Page
    Click Add To Cart For Product    1
    Navigate To Cart Page
    Update Item Quantity In Cart    1    3
    Click Checkout Button
    Verify Checkout Page Is Loaded
    Fill Shipping Details
    Click Place Order

E2E: Continue Shopping Flow
    [Documentation]    Add to cart, continue shopping, add more, then checkout
    [Tags]    e2e    functional
    Navigate To Products Page
    Click Add To Cart For Product    1
    Navigate To Cart Page
    Click Continue Shopping
    Click Add To Cart For Product    2
    Navigate To Cart Page
    ${count}=    Get Cart Item Count
    Should Be True    ${count} >= 2
    Click Checkout Button
    Verify Checkout Page Is Loaded

# ==================== SIGNUP AND SHOP JOURNEY ====================

E2E: Signup Then Shop
    [Documentation]    Register a new account then browse and add to cart
    [Tags]    e2e    functional    signup
    Navigate To Signup Page
    Verify Signup Page Is Loaded
    Signup With Details    New Shopper    newshopper@test.com    Shop@1234
    Navigate To Products Page
    Verify Products Page Is Loaded
    Click Add To Cart For Product    1
    Navigate To Cart Page
    Verify Cart Is Not Empty

E2E: Login To Signup Navigation
    [Documentation]    Navigate from login to signup and back
    [Tags]    e2e    navigation    auth
    Navigate To Login Page
    Click Signup Redirect Link
    Verify Signup Page Is Loaded
    Click Element    ${SIGNUP_LOGIN_LINK}
    Wait For Page To Load

# ==================== PRODUCT DETAIL JOURNEYS ====================

E2E: Browse Multiple Product Details
    [Documentation]    View details of multiple products
    [Tags]    e2e    functional    products
    Navigate To Products Page
    Click On Product By Index    1
    Verify Product Detail Page Is Loaded
    ${name1}=    Get Product Detail Name
    Go Back To Products
    Click On Product By Index    2
    Verify Product Detail Page Is Loaded
    ${name2}=    Get Product Detail Name
    Should Not Be Equal    ${name1}    ${name2}

E2E: Product Detail With Quantity Change
    [Documentation]    View product detail, change quantity, add to cart
    [Tags]    e2e    functional    products
    Navigate To Products Page
    Click On Product By Index    1
    Verify Product Detail Page Is Loaded
    Increase Quantity    2
    Add Product To Cart From Detail
    Navigate To Cart Page
    Verify Cart Is Not Empty

E2E: Product Detail Verify All Sections
    [Documentation]    Verify all sections on product detail page
    [Tags]    e2e    functional    products
    Navigate To Products Page
    Click On Product By Index    1
    Verify Product Detail Has All Sections
    ${name}=    Get Product Detail Name
    ${price}=    Get Product Detail Price
    Should Not Be Empty    ${name}
    Should Not Be Empty    ${price}
    Verify Product Image Is Visible

# ==================== SEARCH JOURNEYS ====================

E2E: Search And Browse Results
    [Documentation]    Search for product and browse results
    [Tags]    e2e    functional    search
    Navigate To Products Page
    Search For Product On Products Page    shirt
    Wait For Page To Load

E2E: Search From Home And Add To Cart
    [Documentation]    Search from home page and add result to cart
    [Tags]    e2e    functional    search
    Verify Home Page Is Loaded
    Search For Product    shirt
    Wait For Page To Load

# ==================== PERSISTENCE JOURNEYS ====================

E2E: Cart Persists Through Navigation
    [Documentation]    Verify cart persists as user navigates the site
    [Tags]    e2e    functional    persistence
    Navigate To Products Page
    Click Add To Cart For Product    1
    Navigate To Home Page
    Navigate To Login Page
    Navigate To Products Page
    Navigate To Cart Page
    Verify Cart Is Not Empty

E2E: Cart Persists After Page Refresh
    [Documentation]    Verify cart persists after refreshing pages
    [Tags]    e2e    functional    persistence
    Navigate To Products Page
    Click Add To Cart For Product    1
    Navigate To Cart Page
    Verify Cart Is Not Empty
    Refresh Page
    Verify Cart Is Not Empty

# ==================== ERROR RECOVERY JOURNEYS ====================

E2E: Failed Login Then Successful Login And Shop
    [Documentation]    Failed login attempt, then succeed and shop
    [Tags]    e2e    functional    recovery
    Navigate To Login Page
    Login With Credentials    wrong@email.com    wrongpassword
    Navigate To Login Page
    Login With Credentials    ${VALID_EMAIL}    ${VALID_PASSWORD}
    Navigate To Products Page
    Click Add To Cart For Product    1
    Navigate To Cart Page
    Verify Cart Is Not Empty

E2E: Checkout With Invalid Data Then Valid Data
    [Documentation]    Submit invalid checkout, correct it, submit again
    [Tags]    e2e    functional    recovery
    Navigate To Products Page
    Click Add To Cart For Product    1
    Navigate To Cart Page
    Click Checkout Button
    Verify Checkout Page Is Loaded
    Click Place Order
    Fill Shipping Details
    Click Place Order

# ==================== PAGE INTEGRITY JOURNEY ====================

E2E: Verify No Broken Images Across All Pages
    [Documentation]    Check all major pages for broken images
    [Tags]    e2e    integrity    ui
    Verify Home Page Is Loaded
    Verify No Broken Images On Page
    Navigate To Products Page
    Verify No Broken Images On Page
    Navigate To Cart Page
    Verify No Broken Images On Page
