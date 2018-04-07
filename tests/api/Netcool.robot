*** Settings ***
Resource          _common.robot
Library           ${LIB_PATH}/CollectionsExt.py
Suite Setup       Setup API suite variables    ${API_URL}/netcool
Test Setup        Setup API test variables


*** Test Cases ***
topology endpoint
    [Documentation]    Check endpoint is responding
    [Tags]    ping
    Set To Dictionary    ${REQ}
    ...    Type=Topology
    ...    ResourceID=NON-EXISTENT
    ...    Direction=BOTH
    ...    ServerNameServerSerial=AUTO_TEST_01
    ...    Identifier=
    ...    RequestPriority=1
    ...    ExtendedAttributes=1
    ...    GzipEnable=0
    ${jresp} =    POST    API    /topology    ${REQ}
    Verify in JSON    ${jresp}    $..ErrorDescription    Equipment unknown

topology response attributes
    [Documentation]
    ...     Post a request with a valid resource id
    ...     Check response has required attributes
    ${resourceId}=     Set Variable    SWCMT0000019/12/4    #NP env only!

    Set To Dictionary    ${REQ}
    ...    Type=Topology
    ...    ResourceID=${resourceId}
    ...    Direction=BOTH
    ...    ServerNameServerSerial=AUTO_TEST_01
    ...    Identifier=
    ...    RequestPriority=1
    ...    ExtendedAttributes=1
    ...    GzipEnable=0
    ${jresp} =    POST    API    /topology    ${REQ}

    ${topology_path}=    Set Variable    $..Impact.Topology[0].Path[0]
    ${paths}=    Get Value From Json    ${jresp}    ${topology_path}
    ${paths_cnt}    Get Length    ${paths}
    Should Be True    ${paths_cnt} > 0    msg=No topology data at ${topology_path} in ${jresp}
    ${attributes}=    Get Dictionary Keys    ${paths[0]}

    ${expected_attributes}=    Create List
    ...    EquipmentType
    ...    CardType
    ...    ResourceId
    ...    LogicalName
    ...    PhysicalName
    ...    SiteCode
    ...    SiteType
    ...    SiteName
    ...    IPAddress
    ...    RackLocation
    ...    Lat
    ...    Lng
    ...    CardName
    ...    RFSegmentName

    List Should Contain Sub List    ${attributes}    ${expected_attributes}

*** Keywords ***
Setup API test variables
    &{default} =       Create Dictionary    User=${USER}    Password=${PASSWORD}
    Set Test Variable   ${REQ}   ${default}
