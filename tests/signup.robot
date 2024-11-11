*** Settings ***
Documentation    Cenários de testes de pré-cadastro de clientes

Resource    ../resources/Base.resource

Test Setup    Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve iniciar o cadastro do cliente
    [Tags]    smoke

    ${account}     Create Dictionary
    ...            name=Marcilio Junio
    ...            email=marciliojunio@teste.com
    ...            cpf=17393873095

    Delete Account By Email    ${account}[email]

    Submit signup form    ${account} 
    Verify welcome message

Tentativa de pré-cadastro
    [Template]    Attempt signup
    ${EMPTY}            marcilio@teste.com    25917080100    Por favor informe o seu nome completo
    marcilio borges     ${EMPTY}              39311430153    Por favor, informe o seu melhor e-mail 
    isaina cristina     isaina@teste.com      ${EMPTY}       Por favor, informe o seu CPF 
    isabel pereira      isabel.teste.com      39311430153    Oops! O email informado é inválido
    Lucas Henrique      lucas@teste.com       3931143015A    Oops! O CPF informado é inválido          

*** Keywords ***
Attempt signup
    [Arguments]    ${name}    ${email}    ${cpf}    ${output_message}

    ${account}    Create Dictionary
    ...    name=${name} 
    ...    email=${email}
    ...    cpf=${cpf}

    Submit signup form    ${account}
    Notice should be      ${output_message}