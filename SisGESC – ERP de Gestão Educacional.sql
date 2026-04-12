CREATE TABLE `pessoas` (
  `cpf` char(11) UNIQUE PRIMARY KEY NOT NULL,
  `nome` varchar(255),
  `data_nascimento` date
);

CREATE TABLE `telefones` (
  `cpf_pessoa` char(11),
  `ddd` char(2),
  `numero` varchar(9),
  `tipo` varchar(255),
  PRIMARY KEY (`cpf_pessoa`, `ddd`, `numero`)
);

CREATE TABLE `emails` (
  `cpf_pessoa` char(11),
  `email` varchar(255) UNIQUE,
  PRIMARY KEY (`cpf_pessoa`, `email`)
);

CREATE TABLE `enderecos` (
  `cpf_pessoa` char(11),
  `tipo` varchar(255),
  `cep` varchar(8),
  `numero` varchar(255),
  `rua` varchar(255),
  `complemento` varchar(255),
  `bairro` varchar(255),
  `cidade` varchar(255),
  `estado` char(2),
  PRIMARY KEY (`cpf_pessoa`, `cep`, `numero`)
);

CREATE TABLE `alunos` (
  `cpf_aluno` char(11) PRIMARY KEY,
  `status` varchar(255)
);

CREATE TABLE `funcionarios` (
  `cpf_funcionario` char(11) PRIMARY KEY,
  `data_contratacao` date,
  `status` varchar(255)
);

CREATE TABLE `cargos` (
  `cod_cargo` int PRIMARY KEY,
  `nome_cargo` varchar(255)
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
  `valor_inicial` decimal NOT NULL COMMENT 'valor inicial se vr ou vale transporte ou ambos',
  `valor_final` decimal NOT NULL
);

CREATE TABLE `idiomas` (
  `codigo_idioma` varchar(3) PRIMARY KEY,
  `nome` varchar(255)
);

CREATE TABLE `niveis` (
  `codigo_nivel` varchar(10) PRIMARY KEY,
  `nome` varchar(255)
);

CREATE TABLE `cursos` (
  `codigo_idioma` varchar(3),
  `codigo_nivel` varchar(10),
  `nome_curso` varchar(255),
  `carga_horaria` int,
  PRIMARY KEY (`codigo_idioma`, `codigo_nivel`)
);

CREATE TABLE `salas` (
  `numero_sala` varchar(255) PRIMARY KEY,
  `capacidade` int
);

CREATE TABLE `turmas` (
  `codigo_idioma` varchar(3),
  `codigo_nivel` varchar(10),
  `numero_sala` varchar(255),
  `horario` varchar(255),
  `cpf_professor` char(11),
  `data_inicio` date,
  `data_fim` date,
  `status` varchar(255),
  PRIMARY KEY (`codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`)
);

CREATE TABLE `professores_turmas` (
  `cpf_professor` char(11),
  `codigo_idioma` varchar(3),
  `codigo_nivel` varchar(10),
  `numero_sala` varchar(255),
  `horario` varchar(255),
  PRIMARY KEY (`cpf_professor`, `codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`)
);

CREATE TABLE `aulas` (
  `codigo_idioma` varchar(3),
  `codigo_nivel` varchar(10),
  `numero_sala` varchar(255),
  `horario` varchar(255),
  `data_aula` date,
  `cpf_professor` char(11),
  `hora_inicio` time,
  `intervalo` time,
  `hora_fim` time,
  `status` varchar(255),
  PRIMARY KEY (`codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`, `data_aula`)
);

CREATE TABLE `matriculas` (
  `cpf_aluno` char(11),
  `codigo_idioma` varchar(3),
  `codigo_nivel` varchar(10),
  `numero_sala` varchar(255),
  `horario` varchar(255),
  `data_matricula` date,
  `desconto` decimal,
  `bolsa` decimal,
  `status` varchar(255),
  PRIMARY KEY (`cpf_aluno`, `codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`)
);

