*** Settings ***
Resource    ../common/common.resource

*** Variables ***
${CHECKOUT_FORM}                css:form
${CHECKOUT_FIRST_NAME}          css:input[name="firstName"], css:#firstName
${CHECKOUT_LAST_NAME}           css:input[name="lastName"], css:#lastName
${CHECKOUT_EMAIL}               css:input[name="email"], css:#checkoutEmail
${CHECKOUT_ADDRESS}             css:input[name="address"], css:#address, css:textarea[name="address"]
${CHECKOUT_CITY}                css:input[name="city"], css:#city
${CHECKOUT_STATE}               css:input[name="state"], css:#state, css:select[name="state"]
${CHECKOUT_ZIP}                 css:input[name="zip"], css:#zip, css:input[name="zipCode"]
${CHECKOUT_COUNTRY}             css:select[name="country"], css:#country
${CHECKOUT_PHONE}               css:input[name="phone"], css:#phone
${CHECKOUT_PLACE_ORDER_BTN}     css:button[type="submit"], css:.place-order, css:.checkout-submit
${CHECKOUT_ORDER_SUMMARY}       css:.order-summary, css:.checkout-summary
${CHECKOUT_TOTAL}               css:.checkout-total, css:.order-total
${CHECKOUT_ERROR}               css:.error-message, css:.alert-danger, css:.checkout-error

# Test Data
${TEST_FIRST_NAME}      John
${TEST_LAST_NAME}       Doe
${TEST_ADDRESS}         123 Test Street
${TEST_CITY}            Test City
${TEST_STATE}           California
${TEST_ZIP}             90210
${TEST_PHONE}           1234567890

*** Keywords ***
Verify Checkout Page Is Loaded
    [Documentation]    Verifies checkout page is loaded
    Wait Until Element Is Visible    ${CHECKOUT_FORM}    timeout=${TIMEOUT}

Fill Shipping Details
    [Arguments]    ${first_name}=${TEST_FIRST_NAME}    ${last_name}=${TEST_LAST_NAME}
    ...            ${address}=${TEST_ADDRESS}    ${city}=${TEST_CITY}
    ...            ${state}=${TEST_STATE}    ${zip}=${TEST_ZIP}
    [Documentation]    Fills in all shipping details
    Input Text    ${CHECKOUT_FIRST_NAME}    ${first_name}
    Input Text    ${CHECKOUT_LAST_NAME}    ${last_name}
    Input Text    ${CHECKOUT_ADDRESS}    ${address}
    Input Text    ${CHECKOUT_CITY}    ${city}
    Input Text    ${CHECKOUT_ZIP}    ${zip}

Click Place Order
    [Documentation]    Clicks the Place Order button
    Click Element    ${CHECKOUT_PLACE_ORDER_BTN}
    Sleep    2s

Verify Order Summary Is Displayed
    [Documentation]    Verifies order summary section is visible
    Element Should Be Visible On Page    ${CHECKOUT_ORDER_SUMMARY}

Verify Checkout Error Is Displayed
    [Documentation]    Verifies error is shown on checkout
    Wait Until Element Is Visible    ${CHECKOUT_ERROR}    timeout=${TIMEOUT}

Fill First Name Only
    [Arguments]    ${first_name}=${TEST_FIRST_NAME}
    [Documentation]    Fills only the first name field
    Input Text    ${CHECKOUT_FIRST_NAME}    ${first_name}

Fill Last Name Only
    [Arguments]    ${last_name}=${TEST_LAST_NAME}
    [Documentation]    Fills only the last name field
    Input Text    ${CHECKOUT_LAST_NAME}    ${last_name}

Fill Address Only
    [Arguments]    ${address}=${TEST_ADDRESS}
    [Documentation]    Fills only the address field
    Input Text    ${CHECKOUT_ADDRESS}    ${address}

Fill City Only
    [Arguments]    ${city}=${TEST_CITY}
    [Documentation]    Fills only the city field
    Input Text    ${CHECKOUT_CITY}    ${city}

Fill Zip Only
    [Arguments]    ${zip}=${TEST_ZIP}
    [Documentation]    Fills only the zip field
    Input Text    ${CHECKOUT_ZIP}    ${zip}

Fill Phone Only
    [Arguments]    ${phone}=${TEST_PHONE}
    [Documentation]    Fills only the phone field
    Input Text    ${CHECKOUT_PHONE}    ${phone}

Verify First Name Field Is Present
    [Documentation]    Verifies first name input is visible
    Element Should Be Visible On Page    ${CHECKOUT_FIRST_NAME}

Verify Last Name Field Is Present
    [Documentation]    Verifies last name input is visible
    Element Should Be Visible On Page    ${CHECKOUT_LAST_NAME}

Verify Address Field Is Present
    [Documentation]    Verifies address input is visible
    Element Should Be Visible On Page    ${CHECKOUT_ADDRESS}

Verify City Field Is Present
    [Documentation]    Verifies city input is visible
    Element Should Be Visible On Page    ${CHECKOUT_CITY}

Verify Zip Field Is Present
    [Documentation]    Verifies zip input is visible
    Element Should Be Visible On Page    ${CHECKOUT_ZIP}

Verify Place Order Button Is Present
    [Documentation]    Verifies place order button is visible and enabled
    Element Should Be Visible On Page    ${CHECKOUT_PLACE_ORDER_BTN}
    Element Should Be Enabled    ${CHECKOUT_PLACE_ORDER_BTN}

Clear Checkout Form
    [Documentation]    Clears all checkout form fields
    Clear Element Text    ${CHECKOUT_FIRST_NAME}
    Clear Element Text    ${CHECKOUT_LAST_NAME}
    Clear Element Text    ${CHECKOUT_ADDRESS}
    Clear Element Text    ${CHECKOUT_CITY}
    Clear Element Text    ${CHECKOUT_ZIP}

Get Checkout Total Text
    [Documentation]    Returns the checkout total text
    ${total}=    Get Text    ${CHECKOUT_TOTAL}
    RETURN    ${total}

Fill Shipping Details With Email
    [Arguments]    ${first_name}=${TEST_FIRST_NAME}    ${last_name}=${TEST_LAST_NAME}
    ...            ${email}=test@example.com    ${address}=${TEST_ADDRESS}
    ...            ${city}=${TEST_CITY}    ${zip}=${TEST_ZIP}
    [Documentation]    Fills shipping details including email
    Input Text    ${CHECKOUT_FIRST_NAME}    ${first_name}
    Input Text    ${CHECKOUT_LAST_NAME}    ${last_name}
    Input Text    ${CHECKOUT_EMAIL}    ${email}
    Input Text    ${CHECKOUT_ADDRESS}    ${address}
    Input Text    ${CHECKOUT_CITY}    ${city}
    Input Text    ${CHECKOUT_ZIP}    ${zip}
