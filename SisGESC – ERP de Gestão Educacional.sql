CREATE DATABASE projetoSisgesc;
USE projetoSisgesc;

CREATE TABLE `pessoas` (
  `cpf` char(11) NOT NULL,
  `nome` varchar(255),
  `data_nascimento` date,
  PRIMARY KEY (`cpf`)
);

CREATE TABLE `telefones` (
  `cpf_pessoa` char(11),
  `ddd` char(2),
  `numero` varchar(9),
  `tipo` varchar(50), 
  PRIMARY KEY (`cpf_pessoa`, `ddd`, `numero`)
);

CREATE TABLE `emails` (
  `cpf_pessoa` char(11),
  `email` varchar(255),
  PRIMARY KEY (`cpf_pessoa`, `email`)
);

CREATE TABLE `enderecos` (
  `cpf_pessoa` char(11),
  `tipo` varchar(50),
  `cep` varchar(8),
  `numero` varchar(20),
  `rua` varchar(150),
  `complemento` varchar(150),
  `bairro` varchar(100),
  `cidade` varchar(100),
  `estado` char(2),
  PRIMARY KEY (`cpf_pessoa`, `cep`, `numero`)
);

CREATE TABLE `alunos` (
  `cpf_aluno` char(11) PRIMARY KEY,
  `status` varchar(50)
);

CREATE TABLE `funcionarios` (
  `cpf_funcionario` char(11) PRIMARY KEY,
  `data_contratacao` date,
  `status` varchar(50)
);

CREATE TABLE `cargos` (
  `cod_cargo` int PRIMARY KEY,
  `nome_cargo` varchar(150)
);

CREATE TABLE `cargos_funcionario` (
  `cpf_funcionario` char(11),
  `cod_cargo` int,
  `data_inicio` date,
  `data_fim` date,
  `ativo` boolean,
  PRIMARY KEY (`cpf_funcionario`, `cod_cargo`)
);

CREATE TABLE `beneficios` (
  `tipo` varchar(50) PRIMARY KEY,
  `valor_inicial` decimal(10,2) NOT NULL,
  `valor_final` decimal(10,2) NOT NULL
);

CREATE TABLE `idiomas` (
  `codigo_idioma` varchar(3) PRIMARY KEY,
  `nome` varchar(100)
);

CREATE TABLE `niveis` (
  `codigo_nivel` varchar(10) PRIMARY KEY,
  `nome` varchar(100)
);

CREATE TABLE `cursos` (
  `codigo_idioma` varchar(3),
  `codigo_nivel` varchar(10),
  `nome_curso` varchar(150),
  `carga_horaria` int,
  PRIMARY KEY (`codigo_idioma`, `codigo_nivel`)
);

CREATE TABLE `salas` (
  `numero_sala` varchar(50) PRIMARY KEY, 
  `capacidade` int
);

CREATE TABLE `turmas` (
  `codigo_idioma` varchar(3),
  `codigo_nivel` varchar(10),
  `numero_sala` varchar(50), 
  `horario` varchar(100),   
  `cpf_professor` char(11),
  `data_inicio` date,
  `data_fim` date,
  `status` varchar(50),
  PRIMARY KEY (`codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`)
);

CREATE TABLE `professores_turmas` (
  `cpf_professor` char(11),
  `codigo_idioma` varchar(3),
  `codigo_nivel` varchar(10),
  `numero_sala` varchar(50),
  `horario` varchar(100),
  PRIMARY KEY (`cpf_professor`, `codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`)
);

CREATE TABLE `aulas` (
  `codigo_idioma` varchar(3),
  `codigo_nivel` varchar(10),
  `numero_sala` varchar(50),
  `horario` varchar(100),
  `data_aula` date,
  `cpf_professor` char(11),
  `hora_inicio` time,
  `intervalo` time,
  `hora_fim` time,
  `status` varchar(50),
  PRIMARY KEY (`codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`, `data_aula`)
);

CREATE TABLE `matriculas` (
  `cpf_aluno` char(11),
  `codigo_idioma` varchar(3),
  `codigo_nivel` varchar(10),
  `numero_sala` varchar(50),
  `horario` varchar(100),
  `data_matricula` date,
  `desconto` decimal(10,2),
  `bolsa` decimal(10,2),
  `status` varchar(50),
  PRIMARY KEY (`cpf_aluno`, `codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`)
);


CREATE TABLE `mensalidades` (
  `cpf_aluno` char(11),
  `codigo_idioma` varchar(3),
  `codigo_nivel` varchar(10),
  `numero_sala` varchar(50),
  `horario` varchar(100),
  `data_vencimento` date,
  `data_pagamento` date,
  `valor` decimal(10,2),
  `status` varchar(50),
  PRIMARY KEY (`cpf_aluno`, `codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`, `data_vencimento`)
);

