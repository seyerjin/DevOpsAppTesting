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

    # Add headless argument based on the browser
    #Run Keyword If    '${browser}' in ['Chrome', 'Opera']    Call Method    ${options}    add_argument    --headless
    Run Keyword If    '${browser}' == 'Firefox'    Call Method    ${options}    add_argument    --headless
    Run Keyword If    '${browser}' == 'Edge'    Call Method    ${options}    add_argument    --headless
    #Run Keyword If    '${browser}' == 'Safari'    Call Method    ${options}    add_argument    --headless
    
    ${actual_browser}=    Set Variable If    '${browser}' == 'Opera'    Chrome    ${browser}
    Open Browser    ${url}    ${actual_browser}    options=${options}
    #Open Browser    ${url}    ${browser}    options=${options}

Select Price Option And Validate
    [Arguments]    ${price_option}
    Execute Javascript    document.getElementById('select${price_option}').click()
    ${price_per_year}=    Get Text    xpath=//table[@id='priceTable']//td[contains(text(), 'Price per Year')]/following-sibling::td[contains(text(), '${price_option}')]
    Log    Price Per Year for ${price_option}: ${price_per_year}

Submit Form And Validate
    Click Button    id=sendemail
    Wait Until Page Contains    Sending e-mail success!    timeout=10s

*** Test Cases ***
Enter Vehicle Data
    Open Browser With Options    ${URL}    ${BROWSER}
    #Open Browser    ${URL}    ${BROWSER}
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
    # Extract the displayed price for Platinum
    ${displayed_price}=    Get Text    id=selectplatinum_price
    Log    Displayed Price: ${displayed_price}
    # Define the expected price based on your calculation
    ${expected_price}=    Set Variable    655.00  # Replace with the actual expected value
    # Verify the price
    Should Be Equal As Numbers    ${displayed_price}    ${expected_price}
    Click Button    id=nextsendquote

*** Test Cases ***
Send Quote
    Input Text    id=email    test@test.me
    Input Text    id=phone    12345678
    Input Text    id=username    MartyMcFly68
    Input Text    id=password    Test1324!
    Input Text    id=confirmpassword    Test1324!
    Input Text    id=Comments    Thanks!
    Wait Until Element Is Visible    id=sendemail    timeout=10s
    #Click Button    id=sendemail
    Submit Form And Validate
    [Teardown]    Close Browser