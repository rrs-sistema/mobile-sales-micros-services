Feature: Login
Como um cliente
Quero poder acessar minha conta e me manter logado
Para que eu possa fazer e ver minhas compras

Cenário: Credenciais Válidas
Dado que o cliente informou as credenciais vlidas
Quando solicitar para fazer o Login
Então o sistema deve enviar o usuário para a tela inicial
E manter o usuário conectado

Cenário: Credencias Inválidas
Dado que o cliente informou credenciais Inválidas
Quando solicitado para fazer o Login
Então o sistema deve retornar uma mensagem de erro