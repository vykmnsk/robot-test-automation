*** Settings ***
Resource          _common.robot
Library           ${LIB_PATH}/CollectionsExt.py
Suite Setup       Setup API suite variables    ${API_URL}/dpumilestone
Test Setup        Setup API test variables


*** Test Cases ***
'update' endpoint response status
    [Documentation]    Posts to /update without errors
    [Tags]    ping
    Set To Dictionary    ${REQ}
    ...    type=DPU
    ...	   status=RETRIABLE
    ${jresp} =    POST    API    /update    ${REQ}
    Verify in JSON    ${jresp}    $.status    error
    Verify in JSON    ${jresp}    $.reason    Missing required field entityColId


*** Keywords ***
Setup API test variables
    ${default} =       Create Dictionary
    ...     user=${USER}
    ...     password=${PASSWORD}
    ...     requester=robot
    Set Test Variable   ${REQ}   ${default}
