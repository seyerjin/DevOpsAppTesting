*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn

*** Variables ***
${BROWSER}    Chrome
${URL}        https://sampleapp.tricentis.com/101/app.php
${FILE_NAME}  Car.webp
${FILE_PATH}  ${CURDIR}/${FILE_NAME}

*** Keywords ***
Open Browser With Options
    [Arguments]    ${url}    ${browser}
    # Initialize options based on the browser
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions() if '${browser}' in ['Chrome', 'Opera'] else sys.modules['selenium.webdriver'].${browser.capitalize()}Options()    sys, selenium.webdriver

    # Add headless argument based on the browser
    Call Method    ${options}    add_argument    --headless
    ${actual_browser}=    Set Variable If    '${browser}' == 'Opera'    Chrome    ${browser}
    Open Browser    ${url}    ${actual_browser}    options=${options}

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
    [Arguments]    
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
    [Arguments]    
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
    #Click Button    id=open
    #Choose File    xpath=//input[@type="file"]    ${FILE_PATH}
    Input Text    id=picture    ${FILE_NAME}
    Click Button    id=nextenterproductdata

Enter Product Data
    [Arguments]    
    Input Text    id=startdate    12/01/2024
    Select From List By Label    id=insurancesum    10.000.000,00
    Select From List By Label    id=meritrating    Bonus 9
    Select From List By Label    id=damageinsurance    Full Coverage
    Execute Javascript    document.getElementById('EuroProtection').click()
    Select From List By Label    id=courtesycar    Yes
    Click Button    id=nextselectpriceoption


*** Test Cases ***
Complete Insurance Process For Silver
    Open Browser With Options    ${URL}    ${BROWSER}
    Enter Vehicle Data
    Enter Insurant Data
    Enter Product Data
    Select Price Option And Validate    silver    113.00    selectsilver
    Click Button    id=nextsendquote
    Fill Quote Form
    [Teardown]    Close Browser
Complete Insurance Process For Gold
    Open Browser With Options    ${URL}    ${BROWSER}
    Enter Vehicle Data
    Enter Insurant Data
    Enter Product Data
    Select Price Option And Validate    gold    334.00    selectgold
    Click Button    id=nextsendquote
    Fill Quote Form
    [Teardown]    Close Browser
Complete Insurance Process For Platinum
    Open Browser With Options    ${URL}    ${BROWSER}
    Enter Vehicle Data
    Enter Insurant Data
    Enter Product Data
    Select Price Option And Validate    platinum    655.00    selectplatinum
    Click Button    id=nextsendquote
    Fill Quote Form
    [Teardown]    Close Browser

Complete Insurance Process For Ultimate
    Open Browser With Options    ${URL}    ${BROWSER}
    Enter Vehicle Data
    Enter Insurant Data
    Enter Product Data
    Select Price Option And Validate    ultimate    1248.00    selectultimate
    Click Button    id=nextsendquote
    Fill Quote Form
    [Teardown]    Close Browser