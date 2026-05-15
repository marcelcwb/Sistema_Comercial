# Sistema Comercial Rails

Sistema Ruby on Rails para clientes, produtos, estoque, pedidos e financeiro.

## Modulos

- Clientes
- Produtos
- Controle de estoque com movimentacoes
- Pedidos com itens
- Contas financeiras a receber e a pagar
- Dashboard inicial com indicadores
- Autenticacao com Devise
- Permissionamento com CanCanCan

## Como rodar

Requisitos:

- Ruby 3.4.4
- Bundler
- SQLite 3
- Dependencias nativas para compilar gems

No Ubuntu/Debian, instale:

```bash
sudo apt update
sudo apt install -y build-essential pkg-config sqlite3 libsqlite3-dev
```

No Fedora:

```bash
sudo dnf install -y gcc gcc-c++ make pkgconf-pkg-config sqlite sqlite-devel
```

No Arch Linux:

```bash
sudo pacman -S --needed base-devel pkgconf sqlite
```

```bash
bundle install
bin/rails db:setup
bin/rails server
```

Depois acesse `http://localhost:3000`.

## Testes automatizados

O projeto usa RSpec com exemplos de TDD e BDD:

- Specs de models para regras de dominio.
- Specs de requests para fluxos de usuario, autenticacao e permissoes.

Para preparar e rodar:

```bash
bin/rails db:test:prepare
bundle exec rspec
```

Com Docker:

```bash
docker compose up --build
```

## Dados iniciais

O comando `bin/rails db:setup` cria clientes, produtos, movimentacoes de estoque, pedidos e contas financeiras de exemplo.

Usuario inicial:

- Email: `admin@sistema.test`
- Senha: `admin123`

Usuarios de exemplo:

- Vendas: `vendas@sistema.test` / `vendas123`
- Financeiro: `financeiro@sistema.test` / `financeiro123`

## Permissoes

- Administrador: gerencia todo o sistema, incluindo usuarios.
- Vendas: gerencia clientes e pedidos, e consulta produtos/estoque.
- Financeiro: gerencia lancamentos financeiros e consulta clientes, produtos e pedidos.
- Operacional: gerencia produtos e estoque, e consulta clientes, pedidos e financeiro.
