-- MySQL Script generated by MySQL Workbench
-- Thu Apr 20 12:31:47 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
drop database `bd-medserver-sentinel`;
-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bd-medserver-sentinel` DEFAULT CHARACTER SET utf8 ;
USE `bd-medserver-sentinel` ;

-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Maquina (
  id_maquina INT NOT NULL auto_increment,
  nome VARCHAR(45),
  tipo VARCHAR(45),
  cod_MAC VARCHAR(45) NOT NULL,
  andar VARCHAR(45),
  setor VARCHAR(45),
  PRIMARY KEY (id_maquina))
ENGINE = InnoDB;


-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS MemoriaRam (
  id_ram INT NOT NULL auto_increment,
  capacidade_total VARCHAR(45) NOT NULL,
  fk_maquina INT UNIQUE NOT NULL,
  PRIMARY KEY (id_ram),
  CONSTRAINT fk_ram_Maquina1
    FOREIGN KEY (fk_maquina)
    REFERENCES Maquina (id_maquina)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS DadosRam (
  id_dados_ram INT NOT NULL auto_increment,
  em_uso VARCHAR(45) NOT NULL,
  disponivel VARCHAR(45)NOT NULL,
  data_hora DATETIME NOT NULL,
  fk_ram INT NOT NULL,
  PRIMARY KEY (id_dados_ram),
  CONSTRAINT fk_dados_ram_ram1
    FOREIGN KEY (fk_ram)
    REFERENCES MemoriaRam (id_ram)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Processador (
  id_processador INT NOT NULL auto_increment,
  nome_processador VARCHAR(200) NOT NULL,
  frequencia VARCHAR(45) NOT NULL,
  num_nucleo INT NOT NULL,
  fk_maquina INT UNIQUE NOT NULL,
  PRIMARY KEY (id_processador),
  CONSTRAINT fk_cpu_Maquina1
    FOREIGN KEY (fk_maquina)
    REFERENCES Maquina (id_maquina)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Processo (
  id_processo INT NOT NULL auto_increment,
  pid INT NOT NULL,
  nome VARCHAR(45) NOT NULL,
  uso_cpu DOUBLE NOT NULL,
  uso_ram DOUBLE NOT NULL,
  data_hora DATETIME NOT NULL,
  fk_processador INT NOT NULL,
  PRIMARY KEY (id_processo),
  CONSTRAINT fk_pross_cpu1
    FOREIGN KEY (fk_processador)
    REFERENCES Processador (id_processador)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Janela (
  id_janela INT NOT NULL auto_increment,
  pid INT NOT NULL,
  titulo VARCHAR(200) CHARACTER SET utf8mb4 NOT NULL,
  comando VARCHAR(200) NOT NULL,
  data_hora DATETIME NOT NULL,
  fk_processador INT NOT NULL,
  PRIMARY KEY (id_janela),
  CONSTRAINT fk_janela_cpu1
    FOREIGN KEY (fk_processador)
    REFERENCES Processador (id_processador)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Disco (
  id_disco INT NOT NULL auto_increment,
	nome VARCHAR(45) NOT NULL,
    tipo VARCHAR(45) NOT NULL,
    total VARCHAR(45) NOT NULL,
    disponivel VARCHAR(45) NOT NULL,
    uuid VARCHAR(45) NOT NULL,
  fk_maquina INT NOT NULL,
  PRIMARY KEY (id_disco),
  CONSTRAINT fk_disco_Maquina1
    FOREIGN KEY (fk_maquina)
    REFERENCES Maquina (id_maquina)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS DadosDisco (
  id_dados_disco INT NOT NULL auto_increment,
  velocida_escrita  VARCHAR(45) NOT NULL,
  velocidade_leitura  VARCHAR(45) NOT NULL,
  tempo_escrita  VARCHAR(45) NOT NULL,
  data_hora DATETIME NOT NULL,
  fk_disco INT NOT NULL,
  PRIMARY KEY (id_dados_disco),
  CONSTRAINT fk_Disco_disco1
    FOREIGN KEY (fk_disco)
    REFERENCES Disco (id_disco)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS SistemaOperacional (
  id_sistema INT NOT NULL auto_increment,
  fabricante VARCHAR(45) NOT NULL,
  tipo_sistema VARCHAR(45) NOT NULL,
  arquitetura VARCHAR(45) NOT NULL,
  tempo_atividade VARCHAR(45) NOT NULL,
  fk_maquina INT UNIQUE NOT NULL,
  PRIMARY KEY (id_sistema),
  CONSTRAINT fk_SISTEMA_OPERACIONAL_Maquina1
    FOREIGN KEY (fk_maquina)
    REFERENCES Maquina (id_maquina)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
