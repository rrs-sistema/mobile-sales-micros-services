Feature: Login
Como um cliente
Quero poder acessar minha conta e me manter logado
Para que eu possa ver e as minhas compras de forma rápida

Cenário: Credenciais Válidas
Dado que o cliente informou credenciais válidas
Quando solicitar para fazer login
Então o sistema deve enviar o usuário para a tela de produtos
E manter o usuário conectado

Cenário: Credenciais Inválidas
Dado que o cliente informou credenciais inválidas
Quando solicitar para fazer login
Então o sistema deve retornar uma mensagem de erro