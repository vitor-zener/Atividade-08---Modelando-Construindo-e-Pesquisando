-- =====================================================
-- PARTE 1: LIMPEZA (Remove tabelas se já existirem)
-- =====================================================

DROP TABLE IF EXISTS item_comanda CASCADE;
DROP TABLE IF EXISTS comanda CASCADE;
DROP TABLE IF EXISTS cardapio CASCADE;

-- =====================================================
-- PARTE 2: CRIAÇÃO DAS TABELAS (DDL)
-- =====================================================

-- Criar tabela de cardápio
CREATE TABLE cardapio (
    codigo_cardapio SERIAL PRIMARY KEY,
    nome_cafe VARCHAR(100) UNIQUE NOT NULL,
    descricao TEXT,
    preco_unitario DECIMAL(10,2) NOT NULL CHECK (preco_unitario > 0)
);

-- Criar tabela de comandas
CREATE TABLE comanda (
    codigo_comanda SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    numero_mesa INTEGER NOT NULL,
    nome_cliente VARCHAR(100) NOT NULL
);

-- Criar tabela de itens da comanda
CREATE TABLE item_comanda (
    codigo_comanda INTEGER NOT NULL,
    codigo_cardapio INTEGER NOT NULL,
    quantidade INTEGER NOT NULL CHECK (quantidade > 0),
    PRIMARY KEY (codigo_comanda, codigo_cardapio),
    FOREIGN KEY (codigo_comanda) REFERENCES comanda(codigo_comanda) ON DELETE CASCADE,
    FOREIGN KEY (codigo_cardapio) REFERENCES cardapio(codigo_cardapio)
);

-- =====================================================
-- PARTE 3: INSERÇÃO DE DADOS DE TESTE (DML)
-- =====================================================

-- Inserir dados no cardápio
INSERT INTO cardapio (nome_cafe, descricao, preco_unitario) VALUES
('Espresso', 'Café puro concentrado', 4.50),
('Cappuccino', 'Espresso com leite vaporizado e espuma', 7.00),
('Latte', 'Espresso com muito leite vaporizado', 8.00),
('Mocha', 'Espresso com chocolate e leite', 9.50),
('Americano', 'Espresso diluído em água quente', 5.00);

-- Inserir comandas
INSERT INTO comanda (data, numero_mesa, nome_cliente) VALUES
('2024-01-15', 1, 'João Silva'),
('2024-01-15', 2, 'Maria Santos'),
('2024-01-16', 3, 'Pedro Oliveira'),
('2024-01-16', 1, 'Ana Costa');

-- Inserir itens das comandas
INSERT INTO item_comanda (codigo_comanda, codigo_cardapio, quantidade) VALUES
(1, 1, 2),  -- João: 2 Espressos
(1, 2, 1),  -- João: 1 Cappuccino
(2, 3, 1),  -- Maria: 1 Latte
(3, 1, 1),  -- Pedro: 1 Espresso
(3, 4, 2),  -- Pedro: 2 Mochas
(3, 5, 1),  -- Pedro: 1 Americano
(4, 2, 3);  -- Ana: 3 Cappuccinos

-- =====================================================
-- PARTE 4: CONSULTAS SOLICITADAS
-- =====================================================

-- QUESTÃO 1: Listagem do cardápio ordenada por nome
SELECT 
    '--- QUESTÃO 1: Cardápio ordenado por nome ---' AS consulta;
    
SELECT 
    codigo_cardapio,
    nome_cafe,
    descricao,
    preco_unitario
FROM cardapio
ORDER BY nome_cafe;

-- QUESTÃO 2: Comandas com seus itens detalhados
SELECT 
    '--- QUESTÃO 2: Comandas com itens detalhados ---' AS consulta;
    
SELECT 
    c.codigo_comanda,
    c.data,
    c.numero_mesa,
    c.nome_cliente,
    ca.nome_cafe,
    ca.descricao,
    ic.quantidade,
    ca.preco_unitario,
    (ic.quantidade * ca.preco_unitario) AS preco_total_item
FROM comanda c
INNER JOIN item_comanda ic ON c.codigo_comanda = ic.codigo_comanda
INNER JOIN cardapio ca ON ic.codigo_cardapio = ca.codigo_cardapio
ORDER BY c.data, c.codigo_comanda, ca.nome_cafe;

-- QUESTÃO 3: Comandas com valor total
SELECT 
    '--- QUESTÃO 3: Comandas com valor total ---' AS consulta;
    
SELECT 
    c.codigo_comanda,
    c.data,
    c.numero_mesa,
    c.nome_cliente,
    SUM(ic.quantidade * ca.preco_unitario) AS valor_total_comanda
FROM comanda c
INNER JOIN item_comanda ic ON c.codigo_comanda = ic.codigo_comanda
INNER JOIN cardapio ca ON ic.codigo_cardapio = ca.codigo_cardapio
GROUP BY c.codigo_comanda, c.data, c.numero_mesa, c.nome_cliente
ORDER BY c.data;

-- QUESTÃO 4: Comandas com mais de um tipo de café
SELECT 
    '--- QUESTÃO 4: Comandas com mais de um tipo de café ---' AS consulta;
    
SELECT 
    c.codigo_comanda,
    c.data,
    c.numero_mesa,
    c.nome_cliente,
    SUM(ic.quantidade * ca.preco_unitario) AS valor_total_comanda
FROM comanda c
INNER JOIN item_comanda ic ON c.codigo_comanda = ic.codigo_comanda
INNER JOIN cardapio ca ON ic.codigo_cardapio = ca.codigo_cardapio
GROUP BY c.codigo_comanda, c.data, c.numero_mesa, c.nome_cliente
HAVING COUNT(DISTINCT ic.codigo_cardapio) > 1
ORDER BY c.data;

-- QUESTÃO 5: Faturamento total por data
SELECT 
    '--- QUESTÃO 5: Faturamento total por data ---' AS consulta;
    
SELECT 
    c.data,
    SUM(ic.quantidade * ca.preco_unitario) AS faturamento_total
FROM comanda c
INNER JOIN item_comanda ic ON c.codigo_comanda = ic.codigo_comanda
INNER JOIN cardapio ca ON ic.codigo_cardapio = ca.codigo_cardapio
GROUP BY c.data
ORDER BY c.data;

-- =====================================================
-- PARTE 5: VERIFICAÇÕES ADICIONAIS (OPCIONAL)
-- =====================================================

-- Verificar estrutura das tabelas criadas
SELECT 
    '--- Estrutura das tabelas criadas ---' AS verificacao;

SELECT 
    table_name,
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_schema = 'public' 
    AND table_name IN ('cardapio', 'comanda', 'item_comanda')
ORDER BY table_name, ordinal_position;

-- Contar registros inseridos
SELECT 
    '--- Contagem de registros ---' AS verificacao;

SELECT 
    'cardapio' AS tabela, 
    COUNT(*) AS total_registros 
FROM cardapio
UNION ALL
SELECT 
    'comanda' AS tabela, 
    COUNT(*) AS total_registros 
FROM comanda
UNION ALL
SELECT 
    'item_comanda' AS tabela, 
    COUNT(*) AS total_registros 
FROM item_comanda;