CREATE TABLE Cliente (
  IdCliente INT AUTO_INCREMENT PRIMARY KEY,
  Email VARCHAR(100) NOT NULL UNIQUE,
  Telefone VARCHAR(20), 
  Tipo_Cliente ENUM('PJ','PF') NOT NULL,
  Data_cadastro DATE NOT NULL
  );

 CREATE TABLE Cliente_PJ(
   IdCliente INT PRIMARY KEY,
   CNPJ VARCHAR(18) NOT NULL UNIQUE,
   Razao_Social VARCHAR(100) NOT NULL,
   Nome_Fantasia VARCHAR(100),
   Telefone CHAR(15) NOT NULL,
   Endereço_Comercial VARCHAR(100) NOT NULL,
   CONSTRAINT fk_Cliente_pj
   FOREIGN KEY (IdCliente)
   REFERENCES Cliente(idCliente)
   );

 CREATE TABLE Cliente_PF(
   IdCliente INT PRIMARY KEY,
   CPF VARCHAR(11) NOT NULL UNIQUE,
   Nome VARCHAR(50) NOT NULL, 
   Email VARCHAR(100) NOT NULL UNIQUE,
   Telefone CHAR(15) NOT NULL, 
   Endereço_de_Entrega VARCHAR(100) NOT NULL UNIQUE,
   CONSTRAINT fk_Cliente_pf
   FOREIGN KEY (IdCliente)
   REFERENCES Cliente(idCliente)
   );
  
 CREATE TABLE Produto( 
   idProduto INT PRIMARY KEy AUTO_INCREMENT,
   Descrição VARCHAR(100)NOT NULL,
   Preço DECIMAL(10,2) NOT NULL,
   Estoque INT NOT NULL DEFAULT 0,
   Ativo BOOLEAN NOT NULL DEFAULT TRUE
   );

CREATE TABLE Pedido(
  IdPedido INT PRIMARY KEy AUTO_INCREMENT, 
  IdCliente INT NOT NULL,
  Data_Pedido DATE NOT NULL, 
  Status_do_Pedido ENUM ('Aguardando pagamento','Aguardando envio','Enviado','Entregue')NOT NULL,
   CONSTRAINT fk_Pedido_Cliente
   FOREIGN KEY (IdCliente)
   REFERENCES Cliente(idCliente)
  );
 
 CREATE TABLE Item_Pedido(   
   IdPedido INT,
   IdProduto INT,
   Quantidade INT NOT NULL,
   Preço_Unitario DECIMAL (10,2) NOT NULL,
   Desconto DECIMAL(5,2) DEFAULT 0,
   PRIMARY KEY(IdPedido,IdProduto),
   CONSTRAINT fk_Item_Pedido
   FOREIGN KEY (IdPedido)
   REFERENCES Pedido(idPedido), 
   CONSTRAINT fk_Item_Produto
   FOREIGN KEY (IdProduto)
   REFERENCES Produto(idProduto)
   );

 CREATE TABLE Pagamentos(
   IdPagamento INT PRIMARY KEY AUTO_INCREMENT,
   IdPedido INT NOT NULL,
   Forma_de_Pagamento ENUM('Cartão','Pix','Boleto') NOT NULL,
   Valor DECIMAL(10,2) NOT NULL,
   Status_Pagamento ENUM('Pendente', 'Aprovado','Recusado') NOT NULL,
   Data_Pagamento DATE NOT NULL,
   CONSTRAINT fk_Pagamento_Pedido
   FOREIGN KEY (IdPedido)
   REFERENCES Pedido(idPedido)
   );  
   
 CREATE TABLE Entrega(
    idCliente INT NOT NULL,
    idPedido INT NOT NULL,
    idProduto INT NOT NULL,
    Telefone VARCHAR(20),
    Tipo_Cliente ENUM('PJ','PF') NOT NULL,
    Descrição VARCHAR(100) NOT NULL,
    Endereço_de_Entrega VARCHAR(100) NOT NULL,
    PRIMARY KEY(idCliente, idPedido, idProduto),
    CONSTRAINT fk_Entrega_Cliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    CONSTRAINT fk_Entrega_Pedido FOREIGN KEY (idPedido) REFERENCES Pedido(IdPedido),
    CONSTRAINT fk_Entrega_Produto FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);  
   
