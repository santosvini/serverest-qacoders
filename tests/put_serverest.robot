*** Settings ***
Resource      ../resources/serverest_tests.resource

*** Test Cases ***
PUT: Atualizar os dados de um usuário
  Criar um novo usuário
  Cadastrar um novo usuário criado
  Consultar os dados do usuário
  Alterar o perfil de acesso de true para false
  Consultar os dados do usuário