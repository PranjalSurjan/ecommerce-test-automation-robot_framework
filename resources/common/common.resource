*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Variables  ../../config/variables.yaml

*** Variables ***
${LOGO_LINK}            css:.navbar-brand
${NAV_HOME}             css:a[href="/practice-ecommerece-website"]
${NAV_PRODUCTS}         css:a[href*="products"]
${NAV_CART}             css:a[href*="cart"]
${NAV_LOGIN}            css:a[href*="login"]
${NAV_SIGNUP}           css:a[href*="signup"]

*** Keywords ***
Open Browser To Site
    [Documentation]    Opens browser and navigates to the base URL
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    ${IMPLICIT_WAIT}
    Set Selenium Timeout    ${TIMEOUT}

Close Test Browser
    [Documentation]    Closes the browser after test
    Close All Browsers

Wait For Page To Load
    [Documentation]    Waits until the page body is visible
    Wait Until Element Is Visible    css:body    timeout=${TIMEOUT}

Take Test Screenshot
    [Arguments]    ${name}=screenshot
    [Documentation]    Captures screenshot with given name
    Capture Page Screenshot    ${name}.png

Navigate To Home Page
    [Documentation]    Clicks on the Home navigation link
    Click Element    ${NAV_HOME}
    Wait For Page To Load

Navigate To Products Page
    [Documentation]    Clicks on the Products navigation link
    Click Element    ${NAV_PRODUCTS}
    Wait For Page To Load

Navigate To Cart Page
    [Documentation]    Clicks on the Cart navigation link
    Click Element    ${NAV_CART}
    Wait For Page To Load

Navigate To Login Page
    [Documentation]    Clicks on the Login navigation link
    Click Element    ${NAV_LOGIN}
    Wait For Page To Load

Navigate To Signup Page
    [Documentation]    Clicks on the Signup navigation link
    Click Element    ${NAV_SIGNUP}
    Wait For Page To Load

Element Should Be Visible On Page
    [Arguments]    ${locator}
    [Documentation]    Asserts that an element is visible
    Wait Until Element Is Visible    ${locator}    timeout=${TIMEOUT}
    Element Should Be Visible    ${locator}

Element Should Contain Expected Text
    [Arguments]    ${locator}    ${expected_text}
    [Documentation]    Asserts element contains expected text
    Wait Until Element Is Visible    ${locator}    timeout=${TIMEOUT}
    Element Should Contain    ${locator}    ${expected_text}

Click And Wait
    [Arguments]    ${locator}
    [Documentation]    Clicks an element and waits for page load
    Wait Until Element Is Enabled    ${locator}    timeout=${TIMEOUT}
    Click Element    ${locator}
    Wait For Page To Load

Verify Current URL Contains
    [Arguments]    ${expected_fragment}
    [Documentation]    Asserts the current URL contains the expected text
    ${url}=    Get Location
    Should Contain    ${url}    ${expected_fragment}

Verify Current URL Does Not Contain
    [Arguments]    ${unexpected_fragment}
    [Documentation]    Asserts the current URL does NOT contain given text
    ${url}=    Get Location
    Should Not Contain    ${url}    ${unexpected_fragment}

Verify Page Title Contains
    [Arguments]    ${expected_title}
    [Documentation]    Asserts the page title contains the expected text
    ${title}=    Get Title
    Should Contain    ${title}    ${expected_title}

Get Current Page URL
    [Documentation]    Returns the current page URL
    ${url}=    Get Location
    RETURN    ${url}

Verify Element Is Not Visible On Page
    [Arguments]    ${locator}
    [Documentation]    Asserts that an element is NOT visible
    Element Should Not Be Visible    ${locator}

Verify Element Count
    [Arguments]    ${locator}    ${expected_count}
    [Documentation]    Asserts the element count matches expected
    ${actual}=    Get Element Count    ${locator}
    Should Be Equal As Integers    ${actual}    ${expected_count}

Verify Element Is Enabled
    [Arguments]    ${locator}
    [Documentation]    Verifies an element is enabled/interactive
    Wait Until Element Is Visible    ${locator}    timeout=${TIMEOUT}
    Element Should Be Enabled    ${locator}

