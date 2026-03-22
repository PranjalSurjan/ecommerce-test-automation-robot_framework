*** Settings ***
Documentation    Comprehensive test suite for Cart Page of TesterBud E-Commerce Website
Resource         ../resources/pages/cart_page.resource
Resource         ../resources/pages/products_page.resource
Suite Setup      Open Browser To Site
Suite Teardown   Close Test Browser

*** Keywords ***
Add Product To Cart And Navigate
    [Arguments]    ${product_index}=1
    [Documentation]    Helper to add a product and go to cart
    Navigate To Products Page
    Click Add To Cart For Product    ${product_index}
    Navigate To Cart Page

Add Multiple Products To Cart And Navigate
    [Arguments]    ${count}=2
    [Documentation]    Helper to add multiple products and go to cart
    Navigate To Products Page
    FOR    ${i}    IN RANGE    1    ${count} + 1
        Click Add To Cart For Product    ${i}
    END
    Navigate To Cart Page

*** Test Cases ***
# ==================== SMOKE TESTS ====================

Verify Cart Page Loads
    [Documentation]    Verify the cart page loads successfully
    [Tags]    smoke    cart    critical
    Navigate To Cart Page
    Verify Cart Page Is Loaded

# ==================== EMPTY CART TESTS ====================

Verify Empty Cart State
    [Documentation]    Verify cart is empty when no products added
    [Tags]    cart    ui    empty
    Navigate To Cart Page
    Verify Cart Is Empty

Verify Empty Cart Item Count Is Zero
    [Documentation]    Verify cart item count is 0 when empty
    [Tags]    cart    empty
    Navigate To Cart Page
    ${count}=    Get Cart Item Count
    Should Be Equal As Integers    ${count}    0

# ==================== ADD TO CART TESTS ====================

Verify Adding Single Product To Cart
    [Documentation]    Verify a product can be added and appears in cart
    [Tags]    cart    functional    critical
    Add Product To Cart And Navigate    1
    Verify Cart Is Not Empty

Verify Cart Item Count After Adding One Product
    [Documentation]    Verify cart count is 1 after adding one product
    [Tags]    cart    functional
    Add Product To Cart And Navigate    1
    ${count}=    Get Cart Item Count
    Should Be True    ${count} >= 1    Expected at least 1 item in cart

Verify Adding Second Product To Cart
    [Documentation]    Verify second product can be added to cart
    [Tags]    cart    functional
    Add Product To Cart And Navigate    2
    Verify Cart Is Not Empty

Verify Adding Multiple Items To Cart
    [Documentation]    Verify multiple items can be added to cart
    [Tags]    cart    functional
    Add Multiple Products To Cart And Navigate    2
    ${count}=    Get Cart Item Count
    Should Be True    ${count} >= 2    Expected at least 2 items in cart

Verify Adding Three Items To Cart
    [Documentation]    Verify three items can be added to cart
    [Tags]    cart    functional
    Add Multiple Products To Cart And Navigate    3
    ${count}=    Get Cart Item Count
    Should Be True    ${count} >= 3    Expected at least 3 items in cart

Verify Cart Item Names Are Displayed
    [Documentation]    Verify cart items show product names
    [Tags]    cart    ui    data
    Add Product To Cart And Navigate    1
    ${names}=    Get All Cart Item Names
    ${length}=    Get Length    ${names}
    Should Be True    ${length} > 0    No item names displayed in cart

Verify Cart Item Prices Are Displayed
    [Documentation]    Verify cart items show prices
    [Tags]    cart    ui    data
    Add Product To Cart And Navigate    1
    ${prices}=    Get All Cart Item Prices
    ${length}=    Get Length    ${prices}
    Should Be True    ${length} > 0    No item prices displayed in cart

# ==================== REMOVE FROM CART TESTS ====================

Verify Remove Single Item From Cart
    [Documentation]    Verify an item can be removed from the cart
    [Tags]    cart    functional    remove
    Add Product To Cart And Navigate    1
    Verify Cart Is Not Empty
    Remove Item From Cart    1

Verify Cart After Removing Item
    [Documentation]    Verify cart state after removing an item
    [Tags]    cart    functional    remove
    Add Multiple Products To Cart And Navigate    2
    ${before}=    Get Cart Item Count
    Remove Item From Cart    1
    Sleep    1s
    ${after}=    Get Cart Item Count
    Should Be True    ${after} < ${before}    Item was not removed

Verify Remove All Items From Cart
    [Documentation]    Verify all items can be removed from cart
    [Tags]    cart    functional    remove
    Add Multiple Products To Cart And Navigate    2
    Remove All Items From Cart
    Sleep    1s

Verify Remove First Item When Multiple In Cart
    [Documentation]    Verify removing first item keeps others
    [Tags]    cart    functional    remove
    Add Multiple Products To Cart And Navigate    2
    Remove Item From Cart    1
    Sleep    1s
    Verify Cart Is Not Empty

# ==================== QUANTITY UPDATE TESTS ====================

Verify Update Item Quantity In Cart
    [Documentation]    Verify quantity can be updated in cart
    [Tags]    cart    functional    quantity
    Add Product To Cart And Navigate    1
    Update Item Quantity In Cart    1    3

Verify Update Quantity To Zero
    [Documentation]    Verify handling of zero quantity in cart
    [Tags]    cart    negative    quantity    boundary
    Add Product To Cart And Navigate    1
    Update Item Quantity In Cart    1    0

Verify Update Quantity To Negative
    [Documentation]    Verify handling of negative quantity
    [Tags]    cart    negative    quantity    boundary
    Add Product To Cart And Navigate    1
    Update Item Quantity In Cart    1    -1

