*** Settings ***
Resource          ../config.robot
Library           Collections
Library           RequestsLibrary
Library           JSONLibrary

*** Keywords ***
Setup API suite variables
    [Arguments]  ${api_url}
    Create Session    API    ${api_url}
    Log to Console    API=${api_url}
    &{headers} =    Create Dictionary   Content-Type=application/json
    Set Suite Variable    ${HEADERS}    ${headers}

Setup API test variables
    ${default}=    Copy Dictionary   ${AUTH}
    Set Test Variable   ${REQ}   ${default}

POST
    [Arguments]  ${session}  ${endpoint}    ${data}
    # Log To Console    POSTing data='${data}'
    ${resp} =    Post Request    ${session}   ${endpoint}   data=${data}  headers=${HEADERS}
    ${msg_with_resp}=    Set Variable    Response='${resp.text}'
    # Log To Console    Received '${msg_with_resp}'

    Should Be Equal As Strings  ${resp.status_code}  ${200}   msg=${msg_with_resp}
    Should Not Contain Any    ${resp.text}
    ...    Error Message:
    ...    error occurred
    ...    msg=${msg_with_resp}

    [Return]    ${resp.json()}

Verify in JSON
    [Arguments]   ${json}    ${path}    ${expected_value}
    ${values}=    Get Value From Json    ${json}    ${path}
    ${values_cnt}    Get Length    ${values}
    Should Be Equal As Integers   ${values_cnt}    1
    ...    msg=Expected to find 1 value but got ${values_cnt} at ${path} in ${json}

    ${value}=    Set Variable     ${values[0]}
    Should Be Equal    ${value}    ${expected_value}
    ...    msg=Expected '${expected_value}' but got '${value}' at '${path}' in '${json}'
