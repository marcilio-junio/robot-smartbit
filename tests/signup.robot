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


Campo nome deve ser obrigatório
    [Tags]    required

    New Browser    browser=chromium    headless=false
    New Page       http://localhost:3000/

    Get Text    css=#signup h2    equal    Faça seu cadastro e venha para a Smartbit!

    Fill Text    id=email    marcilio@teste.com
    Fill Text    id=cpf      34108429001

    Click    css=button >> text=Cadastrar

    Wait For Elements State    css=form .notice    visible    5
    
    Get Text    css=form .notice    equal    Por favor informe o seu nome completo

Campo email deve ser obrigatório
    [Tags]    required

    New Browser    browser=chromium    headless=false
    New Page       http://localhost:3000/

    Get Text    css=#signup h2    equal    Faça seu cadastro e venha para a Smartbit!

    Fill Text    id=name     marcilio junio
    Fill Text    id=cpf      34108429001

    Click    css=button >> text=Cadastrar

    Wait For Elements State    css=form .notice    visible    5
    
    Get Text    css=form .notice    equal    Por favor, informe o seu melhor e-mail   

Campo cpf deve ser obrigatório
    [Tags]    required

    New Browser    browser=chromium    headless=false
    New Page       http://localhost:3000/

    Get Text    css=#signup h2    equal    Faça seu cadastro e venha para a Smartbit!

    Fill Text    id=name     marcilio junio
    Fill Text    id=email    marcilio@teste.com

    Click    css=button >> text=Cadastrar

    Wait For Elements State    css=form .notice    visible    5
    
    Get Text    css=form .notice    equal    Por favor, informe o seu CPF        

Email com formato incorreto
    [Tags]    inv

    New Browser    browser=chromium    headless=false
    New Page       http://localhost:3000/

    Get Text    css=#signup h2    equal    Faça seu cadastro e venha para a Smartbit!

    Fill Text    id=name     marcilio junio
    Fill Text    id=email    marcilio*teste.com
    Fill Text    id=cpf      34108429001

    Click    css=button >> text=Cadastrar

    Wait For Elements State    css=form .notice    visible    5
    
    Get Text    css=form .notice    equal    Oops! O email informado é inválido        


CPF com formato incorreto
    [Tags]    inv

    New Browser    browser=chromium    headless=false
    New Page       http://localhost:3000/

    Get Text    css=#signup h2    equal    Faça seu cadastro e venha para a Smartbit!

    Fill Text    id=name     marcilio junio
    Fill Text    id=email    marcilio@teste.com
    Fill Text    id=cpf      0366405918a

    Click    css=button >> text=Cadastrar

    Wait For Elements State    css=form .notice    visible    5
    
    Get Text    css=form .notice    equal    Oops! O CPF informado é inválido   