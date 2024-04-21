*** Settings ***
Documentation       Armazenar os recursos para os testes da API Serverest
Library             RequestsLibrary
Library             String
Library             Collections
Library             FakerLibrary    locale=pt_BR

*** Variables ***
${url}        https://serverest.dev/#
${nome}       Fulano da Silva
${pass}       teste
${admin}      true
${ALIAS}      APIServerest  

*** Keywords ***
Criar Sessão
  ${headers}        Create Dictionary      accept=application/json    Content-Type=application/json
  Create Session    alias=${ALIAS}         url=${url}    headers=${headers}    disable_warnings=1

Criar um novo usuário
  ${random_word}        Generate Random String    length=5    chars=[LETTERS]
  ${random_word}        Convert To Lower Case     ${random_word}
  Set Test Variable     ${EMAIL_TEST}             ${random_word}@qacoders.com.br
  Log                   ${EMAIL_TEST}

Cadastrar um novo usuário criado
  ${body}        Create Dictionary    nome=${nome}    email=${EMAIL_TEST}   password=${pass}    administrador=${admin}
  Log            ${body}
  Criar Sessão
  ${resposta}    POST On Session    alias=${ALIAS}    url=/usuarios    json=${body}
  Log            ${resposta.json()}
  Set Test Variable    ${ID_USER}    ${resposta.json()["_id"]}
  Set Test Variable    ${RESPOSTA}   ${resposta.json()}

Verificar se o usuário foi criado com sucesso
  Log    ${RESPOSTA}
  Dictionary Should Contain Item    ${RESPOSTA}    message    Cadastro realizado com sucesso
  Dictionary Should Contain Key     ${RESPOSTA}    _id

Consultar os dados do usuário
  ${resposta_consulta}    GET On session    alias=${ALIAS}    url=/usuarios/${ID_USER}    expected_status=200
  Set Test Variable       ${RESPOSTA_CONSULTA}                    ${resposta_consulta.json()}

Conferir os dados retornados do novo usuário
  Log    ${RESPOSTA_CONSULTA}
  Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    nome             ${nome}
  Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    email            ${EMAIL_TEST}
  Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    password         ${pass}
  Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    administrador    ${admin}
  Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    _id              ${ID_USER}

Alterar o perfil de acesso de true para false
  ${alterar_perfil_usuario}    PUT On session    alias=APIServerest    url=/usuarios/${ID_USER}    expected_status=200    data={"nome":"${nome}", "email":"${EMAIL_TEST}", "password":"${pass}", "administrador":"false"}

Excluir o usuário criado
  ${excluir_usuario}    Delete on session       alias=APIServerest    url=/usuarios/${ID_USER}    expected_status=200
  Set Test Variable     ${RESPOSTA_EXCLUSAO}    ${excluir_usuario.json()}

Verificar se o usuário foi excluído corretamente
  Log    ${RESPOSTA_EXCLUSAO}