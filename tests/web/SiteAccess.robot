*** Settings ***
Resource          _common.robot
Suite Setup       Start WebApp, Login, Go to a permanent site
Suite Teardown    Close all browsers


*** Variables ***
${site_access}    css:a[href^="javascript:show_site_access"]


*** Test Cases ***
Site Access
    [Tags]    smoke
    Click Element    ${site_access}
    Select Window    new
    Wait Until Page Contains    Access Details
    Page Should Contain    Site Code:
    Page Should Contain    Purpose:
    Page Should Contain    Address:
    Page Should Contain    Site Details
    Page Should Contain    Site Contacts
    Page Should Contain    Site Access
    Page Should Contain    Power Authority

