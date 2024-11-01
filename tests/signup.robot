*** Settings ***
Documentation    Cenários de testes de pré-cadastro de clientes

Library    Browser

Resource    ../resources/base.resource

*** Test Cases ***
Deve iniciar o cadastro do cliente

    ${account}     Get Fake Account

    New Browser    browser=chromium    headless=false
    New Page       http://localhost:3000/

    Get Text    css=#signup h2    equal    Faça seu cadastro e venha para a Smartbit!

    Fill Text    id=name     ${account}[name]
    Fill Text    id=email    ${account}[email]
    Fill Text    id=cpf      ${account}[cpf]

    # Click    xpath=//button[text()="Cadastrar"]
    Click    css=button >> text=Cadastrar

    Wait For Elements State    text=Falta pouco para fazer parte da família Smartbit!    
    ...    visible    
    ...    5