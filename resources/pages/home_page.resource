*** Settings ***
Resource    ../common/common.resource

*** Variables ***
${HOME_PAGE_TITLE}          css:h1, css:.hero-title, css:.main-title
${HOME_BANNER}              css:.banner, css:.hero-section, css:.carousel
${HOME_FEATURED_PRODUCTS}   css:.featured-products, css:.product-list, css:.products
${HOME_PRODUCT_CARD}        css:.product-card, css:.card
${HOME_SEARCH_INPUT}        css:input[type="search"], css:input[placeholder*="Search"], css:.search-input
${HOME_SEARCH_BUTTON}       css:button[type="submit"], css:.search-btn, css:.btn-search
${HOME_CATEGORY_LINKS}      css:.category, css:.categories a
${HOME_FOOTER}              css:footer

*** Keywords ***
Verify Home Page Is Loaded
    [Documentation]    Verifies that the home page has loaded successfully
    Wait For Page To Load
    Title Should Not Be    ${EMPTY}

Verify Navigation Bar Is Present
    [Documentation]    Checks that the navigation bar is displayed
    Element Should Be Visible On Page    css:nav, css:.navbar

Verify Footer Is Present
    [Documentation]    Checks that the footer section is displayed
    Element Should Be Visible On Page    ${HOME_FOOTER}

Search For Product
    [Arguments]    ${search_term}
    [Documentation]    Searches for a product using the search bar
    Wait Until Element Is Visible    ${HOME_SEARCH_INPUT}    timeout=${TIMEOUT}
    Input Text    ${HOME_SEARCH_INPUT}    ${search_term}
    Click Element    ${HOME_SEARCH_BUTTON}
    Wait For Page To Load

Get Number Of Product Cards
    [Documentation]    Returns the count of product cards displayed
    ${count}=    Get Element Count    ${HOME_PRODUCT_CARD}
    RETURN    ${count}

Verify Products Are Displayed
    [Documentation]    Verifies that at least one product is displayed
    ${count}=    Get Number Of Product Cards
    Should Be True    ${count} > 0    No products found on the page

Click On First Product
    [Documentation]    Clicks on the first product card
    Wait Until Element Is Visible    ${HOME_PRODUCT_CARD}    timeout=${TIMEOUT}
    Click Element    ${HOME_PRODUCT_CARD}
    Wait For Page To Load

Verify All Product Cards Have Images
    [Documentation]    Verifies every product card contains an image
    ${cards}=    Get WebElements    ${HOME_PRODUCT_CARD}
    FOR    ${card}    IN    @{cards}
        ${imgs}=    Get WebElements    css:img
        Should Be True    len($imgs) > 0    Product card missing image
    END

Verify Search Input Is Present
    [Documentation]    Verifies search input field is visible
    Element Should Be Visible On Page    ${HOME_SEARCH_INPUT}

Verify Search With Empty Query
    [Documentation]    Submits an empty search
    Wait Until Element Is Visible    ${HOME_SEARCH_INPUT}    timeout=${TIMEOUT}
    Clear Element Text    ${HOME_SEARCH_INPUT}
    Click Element    ${HOME_SEARCH_BUTTON}
    Wait For Page To Load

Verify Search With Special Characters
    [Arguments]    ${special_chars}=<script>alert(1)</script>
    [Documentation]    Tests search with special/malicious characters
    Wait Until Element Is Visible    ${HOME_SEARCH_INPUT}    timeout=${TIMEOUT}
    Input Text    ${HOME_SEARCH_INPUT}    ${special_chars}
    Click Element    ${HOME_SEARCH_BUTTON}
    Wait For Page To Load

Verify Search With No Results Term
    [Arguments]    ${term}=xyznonexistent12345
    [Documentation]    Searches with a term that should yield no results
    Search For Product    ${term}

Verify Logo Is Visible
    [Documentation]    Verifies the site logo/brand is visible
    Element Should Be Visible On Page    ${LOGO_LINK}

Click Logo To Go Home
    [Documentation]    Clicks the logo to navigate home
    Click Element    ${LOGO_LINK}
    Wait For Page To Load

Verify Category Links Are Present
    [Documentation]    Verifies category navigation links exist
    ${count}=    Get Element Count    ${HOME_CATEGORY_LINKS}
    Should Be True    ${count} > 0    No category links found

Get All Category Link Texts
    [Documentation]    Returns all category link texts
    ${elements}=    Get WebElements    ${HOME_CATEGORY_LINKS}
    ${texts}=    Create List
    FOR    ${el}    IN    @{elements}
        ${text}=    Get Text    ${el}
        Append To List    ${texts}    ${text}
    END
    RETURN    ${texts}