CREATE TABLE `mensalidades` (
  `cpf_aluno` char(11),
  `codigo_idioma` varchar(3),
  `codigo_nivel` varchar(10),
  `numero_sala` varchar(255),
  `horario` varchar(255),
  `data_vencimento` date UNIQUE,
  `data_pagamento` date UNIQUE,
  `valor` decimal,
  `status` varchar(255),
  PRIMARY KEY (`cpf_aluno`, `codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`, `data_vencimento`, `data_pagamento`)
);

CREATE TABLE `faturamentos` (
  `numero_documento` varchar(255) PRIMARY KEY,
  `cpf_aluno` char(11),
  `cpf_aluno_mens` char(11),
  `codigo_idioma` varchar(3),
  `codigo_nivel` varchar(10),
  `numero_sala` varchar(255),
  `horario` varchar(255),
  `data_vencimento` date,
  `tipo_documento` varchar(255),
  `data_emissao` date,
  `valor` decimal
);

CREATE TABLE `fornecedores` (
  `cnpj` char(14) PRIMARY KEY,
  `cpf_pessoa` char(11),
  `nome_fantasia` varchar(255)
);

CREATE TABLE `categorias_despesas` (
  `codigo_categoria` varchar(10) PRIMARY KEY,
  `nome` varchar(255),
  `tipo` varchar(255)
);

CREATE TABLE `faturas` (
  `cnpj_fornecedor` char(14),
  `numero_fatura` varchar(255),
  `codigo_categoria` varchar(10),
  `descricao` varchar(255),
  `valor_original` decimal,
  `juros` decimal,
  `multa` decimal,
  `data_emissao` date,
  `data_vencimento` date,
  `status` varchar(255),
  PRIMARY KEY (`cnpj_fornecedor`, `numero_fatura`)
);

CREATE TABLE `pagamentos_faturas` (
  `cnpj_fornecedor` char(14),
  `numero_fatura` varchar(255),
  `data_pagamento` date,
  `valor_pago` decimal,
  `metodo_pagamento` varchar(255),
  `comprovante_url` varchar(255),
  PRIMARY KEY (`cnpj_fornecedor`, `numero_fatura`, `data_pagamento`)
);

CREATE TABLE `folha_pagamento` (
  `cpf_funcionario` char(11),
  `mes` int,
  `ano` int,
  `valor_base` decimal,
  `bonus` decimal,
  `descontos` decimal,
  `valor_final` decimal,
  `status` varchar(255),
  PRIMARY KEY (`cpf_funcionario`, `mes`, `ano`)
);

CREATE TABLE `pagamentos_funcionarios` (
  `cpf_funcionario` char(11),
  `mes` int,
  `ano` int,
  `data_pagamento` date,
  `metodo_pagamento` varchar(255),
  `comprovante_url` varchar(255),
  PRIMARY KEY (`cpf_funcionario`, `mes`, `ano`, `data_pagamento`)
);

CREATE TABLE `pagamentos_beneficios` (
  `tipo` varchar(50),
  `cpf_funcionarios` char(11),
  `comprovante_pagamento` varchar(255),
  `ano` int,
  `mes` int,
  `data_pagamento` date,
  `metodo_pagamento` varchar(255) COMMENT 'pix, boleto, transferencia',
  `status` varchar(255) COMMENT 'pendente, pago'
);

CREATE TABLE `pedidos_compra` (
  `cpf_solicitante` char(11),
  `data_pedido` date,
  `status` varchar(255),
  PRIMARY KEY (`cpf_solicitante`, `data_pedido`)
);

CREATE TABLE `itens_pedido` (
  `cpf_solicitante` char(11),
  `data_pedido` date,
  `descricao` varchar(255),
  `quantidade` int,
  `valor_unitario` decimal,
  PRIMARY KEY (`cpf_solicitante`, `data_pedido`, `descricao`)
);

