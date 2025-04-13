USE ecommerce;

-- Clientes
INSERT INTO cliente (nome, tipo_cliente, cpf_cnpj) VALUES
('Maria Silva', 'PF', '123.456.789-00'),
('Empresa XYZ', 'PJ', '12.345.678/0001-00');

-- Formas de pagamento
INSERT INTO forma_pagamento (tipo_pagamento) VALUES
('Cartão de Crédito'),
('Boleto'),
('Pix');

-- Cliente x Pagamento
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
('Monitor 27\"', 1200.00, 2);

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
