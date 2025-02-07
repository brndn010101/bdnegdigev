-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Distribuidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Distribuidor` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Marca` NVARCHAR(50) NOT NULL,
  `Descripcion` NVARCHAR(200) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Genero` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Nombre` NVARCHAR(50) NOT NULL,
  `CompID` INT NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Plataforma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Plataforma` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Nombre` NVARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Videojuego`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Videojuego` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Nombre` NVARCHAR(30) NOT NULL,
  `FechaLanzamiento` DATE NOT NULL,
  `UnidadesDisponibles` INT NOT NULL,
  `Descripcion` NVARCHAR(200) NULL,
  `DistribuidorID` INT NOT NULL,
  `GeneroID` INT NOT NULL,
  `PlataformaID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `FK_Videojuego_Distribuidor_idx` (`DistribuidorID` ASC) VISIBLE,
  INDEX `FK_Videojuego_Plataforma_idx` (`PlataformaID` ASC) VISIBLE,
  CONSTRAINT `FK_Videojuego_Distribuidor`
    FOREIGN KEY (`DistribuidorID`)
    REFERENCES `mydb`.`Distribuidor` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Videojuego_Genero`
    FOREIGN KEY (`GeneroID`)
    REFERENCES `mydb`.`Genero` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Videojuego_Plataforma`
    FOREIGN KEY (`PlataformaID`)
    REFERENCES `mydb`.`Plataforma` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
