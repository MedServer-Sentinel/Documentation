use medServer;
create table Empresa(
id_Empresa int primary key auto_increment,
nome varchar(40),
email varchar(14),
cnpj char(14),
telefone char(11)
);

create table usuario(
id_usuario int primary key auto_increment,
nome varchar(40),
senha varchar(14),
cpf char(11),
fkempresa int, foreign key (fkempresa) references empresa(id_empresa)
);
