*** Settings ***
Library    SeleniumLibrary
Suite Setup    Open Browser    http://automationexercise.com    Chrome

*** Variables ***
${EMAIL}              fighterxzed723@gmail.com
${PASSWORD}           123456789
${CARD_NAME}          yyyyy
${CARD_NUMBER}        4111111111111111
${CARD_CVC}           123
${CARD_EXPIRY}        12/25

*** Test Cases ***
Test Case 16: Place Order: Login before Checkout
    [Documentation]    This test case automates the process of logging in, adding products to the cart, placing an order, and deleting the account.
    [Tags]    place_order    login_checkout
    Verify Home Page    # Step 3
    Login    ${EMAIL}    ${PASSWORD}    # Steps 4 to 6
    Add Products To Cart    # Step 7
    Go To Cart Page    # Step 8 and 9
    Proceed To Checkout    # Steps 10 and 11
    Place Order    ${CARD_NAME}    ${CARD_NUMBER}    ${CARD_CVC}    ${CARD_EXPIRY}    # Steps 12 to 14
    Verify Order Success    # Step 15
    Delete Account    # Steps 16 and 17

*** Keywords ***
Verify Home Page
    Title Should Be    Automation Exercise

Login
    [Arguments]    ${email}    ${password}
    Wait Until Element Is Visible    //*[@id="header"]/div/div/div/div[2]/div/ul/li[4]/a    timeout=10s  # เพิ่มรอการแสดงของปุ่ม
    Click Link    //*[@id="header"]/div/div/div/div[2]/div/ul/li[4]/a
    Input Text    xpath=//input[@name='email']    ${email}
    Input Text    xpath=//input[@name='password']    ${password}
    Click Button    xpath=//button[@data-qa='login-button']
   

Add Products To Cart
    # เพิ่มสินค้าลงในตะกร้า (คลิกปุ่ม "Add to Cart")
    Click Element    /html/body/section[2]/div/div/div[2]/div/div[2]/div/div[1]/div[2]/div/a/i
   
Go To Cart Page
    Click Link    //*[@id="header"]/div/div/div/div[2]/div/ul/li[3]/a

Proceed To Checkout
    Click Button    xpath=//a[contains(text(),'Proceed To Checkout')]
    Page Should Contain    Address Details
    Page Should Contain    Review Your Order

Place Order
    [Arguments]    ${card_name}    ${card_number}    ${card_cvc}    ${card_expiry}
    Input Text    xpath=//textarea[@name='message']    This is a test order
    Click Button    xpath=//button[@data-qa='place-order']
    Input Text    xpath=//input[@name='name_on_card']    ${card_name}
    Input Text    xpath=//input[@name='card_number']    ${card_number}
    Input Text    xpath=//input[@name='cvc']    ${card_cvc}
    Input Text    xpath=//input[@name='expiry']    ${card_expiry}
    Click Button    xpath=//button[@data-qa='pay-button']

Verify Order Success
    Page Should Contain    Your order has been placed successfully!

Delete Account
    Click Button    xpath=//a[contains(text(),'Delete Account')]
    Page Should Contain    ACCOUNT DELETED!
    Click Button    xpath=//a[contains(text(),'Continue')]
