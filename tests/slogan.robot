*** Settings ***
Documentation        Teste para verificar o slogan da SmartBit na Aplicaçãop WEB

Library    Browser

*** Test Case ***
Deve Exibir o Slogan na Landing Page
    New Browser    browser=chromium    headless=false
    New Page    http://localhost:3000/
    Get Text    css=.headline h2    equal    Sua Jornada Fitness Começa aqui!
    Sleep    5