CREATE TABLE `faturamentos` (
  `numero_documento` varchar(100) PRIMARY KEY,
  `cpf_aluno_mens` char(11),
  `codigo_idioma` varchar(3),
  `codigo_nivel` varchar(10),
  `numero_sala` varchar(50),
  `horario` varchar(100),
  `data_vencimento` date,
  `tipo_documento` varchar(100),
  `data_emissao` date,
  `valor` decimal(10,2)
);

CREATE TABLE `fornecedores` (
  `cnpj` char(14) PRIMARY KEY,
  `cpf_pessoa` char(11),
  `nome_fantasia` varchar(255)
);

CREATE TABLE `categorias_despesas` (
  `codigo_categoria` varchar(10) PRIMARY KEY,
  `nome` varchar(150),
  `tipo` varchar(50)
);

CREATE TABLE `faturas` (
  `cnpj_fornecedor` char(14),
  `numero_fatura` varchar(100),
  `codigo_categoria` varchar(10),
  `descricao` varchar(255),
  `valor_original` decimal(10,2),
  `juros` decimal(10,2),
  `multa` decimal(10,2),
  `data_emissao` date,
  `data_vencimento` date,
  `status` varchar(50),
  PRIMARY KEY (`cnpj_fornecedor`, `numero_fatura`)
);

CREATE TABLE `pagamentos_faturas` (
  `cnpj_fornecedor` char(14),
  `numero_fatura` varchar(100),
  `data_pagamento` date,
  `valor_pago` decimal(10,2),
  `metodo_pagamento` varchar(50),
  `comprovante_url` varchar(255),
  PRIMARY KEY (`cnpj_fornecedor`, `numero_fatura`, `data_pagamento`)
);


CREATE TABLE `folha_pagamento` (
  `cpf_funcionario` char(11),
  `mes` int,
  `ano` int,
  `valor_base` decimal(10,2),
  `bonus` decimal(10,2),
  `descontos` decimal(10,2),
  `valor_final` decimal(10,2),
  `status` varchar(50),
  PRIMARY KEY (`cpf_funcionario`, `mes`, `ano`)
);

CREATE TABLE `pagamentos_funcionarios` (
  `cpf_funcionario` char(11),
  `mes` int,
  `ano` int,
  `data_pagamento` date,
  `metodo_pagamento` varchar(50),
  `comprovante_url` varchar(255),
  PRIMARY KEY (`cpf_funcionario`, `mes`, `ano`, `data_pagamento`)
);

CREATE TABLE `pagamentos_beneficios` (
  `id_pagamento` int PRIMARY KEY AUTO_INCREMENT,
  `tipo` varchar(50),
  `cpf_funcionarios` char(11),
  `comprovante_pagamento` varchar(255),
  `ano` int,
  `mes` int,
  `data_pagamento` date,
  `metodo_pagamento` varchar(50),
  `status` varchar(50)
);


CREATE TABLE `pedidos_compra` (
  `cpf_solicitante` char(11),
  `data_pedido` date,
  `status` varchar(50),
  PRIMARY KEY (`cpf_solicitante`, `data_pedido`)
);

CREATE TABLE `itens_pedido` (
  `cpf_solicitante` char(11),
  `data_pedido` date,
  `descricao` varchar(255),
  `quantidade` int,
  `valor_unitario` decimal(10,2),
  PRIMARY KEY (`cpf_solicitante`, `data_pedido`, `descricao`)
);

CREATE TABLE `frequencias` (
  `cpf_aluno` char(11),
  `codigo_idioma` varchar(3),
  `codigo_nivel` varchar(10),
  `numero_sala` varchar(50),
  `horario` varchar(100),
  `data_aula` date,
  `presente` boolean,
  `observacao` varchar(255),
  PRIMARY KEY (`cpf_aluno`, `codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`, `data_aula`)
);

CREATE TABLE `avaliacoes` (
  `codigo_idioma` varchar(3),
  `codigo_nivel` varchar(10),
  `numero_sala` varchar(50),
  `horario` varchar(100),
  `titulo` varchar(100), 
  `tipo` varchar(50),
  `data_avaliacao` date,
  `peso` decimal(5,2),
  PRIMARY KEY (`codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`, `titulo`)
);

CREATE TABLE `notas` (
  `cpf_aluno` char(11),
  `codigo_idioma` varchar(3),
  `codigo_nivel` varchar(10),
  `numero_sala` varchar(50),
  `horario` varchar(100),
  `titulo_avaliacao` varchar(100), 
  `nota` decimal(5,2),
  `observacao` varchar(255),
  PRIMARY KEY (`cpf_aluno`, `codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`, `titulo_avaliacao`)
);

CREATE TABLE `registros_ponto` (
  `cpf_funcionario` char(11),
  `data` date,
  `hora_entrada` time,
  `hora_saida` time,
  PRIMARY KEY (`cpf_funcionario`, `data`)
);


