-- Criação do banco de dados para cenário E-commerce
create database ecommerce;
use ecommerce;

-- criar tabela cliente

create table client(
		idCliente int auto_increment primary key,
        Pname varchar(10),
        Pnamemeio char(3),
        Sobrenome varchar(20),
        Identificação varchar(45),
        Endereço varchar(45),
        CPF Char(11) not null,
        DataNascimento Date,
		Contato varchar(50), 
        constraint unique_cpf_client unique(CPF)
);

desc client;

-- criar tabela produto
create table Product(
		idProduto int auto_increment primary key,
        Pnome varchar(20) not null,
        codigo varchar (20),
        Categoria enum('eletronicos', 'vestimentas', 'eletrodomesticos', 'Kids'),
        Descrição  varchar(45),
        Valor varchar(20)
);

-- criar tabela ordem de pagamento
create table Orderpayments(
		IdOrdemPagamento int,
        IdPedido int,
        IdFormadePagamento int,
        IdCliente int,
	    Valor varchar(45),
        ValorTotal varchar(45),
        StatusPagamento enum('Aprovado', 'Recusado', 'Em processamento') not null,
        primary key (IdFormadePagamento, IdOrdemPagamento, IdCliente)
);

-- criar tabela forma de pagamento
create table FormPayments(
		IdFormadePagamento int,
        IdOrdemPagamento int,
        IdCliente int,
        TipoPagamento enum('Credito', 'Debito', 'Dois cartões'),
        Boleto float,
        ChavePix enum('cpf','celular','email','chavealeartoria'),
        primary key (IdFormadePagamento, IdOrdemPagamento, IdCliente)
);

-- criar tabela pedido 
create table Request(
		idCliente int,
        idPedido int auto_increment primary key,
        idPedidoCliente int,
        PedidoStatus enum('Em andamento', 'Em processamento', 'enviado', 'entregue') default 'Em processamento',
        PedidoDescrição  varchar(255),
        PedidoFrete float default 10,
        IdOrdemPagamento int,
		constraint fk_Pedido_Cliente foreign key (idPedidoCliente) references Client (idCliente)
);
-- criar tabela estoque
create table ProductStorage(
IdEstoque int auto_increment primary key,
Localização varchar (45),
Quantidade int default 0
);

-- criar tabelea forncedor
create table Supplier(
IdFornecedor int auto_increment primary key,
Localização varchar (45),
RazãoSocial varchar (45) not null,
NomeFantasia varchar (45),
CNPJ char (14) not null,
Contato char (11) not null,
constraint unique_supplier unique(CNPJ)
);

-- criar tabela vendedor
create table Seller(
IdVendedor int auto_increment primary key,
Localização varchar (45),
RazãoSocial varchar (45) not null,
NomeFantasia varchar (45),
CNPJ char (14),
CPF char (11),
Contato char (11) not null,
constraint unique_CNPJ_Seller unique(CNPJ),
constraint unique_CPF_Seller unique(CPF)
);

-- criar tabela Produtos por vendedor
create table ProductSeller(
IdProduto int,
IdVendedor int,
IdProdutoVendedor int,
Quantidade int default 1,
primary key (IdProduto, IdProdutoVendedor),
constraint fk_produto_vendedor foreign key (IdProdutoVendedor) references Seller (IdVendedor),
constraint fk_produto_produto foreign  key (idProduto) references Product (IdProduto)
);

-- criar tabela produto por pedido
create table ProductRequest(
IdProduto int,
IdPedido int,
IdVendedor int,
IdProdutoVendedor int,
Quantidade int default 1,
StatusProduto enum('Disponivel','Sem Estoque') default 'Disponivel',
primary key (IdProdutoVendedor, IdPedido),
constraint fk_pedido_vendedor foreign key (IdProdutoVendedor) references Seller (IdVendedor),
constraint fk_pedido_produto foreign  key (idPedido) references Request (IdPedido)
);

 -- criar tabela produto estoque
create table ProdutoEstoque (
IdProduto int,
IdEstoque int,
Localização varchar (100) not null,
primary key (IdProduto, IdEstoque),
constraint fk_estoque_vendedor foreign key (IdProduto) references Product (IdProduto),
constraint fk_estoque_produto foreign  key (idEstoque) references Request (IdPedido)
);

-- criar tabela produtos por fornecedor
create table ProductSupplier(
IdProduto int,
IdProdutoFornecedor int,
Quantidade int default 1,
primary key (IdProduto, IdProdutoFornecedor),
constraint fk_fornecerdor_vendedor foreign key (IdProdutoFornecedor) references Supplier (IdFornecedor),
constraint fk_fornecerdor_produto foreign  key (idProduto) references Product (IdProduto)
);

show tables;