CREATE TABLE `contas_pagar_pedidos` (
  `cpf_solicitante` char(11),
  `data_pedido` date,
  `cnpj_fornecedor` char(14),
  `numero_fatura` varchar(255),
  PRIMARY KEY (`cpf_solicitante`, `data_pedido`, `cnpj_fornecedor`, `numero_fatura`)
);

CREATE TABLE `frequencias` (
  `cpf_aluno` char(11),
  `codigo_idioma` varchar(3),
  `codigo_nivel` varchar(10),
  `numero_sala` varchar(255),
  `horario` varchar(255),
  `data_aula` date,
  `presente` boolean,
  `observacao` varchar(255),
  PRIMARY KEY (`cpf_aluno`, `codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`, `data_aula`)
);

CREATE TABLE `avaliacoes` (
  `codigo_idioma` varchar(3),
  `codigo_nivel` varchar(10),
  `numero_sala` varchar(255),
  `horario` varchar(255),
  `titulo` varchar(255),
  `tipo` varchar(255),
  `data_avaliacao` date,
  `peso` decimal,
  PRIMARY KEY (`codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`, `titulo`)
);

CREATE TABLE `notas` (
  `cpf_aluno` char(11),
  `codigo_idioma` varchar(3),
  `codigo_nivel` varchar(10),
  `numero_sala` varchar(255),
  `horario` varchar(255),
  `titulo_avaliacao` varchar(255),
  `nota` decimal,
  `observacao` varchar(255),
  PRIMARY KEY (`cpf_aluno`, `codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`, `titulo_avaliacao`)
);

CREATE TABLE `jornadas_trabalho` (
  `cpf_funcionario` char(11),
  `dia_semana` int,
  `hora_inicio` time,
  `hora_fim` time,
  PRIMARY KEY (`cpf_funcionario`, `dia_semana`)
);

CREATE TABLE `registros_ponto` (
  `cpf_funcionario` char(11),
  `data` date,
  `hora_entrada` time,
  `hora_saida` time,
  PRIMARY KEY (`cpf_funcionario`, `data`)
);

CREATE TABLE `horas_extras` (
  `cpf_funcionario` char(11),
  `data` date,
  `quantidade_horas` decimal,
  `tipo` varchar(255),
  `aprovado` boolean,
  PRIMARY KEY (`cpf_funcionario`, `data`)
);

CREATE INDEX `pagamentos_beneficios_index_0` ON `pagamentos_beneficios` (`cpf_funcionarios`, `comprovante_pagamento`, `ano`, `mes`);

ALTER TABLE `telefones` ADD FOREIGN KEY (`cpf_pessoa`) REFERENCES `pessoas` (`cpf`);

ALTER TABLE `emails` ADD FOREIGN KEY (`cpf_pessoa`) REFERENCES `pessoas` (`cpf`);

ALTER TABLE `enderecos` ADD FOREIGN KEY (`cpf_pessoa`) REFERENCES `pessoas` (`cpf`);

ALTER TABLE `alunos` ADD FOREIGN KEY (`cpf_aluno`) REFERENCES `pessoas` (`cpf`);

ALTER TABLE `funcionarios` ADD FOREIGN KEY (`cpf_funcionario`) REFERENCES `pessoas` (`cpf`);

ALTER TABLE `cargos_funcionario` ADD FOREIGN KEY (`cpf_funcionario`) REFERENCES `funcionarios` (`cpf_funcionario`);

ALTER TABLE `cargos_funcionario` ADD FOREIGN KEY (`cod_cargo`) REFERENCES `cargos` (`cod_cargo`);

ALTER TABLE `beneficios` ADD FOREIGN KEY (`tipo`) REFERENCES `funcionarios` (`cpf_funcionario`);

ALTER TABLE `cursos` ADD FOREIGN KEY (`codigo_idioma`) REFERENCES `idiomas` (`codigo_idioma`);

