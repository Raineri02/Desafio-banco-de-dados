-- script_ddl.sql

CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    tipo_cliente ENUM('PF', 'PJ') NOT NULL,
    cpf_cnpj VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE forma_pagamento (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    tipo_pagamento VARCHAR(50) NOT NULL
);

CREATE TABLE cliente_pagamento (
    id_cliente INT,
    id_pagamento INT,
    PRIMARY KEY (id_cliente, id_pagamento),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_pagamento) REFERENCES forma_pagamento(id_pagamento)
);

CREATE TABLE produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL DEFAULT 0
);

CREATE TABLE fornecedor (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE produto_fornecedor (
    id_produto INT,
    id_fornecedor INT,
    PRIMARY KEY (id_produto, id_fornecedor),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor)
);

CREATE TABLE pedido (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    data_pedido DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE item_pedido (
    id_pedido INT,
    id_produto INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

CREATE TABLE entrega (
    id_entrega INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT,
    status VARCHAR(50),
    codigo_rastreio VARCHAR(100),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);

-- script_dml.sql

-- Clientes
INSERT INTO cliente (nome, tipo_cliente, cpf_cnpj) VALUES
('Maria Silva', 'PF', '123.456.789-00'),
('Empresa XYZ', 'PJ', '12.345.678/0001-00');

-- Formas de pagamento
INSERT INTO forma_pagamento (tipo_pagamento) VALUES
('Cartão de Crédito'),
('Boleto'),
('Pix');

-- Relação cliente x pagamento
INSERT INTO cliente_pagamento (id_cliente, id_pagamento) VALUES
(1, 1), (1, 3),
(2, 2);

-- Fornecedores
INSERT INTO fornecedor (nome) VALUES
('Fornecedor A'),
('Fornecedor B');

-- Produtos
INSERT INTO produto (nome, preco, estoque) VALUES
('Mouse Gamer', 150.00, 10),
('Teclado Mecânico', 250.00, 5),
('Monitor 27"', 1200.00, 2);

-- Produto x Fornecedor
INSERT INTO produto_fornecedor (id_produto, id_fornecedor) VALUES
(1, 1),
(2, 1),
(3, 2);

-- Pedidos
INSERT INTO pedido (id_cliente, data_pedido) VALUES
(1, '2025-04-01'),
(2, '2025-04-02');

-- Itens dos pedidos
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 2, 150.00),
(1, 2, 1, 250.00),
(2, 3, 1, 1200.00);

-- Entregas
INSERT INTO entrega (id_pedido, status, codigo_rastreio) VALUES
(1, 'Entregue', 'BR123456789BR'),
(2, 'Em transporte', 'BR987654321BR');

-- queries.sql

-- A) Quantos pedidos foram feitos por cada cliente
SELECT c.nome, COUNT(p.id_pedido) AS total_pedidos
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.nome;

-- B) Relação de fornecedores e produtos
SELECT f.nome AS fornecedor, p.nome AS produto
FROM produto_fornecedor pf
JOIN fornecedor f ON pf.id_fornecedor = f.id_fornecedor
JOIN produto p ON pf.id_produto = p.id_produto
ORDER BY f.nome;

-- C) Total gasto por cliente
SELECT c.nome, SUM(ip.quantidade * ip.preco_unitario) AS total_gasto
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
JOIN item_pedido ip ON p.id_pedido = ip.id_pedido
GROUP BY c.nome
HAVING total_gasto > 0
ORDER BY total_gasto DESC;

-- D) Produtos com estoque abaixo da média
SELECT nome, estoque
FROM produto
WHERE estoque < (SELECT AVG(estoque) FROM produto);

-- E) Pedidos com status e código de rastreio
SELECT p.id_pedido, c.nome, e.status, e.codigo_rastreio
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id_cliente
JOIN entrega e ON p.id_pedido = e.id_pedido;