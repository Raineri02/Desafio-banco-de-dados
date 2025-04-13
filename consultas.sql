USE ecommerce;

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
