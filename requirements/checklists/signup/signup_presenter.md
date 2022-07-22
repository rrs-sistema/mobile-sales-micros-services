# SignUp Presenter

> ## Regras
1.  ✅ Os Validation ao alterar o email
2.  ✅ Notificar o emailErrorStream com o mesmo erro do Validation, caso retorne erro
3.  ✅ Notificar o emailErrorStream com null, caso o Validation não retorne erro
4.  ✅ Não notificar o emailErrorStream se o valor for igual ao último
5.  ✅ Notificar o isFormValidStream após alterar o email
6.  ✅ Chamar Validation ao alterar a senha
7.  ✅ Notificar o passwordErrorStream com mesmo erro do Validation, caso retorne erro
8.  ✅ Notificar o passwordErrorStream com null, caso o Validation não retorne erro
9.  ✅ Não notificar o passwordErrorStream se o valor for igual ao último
10.  ✅ Notificar o isFormValidStream após alterar a senha
11.  ✅ Chamar Validation ao alterar o nome
12.  ✅ Notificar o nameErrorStream com mesmo erro do Validation, caso retorne erro
13.  ✅ Notificar o nameErrorStream com null, caso o Validation não retorne erro
14.  ✅ Não notificar o nameErrorStream se o valor for igual ao último
15.  ✅ Notificar o isFormValidStream após alterar o nome
16.  ✅ Chamar Validation ao alterar a confirmação senha
17.  ✅ Notificar o passwordConfirmationErrorStream com mesmo erro do Validation, caso retorne erro
18.  ✅ Notificar o passwordConfirmationErrorStream com null, caso o Validation não retorne erro
19.  ✅ Não notificar o passwordConfirmationErrorStream se o valor for igual ao último
20.  ✅ Notificar o isFormValidStream após alterar a confirmação de senha
21.  ❌ Para o formulário está válido todos os Streams de erro precisam estar null e todo os campos obrigatórios não podem estar vazios
22.  ❌ Não notificar o isFormValidStream se o valor for igual ao último
23.  ❌ Chamar o AddAccount com valores corretos
24.  ❌ Notificar o isLoadingStream como true antes de chamar o AddAccount
25.  ❌ Notificar o isLoadingStream como false no fim do AddAccount
26.  ❌ Notificar o mainErrorStream caso o AddAccount retorne erro
27.  ❌ XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
28.  ❌ XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
29.  ❌ XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
30.  ❌ XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
31.  ❌ XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX