*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                https://sampleapp.tricentis.com/101/app.php
${REMOTE_URL}         https://appium.tdc.tricentis-cloud.com:443/v0/403b52aad7e54e5fae88576008b3b6ad/wd/hub
${BROWSER_NAME}       "chrome"

*** Keywords ***
Open Browser With Options
    [Arguments]    ${URL}  ${REMOTE_URL}
    ${options}=    Set Chrome Options
    Open Browser    ${URL}    ${BROWSER_NAME}  remote_url=${REMOTE_URL}  options=${options}

Set Chrome Options
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    set_capability    "tdc:initialScreenSize"    {'width': 1920, 'height': 1080}
    Call Method    ${chrome_options}    set_capability    "tdc:selector"    'device_skus:"Chrome"'
    Set Suite Variable    ${chrome_options}
    Return From Keyword    ${chrome_options}


Select Price Option And Validate
    [Arguments]    ${price_option}    ${expected_price}    ${pricOpts}
    Wait Until Element Is Visible    id=${pricOpts}    timeout=5s
    Execute Javascript    document.getElementById('${pricOpts}').click()
    Wait Until Element Is Visible    id=nextsendquote    timeout=5s
    ${displayed_price}=    Get Text    id=select${price_option}_price
    Log    Displayed Price for ${price_option}: ${displayed_price}
    ${converted_price}=    Evaluate    float("${displayed_price}".replace(',', ''))
    Should Be Equal As Numbers    ${converted_price}    ${expected_price}

Submit Form And Validate
    Click Button    id=sendemail
    Wait Until Page Contains    Sending e-mail success!    timeout=10s

Fill Quote Form
    Input Text    id=email    test@test.me
    Input Text    id=phone    12345678
    Input Text    id=username    MartyMcFly68
    Input Text    id=password    Test1324!
    Input Text    id=confirmpassword    Test1324!
    Input Text    id=Comments    Thanks!
    Submit Form And Validate

Enter Vehicle Data
    Select From List By Label    id=make    Volkswagen
    Select From List By Label    id=model    Scooter
    Input Text    id=cylindercapacity    2000
    Input Text    id=engineperformance    80
    Input Text    id=dateofmanufacture    01/01/2024
    Select From List By Label    id=numberofseats    5
    Select From List By Label    id=fuel    Diesel
    Execute Javascript    document.getElementById('righthanddriveno').click()
    Select From List By Label    id=numberofseatsmotorcycle    3
    Input Text    id=payload    500
    Input Text    id=totalweight    2000
    Input Text    id=listprice    50000
    Input Text    id=licenseplatenumber    BTTF1.21GW
    Input Text    id=annualmileage    21000
    Click Button    id=nextenterinsurantdata

Enter Insurant Data
    Input Text    id=firstname     Marty
    Input Text    id=lastname      McFly
    Input Text    id=birthdate    01/01/1968
    Execute Javascript    document.getElementById('gendermale').click()
    Input Text    id=streetaddress    Roslyndale Avenue 1
    Select From List By Label    id=country    United States
    Input Text    id=zipcode    9303
    Input Text    id=city    Hill Valley
    Select From List By Label    id=occupation    Employee
    Execute Javascript    document.getElementById('cliffdiving').click()
    Execute Javascript    document.getElementById('bungeejumping').click()
    Input Text    id=website    https://www.backtothefuture.com/
    Click Button    id=open
    Click Button    id=nextenterproductdata

Enter Product Data
    Input Text    id=startdate    12/01/2024
    Select From List By Label    id=insurancesum    10.000.000,00
    Select From List By Label    id=meritrating    Bonus 9
    Select From List By Label    id=damageinsurance    Full Coverage
    Execute Javascript    document.getElementById('EuroProtection').click()
    Select From List By Label    id=courtesycar    Yes
    Click Button    id=nextselectpriceoption

*** Test Cases ***
Complete Insurance Process For Silver
    Open Browser With Options    ${URL}    ${REMOTE_URL}
    Enter Vehicle Data
    Enter Insurant Data
    Enter Product Data
    Select Price Option And Validate    silver    113.00    selectsilver
    Click Button    id=nextsendquote
    Fill Quote Form
    [Teardown]    Close Browser