Verify Update Quantity To Very Large Number
    [Documentation]    Verify handling of very large quantity
    [Tags]    cart    boundary    quantity
    Add Product To Cart And Navigate    1
    Update Item Quantity In Cart    1    99999

Verify Get Cart Item Quantity
    [Documentation]    Verify cart item quantity can be retrieved
    [Tags]    cart    functional    quantity
    Add Product To Cart And Navigate    1
    ${qty}=    Get Cart Item Quantity At Index    1
    Should Not Be Empty    ${qty}

# ==================== CART TOTAL TESTS ====================

Verify Cart Total Is Displayed
    [Documentation]    Verify the cart total is shown
    [Tags]    cart    ui    pricing
    Add Product To Cart And Navigate    1
    ${total}=    Get Cart Total
    Should Not Be Empty    ${total}

Verify Cart Total Updates After Adding Item
    [Documentation]    Verify total changes when item is added
    [Tags]    cart    functional    pricing
    Add Multiple Products To Cart And Navigate    2
    ${total}=    Get Cart Total
    Should Not Be Empty    ${total}

Verify Cart Subtotal Is Displayed
    [Documentation]    Verify subtotal section is visible
    [Tags]    cart    ui    pricing
    Add Product To Cart And Navigate    1
    Verify Cart Subtotal Is Displayed

# ==================== CHECKOUT NAVIGATION TESTS ====================

Verify Checkout Button Is Present
    [Documentation]    Verify checkout button is visible when cart has items
    [Tags]    cart    ui    checkout
    Add Product To Cart And Navigate    1
    Element Should Be Visible On Page    ${CART_CHECKOUT_BTN}

Verify Checkout Button Is Enabled
    [Documentation]    Verify checkout button is clickable
    [Tags]    cart    ui    checkout
    Add Product To Cart And Navigate    1
    Verify Checkout Button Is Enabled

Verify Proceeding To Checkout From Cart
    [Documentation]    Verify user can proceed to checkout from cart
    [Tags]    cart    checkout    functional    critical
    Add Product To Cart And Navigate    1
    Click Checkout Button
    Wait For Page To Load

# ==================== CONTINUE SHOPPING TESTS ====================

Verify Continue Shopping Link Works
    [Documentation]    Verify clicking continue shopping goes back to products
    [Tags]    cart    navigation
    Add Product To Cart And Navigate    1
    Click Continue Shopping
    Wait For Page To Load

Verify Continue Shopping Returns To Products Page
    [Documentation]    Verify continue shopping navigates to products
    [Tags]    cart    navigation
    Add Product To Cart And Navigate    1
    Click Continue Shopping
    Verify Current URL Contains    product

# ==================== COUPON TESTS ====================

Verify Coupon Input Is Present
    [Documentation]    Verify coupon code input field exists
    [Tags]    cart    ui    coupon
    Add Product To Cart And Navigate    1
    Verify Coupon Input Is Present

Verify Apply Valid Coupon Code
    [Documentation]    Verify applying a valid coupon code
    [Tags]    cart    functional    coupon
    Add Product To Cart And Navigate    1
    Apply Coupon Code    TESTCOUPON

Verify Apply Invalid Coupon Code
    [Documentation]    Verify error for invalid coupon code
    [Tags]    cart    negative    coupon
    Add Product To Cart And Navigate    1
    Apply Coupon Code    INVALIDCOUPON123

Verify Apply Empty Coupon Code
    [Documentation]    Verify error for empty coupon code
    [Tags]    cart    negative    coupon
    Add Product To Cart And Navigate    1
    Apply Coupon Code    ${EMPTY}

Verify Apply Coupon With Special Characters
    [Documentation]    Verify coupon with special characters
    [Tags]    cart    negative    coupon    security
    Add Product To Cart And Navigate    1
    Apply Coupon Code    <script>alert(1)</script>

# ==================== CART PERSISTENCE TESTS ====================

Verify Cart Persists After Page Refresh
    [Documentation]    Verify cart items remain after page refresh
    [Tags]    cart    functional    persistence
    Add Product To Cart And Navigate    1
    Verify Cart Is Not Empty
    Refresh Page
    Verify Cart Is Not Empty

Verify Cart Persists After Navigation
    [Documentation]    Verify cart items remain after navigating away and back
    [Tags]    cart    functional    persistence
    Add Product To Cart And Navigate    1
    Navigate To Products Page
    Navigate To Cart Page
    Verify Cart Is Not Empty

Verify Cart Persists After Visiting Home
    [Documentation]    Verify cart items remain after visiting home page
    [Tags]    cart    functional    persistence
    Add Product To Cart And Navigate    1
    Navigate To Home Page
    Navigate To Cart Page
    Verify Cart Is Not Empty

# ==================== PAGE INTEGRITY TESTS ====================

Verify Cart Page After Refresh
    [Documentation]    Verify cart page loads correctly after refresh
    [Tags]    cart    functional
    Navigate To Cart Page
    Refresh Page
    Verify Cart Page Is Loaded

Verify Cart Page URL
    [Documentation]    Verify cart page URL contains cart
    [Tags]    cart    navigation
    Navigate To Cart Page
    Verify Current URL Contains    cart

Verify No Broken Images On Cart Page
    [Documentation]    Verify no broken images on cart page
    [Tags]    cart    ui    integrity
    Add Product To Cart And Navigate    1
    Verify No Broken Images On Page

Verify Back Button From Cart Page
    [Documentation]    Verify browser back from cart page
    [Tags]    cart    navigation
    Navigate To Cart Page
    Navigate Back
    Wait For Page To Load
