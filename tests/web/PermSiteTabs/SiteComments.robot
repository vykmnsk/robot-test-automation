*** Settings ***
Resource          ../_common.robot
Suite Setup       Open Site Comments tab
Force Tags        SiteCommentsTab

*** Variables ***
${site_comments_tab}    SiteCommentsTab
${add_comments}    css:div#siteCommentsDiv img#showHideAddFields
${comment_type_select}    sitecommentTypes
${comment_type_edit_select}    css:#editComment select[name=COMMENT_TYPE_ID]
${comment_text_frame}    css:#sitecommentContainer iframe
${comment_text_edit_frame}    css:#editCommentContainer iframe
${comment_text_input}    css:html body
${save_button}    //div[@id="sitenewComment"]/following-sibling::div//button/span[contains(text(),"Save")]/parent::button
${save_edit_button}    //div[@id="editComment"]/following-sibling::div//button/span[contains(text(),"Save")]/parent::button
${comment_cell}    css:table#commentsTable td.comments

*** Test Cases ***
Add-Edit-Delete Site Comment
    ${uuid} =    uuid4
    ${comment_text}    Set Variable    TEST-Comment-${uuid}
    ${comment_text_edit}    Set Variable    ${comment_text}-edit
    ${comment_type}    Set Variable    AAO NE Detection
    ${comment_type_edit}    Set Variable    AAO RMB Detection
    Add Comment    ${comment_type}    ${comment_text}
    Edit Last Comment    ${comment_type_edit}    ${comment_text_edit}
    Delete Last Comment    ${comment_text_edit}

*** Keywords ***
Open Site Comments tab
    Click Link    Site Comments
    Wait for progress bar to finish
    Wait Until Page Contains    Add Comment

Add Comment
    [Arguments]    ${comment_type}    ${comment_text}
    Scroll to comments top
    Click Element    ${add_comments}
    Wait Until Page Contains    Add Comment
    Select From List By Label    ${comment_type_select}    ${comment_type}
    Select Frame    ${comment_text_frame}
    Input Text    ${comment_text_input}    ${comment_text}
    Save Add Comment
    Wait Until Element Contains    ${comment_cell}    ${comment_text}    timeout=15
    Element Should Contain    ${comment_cell}    ${comment_type}

Edit Last Comment
    [Arguments]    ${comment_type_edit}    ${comment_text_edit}
    Scroll to comments top
    Click Link    Edit
    Wait Until Page Contains    Edit Comment
    Select From List By Label    ${comment_type_edit_select}    ${comment_type_edit}
    Select Frame    ${comment_text_edit_frame}
    ${comment_text_actual}=    Get Text    ${comment_text_input}
    Should Start With    ${comment_text_edit}    ${comment_text_actual}
    ...                  msg=Landed on wrong comment
    Input Text    ${comment_text_input}    ${comment_text_edit}
    Save Edit Comment
    Wait Until Element Contains    ${comment_cell}    ${comment_text_edit}
    Element Should Contain    ${comment_cell}    ${comment_type_edit}

Delete Last Comment
    [Arguments]    ${comment_text}
    Scroll to comments top
    Page Should Contain    ${comment_text}
    Click Link    Delete
    Handle Alert
    Wait Until Page Does Not Contain    ${comment_text}

Save Add Comment
    Save Comment with    ${save_button}
    Wait for upload progress bar to finish
    Wait For Condition  return jQuery.active == 0

Save Edit Comment
    Save Comment with    ${save_edit_button}
    Wait for upload progress bar to finish

Save Comment with
    [Arguments]    ${button}
    Unselect Frame
    Click Element    ${button}
    Wait for upload progress bar to finish

Scroll to comments top
    Scroll Element Into View    ${site_comments_tab}

Wait for upload progress bar to finish
     Wait Until Element Is Not Visible    upload_progress    timeout=15
