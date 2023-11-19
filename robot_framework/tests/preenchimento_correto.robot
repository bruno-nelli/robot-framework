*** Settings ***
Resource        ../resources/main.robot
Test Setup      Dado que eu acesse o Organo
Test Teardown   Fechar o navegador

*** Test Cases ***
Verificar se ao preencher os campos do formulário corretamente e enviar, se os dados são inseridos corretamente
    Quando preencher os campos do formulário
    E clique no botão criar card
    Então o card deve ser criado no time esperado

Verificar se é possível criar mais de um card se preenchermos os campos corretamente
    Quando preencher os campos do formulário e enviar 3 vezes
    Então identificar 3 cards no time esperado

Verificar se é possível criar criar um card para cada time disponível
    Quando preencher os campos do formulário e configurar 1 card em cada time disponível
    Então garantir que cada time possui um card criado

