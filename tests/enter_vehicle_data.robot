*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    Chrome
${URL}        http://sampleapp.tricentis.com/101/app.php

*** Keywords ***
Open Headless Chrome Browser
    [Arguments]    ${url}
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Open Browser    ${url}    ${BROWSER}    options=${chrome_options}

*** Test Cases ***
Enter Vehicle Data
    Open Headless Chrome Browser    ${URL}
    #Open Browser    ${URL}    ${BROWSER}
    Select From List By Label    id=make    Volkswagen
    Select From List By Label    id=model    Scooter
    Input Text    id=cylindercapacity    2000
    Input Text    id=engineperformance    80
    Input Text    id=dateofmanufacture    01/01/2024
    Select From List By Label    id=fuel    Diesel
    #Click Element    css=span.ideal-radio
    Execute Javascript    document.getElementById('righthanddriveno').clic
    Select From List By Label    id=numberofseatsmotorcycle    3
    Select From List By Label    id=numberofseats    5
    Input Text    id=payload    500
    Input Text    id=totalweight    2000
    Input Text    id=listprice    50000
    Input Text    id=licenseplatenumber    BTTF1.21GW
    Input Text    id=annualmileage    21000
    Click Button    id=nextenterinsurantdata  # Updated button selector
    #[Teardown]    Close Browser

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
Select Price Option

    Execute Javascript    document.getElementById('selectplatinum').click()
    Wait Until Element Is Visible    id=nextsendquote    timeout=5s
    Click Button    id=nextsendquote

*** Test Cases ***
Send Quote
    Input Text    id=email    test@test.me
    Input Text    id=phone    12345678
    Input Text    id=username    MartyMcFly68
    Input Text    id=password    Test1324!
    Input Text    id=confirmpassword    Test1324!
    Input Text    id=Comments    Thanks!
    Click Button    id=sendemail