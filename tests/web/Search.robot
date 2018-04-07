*** Settings ***
Resource          _common.robot
Test Setup        Start WebApp and login
Test Teardown     Close all browsers
Test Template     Search Site


*** Variables ***
${search_results_loc}    css:ul.ui-autocomplete li a


*** Test Cases ***
Search Permanent 1
    [Tags]    smoke
    MELB

Search Permanent 2
    SYD

Search Permanent 3
    BRISB


*** Keywords ***
Search Site
    [Arguments]    ${sitecode}
    Ensure on Search page
    Input text    SiteList    ${sitecode}
    Wait Until Element Is Visible    ${search_results_loc}    timeout=10
    ${result_count}=    Get Element Count    ${search_results_loc}
    Should Be True    ${result_count} > 0
    ...               msg=Number of sites: ${result_count} is less than expected
    @{result_texts}    Get All Texts    ${search_results_loc}
    Should All Match    ${result_texts}    *${sitecode}*    msg=Search Results
    Click Link    partial link:${sitecode}
    Title Should Be    Site ${sitecode}
