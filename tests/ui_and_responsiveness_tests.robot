*** Settings ***
Documentation    UI, Responsiveness and Cross-Cutting Tests for TesterBud E-Commerce Website
Resource         ../resources/pages/home_page.resource
Resource         ../resources/pages/products_page.resource
Resource         ../resources/pages/login_page.resource
Resource         ../resources/pages/cart_page.resource
Suite Teardown   Close Test Browser

*** Test Cases ***
# ==================== RESPONSIVE DESIGN - MOBILE ====================

Verify Home Page On Mobile Viewport
    [Documentation]    Verify home page renders on mobile screen size
    [Tags]    responsive    mobile    ui
    Open Browser To Site With Size    375    812
    Verify Home Page Is Loaded
    Close Test Browser

Verify Navigation On Mobile Viewport
    [Documentation]    Verify navigation is accessible on mobile
    [Tags]    responsive    mobile    ui
    Open Browser To Site With Size    375    812
    Verify Navigation Bar Is Present
    Close Test Browser

Verify Products Page On Mobile Viewport
    [Documentation]    Verify products page renders on mobile
    [Tags]    responsive    mobile    ui
    Open Browser To Site With Size    375    812
    Navigate To Products Page
    ${count}=    Get Product Count
    Should Be True    ${count} > 0
    Close Test Browser

Verify Login Page On Mobile Viewport
    [Documentation]    Verify login form is usable on mobile
    [Tags]    responsive    mobile    ui
    Open Browser To Site With Size    375    812
    Navigate To Login Page
    Verify Login Page Is Loaded
    Close Test Browser

# ==================== RESPONSIVE DESIGN - TABLET ====================

Verify Home Page On Tablet Viewport
    [Documentation]    Verify home page renders on tablet screen size
    [Tags]    responsive    tablet    ui
    Open Browser To Site With Size    768    1024
    Verify Home Page Is Loaded
    Close Test Browser

Verify Products Page On Tablet Viewport
    [Documentation]    Verify products page renders on tablet
    [Tags]    responsive    tablet    ui
    Open Browser To Site With Size    768    1024
    Navigate To Products Page
    ${count}=    Get Product Count
    Should Be True    ${count} > 0
    Close Test Browser

Verify Login Page On Tablet Viewport
    [Documentation]    Verify login page renders on tablet
    [Tags]    responsive    tablet    ui
    Open Browser To Site With Size    768    1024
    Navigate To Login Page
    Verify Login Page Is Loaded
    Close Test Browser

# ==================== RESPONSIVE DESIGN - SMALL DESKTOP ====================

Verify Home Page On Small Desktop Viewport
    [Documentation]    Verify home page on 1024x768 resolution
    [Tags]    responsive    desktop    ui
    Open Browser To Site With Size    1024    768
    Verify Home Page Is Loaded
    Close Test Browser

# ==================== RESPONSIVE DESIGN - LARGE DESKTOP ====================

Verify Home Page On Large Desktop Viewport
    [Documentation]    Verify home page on 1920x1080 resolution
    [Tags]    responsive    desktop    ui
    Open Browser To Site With Size    1920    1080
    Verify Home Page Is Loaded
    Close Test Browser

# ==================== IMAGE INTEGRITY ACROSS PAGES ====================

Verify No Broken Images On Home Page
    [Documentation]    Check home page for broken images
    [Tags]    ui    integrity    images
    Open Browser To Site
    Verify No Broken Images On Page
    Close Test Browser

Verify No Broken Images On Products Page
    [Documentation]    Check products page for broken images
    [Tags]    ui    integrity    images
    Open Browser To Site
    Navigate To Products Page
    Verify No Broken Images On Page
    Close Test Browser

# ==================== LINK INTEGRITY ====================

Verify All Links On Home Page Have Href
    [Documentation]    Check all home page links are valid
    [Tags]    ui    integrity    links
    Open Browser To Site
    Verify All Links Have Href
    Close Test Browser

Verify All Links On Products Page Have Href
    [Documentation]    Check all products page links are valid
    [Tags]    ui    integrity    links
    Open Browser To Site
    Navigate To Products Page
    Verify All Links Have Href
    Close Test Browser

# ==================== PAGE LOAD AND REFRESH ====================

Verify Home Page Refresh
    [Documentation]    Verify home page loads after refresh
    [Tags]    ui    functional    stability
    Open Browser To Site
    Refresh Page
    Verify Home Page Is Loaded
    Close Test Browser

Verify Products Page Refresh
    [Documentation]    Verify products page loads after refresh
    [Tags]    ui    functional    stability
    Open Browser To Site
    Navigate To Products Page
    Refresh Page
    Verify Products Page Is Loaded
    Close Test Browser

Verify Login Page Refresh
    [Documentation]    Verify login page loads after refresh
    [Tags]    ui    functional    stability
    Open Browser To Site
    Navigate To Login Page
    Refresh Page
    Verify Login Page Is Loaded
    Close Test Browser

Verify Cart Page Refresh
    [Documentation]    Verify cart page loads after refresh
    [Tags]    ui    functional    stability
    Open Browser To Site
    Navigate To Cart Page
    Refresh Page
    Verify Cart Page Is Loaded
    Close Test Browser

# ==================== MULTIPLE TAB TESTS ====================

Verify Site Opens In New Tab
    [Documentation]    Verify site can be opened in a new browser tab
    [Tags]    ui    functional    tabs
    Open Browser To Site
    Open Site In New Tab
    Verify Home Page Is Loaded
    Close Test Browser

# ==================== SCROLL TESTS ====================

Verify Scroll To Footer On Home Page
    [Documentation]    Verify user can scroll to footer
    [Tags]    ui    scroll
    Open Browser To Site
    Scroll To Element    ${HOME_FOOTER}
    Verify Footer Is Present
    Close Test Browser

Verify Scroll To Footer On Products Page
    [Documentation]    Verify user can scroll to footer on products
    [Tags]    ui    scroll
    Open Browser To Site
    Navigate To Products Page
    Scroll To Element    ${HOME_FOOTER}
    Verify Footer Is Present
    Close Test Browser
