*** Settings ***
Documentation    Cenários de testes de pré-cadastro de clientes

Library    Browser

Resource    ../resources/base.resource

*** Test Cases ***
Deve iniciar o cadastro do cliente

    ${account}     Get Fake Account

    Start Session

    Submit signup form    ${account}

    Wait For Elements State    text=Falta pouco para fazer parte da família Smartbit!    
    ...    visible    
    ...    5


Campo nome deve ser obrigatório
    [Tags]    required

    ${account}    Create Dictionary
    ...    name=${EMPTY}
    ...    email=marcilio@teste.com
    ...    cpf=25917080100

    Start Session
    Submit signup form    ${account}
    Notice should be      Por favor informe o seu nome completo

Campo email deve ser obrigatório
    [Tags]    required

    ${account}    Create Dictionary
    ...    name=Lidia dos Anjos
    ...    email=${EMPTY}
    ...    cpf=25917080100

    Start Session
    Submit signup form    ${account}
    Notice should be      Por favor, informe o seu melhor e-mail   

Campo cpf deve ser obrigatório
    [Tags]    required

    ${account}    Create Dictionary
    ...    name=Lidia dos Anjos
    ...    email=lidia@teste.com
    ...    cpf=${EMPTY} 

    Start Session
    Submit signup form    ${account}
    Notice should be      Por favor, informe o seu CPF        

Email com formato incorreto
    [Tags]    inv

    ${account}    Create Dictionary
    ...    name=Lidia dos Anjos
    ...    email=lidia.teste.com
    ...    cpf=04941189116

    Start Session
    Submit signup form    ${account}
    Notice should be      Oops! O email informado é inválido        


CPF com formato incorreto
    [Tags]    inv

    ${account}    Create Dictionary
    ...    name=Lidia dos Anjos
    ...    email=lidia@teste.com
    ...    cpf=0494118911A

    Start Session
    Submit signup form    ${account}
    Notice should be      Oops! O CPF informado é inválido   

*** Keywords ***

Start Session
    New Browser    browser=chromium    headless=false
    New Page       http://localhost:3000/

Submit signup form
    [Arguments]    ${account}
    Get Text    css=#signup h2    equal    Faça seu cadastro e venha para a Smartbit!

    Fill Text    id=name     ${account}[name]
    Fill Text    id=email    ${account}[email]
    Fill Text    id=cpf      ${account}[cpf]

    # Click    xpath=//button[text()="Cadastrar"]
    Click    css=button >> text=Cadastrar

Notice should be
    [Arguments]    ${target}

    ${element}    Set Variable    css=form .notice
    
    Wait For Elements State    ${element}    visible    5
    
    Get Text    ${element}    equal    ${target} 