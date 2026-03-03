
-------1° Query: Qual foi o produto mais vendido do meu Ecommerce?----

SELECT 
    p.idProduto,
    p.Descrição,
    SUM(ip.Quantidade) AS Total_Vendido
FROM Item_Pedido ip
JOIN Produto p ON ip.IdProduto = p.idProduto
GROUP BY p.idProduto, p.Descrição
ORDER BY Total_Vendido DESC;


-------2° Query: Qual produto tenho em maior estoque?----

SELECT idProduto, Descrição, Estoque
FROM Produto
ORDER BY Estoque DESC
LIMIT 1;


-------3° Query: Qual cidade mais comprou conosco sendo cliente Pessoa Fisica ?----

SELECT 
    SUBSTRING_INDEX(cpf.`Endereço_de_Entrega`, ',', -1) AS Cidade,
    COUNT(*) AS Total_Vendas
FROM Pedido pd
JOIN Cliente c ON pd.IdCliente = c.idCliente
JOIN Cliente_PF cpf ON c.idCliente = cpf.IdCliente
WHERE c.Tipo_Cliente = 'PF'
GROUP BY Cidade
ORDER BY Total_Vendas DESC;


-------4° Query: Qual cidade mais comprou conosco sendo cliente Pessoa Juridica- Fornecedor?----

SELECT 
    SUBSTRING_INDEX(cpj.`Endereço_Comercial`, ',', -1) AS Cidade,
    COUNT(*) AS Total_Vendas
FROM Pedido pd
JOIN Cliente c ON pd.IdCliente = c.idCliente
JOIN Cliente_PJ cpj ON c.idCliente = cpj.IdCliente
WHERE c.Tipo_Cliente = 'PJ'
GROUP BY Cidade
ORDER BY Total_Vendas DESC;





