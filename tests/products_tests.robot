*** Settings ***
Documentation    Comprehensive test suite for Products Page of TesterBud E-Commerce Website
Resource         ../resources/pages/products_page.resource
Resource         ../resources/pages/product_detail_page.resource
Suite Setup      Open Browser To Site
Suite Teardown   Close Test Browser
Test Setup       Navigate To Products Page

*** Test Cases ***
# ==================== SMOKE TESTS ====================

Verify Products Page Loads Successfully
    [Documentation]    Verify the products page loads with product cards
    [Tags]    smoke    products    critical
    Verify Products Page Is Loaded

# ==================== PRODUCT LISTING TESTS ====================

Verify All Product Cards Are Displayed
    [Documentation]    Verify product cards are visible on the page
    [Tags]    products    ui
    ${count}=    Get Product Count
    Should Be True    ${count} > 0    No products displayed

Verify Products Heading Is Visible
    [Documentation]    Verify the products page has a heading
    [Tags]    products    ui
    Verify Products Heading Is Visible

Verify Product Names Are Visible
    [Documentation]    Verify that all product cards show product names
    [Tags]    products    ui
    ${names}=    Get All Product Names
    ${length}=    Get Length    ${names}
    Should Be True    ${length} > 0    No product names found

Verify Product Prices Are Visible
    [Documentation]    Verify that all product cards show prices
    [Tags]    products    ui
    ${prices}=    Get All Product Prices
    ${length}=    Get Length    ${prices}
    Should Be True    ${length} > 0    No product prices found

Verify All Products Have Non-Empty Names
    [Documentation]    Verify every product name is not empty
    [Tags]    products    data
    Verify All Products Have Names

Verify All Products Have Non-Empty Prices
    [Documentation]    Verify every product price is not empty
    [Tags]    products    data
    Verify All Products Have Prices

Verify All Products Have Images
    [Documentation]    Verify all product cards display images
    [Tags]    products    ui    images
    Verify All Products Have Images

Verify All Products Have Add To Cart Buttons
    [Documentation]    Verify every product card has an Add to Cart button
    [Tags]    products    ui    functional
    Verify All Products Have Add To Cart Buttons

Verify Product Names Are Unique
    [Documentation]    Verify there are no duplicate product names
    [Tags]    products    data    integrity
    Verify Product Names Are Unique

Verify First Product Name Can Be Retrieved
    [Documentation]    Verify we can get the name of the first product
    [Tags]    products    data
    ${name}=    Get Product Name By Index    1
    Should Not Be Empty    ${name}

Verify First Product Price Can Be Retrieved
    [Documentation]    Verify we can get the price of the first product
    [Tags]    products    data
    ${price}=    Get Product Price By Index    1
    Should Not Be Empty    ${price}

# ==================== ADD TO CART TESTS ====================

Verify Add To Cart Button Works For First Product
    [Documentation]    Verify clicking Add to Cart on first product
    [Tags]    products    cart    functional
    Click Add To Cart For Product    1

Verify Add To Cart Button Works For Second Product
    [Documentation]    Verify clicking Add to Cart on second product
    [Tags]    products    cart    functional
    Click Add To Cart For Product    2

Verify Multiple Products Can Be Added To Cart
    [Documentation]    Verify adding multiple products to cart
    [Tags]    products    cart    functional
    Click Add To Cart For Product    1
    Click Add To Cart For Product    2

Verify Add To Cart For Third Product
    [Documentation]    Verify adding third product to cart
    [Tags]    products    cart    functional
    ${count}=    Get Product Count
    IF    ${count} >= 3
        Click Add To Cart For Product    3
    END

Verify Same Product Can Be Added Multiple Times
    [Documentation]    Verify adding the same product twice
    [Tags]    products    cart    functional    boundary
    Click Add To Cart For Product    1
    Click Add To Cart For Product    1

# ==================== PRODUCT DETAIL NAVIGATION TESTS ====================

Verify Product Detail Page Opens For First Product
    [Documentation]    Verify clicking first product opens detail page
    [Tags]    products    navigation    detail
    Click On Product By Index    1
    Verify Product Detail Page Is Loaded

Verify Product Detail Page Opens For Second Product
    [Documentation]    Verify clicking second product opens detail page
    [Tags]    products    navigation    detail
    Click On Product By Index    2
    Verify Product Detail Page Is Loaded

Verify Product Detail Page Shows Product Name
    [Documentation]    Verify the detail page displays the product name
    [Tags]    products    detail    data
    Click On Product By Index    1
    ${name}=    Get Product Detail Name
    Should Not Be Empty    ${name}

Verify Product Detail Page Shows Product Price
    [Documentation]    Verify the detail page displays the product price
    [Tags]    products    detail    data
    Click On Product By Index    1
    ${price}=    Get Product Detail Price
    Should Not Be Empty    ${price}

Verify Product Detail Page Shows Description
    [Documentation]    Verify the detail page shows product description
    [Tags]    products    detail    data
    Click On Product By Index    1
    Verify Product Description Is Not Empty

Verify Product Detail Page Shows Image
    [Documentation]    Verify the detail page displays product image
    [Tags]    products    detail    ui
    Click On Product By Index    1
    Verify Product Image Is Visible

Verify Product Detail Has All Required Sections
    [Documentation]    Verify detail page shows name, price, and image
    [Tags]    products    detail    ui
    Click On Product By Index    1
    Verify Product Detail Has All Sections

