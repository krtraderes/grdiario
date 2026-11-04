# KR Traders — Diário de Trades com Login e Nuvem

Este pacote publica o diário de trades com login, sincronização em nuvem e dados separados por conta. Ele deve usar um **projeto Supabase próprio**, diferente do projeto do CRM.

## Arquivos

- `Dashboard_Risco_Trade.html` — diário de trades.
- `config.js` — URL e chave publicável do novo projeto Supabase.
- `supabase-trade-setup.sql` — tabela, isolamento por usuário e atualizações em tempo real.
- `LEIA-ME-Diario-Trade-Nuvem.txt` — instruções complementares.

## 1. Criar um projeto Supabase separado

1. Acesse [supabase.com](https://supabase.com/) e crie um projeto novo para o diário.
2. Guarde a senha do banco em local seguro.
3. No projeto novo, abra **SQL Editor**, cole o conteúdo de `supabase-trade-setup.sql` e execute.

## 2. Configurar login e chave

1. No Supabase, abra **Project Settings → API Keys**.
2. Copie a **Project URL** completa, no formato `https://seu-projeto.supabase.co`.
3. Copie a chave **publishable**, que começa com `sb_publishable_`.
4. Edite `config.js` e substitua os valores de exemplo pela URL e chave desse projeto novo.
5. Não use a região do projeto, a chave `service_role` nem uma chave `sb_secret_` no navegador.
6. Em **Authentication → Sign In / Providers**, deixe o provedor **Email** habilitado.
7. Crie cada acesso em **Authentication → Users**. Se quiser que as pessoas criem suas próprias contas na tela, habilite os cadastros públicos nas configurações de autenticação.

## 3. Publicar no GitHub Pages

1. Extraia o ZIP no computador.
2. Envie os arquivos `Dashboard_Risco_Trade.html`, `config.js` e `supabase-trade-setup.sql` para a mesma pasta do repositório GitHub.
3. No GitHub, abra **Settings → Pages** e configure a publicação pela branch principal e pela pasta onde colocou os arquivos.
4. Abra o endereço publicado e entre com o e-mail e senha criados no **novo projeto Supabase do diário**.
5. Para usar em outros aparelhos, abra o mesmo endereço e entre com a mesma conta.

## Dados e privacidade

Cada usuário acessa somente sua própria carteira de trades e configurações. O isolamento é aplicado pelas políticas RLS do SQL. O GitHub Pages hospeda os arquivos da página; o login e os dados ficam no projeto Supabase separado.

Na primeira entrada, se o navegador encontrar operações ou parâmetros antigos salvos localmente e a conta estiver vazia na nuvem, o diário perguntará se deseja copiá-los. Confirme somente se estiver entrando na conta que deve receber esses dados.

A sincronização exige internet. Mantenha backups JSON em local protegido. Evite editar a mesma conta simultaneamente em vários aparelhos.