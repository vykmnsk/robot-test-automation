*** Settings ***
Resource   ../config.robot
Library    uuid
Library    Dialogs
Library    SeleniumLibrary
Library    ${LIB_PATH}/SeleniumLibraryExt.py
Library    Collections
Library    ${LIB_PATH}/CollectionsExt.py


*** Keywords ***
Start WebApp
    Create WebDriver for    ${BROWSER}    ${HEADLESS}

    Run Keyword If    ${WIN_WIDTH} > 0 and ${WIN_HEIGHT} >0
    ...    Set Window Size    ${WIN_WIDTH}    ${WIN_HEIGHT}
    ...    ELSE    Maximize Browser Window
    ${width}    ${height}=    Get Window Size
    Log to Console    'actual Window Size='${width}x${height}

    Delete All Cookies
    Register Keyword To Run On Failure  Capture Page Screenshot With Unique Name
    Log To Console    'SuT URL='${WEB_URL}
    Go To    ${WEB_URL}

Start WebApp and login
    Start WebApp
    Ensure on Login page
    Perform Login     ${USER}     ${PASSWORD}
    Ensure on Search page

Go to a permanent site
    Go to relative    search/permanent/1001

Start WebApp, Login, Go to a permanent site
    Start WebApp and login
    Go to a permanent site

Go to relative
    [Arguments]    ${url}
    ${full_url}=    Set Variable    ${WEB_URL}/${url}
    Log To Console    'go to URL='${full_url}
    Go To    ${full_url}

Create WebDriver for
    [Arguments]     ${browser}    ${headless}
    Run Keyword If    '${browser.upper()}' == 'CHROME'     Create Chrome WebDriver with options    ${headless}
    ...  ELSE    Create WebDriver    ${browser}

Create Chrome WebDriver with options
    [Arguments]    ${headless}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}   add_argument   --disable-infobars

    Run Keyword If    '${headless.upper()}' == 'YES'    Run Keywords
    ...    Call Method    ${options}   add_argument   --headless
    ...    AND    Call Method    ${options}   add_argument   --disable-gpu
    ...    AND    Call Method    ${options}   add_argument   --no-sandbox
    ...    AND    Call Method    ${options}   add_argument   --acceptInsecureCerts

    Create WebDriver    Chrome    chrome_options=${options}

Capture Page Screenshot With Unique Name
    ${uuid} =  uuid4
    Capture Page Screenshot  selenium-${uuid}.png

Perform Login
    [Arguments]     ${usr}  ${pwd}
    Input Text      username    ${usr}
    Input Password  pwd    ${pwd}
    Click Button    SubmitLogin
    Wait For Condition  return jQuery.active == 0

Ensure on Login page
    Title Should Be           Site login

Ensure on Search page
    Wait Until Page Contains    Engineering
    Wait Until Page Contains Element    SearchType
    Wait Until Page Contains Element    SiteList

Wait for progress bar to finish
    ${loading_animation}=   Set Variable    css:img.loadingGif
    Wait Until Page Does Not Contain Element    ${loading_animation}    timeout=30
