*** Settings ***
Documentation    Cenários de testes do Login SAC 

Resource         ../resources/Base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve logar como gestor de Academia
    
    Go to login page
    Submit login form    sac@smartbit.com    pwd123
    User is logged       sac@smartbit.com

Não deve logar com senha incorreta
    [Tags]    inv_pass
    Go to login page
    Submit login form    sac@smartbit.com    qa@123  

    Toast should be    As credenciais de acesso fornecidas são inválidas. Tente novamente!

Não deve logar com email não cadastrado
    [Tags]    email_404
    Go to login page
    Submit login form    404@smartbit.com    qa@123  

    Toast should be    As credenciais de acesso fornecidas são inválidas. Tente novamente!    

Tentativa de login com dados incorretos
    [Template]    Login with verify notice
    ${EMPTY}              ${EMPTY}    Os campos email e senha são obrigatórios.
    ${EMPTY}              pwd123      Os campos email e senha são obrigatórios.
    marcilio@teste.com    ${EMPTY}    Os campos email e senha são obrigatórios.
    marcilio.teste.com    pwd123      Oops! O email informado é inválido

*** Keywords ***
Login with verify notice
    [Arguments]    ${email}    ${password}    ${output_message}

    Go to login page
    Submit login form    ${email}    ${password}
    Notice should be     ${output_message}