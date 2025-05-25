
-- Relatório 1: Lista dos empregados admitidos entre 2019-01-01 e 2022-03-31
SELECT e.nome AS Nome_Empregado, e.cpf, e.data_admissao, e.salario, d.nome AS Departamento, e.telefone
FROM Empregado e
JOIN Departamento d ON e.departamento_id = d.id
WHERE e.data_admissao BETWEEN '2019-01-01' AND '2022-03-31'
ORDER BY e.data_admissao DESC;

-- Relatório 2: Lista dos empregados que ganham menos que a média salarial dos funcionários do Petshop
SELECT e.nome, e.cpf, e.data_admissao, e.salario, d.nome AS Departamento, e.telefone
FROM Empregado e
JOIN Departamento d ON e.departamento_id = d.id
WHERE e.salario < (SELECT AVG(salario) FROM Empregado)
ORDER BY e.nome;

-- Relatório 3: Lista dos departamentos com a quantidade de empregados total por cada departamento
SELECT d.nome AS Departamento,
       COUNT(e.id) AS Quantidade_Empregados,
       AVG(e.salario) AS Media_Salarial,
       AVG(vs.comissao) AS Media_Comissao
FROM Departamento d
LEFT JOIN Empregado e ON e.departamento_id = d.id
LEFT JOIN VendaServico vs ON vs.empregado_id = e.id
GROUP BY d.nome
ORDER BY d.nome;

-- Relatório 4: Lista dos empregados com a quantidade total de vendas já realiza por cada Empregado
SELECT e.nome, e.cpf, e.sexo, e.salario,
       COUNT(v.id) AS Quantidade_Vendas,
       SUM(v.valor_final) AS Total_Valor_Vendido,
       SUM(vs.comissao) AS Total_Comissao
FROM Empregado e
LEFT JOIN Venda v ON v.empregado_id = e.id
LEFT JOIN VendaServico vs ON vs.empregado_id = e.id
GROUP BY e.id
ORDER BY Quantidade_Vendas DESC;

-- Relatório 5: Lista dos empregados que prestaram Serviço na venda computando a quantidade total de vendas realizadas com serviço por cada Empregado
SELECT e.nome, e.cpf, e.sexo, e.salario,
       COUNT(DISTINCT vs.venda_id) AS Quantidade_Vendas_Servico,
       SUM(vs.valor) AS Total_Valor_Servico,
       SUM(vs.comissao) AS Total_Comissao_Servico
FROM Empregado e
JOIN VendaServico vs ON vs.empregado_id = e.id
GROUP BY e.id
ORDER BY Quantidade_Vendas_Servico DESC;

-- Relatório 6: Lista dos serviços já realizados por um Pet
SELECT p.nome AS Nome_Pet, vs.data_servico, s.nome AS Nome_Servico,
       vs.quantidade, vs.valor, e.nome AS Empregado
FROM VendaServico vs
JOIN Servico s ON vs.servico_id = s.id
JOIN Pet p ON vs.pet_id = p.id
JOIN Empregado e ON vs.empregado_id = e.id
ORDER BY vs.data_servico DESC;

-- Relatório 7: Lista das vendas já realizados para um Cliente
SELECT v.data_venda, v.valor, v.desconto, v.valor_final, e.nome AS Empregado
FROM Venda v
JOIN Empregado e ON v.empregado_id = e.id
WHERE v.cliente_id = [ID_DO_CLIENTE]
ORDER BY v.data_venda DESC;

-- Relatório 8: Lista dos 10 serviços mais vendidos
SELECT s.nome AS Nome_Servico,
       COUNT(vs.id) AS Quantidade_Vendas,
       SUM(vs.valor) AS Total_Valor_Vendido
FROM VendaServico vs
JOIN Servico s ON vs.servico_id = s.id
GROUP BY s.id
ORDER BY Quantidade_Vendas DESC
LIMIT 10;

-- Relatório 9: Lista das formas de pagamentos mais utilizadas nas Vendas
SELECT fp.tipo AS Tipo_Forma_Pagamento,
       COUNT(v.id) AS Quantidade_Vendas,
       SUM(v.valor_final) AS Total_Valor_Vendido
FROM Venda v
JOIN FormaPagamento fp ON v.forma_pagamento_id = fp.id
GROUP BY fp.tipo
ORDER BY Quantidade_Vendas DESC;

-- Relatório 10: Balaço das Vendas
SELECT v.data_venda,
       COUNT(v.id) AS Quantidade_Vendas,
       SUM(v.valor_final) AS Valor_Total_Venda
FROM Venda v
GROUP BY v.data_venda
ORDER BY v.data_venda DESC;

-- Relatório 11: Lista dos Produtos
SELECT p.nome AS Nome_Produto, p.valor AS Valor_Produto,
       p.categoria_id AS Categoria_Produto,
       f.nome AS Nome_Fornecedor, f.email, f.telefone
FROM Produto p
JOIN Fornecedor f ON p.fornecedor_id = f.id
ORDER BY p.nome;

-- Relatório 12: Lista dos Produtos mais vendidos
SELECT p.nome AS Nome_Produto,
       SUM(vp.quantidade) AS Quantidade_Vendas,
       SUM(vp.quantidade * vp.valor_unitario) AS Valor_Total_Recebido
FROM VendaProduto vp
JOIN Produto p ON vp.produto_id = p.id
GROUP BY p.id
ORDER BY Quantidade_Vendas DESC;
