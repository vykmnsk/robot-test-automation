*** Settings ***
Resource          _common.robot
Library           ${LIB_PATH}/CollectionsExt.py
Suite Setup       Setup API suite variables    ${API_URL}/ams
Test Setup        Setup API test variables

*** Test Cases ***
amsGetSystemInfo response OK
    [Tags]    ping
    ${jresp} =    POST    API    /amsGetSystemInfo    ${REQ}
    Verify in JSON    ${jresp}    $.status    ok

amsGetSystemInfo invalid credentials
    [Documentation]    Verify response status=error
    [Tags]    smoke
    [Template]           POST with invalid credentials
    /amsGetSystemInfo    WrongUser       ${PASSWORD}
    /amsGetSystemInfo    ${USER}         WrongPassword
    /amsGetSystemInfo    WrongUser       WrongPassword

amsGetSystemInfo clusterStatus
    [Tags]    smoke
    [Documentation]    Verify response clusterStatus value
    ${jresp} =    POST    API    /amsGetSystemInfo    ${REQ}
    Dictionary Should Contain Item    ${jresp['results']}    clusterStatus    Cluster

amsGetSystemInfo server IP addresses
    [Documentation]    Verify response server values are valid IP adresses
    ${jresp} =    POST    API    /amsGetSystemInfo    ${REQ}
    ${servers}=    Get Value From Json    ${jresp}    $..results..server
    Comment    ${total_servers}=    Get Length    ${servers}
    Comment    ${matching_servers}    Get Match Count    ${servers}    172.*
    Comment    Should Be Equal As Integers    ${total_servers}    ${matching_servers}
    Should All Match    ${servers}    regexp=172\\.\\d{1,3}\.\\d{1,3}\\.\\d{1,3}    IP addresses


*** Keywords ***
Setup API test variables
    &{default}=     Create Dictionary
    ...     user=${USER}
    ...     password=${PASSWORD}
    ...     requester=robot
    Set Test Variable   ${REQ}   ${default}

POST with invalid credentials
    [Arguments]    ${endpoint}    ${usr}    ${pwd}
    Set To Dictionary    ${REQ}     user=${usr}
    Set To Dictionary    ${REQ}     password=${pwd}
    ${jresp}=    POST    API    ${endpoint}    ${REQ}
    Verify in JSON    ${jresp}    $.status    error
    Verify in JSON    ${jresp}    $.reason    Unauthorised

