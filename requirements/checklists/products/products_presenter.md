## Products Presenter

## Regras
1. ❌ Chamar LoadProducts no método loadData
2. ❌ Notificar o isLoadingStream como true antes de chamar o LoadProducts
3. ❌ Notificar o isLoadingStream como false no fim do LoadProducts
4. ❌ Notificar o surveysStream com erro caso o LoadProducts retorne erro
5. ❌ Notificar o surveysStream com uma lista de Produtos caso o LoadProducts retorne sucesso
6. ❌ Levar o usuário pra tela de Detalhe do produto ao clicar em algum item
7. ❌ Notificar o sessionExpiredStream como true caso o LoadProducts retorne erro accessDenied