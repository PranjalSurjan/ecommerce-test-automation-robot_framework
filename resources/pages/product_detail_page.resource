*** Settings ***
Resource    ../common/common.resource

*** Variables ***
${DETAIL_PRODUCT_NAME}      css:.product-detail h1, css:.product-name, css:.product-title
${DETAIL_PRODUCT_PRICE}     css:.product-detail .price, css:.product-price, css:.detail-price
${DETAIL_PRODUCT_DESC}      css:.product-description, css:.description, css:.product-detail p
${DETAIL_PRODUCT_IMAGE}     css:.product-detail img, css:.product-image img
${DETAIL_ADD_TO_CART}       css:.product-detail .add-to-cart, css:.product-detail button[class*="cart"]
${DETAIL_QUANTITY_INPUT}    css:input[type="number"], css:.quantity-input, css:#quantity
${DETAIL_QUANTITY_PLUS}     css:.quantity-plus, css:button[class*="plus"], css:.increment
${DETAIL_QUANTITY_MINUS}    css:.quantity-minus, css:button[class*="minus"], css:.decrement
${DETAIL_REVIEW_SECTION}    css:.reviews, css:.review-section, css:.product-reviews
${DETAIL_RATING}            css:.rating, css:.stars, css:.product-rating
${DETAIL_BACK_BTN}          css:.back-btn, css:a[href*="products"], css:.go-back

*** Keywords ***
Verify Product Detail Page Is Loaded
    [Documentation]    Verifies that the product detail page has loaded
    Wait Until Element Is Visible    ${DETAIL_PRODUCT_NAME}    timeout=${TIMEOUT}

Get Product Detail Name
    [Documentation]    Returns the product name from detail page
    ${name}=    Get Text    ${DETAIL_PRODUCT_NAME}
    RETURN    ${name}

Get Product Detail Price
    [Documentation]    Returns the product price from detail page
    ${price}=    Get Text    ${DETAIL_PRODUCT_PRICE}
    RETURN    ${price}

Get Product Detail Description
    [Documentation]    Returns the product description
    ${desc}=    Get Text    ${DETAIL_PRODUCT_DESC}
    RETURN    ${desc}

Add Product To Cart From Detail
    [Documentation]    Clicks Add to Cart on the detail page
    Wait Until Element Is Enabled    ${DETAIL_ADD_TO_CART}    timeout=${TIMEOUT}
    Click Element    ${DETAIL_ADD_TO_CART}
    Sleep    1s

Set Product Quantity
    [Arguments]    ${quantity}
    [Documentation]    Sets the quantity for the product
    Wait Until Element Is Visible    ${DETAIL_QUANTITY_INPUT}    timeout=${TIMEOUT}
    Clear Element Text    ${DETAIL_QUANTITY_INPUT}
    Input Text    ${DETAIL_QUANTITY_INPUT}    ${quantity}

Increase Quantity
    [Arguments]    ${times}=1
    [Documentation]    Increases quantity by clicking plus button
    FOR    ${i}    IN RANGE    ${times}
        Click Element    ${DETAIL_QUANTITY_PLUS}
    END

Decrease Quantity
    [Arguments]    ${times}=1
    [Documentation]    Decreases quantity by clicking minus button
    FOR    ${i}    IN RANGE    ${times}
        Click Element    ${DETAIL_QUANTITY_MINUS}
    END

Go Back To Products
    [Documentation]    Navigates back to products listing
    Click Element    ${DETAIL_BACK_BTN}
    Wait For Page To Load

Verify Product Image Is Visible
    [Documentation]    Verifies product image is displayed on detail page
    Element Should Be Visible On Page    ${DETAIL_PRODUCT_IMAGE}

Verify Product Description Is Not Empty
    [Documentation]    Verifies product has a description
    ${desc}=    Get Product Detail Description
    Should Not Be Empty    ${desc}

Verify Add To Cart Button Is Present On Detail
    [Documentation]    Verifies Add to Cart button exists on detail
    Element Should Be Visible On Page    ${DETAIL_ADD_TO_CART}
    Element Should Be Enabled    ${DETAIL_ADD_TO_CART}

Verify Quantity Input Is Present
    [Documentation]    Verifies quantity input field exists
    Element Should Be Visible On Page    ${DETAIL_QUANTITY_INPUT}

Get Current Quantity
    [Documentation]    Returns current quantity value
    ${value}=    Get Value    ${DETAIL_QUANTITY_INPUT}
    RETURN    ${value}

Verify Default Quantity Is One
    [Documentation]    Verifies default quantity is 1
    ${qty}=    Get Current Quantity
    Should Be Equal    ${qty}    1

Verify Review Section Is Present
    [Documentation]    Verifies review section exists
    Element Should Be Visible On Page    ${DETAIL_REVIEW_SECTION}

Verify Rating Is Displayed
    [Documentation]    Verifies rating/stars are displayed
    Element Should Be Visible On Page    ${DETAIL_RATING}

Verify Back Button Is Present
    [Documentation]    Verifies back to products button exists
    Element Should Be Visible On Page    ${DETAIL_BACK_BTN}

Verify Product Detail Has All Sections
    [Documentation]    Verifies all main sections on product detail page
    Element Should Be Visible On Page    ${DETAIL_PRODUCT_NAME}
    Element Should Be Visible On Page    ${DETAIL_PRODUCT_PRICE}
    Element Should Be Visible On Page    ${DETAIL_PRODUCT_IMAGE}
