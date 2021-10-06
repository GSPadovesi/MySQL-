/**
	Agenda de contatos
    @author Gabriel Santana Padovesi 
*/
-- Criar um novo banco de dados 
create database dbloja;
---------------------------------------------------
-- selecionar o banco de dados 
use dbloja;
---------------------------------------------------
-- verificar tabelas existentes 
show tables;
---------------------------------------------------
-- decimal (tipo de dados numericos não inteiro 10,2 dez digitos com 2 casas decimais)
create table carrinho(
	codigo int primary key auto_increment,
    produto varchar(250) not null,
    quantidade int not null,
    valor decimal(10,2) not null
);

-- Descrição da tabela
describe carrinho;
---------------------------------------------------
-- Criando o CRUD create
insert into carrinho(produto,quantidade,valor)
values ('Caixa de bobom1',15,9.60);
insert into carrinho(produto,quantidade,valor)
values ('Caixa de cerveja',10,25.80);
insert into carrinho(produto,quantidade,valor)
values ('Caixa de coca-cola',30,3.50);
insert into carrinho(produto,quantidade,valor)
values ('Salgados',10,5.50);
---------------------------------------------------
-- Colocando o CRUD read
select * from carrinho;

---------------------------------------------------
-- Operaçoes matematicas no banco de dados 
select sum(valor * quantidade) as total from carrinho;

---------------------------------------------------
-- Mostrando os produtos e a quantidade
select produto, quantidade from carrinho;
-- Mostrando o codigo e os valores de tal
select codigo, valor from carrinho;
-- Mostrando o codigo, o produto e o valor
select codigo, produto, valor from carrinho;
---------------------------------------------------
-- Mostrando do menor valor para o maior 
select * from carrinho order by valor;
---------------------------------------------------
-- Colocando o CRUD update
update carrinho set valor = 13.40 where codigo = 5;
---------------------------------------------------
-- timestamp default current_timestamp (Data e Hora automatica)
-- date (tipo de dados relacionados a data) yyyy/mm/dd
create table estoque(
	codigo int primary key auto_increment,
    barcode varchar(50) unique, 
    produto varchar(250) not null,
    fabricante varchar(100) not null,
    datacad timestamp default current_timestamp,
    dataval date not null,
    quantidade int not null,
    estoquemin int not null,
    medida varchar(50) not null,
    valor decimal(10,2),
    loc varchar(100)
);
---------------------------------------------------
describe estoque;
---------------------------------------------------
insert into estoque(produto,fabricante,dataval,quantidade,estoquemin,
medida,valor,loc)
values ('Caneta BIC azul','BIC',20221005,100,10,'CX',28.75,'setor A p21');
insert into estoque(produto,fabricante,dataval,quantidade,estoquemin,
medida,valor,loc)
values ('Borracha FABER dupla','FABER',20231201,15,20,'CX',30.50,'setor B p15');
insert into estoque(produto,fabricante,dataval,quantidade,estoquemin,
medida,valor,loc)
values ('Cola','PRITT',20210925,47,8,'CX',25.50,'setor D p25');
insert into estoque(produto,fabricante,dataval,quantidade,estoquemin,
medida,valor,loc)
values ('Branquinho','BIC',20210823,30,60,'CX',15.50,'setor C p45');
insert into estoque(produto,fabricante,dataval,quantidade,estoquemin,
medida,valor,loc)
values ('Papel Sufite','CHAMEX',20240223,30,30,'CX',60.00,'setor F p02');

select * from estoque;
---------------------------------------------------
-- Inventario do estoque(total)
-- Operaçoes matematicas no banco de dados 
select sum(valor * quantidade) as total from estoque;
-----------------------------------------------------
-- Relatorio de reposição do estoque 1
select * from estoque where quantidade < estoquemin;
-- Relatorio de reposição do estoque 2
-- date_format() -> formatar a exibição da data
-- Dia -> %d/ Mes -> %m/ Ano -> %Y
select codigo as código, produto,
date_format(dataval,'%d/%m/%Y') as data_validade,
quantidade,estoquemin as estoque_mínimo from estoque
where quantidade < estoquemin;

-- Relatório de validade dos produtos 1 
select codigo as Código,produto,
date_format(dataval,'%d/%m/%Y') as data_validade
from estoque;

-- Relatório de validade dos produtos 2 
-- datediff() retorna a diferença em dias de duas datas
-- curdate() data atual
select codigo as Código, produto,
date_format(dataval,'%d/%m/%Y') as data_validade,
datediff(dataval,curdate()) as dias_restantes
from estoque;
-----------------------------------------------------
update estoque set valor = 30.50 where codigo = 1;
update estoque set produto = 'caneta FABER azul',fabricante = 'FABER',
dataval = 20210512,quantidade = 30,estoquemin = 40,medida = 'fardo',
valor = 30.00,loc = 'setor A p01' where codigo = 1;
-----------------------------------------------------
delete from estoque where codigo = 11;
-----------------------------------------------------
select * from estoque;
