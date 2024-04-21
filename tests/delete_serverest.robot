*** Settings ***
Resource      ../resources/serverest_tests.resource

*** Test Cases ***
DELETE: Excluir usuário existente
  Criar um novo usuário
  Cadastrar um novo usuário criado
  Excluir o usuário criado
  Verificar se o usuário foi excluído corretamente