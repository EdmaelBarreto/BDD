
-- DDL Script: Estrutura das tabelas do PetShop

CREATE TABLE Departamento (
    id INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE Empregado (
    id INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    data_admissao DATE NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    sexo CHAR(1) NOT NULL,
    departamento_id INT,
    telefone VARCHAR(15),
    FOREIGN KEY (departamento_id) REFERENCES Departamento(id)
);

CREATE TABLE Cliente (
    id INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE Pet (
    id INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cliente_id INT,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(id)
);

CREATE TABLE Servico (
    id INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Venda (
    id INT PRIMARY KEY,
    data_venda DATE NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    desconto DECIMAL(10, 2),
    valor_final DECIMAL(10, 2) NOT NULL,
    empregado_id INT,
    cliente_id INT,
    forma_pagamento_id INT,
    FOREIGN KEY (empregado_id) REFERENCES Empregado(id),
    FOREIGN KEY (cliente_id) REFERENCES Cliente(id),
    FOREIGN KEY (forma_pagamento_id) REFERENCES FormaPagamento(id)
);

CREATE TABLE VendaServico (
    id INT PRIMARY KEY,
    venda_id INT,
    servico_id INT,
    quantidade INT NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    empregado_id INT,
    pet_id INT,
    data_servico DATE NOT NULL,
    comissao DECIMAL(10, 2),
    FOREIGN KEY (venda_id) REFERENCES Venda(id),
    FOREIGN KEY (servico_id) REFERENCES Servico(id),
    FOREIGN KEY (empregado_id) REFERENCES Empregado(id),
    FOREIGN KEY (pet_id) REFERENCES Pet(id)
);

CREATE TABLE Produto (
    id INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    categoria_id INT,
    fornecedor_id INT,
    FOREIGN KEY (fornecedor_id) REFERENCES Fornecedor(id)
);

CREATE TABLE VendaProduto (
    id INT PRIMARY KEY,
    venda_id INT,
    produto_id INT,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (venda_id) REFERENCES Venda(id),
    FOREIGN KEY (produto_id) REFERENCES Produto(id)
);

CREATE TABLE Fornecedor (
    id INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    telefone VARCHAR(15)
);

CREATE TABLE FormaPagamento (
    id INT PRIMARY KEY,
    tipo VARCHAR(255) NOT NULL
);
