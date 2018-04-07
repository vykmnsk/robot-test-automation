*** Settings ***
Resource          ../_common.robot
Suite Setup       Open Equipment Config tab
Suite Teardown    Go to a permanent site
Test Setup        Scroll to tab top
Force Tags        EquipConfigTab


*** Variables ***
${equipment_status}     equipmentStatus
${active_equipment_item}     css:ul.siteBoxList li[insttype=Site]
${rack_item}            css:ul.boxRackList li[insttype=Rack]
${box_item}             css:ul.boxBoxList li[insttype=Box]
${card_item}            css:ul.boxCardList li[insttype=Card]
${port_item}            css:ul.boxCardList li[insttype=Port]

${right_panel}    boxDispPanel_Editor
${right_panel_form_labels}    css:#boxDispPanel_Editor form label
${right_panel_table_headers}    css:#boxDispPanel_Editor table#gridViewData tr th


*** Test Cases ***
Active Equipment input form
    [Tags]    smoke
    Click Element    ${active_equipment_item} div
    Wait for progress bar to finish

    Wait Until Element Contains    ${right_panel}    Generate Configuration Scripts
    ${form_labels}=    Get all texts    ${right_panel_form_labels}
    Should Contain    ${form_labels}    Template Package Version    ignore_case=True
    Should Contain    ${form_labels}    Comments    ignore_case=True

    ${headers}=    Get all texts    ${right_panel_table_headers}
    ${expected_headers}=    Create List
    ...    File name
    ...    Version
    ...    Created Date
    ...    Created By
    ...    Comments
    ...    Actions
    List Should Contain Sub List    ${headers}    ${expected_headers}


Rack Item input form
    Expand Tree Element    ${active_equipment_item}
    Click Element    ${rack_item}
    Wait for progress bar to finish

    Wait Until Element Contains    ${right_panel}    Rack (
    ${form_labels}=    Get all texts    ${right_panel_form_labels}
    ${expected_form_labels}=    Create List
    ...    Main Type
    ...    Telstra Type
    ...    LOD Rack
    ...    Floor
    ...    Suite
    ...    Rack
    ...    Physical Name
    ...    Physical Name Extn
    ...    ALT Physical Name
    ...    ALT Physical Name Extn
    ...    In Service Date
    List Should Contain Sub List    ${form_labels}    ${expected_form_labels}

Box Item input form
    Expand Tree Element    ${active_equipment_item}
    Expand Tree Element    ${rack_item}
    Wait Until Element Is Visible    ${box_item}
    Click Element    ${box_item}

    Wait Until Element Contains    ${right_panel}    Box (
    ${form_labels}=    Get all texts    ${right_panel_form_labels}
    ${expected_form_labels}=    Create List
    ...    Logical Name
    ...    Physical Name
    ...    Physical Name Extension
    ...    Sub Rack Position
    ...    Status
    List Should Contain Sub List    ${form_labels}    ${expected_form_labels}

Card Item input form
    Expand Tree Element    ${active_equipment_item}
    Expand Tree Element    ${rack_item}
    Wait Until Element Is Visible    ${box_item}
    Expand Tree Element    ${box_item}
    Wait Until Element Is Visible    ${card_item}
    Click Element    ${card_item}

    Wait Until Element Contains    ${right_panel}    Card (
    ${form_labels}=    Get all texts    ${right_panel_form_labels}
    ${expected_form_labels}=    Create List
    ...    Name
    ...    Slot
    ...    NDD Name
    ...    Status
    List Should Contain Sub List    ${form_labels}    ${expected_form_labels}

Port Item input form
    Expand Tree Element    ${active_equipment_item}
    Expand Tree Element    ${rack_item}
    Wait Until Element Is Visible    ${box_item}
    Expand Tree Element    ${box_item}
    Wait Until Element Is Visible    ${card_item}
    Expand Tree Element    ${card_item}
    Wait Until Element Is Visible    ${port_item}
    Click Element    ${port_item}

    Wait Until Element Contains    ${right_panel}    Port (
    ${form_labels}=    Get all texts    ${right_panel_form_labels}
    Should Contain    ${form_labels}    Status


*** Keywords ***
Open Equipment Config tab
    Click Link    Equipment Config
    Wait for progress bar to finish
    Wait Until Page Contains    Active Equipment

Expand Tree Element
    [Arguments]    ${element}
    ${arrow}=    Set Variable    ${element} span
    ${class}=    Get Element Attribute     ${arrow}   attribute=class
    Run Keyword If    'collapse' in '${class}'    Click Element     ${arrow}
    Wait For Condition  return jQuery.active == 0

Scroll to tab top
    Scroll Element Into View    ${equipment_status}
