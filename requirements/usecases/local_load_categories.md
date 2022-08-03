## Local Load Categories

 ## Caso de sucesso
1. ✅ Sistema solicita os dados das Categories do Cache
2. ✅ Sistema entrega os dados das categories

## Exceção - Erro ao carregar dados do Cache
1. ✅ Sistema retorna uma mensagem de erro inesperado

## Exceção - Cache vazio
1. ✅ Sistema retorna uma mensagem de erro inesperado

---

## Local Validate Categories

## Caso de sucesso
1. ✅ Sistema solicita os dados das Categories do Cache
2. ✅ Sistema valida os dados recebidos do Cache

## Exceção - Erro ao carregar dados do Cache
1. ✅ Sistema limpa os dados do cache

## Exceção - Dados inválidos no cache
1. ✅ Sistema limpa os dados do cache

---

## Local Save Categories

## Caso de sucesso
1. ✅ Sistema grava os novos dados no Cache

## Exceção - Erro ao gravar dados no Cache
1. ✅ Sistema retorna uma mensagem de erro inesperado