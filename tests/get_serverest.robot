*** Settings ***
Resource      ../resources/serverest_tests.resource

*** Test Cases ***
GET: Consultar dados um novo usuário cadastrado
  Criar um novo usuário
  Cadastrar um novo usuário criado
  Consultar os dados do usuário
  Conferir os dados retornados do novo usuário