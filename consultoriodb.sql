-- MySQL Script generated by MySQL Workbench
-- 07/22/17 01:16:11
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema consultoriodb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema consultoriodb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `consultoriodb` DEFAULT CHARACTER SET utf8 ;
USE `consultoriodb` ;

-- -----------------------------------------------------
-- Table `consultoriodb`.`paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consultoriodb`.`paciente` (
  `num_historia` INT(20) NOT NULL,
  `nombres` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `documento_identidad` VARCHAR(10) NOT NULL,
  `sexo` VARCHAR(1) NOT NULL,
  `telefono` VARCHAR(20) NOT NULL,
  `celular` VARCHAR(9) NOT NULL,
  `correo` VARCHAR(45) NULL,
  `fecha_nac` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`num_historia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `consultoriodb`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consultoriodb`.`estado` (
  `idestado` VARCHAR(20) NOT NULL,
  `tipo_estado` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idestado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `consultoriodb`.`cita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consultoriodb`.`cita` (
  `idcita` INT(20) NOT NULL AUTO_INCREMENT,
  `num_historia` INT(20) NULL,
  `hora_inicio` VARCHAR(4) NULL,
  `hora_fin` VARCHAR(4) NULL,
  `fecha` VARCHAR(8) NOT NULL,
  `idestado` VARCHAR(20) NOT NULL,
  `turno` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcita`),
  INDEX `num_historia_idx` (`num_historia` ASC),
  INDEX `idestado_idx` (`idestado` ASC),
  CONSTRAINT `num_historia`
    FOREIGN KEY (`num_historia`)
    REFERENCES `consultoriodb`.`paciente` (`num_historia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idestado`
    FOREIGN KEY (`idestado`)
    REFERENCES `consultoriodb`.`estado` (`idestado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `consultoriodb`.`historico_pagos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consultoriodb`.`historico_pagos` (
  `idpresupuesto` INT(20) NOT NULL AUTO_INCREMENT,
  `num_historia` INT(20) NOT NULL,
  `descripción` VARCHAR(45) NOT NULL,
  `cantidad` VARCHAR(10) NOT NULL,
  `precio` VARCHAR(20) NOT NULL,
  `saldo_deudor` VARCHAR(45) NULL,
  `saldo_acreedor` VARCHAR(45) NULL,
  `fecha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idpresupuesto`),
  INDEX `num_historia_idx` (`num_historia` ASC),
  CONSTRAINT `historia`
    FOREIGN KEY (`num_historia`)
    REFERENCES `consultoriodb`.`paciente` (`num_historia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `consultoriodb`.`servicio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consultoriodb`.`servicio` (
  `idservicio` VARCHAR(20) NOT NULL,
  `nombre_servicio` VARCHAR(45) NOT NULL,
  `duracion` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`idservicio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `consultoriodb`.`historico_citas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consultoriodb`.`historico_citas` (
  `idhistorico_citas` INT(20) NOT NULL,
  `id_servicio` VARCHAR(20) NULL,
  `historia` INT(20) NULL,
  `idcita` INT(20) NULL,
  PRIMARY KEY (`idhistorico_citas`),
  INDEX `id_servicio_idx` (`id_servicio` ASC),
  INDEX `historia_idx` (`historia` ASC),
  INDEX `idcita_idx` (`idcita` ASC),
  CONSTRAINT `id_servicio`
    FOREIGN KEY (`id_servicio`)
    REFERENCES `consultoriodb`.`servicio` (`idservicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `historia`
    FOREIGN KEY (`historia`)
    REFERENCES `consultoriodb`.`paciente` (`num_historia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idcita`
    FOREIGN KEY (`idcita`)
    REFERENCES `consultoriodb`.`cita` (`idcita`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
