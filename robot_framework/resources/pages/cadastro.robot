*** Settings ***
Resource          ../main.robot

*** Variables ***
${CAMPO_NOME}             id:form-nome
${CAMPO_CARGO}            id:form-cargo
${CAMPO_IMAGEM}           id:form-imagem
${CAMPO_TIME}             class:lista-suspensa
${BOTAO_CARD}             id:form-botao
${OPCAO_PROGRAMACAO}      //option[contains(.,'Programação')]
${OPCAO_FRONT}            //option[contains(.,'Front-End')]
${OPCAO_DADOS}            //option[contains(.,'Data Science')]
${OPCAO_DEVOPS}           //option[contains(.,'Devops')] 
${OPCAO_UX}               //option[contains(.,'UX e Design')]
${OPCAO_MOBILE}           //option[contains(.,'Mobile')]
${OPCAO_INOVACAO}         //option[contains(.,'Inovação e Gestão')]
${DIV_COLABORADOR}        class:colaborador
${TIME_SECTION}           xpath://section[contains(@class, 'time')]
${PARAGRAFO_ERRO_NOME}    id:form-nome-erro
${PARAGRAFO_ERRO_CARGO}   id:form-cargo-erro
${PARAGRAFO_ERRO_TIME}    id:form-times-erro
@{selecionar_times}
...                        ${OPCAO_PROGRAMACAO}
...                        ${OPCAO_FRONT}
...                        ${OPCAO_DADOS}
...                        ${OPCAO_DEVOPS}
...                        ${OPCAO_UX}
...                        ${OPCAO_MOBILE}
...                        ${OPCAO_INOVACAO}
@{div_colaboradores}
...                        xpath=//section[h3[text()='Front-End']]//div[@class='colaboradores']//div[@class='colaborador']
...                        xpath=//section[h3[text()='Programação']]//div[@class='colaboradores']//div[@class='colaborador']
...                        xpath=//section[h3[text()='Data Science']]//div[@class='colaboradores']//div[@class='colaborador']
...                        xpath=//section[h3[text()='Devops']]//div[@class='colaboradores']//div[@class='colaborador']
...                        xpath=//section[h3[text()='UX e Design']]//div[@class='colaboradores']//div[@class='colaborador']
...                        xpath=//section[h3[text()='Mobile']]//div[@class='colaboradores']//div[@class='colaborador']
...                        xpath=//section[h3[text()='Inovação e Gestão']]//div[@class='colaboradores']//div[@class='colaborador']


*** Keywords ***
Quando preencher os campos do formulário
    ${Nome}          FakerLibrary.First Name
    Input Text       ${CAMPO_NOME}           ${Nome}
    ${Cargo}         FakerLibrary.Job
    Input Text       ${CAMPO_CARGO}          ${Cargo}
    ${Imagem}        FakerLibrary.Image Url   100  100
    Input Text       ${CAMPO_IMAGEM}         ${Imagem}
    Click Element    ${CAMPO_TIME}
    Click Element    ${OPCAO_PROGRAMACAO}

E clique no botão criar card
    Click Element    ${BOTAO_CARD}

Então o card deve ser criado no time esperado
    Element Should Be Visible   ${DIV_COLABORADOR}

Quando preencher os campos do formulário e enviar 3 vezes
    FOR    ${counter}    IN RANGE    0    3
        Quando preencher os campos do formulário
        E clique no botão criar card
    END

Então identificar 3 cards no time esperado
    ${cards}    Get WebElements    ${DIV_COLABORADOR}
    Length Should Be    ${cards}    3

Quando preencher os campos do formulário e configurar 1 card em cada time disponível
    FOR    ${index}    ${time}    IN ENUMERATE    @{selecionar_times}
        Quando preencher os campos do formulário
        Click Element    ${time}
        E clique no botão criar card
    END

Então garantir que cada time possui um card criado
    ${cards}    Get WebElements    ${DIV_COLABORADOR}
    Length Should Be    ${cards}    7

    FOR    ${index}    IN RANGE    0    ${div_colaboradores.__len__()}
        Run Keyword And Continue On Failure    Element Should Be Visible    ${div_colaboradores[${index}]}
    END


Quando clicar no botão criar card sem preencher os campos
    Click Element    ${BOTAO_CARD}
Então o card não deve ser criado em nenhum no time
    Element Should Not Be Visible    ${DIV_COLABORADOR}
E as exceções devem ser apresentadas
    Element Should Be Visible               ${PARAGRAFO_ERRO_NOME}
    Element Should Be Visible               ${PARAGRAFO_ERRO_CARGO}
    Element Should Be Visible               ${PARAGRAFO_ERRO_TIME}
    ${texto_erro_nome} =    Get Text        ${PARAGRAFO_ERRO_NOME}
    Should Be Equal As Strings              ${texto_erro_nome}                O campo nome deve ser preenchido
    ${texto_erro_cargo} =    Get Text       ${PARAGRAFO_ERRO_CARGO}
    Should Be Equal As Strings              ${texto_erro_cargo}               O campo cargo deve ser preenchido
    ${texto_erro_time} =    Get Text        ${PARAGRAFO_ERRO_TIME}
    Should Be Equal As Strings              ${texto_erro_time}                Selecione um time para essa pessoa
