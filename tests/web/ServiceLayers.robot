*** Settings ***
Resource   _common.robot
Suite Setup      Go to Service Layers and Search
Suite Teardown   Close all browsers


*** Variables ***
${main_menu}    mainMenu
${state_filter}    slStateFilter
${search_results}    serviceLayerList
${results_rows}    css:table#slList tr
${button_bar}    css:div.DTTT_container a span

*** Test Cases ***
Service search results Table
    [Tags]    smoke
    Page Should Contain Element    ${search_results}
    ${results_count}=    Get Element Count    ${results_rows}
    Should Be True    ${results_count} > 1

Service search results Buttons
    ${btn_labels}=    Get all texts    ${button_bar}
    ${expected_btn_labels}=    Create List
    ...    Copy
    ...    CSV
    ...    Excel
    ...    PDF
    ...    Print
    List Should Contain Sub List    ${btn_labels}    ${expected_btn_labels}


*** Keywords ***
Go to Service Layers and Search
    Start WebApp and login
    List services    NT

List services
    [Arguments]    ${state}
    Go to relative   servicelayer/index
    Select From List By Label    ${state_filter}    ${state}
    Click Button    List
    Wait for progress bar to finish

