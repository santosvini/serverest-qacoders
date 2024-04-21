*** Settings ***
Resource    ../resources/serverest_tests.resource

*** Test Cases ***
POST: Cadastrar um usuário com sucesso
  Criar um novo usuário
  Cadastrar um novo usuário criado
  Verificar se o usuário foi criado com sucesso