Verify Add To Cart From Product Detail
    [Documentation]    Verify adding product to cart from detail page
    [Tags]    products    detail    cart    functional
    Click On Product By Index    1
    Add Product To Cart From Detail

Verify Add To Cart Button Present On Detail Page
    [Documentation]    Verify Add to Cart button is visible on detail page
    [Tags]    products    detail    ui
    Click On Product By Index    1
    Verify Add To Cart Button Is Present On Detail

# ==================== QUANTITY TESTS ON DETAIL PAGE ====================

Verify Quantity Input Is Present On Detail Page
    [Documentation]    Verify quantity input exists on product detail
    [Tags]    products    detail    quantity    ui
    Click On Product By Index    1
    Verify Quantity Input Is Present

Verify Default Quantity Is One
    [Documentation]    Verify default quantity is 1 on product detail
    [Tags]    products    detail    quantity
    Click On Product By Index    1
    Verify Default Quantity Is One

Verify Quantity Can Be Increased
    [Documentation]    Verify quantity can be increased using plus button
    [Tags]    products    detail    quantity    functional
    Click On Product By Index    1
    Increase Quantity    2
    ${qty}=    Get Current Quantity
    Should Not Be Equal    ${qty}    1

Verify Quantity Can Be Decreased
    [Documentation]    Verify quantity can be decreased using minus button
    [Tags]    products    detail    quantity    functional
    Click On Product By Index    1
    Increase Quantity    3
    Decrease Quantity    1

Verify Quantity Can Be Set Manually
    [Documentation]    Verify quantity can be typed directly
    [Tags]    products    detail    quantity    functional
    Click On Product By Index    1
    Set Product Quantity    5
    ${qty}=    Get Current Quantity
    Should Be Equal    ${qty}    5

Verify Zero Quantity Handling
    [Documentation]    Verify system handles zero quantity
    [Tags]    products    detail    quantity    negative
    Click On Product By Index    1
    Set Product Quantity    0

Verify Negative Quantity Handling
    [Documentation]    Verify system handles negative quantity
    [Tags]    products    detail    quantity    negative
    Click On Product By Index    1
    Set Product Quantity    -1

Verify Very Large Quantity Handling
    [Documentation]    Verify system handles very large quantity
    [Tags]    products    detail    quantity    boundary
    Click On Product By Index    1
    Set Product Quantity    99999

# ==================== BACK NAVIGATION FROM DETAIL ====================

Verify Back Button On Detail Page
    [Documentation]    Verify back button returns to products listing
    [Tags]    products    detail    navigation
    Click On Product By Index    1
    Verify Back Button Is Present

Verify Back Button Navigation From Detail
    [Documentation]    Verify clicking back returns to products
    [Tags]    products    detail    navigation
    Click On Product By Index    1
    Go Back To Products
    Verify Products Page Is Loaded

# ==================== REVIEW AND RATING TESTS ====================

Verify Review Section On Detail Page
    [Documentation]    Verify review section is present on detail page
    [Tags]    products    detail    reviews
    Click On Product By Index    1
    Verify Review Section Is Present

Verify Rating Is Displayed On Detail Page
    [Documentation]    Verify product rating is shown on detail page
    [Tags]    products    detail    rating
    Click On Product By Index    1
    Verify Rating Is Displayed

# ==================== SEARCH TESTS ====================

Verify Search On Products Page
    [Documentation]    Verify searching for a product on the products page
    [Tags]    products    search    functional
    Search For Product On Products Page    phone

Verify Search With Empty Input
    [Documentation]    Verify search with empty input
    [Tags]    products    search    negative
    Search For Product On Products Page    ${EMPTY}

Verify Search With Special Characters
    [Documentation]    Verify search handles special characters
    [Tags]    products    search    security
    Search For Product On Products Page    <script>alert(1)</script>

Verify Search With Non-Existent Product
    [Documentation]    Verify search for product that doesn't exist
    [Tags]    products    search    negative
    Search For Product On Products Page    xyznonexistent99999

Verify Search With Partial Name
    [Documentation]    Verify partial name search works
    [Tags]    products    search    functional
    Search For Product On Products Page    sho

# ==================== SORTING AND FILTERING TESTS ====================

Verify Category Filter Is Present
    [Documentation]    Verify category filter dropdown exists
    [Tags]    products    filter    ui
    Element Should Be Visible On Page    ${PRODUCT_CATEGORY_FILTER}

Verify Sort Dropdown Is Present
    [Documentation]    Verify sort dropdown exists
    [Tags]    products    sort    ui
    Element Should Be Visible On Page    ${PRODUCT_SORT_DROPDOWN}

# ==================== PAGE INTEGRITY TESTS ====================

Verify Products Page After Refresh
    [Documentation]    Verify products page loads after refresh
    [Tags]    products    functional
    Refresh Page
    Verify Products Page Is Loaded

Verify Products Page Has No Broken Images
    [Documentation]    Verify all product images are loaded
    [Tags]    products    ui    integrity
    Verify No Broken Images On Page

Verify Browser Back From Detail Returns To Products
    [Documentation]    Verify browser back from detail returns to products
    [Tags]    products    navigation
    Click On Product By Index    1
    Navigate Back
    Verify Products Page Is Loaded
