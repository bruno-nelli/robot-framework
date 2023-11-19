*** Settings ***
Resource    ../main.robot

*** Variables ***
${loginUrl}       http://localhost:3000/
${browser}        chrome

*** Keywords ***
Dado que eu acesse o Organo
    Open Browser    url=${loginUrl}    browser=${browser}    options=add_argument("--ignore-certificate-errors")

Fechar o navegador
    Close Browser