*** Settings ***
Suite Setup       Start WebApp
Suite Teardown    Close all browsers
Resource          _common.robot

*** Test Cases ***    USER                     PASSWORD
Correct Username and Password
    [Tags]                   ping
    Ensure on Login page
    Perform Login            ${USER}           ${PASSWORD}
    Ensure on Search page
    [Teardown]               Go to relative    index/logout

Wrong Username and/or Password
    [Tags]                   smoke
    [Template]               Invalid Login
    WrongUser               ${PASSWORD}
    ${USER}                  WrongPassword
    WrongUser                WrongPassword


*** Keywords ***
Invalid Login
    [Arguments]    ${usr}    ${pwd}
    Ensure on Login page
    Perform Login    ${usr}    ${pwd}
    Wait Until Page Contains    Username/Password not correct
    Ensure on Login page
    [Teardown]    Press Key    css=body    \\27
