## Categories Presenter

## Regras
1. ✅ Chamar LoadCategories no método loadData
2. ✅ Notificar o isLoadingStream como true antes de chamar o LoadCategories
3. ✅ Notificar o isLoadingStream como false no fim do LoadCategories
4. ✅ Notificar o productsStream com erro caso o LoadCategories retorne erro
5. ✅ Notificar o productsStream com uma lista de Categorias caso o LoadCategories retorne sucesso
6. ❌ Levar o usuário pra tela de Detalhe do categoria ao clicar em algum item
7. ❌ Notificar o sessionExpiredStream como true caso o LoadCategories retorne erro accessDenied