Verify Element Is Disabled
    [Arguments]    ${locator}
    [Documentation]    Verifies an element is disabled
    Wait Until Element Is Visible    ${locator}    timeout=${TIMEOUT}
    Element Should Be Disabled    ${locator}

Verify Element Text Is Not Empty
    [Arguments]    ${locator}
    [Documentation]    Asserts element text is not empty
    ${text}=    Get Text    ${locator}
    Should Not Be Empty    ${text}

Scroll To Element
    [Arguments]    ${locator}
    [Documentation]    Scrolls the page until element is visible
    Scroll Element Into View    ${locator}

Navigate Back
    [Documentation]    Uses browser back button
    Go Back
    Wait For Page To Load

Navigate Forward
    [Documentation]    Uses browser forward button
    Go To    javascript:history.forward()
    Wait For Page To Load

Refresh Page
    [Documentation]    Reloads the current page
    Reload Page
    Wait For Page To Load

Open Site In New Tab
    [Documentation]    Opens the base URL in a new browser tab
    Execute JavaScript    window.open('${BASE_URL}', '_blank')
    Switch Window    NEW

Verify No Broken Images On Page
    [Documentation]    Checks that all images on the page have loaded
    ${broken_count}=    Execute JavaScript
    ...    return document.querySelectorAll('img').length - [...document.querySelectorAll('img')].filter(img => img.complete && img.naturalHeight > 0).length
    Should Be Equal As Integers    ${broken_count}    0    Found broken images on the page

Verify All Links Have Href
    [Documentation]    Checks that all anchor tags have href attributes
    ${links_without_href}=    Execute JavaScript
    ...    return [...document.querySelectorAll('a')].filter(a => !a.href || a.href === '').length
    Should Be Equal As Integers    ${links_without_href}    0    Found links without href

Get Element CSS Property
    [Arguments]    ${locator}    ${property}
    [Documentation]    Returns a CSS property value for an element
    ${value}=    Execute JavaScript
    ...    return window.getComputedStyle(document.querySelector('${locator}')).${property}
    RETURN    ${value}

Verify Console Has No Errors
    [Documentation]    Checks browser console for JavaScript errors
    ${logs}=    Execute JavaScript
    ...    return window.__consoleErrors || []
    ${length}=    Get Length    ${logs}
    Should Be Equal As Integers    ${length}    0    Found JavaScript console errors

Open Browser To Site With Size
    [Arguments]    ${width}    ${height}
    [Documentation]    Opens browser at specific window size
    Open Browser    ${BASE_URL}    ${BROWSER}
    Set Window Size    ${width}    ${height}
    Set Selenium Implicit Wait    ${IMPLICIT_WAIT}
    Set Selenium Timeout    ${TIMEOUT}

Verify Element Has Attribute
    [Arguments]    ${locator}    ${attribute}
    [Documentation]    Verifies element has specified attribute
    ${value}=    Get Element Attribute    ${locator}    ${attribute}
    Should Not Be Equal    ${value}    ${NONE}

Verify Element Attribute Value
    [Arguments]    ${locator}    ${attribute}    ${expected_value}
    [Documentation]    Verifies element attribute has expected value
    ${value}=    Get Element Attribute    ${locator}    ${attribute}
    Should Be Equal    ${value}    ${expected_value}

Wait And Click
    [Arguments]    ${locator}    ${wait_time}=${TIMEOUT}
    [Documentation]    Waits for element to be clickable then clicks
    Wait Until Element Is Visible    ${locator}    timeout=${wait_time}
    Wait Until Element Is Enabled    ${locator}    timeout=${wait_time}
    Click Element    ${locator}

Input Text And Verify
    [Arguments]    ${locator}    ${text}
    [Documentation]    Inputs text and verifies it was entered correctly
    Input Text    ${locator}    ${text}
    ${actual}=    Get Value    ${locator}
    Should Be Equal    ${actual}    ${text}

Clear Field And Verify Empty
    [Arguments]    ${locator}
    [Documentation]    Clears a field and verifies it is empty
    Clear Element Text    ${locator}
    ${value}=    Get Value    ${locator}
    Should Be Empty    ${value}
