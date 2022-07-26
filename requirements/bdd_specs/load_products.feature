Feature: Listar Produtos
Como um cliente
Quero poder ver todos os produtos
Para poder saber o o meu carrinho de compras

Cenário: Com internet
Dado que o cliente tem conexão com a internet
Quando solicitar para ver os produtos
Então o sistema deve exibir os produtos
E armazenar os dados atualizados no cache

Cenário: Sem internet
Dado que o cliente não tem conexão com a internet
Quando solicitar para ver os produtos
Então o sistema deve exibir os produtos que foram gravadas no cache no último acesso