*** Settings ***
Documentation    Arquivo principal do projeto Robot

Library    Browser
Library    libs/Account.py

Resource    pages/Landing.resource 

*** Keywords ***
Start Session
    New Browser    browser=chromium    headless=false
    New Page       http://localhost:3000/