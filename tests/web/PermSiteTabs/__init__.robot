*** Settings ***
Resource          ../_common.robot
Suite Setup       Start WebApp, Login, Go to a permanent site
Suite Teardown    Close all browsers
Force Tags        PermSiteTabs
