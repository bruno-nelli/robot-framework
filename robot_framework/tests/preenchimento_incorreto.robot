*** Settings ***
Resource        ../resources/main.robot
Test Setup      Dado que eu acesse o Organo
Test Teardown   Fechar o navegador

*** Test Cases ***
Verificar se ao preencher os campos do formulário incorretamente e enviar, não serão inseridos dados no card e apresentará as mensagens de erro
    Quando clicar no botão criar card sem preencher os campos
    Então o card não deve ser criado em nenhum no time
    E as exceções devem ser apresentadas

