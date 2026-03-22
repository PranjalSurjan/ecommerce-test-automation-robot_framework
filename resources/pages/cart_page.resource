*** Settings ***
Resource    ../common/common.resource

*** Variables ***
${CART_HEADING}             css:h1, css:h2, css:.cart-title
${CART_ITEM}                css:.cart-item, css:.cart-product, css:tr.cart-row
${CART_ITEM_NAME}           css:.cart-item-name, css:.cart-product-name, css:.item-name
${CART_ITEM_PRICE}          css:.cart-item-price, css:.item-price
${CART_ITEM_QUANTITY}       css:.cart-item-quantity input, css:.quantity input
${CART_ITEM_TOTAL}          css:.cart-item-total, css:.item-total
${CART_REMOVE_BTN}          css:.remove-item, css:.cart-remove, css:button[class*="remove"]
${CART_SUBTOTAL}            css:.cart-subtotal, css:.subtotal
${CART_TOTAL}               css:.cart-total, css:.total-amount, css:.grand-total
${CART_CHECKOUT_BTN}        css:.checkout-btn, css:a[href*="checkout"], css:button[class*="checkout"]
${CART_CONTINUE_SHOPPING}   css:a[href*="products"], css:.continue-shopping
${CART_EMPTY_MSG}           css:.empty-cart, css:.cart-empty, css:.no-items
${CART_UPDATE_BTN}          css:.update-cart, css:button[class*="update"]
${CART_COUPON_INPUT}        css:input[name="coupon"], css:input[placeholder*="coupon"], css:#coupon
${CART_APPLY_COUPON_BTN}    css:.apply-coupon, css:button[class*="coupon"]

*** Keywords ***
Verify Cart Page Is Loaded
    [Documentation]    Verifies that the cart page has loaded
    Wait For Page To Load

Get Cart Item Count
    [Documentation]    Returns the number of items in the cart
    ${count}=    Get Element Count    ${CART_ITEM}
    RETURN    ${count}

Verify Cart Is Empty
    [Documentation]    Verifies that the cart has no items
    ${count}=    Get Cart Item Count
    Should Be Equal As Integers    ${count}    0    Cart is not empty

Verify Cart Is Not Empty
    [Documentation]    Verifies that the cart has at least one item
    ${count}=    Get Cart Item Count
    Should Be True    ${count} > 0    Cart is empty

Remove Item From Cart
    [Arguments]    ${index}=1
    [Documentation]    Removes an item from cart by index
    ${buttons}=    Get WebElements    ${CART_REMOVE_BTN}
    ${actual_index}=    Evaluate    ${index} - 1
    Click Element    ${buttons}[${actual_index}]
    Sleep    1s

Update Item Quantity In Cart
    [Arguments]    ${index}=1    ${new_quantity}=2
    [Documentation]    Updates quantity of an item in the cart
    ${inputs}=    Get WebElements    ${CART_ITEM_QUANTITY}
    ${actual_index}=    Evaluate    ${index} - 1
    Clear Element Text    ${inputs}[${actual_index}]
    Input Text    ${inputs}[${actual_index}]    ${new_quantity}

Get Cart Total
    [Documentation]    Returns the cart total text
    ${total}=    Get Text    ${CART_TOTAL}
    RETURN    ${total}

Click Checkout Button
    [Documentation]    Clicks the checkout button
    Wait Until Element Is Enabled    ${CART_CHECKOUT_BTN}    timeout=${TIMEOUT}
    Click Element    ${CART_CHECKOUT_BTN}
    Wait For Page To Load

Click Continue Shopping
    [Documentation]    Clicks continue shopping link
    Click Element    ${CART_CONTINUE_SHOPPING}
    Wait For Page To Load

Apply Coupon Code
    [Arguments]    ${coupon_code}
    [Documentation]    Applies a coupon code to the cart
    Wait Until Element Is Visible    ${CART_COUPON_INPUT}    timeout=${TIMEOUT}
    Input Text    ${CART_COUPON_INPUT}    ${coupon_code}
    Click Element    ${CART_APPLY_COUPON_BTN}
    Sleep    1s

Get All Cart Item Names
    [Documentation]    Returns list of all item names in cart
    ${elements}=    Get WebElements    ${CART_ITEM_NAME}
    ${names}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        Append To List    ${names}    ${text}
    END
    RETURN    ${names}

Get All Cart Item Prices
    [Documentation]    Returns list of all item prices in cart
    ${elements}=    Get WebElements    ${CART_ITEM_PRICE}
    ${prices}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        Append To List    ${prices}    ${text}
    END
    RETURN    ${prices}

Verify Cart Item Name At Index
    [Arguments]    ${index}    ${expected_name}
    [Documentation]    Verifies cart item name at a specific index
    ${names}=    Get All Cart Item Names
    ${actual_index}=    Evaluate    ${index} - 1
    ${actual_name}=    Get From List    ${names}    ${actual_index}
    Should Contain    ${actual_name}    ${expected_name}

Verify Cart Has Expected Item Count
    [Arguments]    ${expected_count}
    [Documentation]    Verifies cart has exact number of items
    ${count}=    Get Cart Item Count
    Should Be Equal As Integers    ${count}    ${expected_count}

Remove All Items From Cart
    [Documentation]    Removes all items from cart one by one
    ${count}=    Get Cart Item Count
    FOR    ${i}    IN RANGE    ${count}
        Remove Item From Cart    1
    END

Verify Cart Subtotal Is Displayed
    [Documentation]    Verifies subtotal section is visible
    Element Should Be Visible On Page    ${CART_SUBTOTAL}

Verify Checkout Button Is Enabled
    [Documentation]    Verifies checkout button is clickable
    Element Should Be Enabled    ${CART_CHECKOUT_BTN}

Verify Empty Cart Shows Empty Message
    [Documentation]    Verifies empty cart displays a message
    Wait Until Element Is Visible    ${CART_EMPTY_MSG}    timeout=${TIMEOUT}

Verify Coupon Input Is Present
    [Documentation]    Verifies coupon input field exists
    Element Should Be Visible On Page    ${CART_COUPON_INPUT}

Get Cart Item Quantity At Index
    [Arguments]    ${index}=1
    [Documentation]    Returns the quantity value of a cart item
    ${inputs}=    Get WebElements    ${CART_ITEM_QUANTITY}
    ${actual_index}=    Evaluate    ${index} - 1
    ${value}=    Get Value    ${inputs}[${actual_index}]
    RETURN    ${value}