ALTER TABLE `telefones` ADD FOREIGN KEY (`cpf_pessoa`) REFERENCES `pessoas` (`cpf`);
ALTER TABLE `emails` ADD FOREIGN KEY (`cpf_pessoa`) REFERENCES `pessoas` (`cpf`);
ALTER TABLE `enderecos` ADD FOREIGN KEY (`cpf_pessoa`) REFERENCES `pessoas` (`cpf`);
ALTER TABLE `alunos` ADD FOREIGN KEY (`cpf_aluno`) REFERENCES `pessoas` (`cpf`);
ALTER TABLE `funcionarios` ADD FOREIGN KEY (`cpf_funcionario`) REFERENCES `pessoas` (`cpf`);
ALTER TABLE `cargos_funcionario` ADD FOREIGN KEY (`cpf_funcionario`) REFERENCES `funcionarios` (`cpf_funcionario`);
ALTER TABLE `cargos_funcionario` ADD FOREIGN KEY (`cod_cargo`) REFERENCES `cargos` (`cod_cargo`);

ALTER TABLE `cursos` ADD FOREIGN KEY (`codigo_idioma`) REFERENCES `idiomas` (`codigo_idioma`);
ALTER TABLE `cursos` ADD FOREIGN KEY (`codigo_nivel`) REFERENCES `niveis` (`codigo_nivel`);

ALTER TABLE `turmas` ADD FOREIGN KEY (`codigo_idioma`, `codigo_nivel`) REFERENCES `cursos` (`codigo_idioma`, `codigo_nivel`);
ALTER TABLE `turmas` ADD FOREIGN KEY (`numero_sala`) REFERENCES `salas` (`numero_sala`);
ALTER TABLE `turmas` ADD FOREIGN KEY (`cpf_professor`) REFERENCES `funcionarios` (`cpf_funcionario`);

ALTER TABLE `matriculas` ADD FOREIGN KEY (`cpf_aluno`) REFERENCES `alunos` (`cpf_aluno`);
ALTER TABLE `matriculas` ADD FOREIGN KEY (`codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`) REFERENCES `turmas` (`codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`);

ALTER TABLE `mensalidades` ADD FOREIGN KEY (`cpf_aluno`, `codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`) REFERENCES `matriculas` (`cpf_aluno`, `codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`);

ALTER TABLE `faturamentos` ADD FOREIGN KEY (`cpf_aluno_mens`, `codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`, `data_vencimento`) REFERENCES `mensalidades` (`cpf_aluno`, `codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`, `data_vencimento`);

ALTER TABLE `fornecedores` ADD FOREIGN KEY (`cpf_pessoa`) REFERENCES `pessoas` (`cpf`);
ALTER TABLE `faturas` ADD FOREIGN KEY (`cnpj_fornecedor`) REFERENCES `fornecedores` (`cnpj`);
ALTER TABLE `faturas` ADD FOREIGN KEY (`codigo_categoria`) REFERENCES `categorias_despesas` (`codigo_categoria`);
ALTER TABLE `pagamentos_faturas` ADD FOREIGN KEY (`cnpj_fornecedor`, `numero_fatura`) REFERENCES `faturas` (`cnpj_fornecedor`, `numero_fatura`);

ALTER TABLE `folha_pagamento` ADD FOREIGN KEY (`cpf_funcionario`) REFERENCES `funcionarios` (`cpf_funcionario`);
ALTER TABLE `pagamentos_funcionarios` ADD FOREIGN KEY (`cpf_funcionario`, `mes`, `ano`) REFERENCES `folha_pagamento` (`cpf_funcionario`, `mes`, `ano`);

ALTER TABLE `pagamentos_beneficios` ADD FOREIGN KEY (`tipo`) REFERENCES `beneficios` (`tipo`);
ALTER TABLE `pagamentos_beneficios` ADD FOREIGN KEY (`cpf_funcionarios`) REFERENCES `funcionarios` (`cpf_funcionario`);

ALTER TABLE `pedidos_compra` ADD FOREIGN KEY (`cpf_solicitante`) REFERENCES `pessoas` (`cpf`);
ALTER TABLE `itens_pedido` ADD FOREIGN KEY (`cpf_solicitante`, `data_pedido`) REFERENCES `pedidos_compra` (`cpf_solicitante`, `data_pedido`);

ALTER TABLE `frequencias` ADD FOREIGN KEY (`cpf_aluno`, `codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`) REFERENCES `matriculas` (`cpf_aluno`, `codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`);
ALTER TABLE `avaliacoes` ADD FOREIGN KEY (`codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`) REFERENCES `turmas` (`codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`);

ALTER TABLE `notas` ADD FOREIGN KEY (`cpf_aluno`, `codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`) REFERENCES `matriculas` (`cpf_aluno`, `codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`);
ALTER TABLE `notas` ADD FOREIGN KEY (`codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`, `titulo_avaliacao`) REFERENCES `avaliacoes` (`codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`, `titulo`);
