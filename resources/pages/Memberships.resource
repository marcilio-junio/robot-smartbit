*** Settings ***
Documentation    Ações e elementos da página de Matrículas

Library    Browser

*** Keywords ***
Create new membership
    [Arguments]    ${data}
    Go to memberships form
    Select account        ${data}[account][name]       ${data}[account][cpf]
    Select plan           ${data}[plan]
    Fill payment card     ${data}[credit_card]

    Click    css=button[type=submit] >> text=Cadastrar
    
Go to memberships form    
    Click    css=[href="/memberships/new"]
    Wait For Elements State    css=h1 >> text=Nova matrícula
    ...    visible    5

Select account
    [Arguments]    ${name}    ${cpf}
    
    Fill Text    css=input[aria-label=select_account]    ${name}
    Click        css=[data-testid="${cpf}"]

Select plan    
    [Arguments]    ${plan_name}
    Fill Text    css=input[aria-label=select_plan]    ${plan_name}
    Click        css=div[class$=option] >> text=${plan_name}

Fill payment card
    [Arguments]    ${credit_card}

    Fill Text    css=input[name=card_number]    ${credit_card}[number]
    Fill Text    css=input[name=card_holder]    ${credit_card}[holder]
    Fill Text    css=input[name=card_month]     ${credit_card}[month]
    Fill Text    css=input[name=card_year]      ${credit_card}[year]
    Fill Text    css=input[name=card_cvv]       ${credit_card}[cvv]