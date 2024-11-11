*** Settings ***
Documentation        Teste para verificar o slogan da SmartBit na Aplicaçãop WEB

Library    Browser

Resource    ../resources/Base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve Exibir o Slogan na Landing Page
    Get Text    css=.headline h2    equal    Sua Jornada Fitness Começa aqui!
    Sleep    5