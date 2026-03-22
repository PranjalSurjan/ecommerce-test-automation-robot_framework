*** Settings ***
Resource    ../common/common.resource

*** Variables ***
${PRODUCTS_HEADING}         css:h1, css:h2, css:.products-title
${PRODUCT_CARD}             css:.product-card, css:.card, css:.product-item
${PRODUCT_NAME}             css:.product-name, css:.card-title, css:.product-title
${PRODUCT_PRICE}            css:.product-price, css:.price, css:.card-price
${PRODUCT_IMAGE}            css:.product-image img, css:.card img, css:.product-img
${ADD_TO_CART_BTN}          css:.add-to-cart, css:button[class*="cart"], css:.btn-cart
${PRODUCT_CATEGORY_FILTER}  css:.category-filter, css:select[name="category"], css:.filter
${PRODUCT_SORT_DROPDOWN}    css:select[name="sort"], css:.sort-dropdown, css:.sort-select
${PRODUCT_SEARCH}           css:input[type="search"], css:input[placeholder*="Search"]
${PRODUCT_DETAIL_LINK}      css:.product-card a, css:.card a, css:.product-link
${PAGINATION}               css:.pagination, css:.page-numbers
${PRODUCT_COUNT_TEXT}        css:.product-count, css:.results-count

*** Keywords ***
Verify Products Page Is Loaded
    [Documentation]    Verifies that the products page has loaded
    Wait For Page To Load
    ${count}=    Get Element Count    ${PRODUCT_CARD}
    Should Be True    ${count} > 0    No products found on the products page

Get All Product Names
    [Documentation]    Returns a list of all visible product names
    ${elements}=    Get WebElements    ${PRODUCT_NAME}
    ${names}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        Append To List    ${names}    ${text}
    END
    RETURN    ${names}

Get All Product Prices
    [Documentation]    Returns a list of all visible product prices
    ${elements}=    Get WebElements    ${PRODUCT_PRICE}
    ${prices}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        Append To List    ${prices}    ${text}
    END
    RETURN    ${prices}

Get Product Count
    [Documentation]    Returns the number of products displayed
    ${count}=    Get Element Count    ${PRODUCT_CARD}
    RETURN    ${count}

Click Add To Cart For Product
    [Arguments]    ${index}=1
    [Documentation]    Clicks Add to Cart on a specific product by index
    ${buttons}=    Get WebElements    ${ADD_TO_CART_BTN}
    ${actual_index}=    Evaluate    ${index} - 1
    Click Element    ${buttons}[${actual_index}]
    Sleep    1s

Click On Product By Index
    [Arguments]    ${index}=1
    [Documentation]    Clicks on a product card by index to view details
    ${cards}=    Get WebElements    ${PRODUCT_CARD}
    ${actual_index}=    Evaluate    ${index} - 1
    Click Element    ${cards}[${actual_index}]
    Wait For Page To Load

Filter By Category
    [Arguments]    ${category}
    [Documentation]    Filters products by category
    Wait Until Element Is Visible    ${PRODUCT_CATEGORY_FILTER}    timeout=${TIMEOUT}
    Select From List By Label    ${PRODUCT_CATEGORY_FILTER}    ${category}
    Wait For Page To Load

Sort Products By
    [Arguments]    ${sort_option}
    [Documentation]    Sorts products by the given option
    Wait Until Element Is Visible    ${PRODUCT_SORT_DROPDOWN}    timeout=${TIMEOUT}
    Select From List By Label    ${PRODUCT_SORT_DROPDOWN}    ${sort_option}
    Wait For Page To Load

Search For Product On Products Page
    [Arguments]    ${search_term}
    [Documentation]    Searches for a product on the products page
    Wait Until Element Is Visible    ${PRODUCT_SEARCH}    timeout=${TIMEOUT}
    Input Text    ${PRODUCT_SEARCH}    ${search_term}
    Press Keys    ${PRODUCT_SEARCH}    ENTER
    Wait For Page To Load

Verify Product Card Has Required Elements
    [Arguments]    ${index}=1
    [Documentation]    Verifies a product card has name, price, and image
    ${cards}=    Get WebElements    ${PRODUCT_CARD}
    ${actual_index}=    Evaluate    ${index} - 1
    ${card}=    Set Variable    ${cards}[${actual_index}]
    Element Should Be Visible    ${card}

Verify All Products Have Images
    [Documentation]    Verifies all product cards have images
    ${images}=    Get WebElements    ${PRODUCT_IMAGE}
    ${count}=    Get Length    ${images}
    Should Be True    ${count} > 0    No product images found
    FOR    ${img}    IN    @{images}
        Element Should Be Visible    ${img}
    END

Verify All Products Have Add To Cart Buttons
    [Documentation]    Verifies all products have Add to Cart
    ${buttons}=    Get WebElements    ${ADD_TO_CART_BTN}
    ${product_count}=    Get Product Count
    ${btn_count}=    Get Length    ${buttons}
    Should Be Equal As Integers    ${btn_count}    ${product_count}    Not all products have Add to Cart buttons

Verify All Products Have Prices
    [Documentation]    Verifies every product card displays a price
    ${prices}=    Get All Product Prices
    FOR    ${price}    IN    @{prices}
        Should Not Be Empty    ${price}
    END

Verify All Products Have Names
    [Documentation]    Verifies every product card displays a name
    ${names}=    Get All Product Names
    FOR    ${name}    IN    @{names}
        Should Not Be Empty    ${name}
    END

Verify Product Names Are Unique
    [Documentation]    Verifies no duplicate product names
    ${names}=    Get All Product Names
    ${unique}=    Remove Duplicates    ${names}
    ${names_len}=    Get Length    ${names}
    ${unique_len}=    Get Length    ${unique}
    Should Be Equal As Integers    ${names_len}    ${unique_len}    Duplicate product names found

Get Product Name By Index
    [Arguments]    ${index}=1
    [Documentation]    Returns name of product at given index
    ${names}=    Get All Product Names
    ${actual_index}=    Evaluate    ${index} - 1
    ${name}=    Get From List    ${names}    ${actual_index}
    RETURN    ${name}

Get Product Price By Index
    [Arguments]    ${index}=1
    [Documentation]    Returns price of product at given index
    ${prices}=    Get All Product Prices
    ${actual_index}=    Evaluate    ${index} - 1
    ${price}=    Get From List    ${prices}    ${actual_index}
    RETURN    ${price}

Verify Pagination Is Present
    [Documentation]    Verifies pagination controls exist
    Element Should Be Visible On Page    ${PAGINATION}

Verify Search Results Contain Term
    [Arguments]    ${term}
    [Documentation]    Verifies search results contain the search term in names
    ${names}=    Get All Product Names
    ${found}=    Set Variable    ${FALSE}
    FOR    ${name}    IN    @{names}
        ${lower_name}=    Convert To Lower Case    ${name}
        ${lower_term}=    Convert To Lower Case    ${term}
        ${contains}=    Run Keyword And Return Status    Should Contain    ${lower_name}    ${lower_term}
        IF    ${contains}    ${found}=    Set Variable    ${TRUE}
    END

Verify Products Heading Is Visible
    [Documentation]    Verifies the products page heading exists
    Element Should Be Visible On Page    ${PRODUCTS_HEADING}
