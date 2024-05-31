*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    Chrome
${URL}        https://sampleapp.tricentis.com/101/app.php

*** Keywords ***
Open Browser With Options
    [Arguments]    ${url}    ${browser}
    # Initialize options based on the browser
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions() if '${browser}' in ['Chrome', 'Opera'] else sys.modules['selenium.webdriver'].${browser.capitalize()}Options()    sys, selenium.webdriver

    #Add headless argument based on the browser
    Call Method    ${options}    add_argument    --headless
    #${actual_browser}=    Set Variable If    '${browser}' == 'Opera'    Chrome    ${browser}
    #Open Browser    ${url}    ${actual_browser}    options=${options}
    Open Browser    ${url}    ${browser}    options=${options}
Select Price Option And Validate
    [Arguments]    ${price_option}    ${expected_price}    ${pricOpts}
    Wait Until Element Is Visible    id=${pricOpts}    timeout=5s
    Execute Javascript    document.getElementById('${pricOpts}').click()
    Wait Until Element Is Visible    id=nextsendquote    timeout=5s
    ${displayed_price}=    Get Text    id=select${price_option}_price
    Log    Displayed Price for ${price_option}: ${displayed_price}
    Should Be Equal As Numbers    ${displayed_price}    ${expected_price}

Submit Form And Validate
    Click Button    id=sendemail
    Wait Until Page Contains    Sending e-mail success!    timeout=10s

*** Test Cases ***
Enter Vehicle Data
    Open Browser With Options    ${URL}    ${BROWSER}
    Select From List By Label    id=make    Volkswagen
    Select From List By Label    id=model    Scooter
    Input Text    id=cylindercapacity    2000
    Input Text    id=engineperformance    80
    Input Text    id=dateofmanufacture    01/01/2024
    Select From List By Label    id=numberofseats    5
    Select From List By Label    id=fuel    Diesel
    Execute Javascript    document.getElementById('righthanddriveno').click()
    #Click Element    css=span.ideal-radio
    Select From List By Label    id=numberofseatsmotorcycle    3
    Input Text    id=payload    500
    Input Text    id=totalweight    2000
    Input Text    id=listprice    50000
    Input Text    id=licenseplatenumber    BTTF1.21GW
    Input Text    id=annualmileage    21000
    Click Button    id=nextenterinsurantdata  # Updated button selector

*** Test Cases ***
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
    Input Text    id=picture    .\tests\car.webp
    Click Button    id=nextenterproductdata    

*** Test Cases ***
Enter Product Data
    Input Text    id=startdate    12/01/2024
    Select From List By Label    id=insurancesum    10.000.000,00
    Select From List By Label    id=meritrating    Bonus 9
    Select From List By Label    id=damageinsurance    Full Coverage
    Execute Javascript    document.getElementById('EuroProtection').click()
    Select From List By Label    id=courtesycar    Yes
    Click Button    id=nextselectpriceoption   
    
*** Test Cases ***
Select Price Option - Platinum
    Select Price Option And Validate    platinum    655.00    selectplatinum
    Wait Until Element Is Visible    id=selectgold    timeout=5s

Select Price Option - Gold
    Select Price Option And Validate    gold    334.00    selectgold
    Wait Until Element Is Visible    id=selectsilver    timeout=5s

Select Price Option - Silver
    Select Price Option And Validate    silver    113.00    selectsilver
    Click Button    id=nextsendquote

*** Test Cases ***
Send Quote
    Input Text    id=email    test@test.me
    Input Text    id=phone    12345678
    Input Text    id=username    MartyMcFly68
    Input Text    id=password    Test1324!
    Input Text    id=confirmpassword    Test1324!
    Input Text    id=Comments    Thanks!
    Submit Form And Validate
    [Teardown]    Close Browser