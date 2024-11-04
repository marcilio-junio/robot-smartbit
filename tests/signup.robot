*** Settings ***
Documentation    Cenários de testes de pré-cadastro de clientes

Resource    ../resources/Base.resource

Test Setup    Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve iniciar o cadastro do cliente

    ${account}     Get Fake Account

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

    Submit signup form    ${account}
    Notice should be      Por favor informe o seu nome completo

Campo email deve ser obrigatório
    [Tags]    required

    ${account}    Create Dictionary
    ...    name=Lidia dos Anjos
    ...    email=${EMPTY}
    ...    cpf=25917080100

    Submit signup form    ${account}
    Notice should be      Por favor, informe o seu melhor e-mail   

Campo cpf deve ser obrigatório
    [Tags]    required

    ${account}    Create Dictionary
    ...    name=Lidia dos Anjos
    ...    email=lidia@teste.com
    ...    cpf=${EMPTY} 

    Submit signup form    ${account}
    Notice should be      Por favor, informe o seu CPF        

Email com formato incorreto
    [Tags]    inv

    ${account}    Create Dictionary
    ...    name=Lidia dos Anjos
    ...    email=lidia.teste.com
    ...    cpf=04941189116

    Submit signup form    ${account}
    Notice should be      Oops! O email informado é inválido        

CPF com formato incorreto
    [Tags]    inv

    ${account}    Create Dictionary
    ...    name=Lidia dos Anjos
    ...    email=lidia@teste.com
    ...    cpf=0494118911A

    Submit signup form    ${account}
    Notice should be      Oops! O CPF informado é inválido