ALTER TABLE `cursos` ADD FOREIGN KEY (`codigo_nivel`) REFERENCES `niveis` (`codigo_nivel`);

ALTER TABLE `turmas` ADD FOREIGN KEY (`codigo_idioma`) REFERENCES `cursos` (`codigo_idioma`);

ALTER TABLE `turmas` ADD FOREIGN KEY (`codigo_nivel`) REFERENCES `cursos` (`codigo_nivel`);

ALTER TABLE `turmas` ADD FOREIGN KEY (`numero_sala`) REFERENCES `salas` (`numero_sala`);

ALTER TABLE `turmas` ADD FOREIGN KEY (`cpf_professor`) REFERENCES `funcionarios` (`cpf_funcionario`);

ALTER TABLE `professores_turmas` ADD FOREIGN KEY (`cpf_professor`) REFERENCES `funcionarios` (`cpf_funcionario`);

ALTER TABLE `professores_turmas` ADD FOREIGN KEY (`codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`) REFERENCES `turmas` (`codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`);

ALTER TABLE `aulas` ADD FOREIGN KEY (`cpf_professor`) REFERENCES `funcionarios` (`cpf_funcionario`);

ALTER TABLE `aulas` ADD FOREIGN KEY (`codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`) REFERENCES `turmas` (`codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`);

ALTER TABLE `matriculas` ADD FOREIGN KEY (`cpf_aluno`) REFERENCES `alunos` (`cpf_aluno`);

ALTER TABLE `matriculas` ADD FOREIGN KEY (`codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`) REFERENCES `turmas` (`codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`);

ALTER TABLE `mensalidades` ADD FOREIGN KEY (`cpf_aluno`, `codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`) REFERENCES `matriculas` (`cpf_aluno`, `codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`);

ALTER TABLE `faturamentos` ADD FOREIGN KEY (`cpf_aluno`) REFERENCES `alunos` (`cpf_aluno`);

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

ALTER TABLE `contas_pagar_pedidos` ADD FOREIGN KEY (`cpf_solicitante`, `data_pedido`) REFERENCES `pedidos_compra` (`cpf_solicitante`, `data_pedido`);

ALTER TABLE `contas_pagar_pedidos` ADD FOREIGN KEY (`cnpj_fornecedor`, `numero_fatura`) REFERENCES `faturas` (`cnpj_fornecedor`, `numero_fatura`);

ALTER TABLE `frequencias` ADD FOREIGN KEY (`cpf_aluno`, `codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`) REFERENCES `matriculas` (`cpf_aluno`, `codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`);

ALTER TABLE `frequencias` ADD FOREIGN KEY (`codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`, `data_aula`) REFERENCES `aulas` (`codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`, `data_aula`);

ALTER TABLE `avaliacoes` ADD FOREIGN KEY (`codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`) REFERENCES `turmas` (`codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`);

ALTER TABLE `notas` ADD FOREIGN KEY (`cpf_aluno`, `codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`) REFERENCES `matriculas` (`cpf_aluno`, `codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`);

ALTER TABLE `notas` ADD FOREIGN KEY (`codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`, `titulo_avaliacao`) REFERENCES `avaliacoes` (`codigo_idioma`, `codigo_nivel`, `numero_sala`, `horario`, `titulo`);

ALTER TABLE `jornadas_trabalho` ADD FOREIGN KEY (`cpf_funcionario`) REFERENCES `funcionarios` (`cpf_funcionario`);

ALTER TABLE `registros_ponto` ADD FOREIGN KEY (`cpf_funcionario`) REFERENCES `funcionarios` (`cpf_funcionario`);

ALTER TABLE `horas_extras` ADD FOREIGN KEY (`cpf_funcionario`, `data`) REFERENCES `registros_ponto` (`cpf_funcionario`, `data`);

ALTER TABLE `cursos` ADD FOREIGN KEY (`nome_curso`) REFERENCES `notas` (`codigo_nivel`);
