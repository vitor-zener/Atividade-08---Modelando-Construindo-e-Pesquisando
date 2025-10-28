# Sistema Cafeteria BomGosto

Sistema de controle de vendas para cafeteria implementado em PostgreSQL.

## 📋 Descrição

A cafeteria BomGosto deseja controlar suas vendas de café através de comandas, 
registrando pedidos, mesas e clientes.

## 🗄️ Estrutura do Banco de Dados

### Tabelas
- **cardapio**: Catálogo de cafés disponíveis
- **comanda**: Registro de vendas por cliente/mesa
- **item_comanda**: Itens vendidos em cada comanda

## 🚀 Como Usar

### Pré-requisitos
- PostgreSQL 12 ou superior
- Cliente psql ou pgAdmin

### Instalação

1. Clone o repositório:
```bash
git clone https://github.com/seu-usuario/cafeteria-bomgosto-sql.git
cd cafeteria-bomgosto-sql
```

2. Conecte ao PostgreSQL:
```bash
psql -U seu_usuario -d seu_banco_de_dados
```

3. Execute o script:
```bash
\i schema.sql
```

## 📊 Consultas Disponíveis

1. **Listagem do cardápio** - Ordenada por nome
2. **Comandas detalhadas** - Com todos os itens
3. **Comandas com total** - Valor total por comanda
4. **Comandas múltiplos cafés** - Apenas com mais de um tipo
5. **Faturamento por data** - Total vendido por dia

## 🛠️ Tecnologias

- PostgreSQL
- SQL

## 📝 Licença

Este projeto está sob a licença MIT.

## 👤 Autor

Seu Nome
- GitHub: [@vitor-zener](https://github.com/vitor-zener)
```

**Arquivo: `.gitignore`**
```
# Database
*.log
*.sql~
*.swp

# IDE
.vscode/
.idea/

# OS
.DS_Store
Thumbs.db

# Backup
*.backup
*.bak
