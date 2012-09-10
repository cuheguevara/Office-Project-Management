-- phpMyAdmin SQL Dump
-- version 3.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 11, 2012 at 12:08 AM
-- Server version: 5.5.25a
-- PHP Version: 5.4.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `db_opm`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `sp_departemen_delete`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_departemen_delete`(IN `i_departemenID` varchar(50),IN `i_departemenNama` varchar(50), IN `i_alamatIP` varchar(150),IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefdepartemen_delete(i_departemenID,i_departemenNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_departemen_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_departemen_insert`(IN `i_departemenID` varchar(50),IN `i_departemenNama` varchar(50), IN `i_alamatIP` varchar(150),IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefdepartemen_insert(i_departemenID,i_departemenNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_departemen_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_departemen_update`(IN `i_departemenID` varchar(50),IN `i_departemenNama` varchar(50), IN `i_alamatIP` varchar(150),IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefdepartemen_update(i_departemenID,i_departemenNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_GetModuleAuthenticationByUsername`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetModuleAuthenticationByUsername`(IN `i_username` varchar(50))
BEGIN
	#Routine body goes here...
	SELECT
tref_user.username,
conf_modul.modulID,
conf_modul.modulNama,
conf_modul.modulPage_Form_Controller,
conf_modul.picture,
conf_modul.link,
tref_user.`password`,
t_hakakses.is_grant
FROM
t_hakakses
INNER JOIN conf_modul ON t_hakakses.modulID = conf_modul.modulID
INNER JOIN tref_user ON t_hakakses.username = tref_user.username
WHERE	t_hakakses.username = i_username AND t_hakakses.is_grant='Y';
END$$

DROP PROCEDURE IF EXISTS `sp_GetUserByNIP`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetUserByNIP`(IN `i_nip` vaRCHAR(50))
BEGIN
	#Routine body goes here...
SELECT DISTINCT
tref_leveluser.levelID,
tref_user.nip,
tref_user.username,
tref_user.`password`,
tref_leveluser.levelName,
tref_leveluser.levelSlug,
tref_user.userID,
tref_karyawan.namalengkap,
tref_kota.kotaNama,
tref_propinsi.propinsiNama,
tref_karyawan.namapanggilan,
tref_karyawan.alamat,
tref_karyawan.nomortelepon,
tref_karyawan.tanggalmasuk,
tref_karyawan.tanggallahir,
fnKotaById(tref_karyawan.tempatlahir) as kotalahir ,
tref_karyawan.noregistrasikaryawan
FROM
tref_user
INNER JOIN tref_leveluser ON tref_leveluser.levelID = tref_user.levelID
INNER JOIN tref_karyawan ON tref_karyawan.nip = tref_user.nip
INNER JOIN tref_kota ON tref_karyawan.kotaID = tref_kota.kotaID 
INNER JOIN tref_propinsi ON tref_propinsi.propinsiID = tref_kota.propinsiID AND tref_propinsi.propinsiID = tref_karyawan.propinsiID
WHERE	
	tref_user.nip = i_nip ;
END$$

DROP PROCEDURE IF EXISTS `sp_GetUserByUserNameAndPassword`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetUserByUserNameAndPassword`(IN `i_username` varchar(50), IN `i_password` varchar(50))
BEGIN
	#Routine body goes here...
SELECT DISTINCT
tref_leveluser.levelID,
tref_user.nip,
tref_user.username,
tref_user.`password`,
tref_leveluser.levelName,
tref_leveluser.levelSlug,
tref_user.userID,
tref_karyawan.namalengkap,
tref_karyawan.kotaID,
tref_karyawan.propinsiID,
fnKotaByID(tref_karyawan.kotaID,tref_karyawan.propinsiID) as kotaNama,
tref_karyawan.namapanggilan,
tref_karyawan.alamat,
tref_karyawan.nomortelepon,
tref_karyawan.tanggalmasuk,
tref_karyawan.tanggallahir,
fnKotaById(tref_karyawan.tempatlahir,tref_karyawan.propinsiID) as kotalahir ,
tref_karyawan.noregistrasikaryawan
FROM
tref_user
INNER JOIN tref_leveluser ON tref_leveluser.levelID = tref_user.levelID
INNER JOIN tref_karyawan ON tref_karyawan.nip = tref_user.nip
WHERE	
	tref_user.username = username AND tref_user.`password` = i_password;
END$$

DROP PROCEDURE IF EXISTS `sp_jabatan_delete`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_jabatan_delete`(IN `i_jabatanID` varchar(50),IN `i_jabatanNama` varchar(50), IN `i_alamatIP` varchar(150),IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefjabatan_delete(i_jabatanID,i_jabatanNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_jabatan_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_jabatan_insert`(IN `i_jabatanID` varchar(50),IN `i_jabatanNama` varchar(50), IN `i_alamatIP` varchar(150),IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefjabatan_insert(i_jabatanID,i_jabatanNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_jabatan_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_jabatan_update`(IN `i_jabatanID` varchar(50),IN `i_jabatanNama` varchar(50), IN `i_alamatIP` varchar(150),IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefjabatan_update(i_jabatanID,i_jabatanNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_karyawan_insert_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_karyawan_insert_update`(IN `i_manufakturID` varchar(50), IN `i_manufakturNama` varchar(50), IN `i_alamatIP` varchar(150), IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefmanufaktur_insert(i_manufakturID,i_manufakturNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_propinsi_delete`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_propinsi_delete`(IN `i_propinsiID` varchar(50),IN `i_propinsiNama` varchar(50), IN `i_alamatIP` varchar(150),IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefpropinsi_delete(i_propinsiID,i_propinsiNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_propinsi_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_propinsi_insert`(IN `i_propinsiID` varchar(50),IN `i_propinsiNama` varchar(50), IN `i_alamatIP` varchar(150),IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefpropinsi_insert(i_propinsiID,i_propinsiNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_propinsi_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_propinsi_update`(IN `i_propinsiID` varchar(50),IN `i_propinsiNama` varchar(50), IN `i_alamatIP` varchar(150),IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	/* Declare a control variable that manages transaction
     success or failure. */
  DECLARE lv_success_value  INT DEFAULT FALSE;
	
  /* Start a transaction context. */
  START TRANSACTION;
 
  /* Set a SAVEPOINT in the transaction context. */
  SAVEPOINT before_transaction;
 
  /* Call the function. */
  SET lv_success_value := fn_trefpropinsi_update(i_propinsiID,i_propinsiNama,i_alamatIP,i_user);
 
  /* Check the status of the control variable, and commit
     or rollback the transaction. */
  IF lv_success_value = TRUE THEN
    COMMIT;
		SELECT 'OK' AS HASIL;
  ELSE
    ROLLBACK TO before_transaction;
	SELECT 'NOK' AS HASIL;
  END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_tlog_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tlog_insert`(IN `i_aktivitas` varchar(15), IN `i_table` varchar(50), IN `i_penjelasan` text, IN `i_alamatIP` varchar(150), IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	DECLARE logid VARCHAR(150);
	SET logid = UUID();

	INSERT INTO t_log
	(logID, logAktivitas, logTable, logPenjelasan, logKomputer, logTerakhir, logUser)
	VALUES
	(logid, i_aktivitas, i_table,i_penjelasan,i_alamatIP,SYSDATE(),i_user);

END$$

--
-- Functions
--
DROP FUNCTION IF EXISTS `fnBankByID`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fnBankByID`(`ibankID` int) RETURNS varchar(150) CHARSET latin1
BEGIN
	#Routine body goes here...
	SET @namaBank = '';
SELECT tref_bank.bankName AS bank INTO @namaBank FROM tref_bank WHERE tref_bank.bankID = ibankID LIMIT 1;
  RETURN @namaBank;
END$$

DROP FUNCTION IF EXISTS `fnCabangByIDBankIDCabang`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fnCabangByIDBankIDCabang`(`iBankID` varchar(5), `iCabangID` INT) RETURNS varchar(150) CHARSET latin1
BEGIN
	#Routine body goes here...
	SET @namaCabang = '';
SELECT tref_bank_cabang.cabangNama AS bankCabang INTO @namaCabang FROM tref_bank_cabang WHERE tref_bank_cabang.bankID = iBankID AND tref_bank_cabang.cabangID=iCabangID LIMIT 1;
  RETURN @namaCabang;
END$$

DROP FUNCTION IF EXISTS `fnCityByID`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fnCityByID`(`kotaID` int) RETURNS varchar(150) CHARSET latin1
BEGIN
	#Routine body goes here...
	SET @namaKota = '';
SELECT kotaNama AS kota INTO @namaKota FROM tref_city WHERE kotaID = kotaID LIMIT 1;
  RETURN @namaKota;
END$$

DROP FUNCTION IF EXISTS `fnKotaByID`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fnKotaByID`(`kotaID` int, `ipropinsiID` INT) RETURNS varchar(50) CHARSET latin1
BEGIN
	#Routine body goes here...
	SET @namaKota = '';
SELECT kotaNama AS kota INTO @namaKota FROM tref_city WHERE kotaID = kotaID AND tref_city.propinsiID=ipropinsiID LIMIT 1;
  RETURN @namaKota;
END$$

DROP FUNCTION IF EXISTS `fnPropinsiByID`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fnPropinsiByID`(`ipropinsiID` INT) RETURNS varchar(50) CHARSET latin1
BEGIN
	#Routine body goes here...
	SET @namaPropinsi = '';
SELECT tref_propinsi.propinsiNama AS propinsi INTO @namaPropinsi FROM tref_propinsi WHERE tref_propinsi.propinsiID=ipropinsiID LIMIT 1;
  RETURN @namaPropinsi;
END$$

DROP FUNCTION IF EXISTS `fn_trefdepartemen_delete`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefdepartemen_delete`(`i_departemenID` varchar(50),`i_departemenNama` varchar(50), `i_alamatIP` varchar(64),`i_user` varchar(64)) RETURNS int(11)
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);
	
  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
 
  /* DELETE statement with auto commit enabled. */
  DELETE FROM tref_departemen WHERE departemenID=i_departemenID;
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('departemenID','=',i_departemenID,'|','departemenNama','=',i_departemenNama); 

	/* catat log */
	CALL sp_tlog_insert('DELETE','TREF_DEPARTEMEN',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DROP FUNCTION IF EXISTS `fn_trefdepartemen_insert`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefdepartemen_insert`(`i_departemenID` varchar(50),`i_departemenNama` varchar(50), `i_alamatIP` varchar(64),`i_user` varchar(64)) RETURNS int(11)
    MODIFIES SQL DATA
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);
	
  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
 
  /* Insert statement with auto commit enabled. */
  INSERT INTO tref_departemen (tref_departemen.departemenID,tref_departemen.departemenNama) VALUES (i_departemenID,i_departemenNama);
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('departemenID','=',i_departemenID,'|','departemenNama','=',i_departemenNama); 

	/* catat log */
	CALL sp_tlog_insert('INSERT','TREF_DEPARTEMEN',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DROP FUNCTION IF EXISTS `fn_trefdepartemen_update`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefdepartemen_update`(`i_departemenID` varchar(50),`i_departemenNama` varchar(50), `i_alamatIP` varchar(64),`i_user` varchar(64)) RETURNS int(11)
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);

  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
	

	/* Insert statement with auto commit enabled. */
  UPDATE tref_departemen SET departemenNama=i_departemenNama WHERE departemenID=i_departemenID;
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('departemenID','=',i_departemenID,'|','departemenNama','=',i_departemenNama); 

	/* catat log */
	CALL sp_tlog_insert('UPDATE','TREF_DEPARTEMEN',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DROP FUNCTION IF EXISTS `fn_trefjabatan_delete`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefjabatan_delete`(`i_jabatanID` varchar(50),`i_jabatanNama` varchar(50), `i_alamatIP` varchar(64),`i_user` varchar(64)) RETURNS int(11)
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);
	
  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
 
  /* DELETE statement with auto commit enabled. */
  DELETE FROM tref_jabatan WHERE jabatanID=i_jabatanID;
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('jabatanID','=',i_jabatanID,'|','jabatanNama','=',i_jabatanNama); 

	/* catat log */
	CALL sp_tlog_insert('DELETE','TREF_JABATAN',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DROP FUNCTION IF EXISTS `fn_trefjabatan_insert`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefjabatan_insert`(`i_jabatanID` varchar(50),`i_jabatanNama` varchar(50), `i_alamatIP` varchar(64),`i_user` varchar(64)) RETURNS int(11)
    MODIFIES SQL DATA
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);
	
  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
 
  /* Insert statement with auto commit enabled. */
  INSERT INTO tref_jabatan (tref_jabatan.jabatanID,tref_jabatan.jabatanNama) VALUES (i_jabatanID,i_jabatanNama);
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('jabatanID','=',i_jabatanID,'|','jabatanNama','=',i_jabatanNama); 

	/* catat log */
	CALL sp_tlog_insert('INSERT','TREF_JABATAN',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DROP FUNCTION IF EXISTS `fn_trefjabatan_update`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefjabatan_update`(`i_jabatanID` varchar(50),`i_jabatanNama` varchar(50), `i_alamatIP` varchar(64),`i_user` varchar(64)) RETURNS int(11)
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);

  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
	

	/* Insert statement with auto commit enabled. */
  UPDATE tref_jabatan SET jabatanNama=i_jabatanNama WHERE jabatanID=i_jabatanID;
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('jabatanID','=',i_jabatanID,'|','jabatanNama','=',i_jabatanNama); 

	/* catat log */
	CALL sp_tlog_insert('UPDATE','TREF_JABATAN',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DROP FUNCTION IF EXISTS `fn_trefkaryawan_insert_update`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefkaryawan_insert_update`(`i_manufakturID` varchar(50), `i_manufakturNama` varchar(50), `i_alamatIP` varchar(64), `i_user` varchar(64)) RETURNS int(11)
    MODIFIES SQL DATA
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);
	
  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
 
  /* Insert statement with auto commit enabled. */
  INSERT INTO tref_manufaktur (tref_manufaktur.manufakturID,tref_manufaktur.manufakturNama) VALUES (i_manufakturID,i_manufakturNama);
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('manufakturID','=',i_manufakturID,'|','manufakturNama','=',i_manufakturNama); 

	/* catat log */
	CALL sp_tlog_insert('INSERT','TREF_MANUFAKTUR',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DROP FUNCTION IF EXISTS `fn_trefpropinsi_delete`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefpropinsi_delete`(`i_propinsiID` varchar(50),`i_propinsiNama` varchar(50), `i_alamatIP` varchar(64),`i_user` varchar(64)) RETURNS int(11)
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);
	
  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
 
  /* DELETE statement with auto commit enabled. */
  DELETE FROM tref_propinsi WHERE propinsiID=i_propinsiID;
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('propinsiID','=',i_propinsiID,'|','propinsiNama','=',i_propinsiNama); 

	/* catat log */
	CALL sp_tlog_insert('DELETE','TREF_PROPINSI',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DROP FUNCTION IF EXISTS `fn_trefpropinsi_insert`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefpropinsi_insert`(`i_propinsiID` varchar(50), `i_propinsiNama` varchar(50), `i_alamatIP` varchar(64), `i_user` varchar(64)) RETURNS int(11)
    MODIFIES SQL DATA
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);
	
	DECLARE propID VARCHAR(50);
	
	
	
  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
 
  /* Insert statement with auto commit enabled. */
  /* INSERT INTO tref_propinsi (tref_propinsi.propinsiID,tref_propinsi.propinsiNama) VALUES (i_propinsiID,i_propinsiNama); */
  SELECT MAX(propinsiID)+1 INTO propID FROM tref_propinsi;
  INSERT INTO tref_propinsi (tref_propinsi.propinsiID,tref_propinsi.propinsiNama) VALUES (propID,i_propinsiNama); 
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('propinsiID','=',propID,'|','propinsiNama','=',i_propinsiNama); 

	/* catat log */
	CALL sp_tlog_insert('INSERT','TREF_PROPINSI',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DROP FUNCTION IF EXISTS `fn_trefpropinsi_update`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_trefpropinsi_update`(`i_propinsiID` varchar(50),`i_propinsiNama` varchar(50), `i_alamatIP` varchar(64),`i_user` varchar(64)) RETURNS int(11)
BEGIN
  /* Declare Boolean-like variables as FALSE. */
  DECLARE lv_return_value INT DEFAULT FALSE;
  DECLARE lv_error_value INT DEFAULT FALSE;
	DECLARE sqlStatement VARCHAR(2500);

  /* Declare a generic exit handler to reset error control variable to true. */
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET lv_error_value := TRUE;   
	

	/* Insert statement with auto commit enabled. */
  UPDATE tref_propinsi SET propinsiNama=i_propinsiNama WHERE propinsiID=i_propinsiID;
  
	/* inisialisasi nilai log */
  SET sqlStatement = CONCAT('propinsiID','=',i_propinsiID,'|','propinsiNama','=',i_propinsiNama); 

	/* catat log */
	CALL sp_tlog_insert('UPDATE','TREF_PROPINSI',sqlStatement,i_alamatIP,i_user);
  
  /* True unless the CONTINUE HANDLER disables the error control variable. */ 
  IF lv_error_value = FALSE THEN
    SET lv_return_value := TRUE;
  END IF;
 
  /* Return local variable. */
  RETURN lv_return_value;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ci_sessions`
--

DROP TABLE IF EXISTS `ci_sessions`;
CREATE TABLE IF NOT EXISTS `ci_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `last_activity_idx` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ci_sessions`
--

INSERT INTO `ci_sessions` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES
('0684215fbf82cccc552bd32b7f076e0c', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20100101 Firefox/15.0.1 FirePHP/0.7.1', 1347314590, 'a:10:{s:9:"user_data";s:0:"";s:7:"levelID";s:1:"1";s:3:"nip";s:7:"6304194";s:8:"username";s:4:"sa01";s:8:"password";s:32:"cad06946b642c2597817d939d31e1715";s:9:"levelName";s:32:"6fb73e8a536739deba2f642ebfc4282c";s:6:"userID";s:8:"UID00001";s:11:"namalengkap";s:8:"Suhendra";s:13:"namapanggilan";s:6:"hendra";s:9:"setmodule";s:15:"human_resources";}');

-- --------------------------------------------------------

--
-- Table structure for table `conf_menu`
--

DROP TABLE IF EXISTS `conf_menu`;
CREATE TABLE IF NOT EXISTS `conf_menu` (
  `menuID` int(10) NOT NULL AUTO_INCREMENT,
  `submodulID` int(10) NOT NULL DEFAULT '0',
  `menuNama` varchar(50) DEFAULT '0',
  `controller` varchar(50) DEFAULT '0',
  `function` varchar(50) DEFAULT '0',
  `is_aktif` enum('Y','N') DEFAULT 'Y',
  PRIMARY KEY (`menuID`,`submodulID`),
  KEY `submodulID` (`submodulID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `conf_menu`
--

INSERT INTO `conf_menu` (`menuID`, `submodulID`, `menuNama`, `controller`, `function`, `is_aktif`) VALUES
(1, 1, 'Provinsi', 'provinsi', '0', 'Y'),
(2, 1, 'Kota', 'kota', '0', 'Y'),
(3, 1, 'Bank', 'bank', '0', 'Y'),
(4, 2, 'Departmen', 'department', '0', 'Y'),
(5, 2, 'Jabatan', 'jabatan', '0', 'Y'),
(6, 1, 'Instansi', 'instansi', '0', 'Y'),
(7, 3, 'Karyawan', 'karyawan', '0', 'Y'),
(8, 3, 'Penerimaan', 'penerimaan', '0', 'Y');

-- --------------------------------------------------------

--
-- Table structure for table `conf_modul`
--

DROP TABLE IF EXISTS `conf_modul`;
CREATE TABLE IF NOT EXISTS `conf_modul` (
  `modulID` varchar(10) NOT NULL,
  `modulNama` varchar(50) NOT NULL DEFAULT '0',
  `modulPage_Form_Controller` varchar(150) NOT NULL DEFAULT '0',
  `picture` varchar(150) DEFAULT NULL,
  `link` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`modulID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Contoh, Modul Master, Transaksi Booking, Pengadaan Barang, Penjualan, Pembelian';

--
-- Dumping data for table `conf_modul`
--

INSERT INTO `conf_modul` (`modulID`, `modulNama`, `modulPage_Form_Controller`, `picture`, `link`) VALUES
('1', 'Reference', 'references', 'config.png', 'konfigurasi'),
('2', 'Project Management', 'project_management', 'calendar.png', NULL),
('3', 'Human Resource', 'human_resources', 'hire-me.png', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `conf_submodul`
--

DROP TABLE IF EXISTS `conf_submodul`;
CREATE TABLE IF NOT EXISTS `conf_submodul` (
  `submodulID` int(10) NOT NULL AUTO_INCREMENT,
  `modulID` varchar(10) NOT NULL DEFAULT '0',
  `submodulNama` varchar(150) DEFAULT NULL,
  `submodulPage_Form_Controller` varchar(150) DEFAULT NULL,
  `is_aktif` enum('N','Y') DEFAULT 'Y',
  `label` varchar(150) DEFAULT 'Y',
  PRIMARY KEY (`submodulID`),
  KEY `modulID` (`modulID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Contoh : Master Kendaraan, master Manufaktur (table yang bersifat stand-alone' AUTO_INCREMENT=8 ;

--
-- Dumping data for table `conf_submodul`
--

INSERT INTO `conf_submodul` (`submodulID`, `modulID`, `submodulNama`, `submodulPage_Form_Controller`, `is_aktif`, `label`) VALUES
(1, '1', 'Master Pendukung', 'Trefmanufaktur', 'Y', 'Y'),
(2, '3', 'Master Pendukung', 'Trefmodel', 'Y', 'Y'),
(3, '3', 'Kepegawaian', 'Trefkategori', 'Y', 'Y');

-- --------------------------------------------------------

--
-- Table structure for table `tref_bank`
--

DROP TABLE IF EXISTS `tref_bank`;
CREATE TABLE IF NOT EXISTS `tref_bank` (
  `bankID` varchar(5) NOT NULL DEFAULT '',
  `bankName` varchar(150) DEFAULT NULL,
  `bankFullName` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`bankID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tref_bank`
--

INSERT INTO `tref_bank` (`bankID`, `bankName`, `bankFullName`) VALUES
('10002', 'BNI (Persero) Tbk.', 'PT Bank Negara Indonesia (Persero) Tbk'),
('10003', 'Bank Rakyat Indonesia (Persero) Tbk.', 'PT Bank Rakyat Indonesia (Persero) Tbk.'),
('10004', 'Bank Tabungan Negara (Persero)', 'PT Bank Tabungan Negara (Persero) Tbk.'),
('10005', 'Bank Bengkulu', 'PT Bank Pembangunan Daerah Bengkulu'),
('10006', 'Bank BPD Bali', 'PT Bank Pembangunan Daerah Bali'),
('10007', 'Bank Jabar Banten', 'PT Bank Jabar Banten'),
('10008', 'Bank Jambi', 'PT Bank Jambi'),
('10009', 'Bank Lampung', 'PT Bank Lampung'),
('10010', 'Bank Maluku', 'PT Bank Maluku'),
('10011', 'Bank Nusa Tenggara Timur', 'PT Bank Nusa Tenggara Timur'),
('10012', 'Bank Kalimantan Tengah', 'PT Bank Pembangunan Daerah Kalimantan Tengah'),
('10013', 'Bank Papua', 'PT Bank Papua'),
('10014', 'Bank Sulawesi Tenggara', 'PD Bank Pembangunan Daerah Sulawesi Tenggara'),
('10015', 'Bank Sulawesi Tengah', 'PT Bank Pembangunan Daerah Sulawesi Tengah'),
('10016', 'Bank Aceh', 'PT Bank BPD Aceh'),
('10017', 'Bank Daerah Istimewa Yogyakarta', 'PD Bank Pembangunan Daerah Istimewa Yogyakarta'),
('10018', 'Bank DKI', 'PT Bank DKI'),
('10019', 'Bank Jawa Tengah', 'PT Bank Pembangunan Daerah Jawa Tengah'),
('10020', 'Bank Jawa Timur', 'PT Bank Pembangunan Daerah Jawa Timur'),
('10021', 'Bank Nagari', 'PT Bank Nagari'),
('10022', 'Bank Nusa Tenggara Barat', 'PT Bank Nusa Tenggara Barat'),
('10023', 'Bank Kalimantan Barat', 'PT Bank Pembangunan Daerah Kalimantan Barat'),
('10024', 'Bank Kalimantan Selatan', 'PD Bank Pembangunan Daerah Kalimantan Selatan'),
('10025', 'Bank Kalimantan Timur', 'PD Bank Pembangunan Daerah Kalimantan Timur'),
('10026', 'Bank Riau dan Kepri', 'PT Bank BPD Riau'),
('10027', 'Bank Sulawesi Selatan', 'PT Bank Pembangunan Daerah Sulawesi Selatan dan Sulawesi Barat'),
('10028', 'Bank Sulawesi Utara', 'PT Bank Pembangunan Daerah Sulawesi Utara'),
('10029', 'Bank Sumatera Selatan dan Bangka Belitung', 'PT Bank Pembangunan Daerah Sumatera Selatan'),
('10030', 'Bank Sumatera Utara', 'PT Bank Pembangunan Daerah Sumatera Utara'),
('10031', 'Anglomas International Bank', 'PT Anglomas International Bank'),
('10032', 'ANZ Panin Bank', 'PT ANZ Panin Bank'),
('10033', 'Bank Agris', 'PT Bank Agris'),
('10034', 'Bank Agroniaga Tbk.', 'PT Bank Agroniaga Tbk.'),
('10035', 'Bank Andara', 'PT Bank Andara'),
('10036', 'Bank Antar Daerah', 'PT Bank Antar Daerah'),
('10037', 'Bank Artha Graha', 'PT Bank Artha Graha Internasional Tbk.'),
('10038', 'Bank Artos Indonesia', 'PT Bank Artos Indonesia'),
('10039', 'Bank Bisnis Internasional', 'PT Bank Bisnis Internasional'),
('10040', 'Bank BNP Paribas Indonesia', 'PT Bank BNP Paribas Indonesia'),
('10041', 'Bank Bukopin', 'PT Bank Bukopin'),
('10042', 'Bank Bumi Arta', 'PT Bank Bumi Arta Tbk.'),
('10043', 'Bank Capital Indonesia, Tbk.', 'PT Bank Capital Indonesia, Tbk.'),
('10044', 'Bank Central Asia Tbk.', 'PT Bank Central Asia Tbk.'),
('10045', 'Bank China Trust Indonesia', 'PT Bank ChinaTrust Indonesia'),
('10046', 'Bank Commonwealth', 'PT Bank Commonwealth'),
('10047', 'Bank DBS Indonesia', 'PT Bank DBS Indonesia'),
('10048', 'Bank Dipo Internasional', 'PT Bank Dipo Internasional'),
('10049', 'Bank Ekonomi Raharja', 'PT Bank Ekonomi Raharja Tbk.'),
('10050', 'Bank Fama Internasional', 'PT Bank Fama Internasional'),
('10051', 'Bank Ganesha', 'PT Bank Ganesha'),
('10052', 'Bank Hana', 'PT Bank Hana'),
('10053', 'Bank Harda Internasional', 'PT Bank Harda Internasional'),
('10054', 'Bank ICB Bumiputera, Tbk.', 'PT Bank ICB Bumiputera, Tbk.'),
('10055', 'Bank INA Perdana', 'PT Bank INA Perdana'),
('10056', 'Bank Index Selindo', 'PT Bank Index Selindo'),
('10057', 'Bank Jasa Jakarta', 'PT Bank Jasa Jakarta'),
('10058', 'Bank KEB Indonesia', 'PT Bank KEB Indonesia'),
('10059', 'Bank Kesawan', 'PT Bank Kesawan'),
('10060', 'Bank Kesejahteraan Ekonomi', 'PT Bank Kesejahteraan Ekonomi'),
('10061', 'Bank Liman International', 'PT Bank Liman International'),
('10062', 'Bank Maspion Indonesia', 'PT Bank Maspion Indonesia'),
('10063', 'Bank Mayapada Internasional', 'PT Bank Mayapada Internasional Tbk.'),
('10064', 'Bank Mayora', 'PT Bank Mayora'),
('10065', 'Bank Mega Tbk.', 'PT Bank Mega Tbk.'),
('10066', 'Bank Mestika Dharma', 'PT Bank Mestika Dharma Tbk.'),
('10067', 'Bank Metro Express', 'PT Bank Metro Express'),
('10068', 'Bank Mitraniaga', 'PT Bank Mitraniaga'),
('10069', 'Bank Mizuho Indonesia', 'PT Bank Mizuho Indonesia'),
('10070', 'Bank Multiarta Sentosa', 'PT Bank Multiarta Sentosa'),
('10071', 'Bank Mutiara', 'PT Bank Mutiara Tbk.'),
('10072', 'Bank Nationalnobu', 'PT Bank Nationalnobu'),
('10073', 'Bank Nusantara Parahyangan', 'PT Bank Nusantara Parahyangan Tbk.'),
('10074', 'Bank OCBC NISP', 'PT Bank OCBC NISP Tbk.'),
('10075', 'Bank Panin Tbk.', 'PT Bank Panin Tbk.'),
('10076', 'Bank Pundi Indonesia Tbk.', 'PT Bank Pundi'),
('10077', 'Bank Resona Perdania', 'PT Bank Resona Perdania'),
('10078', 'Bank Royal Indonesia', 'PT Bank Royal Indonesia'),
('10079', 'Bank Sahabat Purba Danarta', 'PT Bank Sahabat Purba Danarta'),
('10080', 'Bank Saudara', 'PT Bank Saudara'),
('10081', 'Bank SBI Indonesia', 'PT Bank SBI Indonesia'),
('10082', 'Bank Sinar Harapan Bali', 'PT Bank Sinar Harapan Bali'),
('10083', 'Bank Sumitomo Mitsui Indoneasia', 'PT Bank Sumitomo Mitsui Indoneasia'),
('10084', 'Bank Swadesi Tbk.', 'PT Bank Swadesi Tbk.'),
('10085', 'Bank UOB Indonesia Tbk.', 'PT Bank UOB Indonesia Tbk.'),
('10086', 'Bank Victoria Internasional Tbk', 'PT Bank Victoria Internasional Tbk'),
('10087', 'Bank Windu Kentjana International Tbk.', 'PT Bank Windu Kentjana International Tbk.'),
('10088', 'Bank Woori Indonesia', 'PT Bank Woori Indonesia'),
('10089', 'Bank Yudha Bakti', 'PT Bank Yudha Bakti'),
('10090', 'Centratama Nasional Bank', 'PT Centratama Nasional Bank'),
('10091', 'Prima Master Bank', 'Prima Master Bank'),
('10092', 'Rabobank Internasional', 'PT Bank Rabobank Internasional Indonesia'),
('10093', 'Bank CIMB Niaga Tbk.', 'PT Bank CIMB Niaga Tbk.'),
('10094', 'Bank Danamon Indonesia Tbk.', 'PT Bank Danamon Indonesia Tbk.'),
('10095', 'Bank ICBC Indonesia', 'PT Bank ICBC Indonesia'),
('10096', 'Bank Internasional Indonesia Tbk.', 'PT Bank Internasional Indonesia Tbk.'),
('10097', 'Bank Permata Tbk.', 'PT Bank Permata Tbk.'),
('10098', 'Bank Sinarmas', 'PT Bank Sinarmas'),
('10099', 'Bank Tabungan Pensiunan Nasional', 'PT Bank Tabungan Pensiunan Nasional'),
('101', 'BKK Grabag', ''),
('10100', 'Bank Muamalat Indonesia', 'PT Bank Syariah Muamalat Indonesia Tbk.'),
('10101', 'Bank Syariah BCA', 'PT Bank BCA Syariah'),
('10102', 'Bank Syariah BNI', 'PT Bank BNI Syariah'),
('10103', 'Bank Syariah BRI', 'PT Bank BRI Syariah'),
('10104', 'Bank Syariah Bukopin', 'PT Bank Syariah Bukopin'),
('10105', 'Bank Syariah Jabar Banten', 'PT Bank Jabar Banten Syariah'),
('10106', 'Bank Syariah Mandiri', 'PT Bank Syariah Mandiri'),
('10107', 'Bank Syariah Maybank', 'PT Bank Maybank Syariah Indonesia'),
('10108', 'Bank Syariah Mega Indonesia', 'PT Bank Syariah Mega Indonesia'),
('10109', 'Bank Syariah Panin', 'PT Bank Panin Syariah'),
('10110', 'Bank Syariah Victoria', 'PT Bank Victoria Syariah'),
('10111', 'The Royal Bank Of Scotland N.V', 'The Royal Bank Of Scotland N.V'),
('10112', 'Bangkok Bank Public Company Limited', 'The Bangkok Bank Public Company Limited'),
('10113', 'Bank Of America, N.A', 'Bank Of America, National Association'),
('10114', 'Bank Of China Limited', 'Bank Of China Limited'),
('10115', 'Citibank N.A.', 'Citibank N.A.'),
('10116', 'Deutsche Bank AG.', 'Deutsche Bank AG.'),
('10117', 'JP. Morgan Chase Bank N.A.', 'JP. Morgan Chase Bank National Association'),
('10118', 'Standard Chartered Bank', 'Standard Chartered Bank'),
('10119', 'The Bank Of Tokyo - Mitsubishi UFJ, Ltd.', 'The Bank Of Tokyo - Mitsubishi UFJ, Ltd.'),
('10120', 'The Hongkong & Shanghai B.C', 'The Hongkong & Shanghai Banking Corporation Limited'),
('102', 'LKP Rasabou', ''),
('103', 'BKK Gabus - Grobogan', ''),
('104', 'BKK Gabus - Pati', ''),
('105', 'Cicadas (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', ''),
('106', 'Kec. Pagaden', ''),
('107', 'BKK Baturraden', ''),
('108', 'BKK Kragan', ''),
('109', 'Mustaqim Seunagan', ''),
('110', 'BKK Kalibagor', ''),
('111', 'BKK Petanahan', ''),
('11106', 'Bank Tests', 'Pt Bank Tests'),
('112', 'BKK Gajah', ''),
('113', 'BKK Kejajar', ''),
('114', 'Kec. Batujajar (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', ''),
('115', 'BKK Parakan', ''),
('116', 'Swadharma Pakem', ''),
('117', 'BKK Jaken', ''),
('118', 'Rakit', ''),
('119', 'Bank Barclays Indonesia', ''),
('120', 'BKK Wedarijaksa', ''),
('121', 'Tunas Artha Jaya Abadi', ''),
('122', 'Ngadiluwih Sakti', ''),
('123', 'Kec. Cisalak', ''),
('124', 'BKK Salam', ''),
('125', 'BKK Wonosalam', ''),
('126', 'Babussalam', ''),
('127', 'LKP Dalam  Alas (Merger ke NTB Sumbawa Tgl 6 Nov 2009)', ''),
('128', 'Mustaqim Lawe Alas (alamat surat menyurat ke Mustaqim Blangkejeren)', ''),
('129', 'BKPD Rajagaluh', ''),
('130', 'Artha Nusa Graha', ''),
('131', 'BKK Kramat', ''),
('132', 'BKK Bulakamba', ''),
('133', 'BKK Kalijambe', ''),
('134', 'Sambi BKK', ''),
('135', 'BKK Klambu', ''),
('136', 'American Express Bank Ltd.', ''),
('137', 'BKK Ulujami', ''),
('138', 'Kalimanah', ''),
('139', 'Anugerah Bintang Sejahtera', 'PT BPR Anugerah Bintang Sejahtera'),
('140', 'Masaran Mitra Anda', ''),
('141', 'LPK Sukamandi', ''),
('142', 'BKK Pucakwangi', ''),
('143', 'Juwangi BKK', ''),
('144', 'Garawangi', ''),
('145', 'Lebakwangi', ''),
('146', 'BKK Banjarmangu', ''),
('147', 'Gandrungmangu', ''),
('148', 'Tawangmangu BKK', ''),
('149', 'Bank Arta Niaga Kencana (Merger ke Bank Commonwealth tgl 10/12/2007)', ''),
('150', 'Mataram Banguntapan', ''),
('151', 'BKK Tembarak', ''),
('152', 'Kec. Pabuaran', ''),
('153', 'BKK Kembaran', ''),
('154', 'Pejawaran', ''),
('155', 'LPK Pabuaran', ''),
('156', 'BKK Masaran', ''),
('157', 'Mitra Banjaran', ''),
('158', 'Banjaran (Merger ke Kabupaten Bandung Tgl 15/12/2009)', ''),
('159', 'BKK Purwokerto Barat', ''),
('160', 'Kecamatan Ciparay (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', ''),
('161', 'Sidomulyo Sarana Raharja', ''),
('162', 'BKK Tawangharjo', ''),
('163', 'BKK Sidoharjo', ''),
('164', 'Singaparna', ''),
('165', 'BKPD Singaparna', ''),
('166', 'Batuwarno BKK', ''),
('167', 'Kedungwuni Arta', ''),
('168', 'Langgeng Sewuarta', ''),
('169', 'Pundi Artha Sejahtera', ''),
('170', 'Taruna Mitra Danarta', ''),
('171', 'Prismamutiara Danarta', ''),
('172', 'Girimarto', ''),
('173', 'BKK Kuwarasan', ''),
('174', 'Kec. Paseh (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', ''),
('175', 'Kecamatan Ciasem', ''),
('176', 'BKK Kebasen', ''),
('177', 'Mataram Kasih', ''),
('178', 'Samudra Air Tawar', ''),
('179', 'BKK Magelang Selatan', ''),
('180', 'Daha Selatan (merger ke Kandangan 3 Maret 2009)', ''),
('181', 'Salimpaung Sepakat', ''),
('182', 'LKP Empang Atas (merger ke NTB Sumbawa Tgl 6 Nov 2009)', ''),
('183', 'Mustaqim Kuala Batee', ''),
('184', 'Jaten BKK', ''),
('185', 'BKPD Kadipaten', ''),
('186', 'Artha Galunggung', 'PD BPR Artha Galunggung'),
('187', 'Artha Mitra Niaga', 'PT BPR Artha Mitra Niaga'),
('188', 'Tolutug Naton', ''),
('189', 'Artha Sukapura', 'PD BPR Artha Sukapura'),
('190', 'Junjung Sirih', ''),
('191', 'BKK Karangawen', ''),
('192', 'Sawit  BKK', ''),
('193', 'BKK Ayah', ''),
('194', 'BKK Karanggayam', ''),
('195', 'Anyar Bayan', ''),
('196', 'BKK Bayan', ''),
('197', 'BKK Buayan', ''),
('198', 'BKK Kayen', ''),
('199', 'Bada Dompu', ''),
('200', 'BKK Bae', ''),
('20001', 'Modern Express', 'PT BPR Modern Express'),
('20002', 'Bobato Lestari', 'PT BPR Bobato Lestari'),
('20003', 'Malifut Danatama', 'PT BPR Malifut Danatama'),
('20004', 'Artha Tual', 'PT BPR Artha Tual'),
('20005', 'Ronabasa', 'PT BPR Ronabasa'),
('20006', 'Ibadurrahman', 'PT BPRS Ibadurrahman'),
('20007', 'Darul Imarah Jaya', 'PT BPR Darul Imarah Jaya'),
('20008', 'Ingin Jaya', 'Koperasi BPR Ingin Jaya'),
('20009', 'Mustaqim Sukamakmur', 'PD BPR Mustaqim Sukamakmur'),
('20010', 'Baiturrahman', 'PT BPRS Baiturrahman'),
('20011', 'Hareukat', 'PT BPRS Hareukat'),
('20012', 'Renggali', 'PT BPRS Renggali'),
('20013', 'Berlian Global Aceh', 'PT BPR Berlian Global Aceh'),
('20014', 'Hikmah  Wakilah', 'PT BPRS Hikmah  Wakilah'),
('20015', 'Kota Juang', 'PT BPRS Kota Juang'),
('20016', 'Rahmania Dana Sejahtera', 'PT BPRS Rahmania Dana Sejahtera'),
('20017', 'Adeco', 'PT BPRS Adeco'),
('20018', 'Ar-Raihan', 'PT BPRS Ar-Raihan'),
('20019', 'Tengku Chiek Dipante', 'PT BPRS Tengku Chiek Dipante'),
('20020', 'Aji Caka', 'PT BPR Aji Caka'),
('20021', 'Arta Kedaton Makmur', 'PT BPR Arta Kedaton Makmur'),
('20022', 'Bank Pasar Kota Bandar Lampung', 'PD BPR Bank Pasar Kota Bandar Lampung'),
('20023', 'Citra Dana Mandiri', 'PT BPR Citra Dana Mandiri'),
('20024', 'Desa Sanggalangit', 'PT BPR Desa Sanggalangit'),
('20025', 'Dhana Sewu', 'PT BPR Dhana Sewu'),
('20026', 'Lampung Bina Sejahtera', 'PT BPR Lampung Bina Sejahtera'),
('20027', 'Langgeng Lestari Bersama', 'PT BPR Langgeng Lestari Bersama'),
('20028', 'Trisurya Bumindo', 'PT BPR Trisurya Bumindo'),
('20029', 'Bandar Lampung', 'PT BPRS Bandar Lampung'),
('20030', 'Dana Master Bahtera', 'PT BPR Dana Master Bahtera'),
('20031', 'Tahuan Ganda', 'PT BPR Tahuan Ganda'),
('20032', 'Cipta Dana Mulia', 'PT BPR Cipta Dana Mulia'),
('20033', 'Paramaarta Dina', 'PT BPR Paramaarta Dina'),
('20034', 'Tara Dharma Artha', 'PT BPR Tara Dharma Artha'),
('20035', 'Tataarta Swadaya', 'PT BPR Tataarta Swadaya'),
('20036', 'Rajasa', 'PD BPRS Rajasa'),
('20037', 'Fajar Warapastika', 'PT BPR Fajar Warapastika'),
('20038', 'Labuhan Dana Sentosa', 'PT BPR Labuhan Dana Sentosa'),
('20039', 'Lipat Ganda', 'PT BPR Lipat Ganda'),
('20040', 'Lampung Timur', 'PT BPRS Lampung Timur'),
('20041', 'Bungamayang Agroloka', 'PT BPR Bungamayang Agroloka'),
('20042', 'Kotabumi', 'PD BPRS Kotabumi'),
('20043', 'Eka Bumi Artha', 'PT BPR Eka Bumi Artha'),
('20044', 'Inti Dana Sentosa', 'PT BPR Inti Dana Sentosa'),
('20045', 'Metro Madani', 'PT BPRS Metro Madani'),
('20046', 'Syariah Tanggamus', 'PD BPRS Syariah Tanggamus'),
('20047', 'Tunas Jaya Graha', 'PT BPR Tunas Jaya Graha'),
('20048', 'Utomo Manunggal Sejahtera Lampung', 'PT BPR Utomo Manunggal Sejahtera Lampung'),
('20049', 'Cempaka Mitra Usaha', 'PT BPR Cempaka Mitra Usaha'),
('20050', 'Way Kanan', 'PT BPRS Way Kanan'),
('20051', 'Mitra Agro Usaha', 'PT BPR Mitra Agro Usaha'),
('20052', 'Artamas Priangan', 'PT BPR Artamas Priangan'),
('20053', 'Artha Karya Usaha', 'PT BPR Artha Karya Usaha'),
('20054', 'Artha Mitra Kencana', 'PT BPR Artha Mitra Kencana'),
('20055', 'Artha Niaga Finatama', 'PT BPR Artha Niaga Finatama'),
('20056', 'Artos Parahyangan', 'Koperasi BPR Bank Pasar Artos Parahyangan'),
('20057', 'Bara Ujungberung', 'Koperasi BPR Bara Ujungberung'),
('20058', 'Bina Maju Usaha', 'PT BPR Bina Maju Usaha'),
('20059', 'Citradana Rahayu', 'PT BPR Citradana Rahayu'),
('20060', 'Emasnusantara Sentosa', 'PT BPR Emasnusantara Sentosa'),
('20061', 'Kabupaten Bandung', 'PD BPR Kabupaten Bandung'),
('20062', 'Kertamulia', 'PT BPR Kertamulia'),
('20063', 'Kop. Jawa Barat', 'PT BPR Kop. Jawa Barat'),
('20064', 'Kota Bandung', 'PD BPR Kota Bandung'),
('20065', 'Metro Asia Mandiri', 'PT BPR Metro Asia Mandiri'),
('20066', 'Mitra Anditta', 'PT BPR Mitra Anditta'),
('20067', 'Nata Citraperdana', 'PT BPR Nata Citraperdana'),
('20068', 'Permata Dhanawira', 'PT BPR Permata Dhanawira'),
('20069', 'Pundi Kencana Makmur', 'PT BPR Pundi Kencana Makmur'),
('20070', 'Ratna Artha Pusaka', 'PT BPR Ratna Artha Pusaka'),
('20071', 'Sentral Investasi Prima', 'PT BPR Sentral Investasi Prima'),
('20072', 'Trisurya Marga Artha', 'PT BPR Trisurya Marga Artha'),
('20073', 'Utama Kita Mandiri', 'PT BPR Utama Kita Mandiri'),
('20074', 'Berkah Amal Salman', 'PT BPRS Berkah Amal Salman'),
('20075', 'Harta Insan Karimah Parahyangan', 'PT BPRS Harta Insan Karimah Parahyangan'),
('20076', 'Arta Gandhita', 'PT BPR Arta Gandhita'),
('20077', 'Bumi Pendawa Raharja', 'PT BPR Bumi Pendawa Raharja'),
('20078', 'Cikalong Kulon', 'PD BPR LPK Cikalongkulon'),
('20079', 'Cipanas Artha', 'PT BPR Cipanas Artha'),
('20080', 'Dana Pos', 'PT BPR Dana Pos'),
('20081', 'Kadupandak', 'PD BPR LPK Kadupandak'),
('20082', 'LPK Bojongpicung', 'PD BPR LPK Bojongpicung'),
('20083', 'LPK Cibeber', 'PD BPR LPK Cibeber'),
('20084', 'LPK Cidaun', 'PD BPR LPK Cidaun'),
('20085', 'LPK Ciranjang', 'PD BPR LPK Ciranjang'),
('20086', 'LPK Pacet', 'PD BPR LPK Pacet'),
('20087', 'LPK Sukanagara', 'PD BPR LPK Sukanagara'),
('20088', 'LPK Warungkondang', 'PD BPR LPK Warungkondang'),
('20089', 'Putra Pertiwi Sejati', 'PT BPR Putra Pertiwi Sejati'),
('20090', 'Sindangbarang', 'PD BPR LPK Sindangbarang'),
('20091', 'Universal Karya Mandiri Puncak', 'PT BPR Universal Karya Mandiri Puncak'),
('20092', 'Artha Fisabilillah', 'PT BPRS Artha Fisabilillah'),
('20093', 'Multidana Indonesia', 'PT BPR Multidana Indonesia'),
('20094', 'Baiturridha', 'PT BPRS Baiturridha'),
('20095', 'BPR Garut', 'PD BPR BPR Garut'),
('20096', 'LPK Banjarwangi', 'PD BPR LPK Banjarwangi'),
('20097', 'LPK Bayongbong', 'PD BPR LPK Bayongbong'),
('20098', 'LPK Cibalong', 'PD BPR LPK Cibalong'),
('20099', 'LPK Cikajang', 'PD BPR LPK Cikajang'),
('201', 'Sumber Hiobaja', ''),
('20100', 'LPK Garut Kota', 'PD BPR LPK Garut Kota'),
('20101', 'LPK Leuwigoong', 'PD BPR LPK Leuwigoong'),
('20102', 'LPK Sukawening', 'PD BPR LPK Sukawening'),
('20103', 'Mustika Permai', 'PT BPR Mustika Permai'),
('20104', 'Harum Hikmahnugraha', 'PT BPRS Harum Hikmahnugraha'),
('20105', 'PNM Mentari', 'PT BPRS PNM Mentari'),
('20106', 'Adhierresa', 'PT BPR Adhierresa'),
('20107', 'Bale Endah Rahayu', 'PT BPR Bale Endah Rahayu'),
('20108', 'Bandung Kidul', 'PT BPR Bandung Kidul'),
('20109', 'Bina Sono Artha', 'PT BPR Bina Sono Artha'),
('20110', 'Brata Nusantara', 'PT BPR Brata Nusantara'),
('20111', 'Bumi Bandung Kencana', 'PT BPR Bumi Bandung Kencana'),
('20112', 'Nusantara Bona Pasogit 26', 'PT BPR Nusantara Bona Pasogit 26'),
('20113', 'Bumiasih NBP 27', 'PT BPR Bumiasih NBP 27'),
('20114', 'Nusantara Bona Pasogit 30', 'PT BPR Nusantara Bona Pasogit 30'),
('20115', 'Dana Putra Mandiri', 'PT BPR Dana Putra Mandiri'),
('20116', 'Danamasa Cimahi', 'PT BPR Danamasa Cimahi'),
('20117', 'Daya Lumbung Asia', 'PT BPR Daya Lumbung Asia'),
('20118', 'Duta Artha Sejahtera', 'PT BPR Duta Artha Sejahtera'),
('20119', 'Duta Pasundan', 'PT BPR Duta Pasundan'),
('20120', 'Gunadhana Mitrasembada', 'PT BPR Gunadhana Mitrasembada'),
('20121', 'Hayura Artalola', 'PT BPR Hayura Artalola'),
('20122', 'Jelita Arta', 'PT BPR Jelita Arta'),
('20123', 'Jujur Arghadana', 'PT BPR Jujur Arghadana'),
('20124', 'Karyajatnika Sadaya', 'PT BPR Karyajatnika Sadaya'),
('20125', 'Kencana', 'PT BPR Kencana'),
('20126', 'Lembangsari Arthatama', 'PT BPR Lembangsari Arthatama'),
('20127', 'Lexi Pratama Mandiri', 'PT BPR Lexi Pratama Mandiri'),
('20128', 'Mangun Pundiyasa', 'PT BPR Mangun Pundiyasa'),
('20129', 'Margahayu Arthatama', 'PT BPR Margahayu Arthatama'),
('20130', 'Mitra Kanaka Santosa', 'PT BPR Mitra Kanaka Santosa'),
('20131', 'Mitra Rukun Mandiri', 'PT BPR Mitra Rukun Mandiri'),
('20132', 'Mutiara Artha Pratama', 'PT BPR Mutiara Artha Pratama'),
('20133', 'Nehemia', 'PT BPR Nehemia'),
('20134', 'Niaga Mitra Usaha', 'PT BPR Niaga Mitra Usaha'),
('20135', 'Pangandaran', 'PT BPR Pangandaran'),
('20136', 'Panjawan Mitrausaha', 'PT BPR Panjawan Mitrausaha'),
('20137', 'Sadayana Artha', 'PT BPR Sadayana Artha'),
('20138', 'Sagitarius Pembangunan', 'PT BPR Sagitarius Pembangunan'),
('20139', 'Sarikusuma Surya', 'PT BPR Sarikusuma Surya'),
('20140', 'Sembada', 'PT BPR Sembada'),
('20141', 'Sinar Mas Pelita', 'PT BPR Sinar Mas Pelita'),
('20142', 'Tanjung Raya', 'Koperasi BPR Tanjung Raya'),
('20143', 'Teguh Ayusuastika', 'PT BPR Teguh Ayusuastika'),
('20144', 'Al Ihsan', 'Koperasi BPRS Al Ihsan'),
('20145', 'Amanah Rabbaniah', 'PT BPRS Amanah Rabbaniah'),
('20146', 'Cipaganti', 'PT BPRS Cipaganti'),
('20147', 'Ishlahul Ummah', 'PT BPRS Ishlahul Ummah'),
('20148', 'PNM Al Ma''soem Syariah', 'PT BPRS PNM Al Ma''soem Syariah'),
('20149', 'Arthaguna Mandiri', 'PT BPR Arthaguna Mandiri'),
('20150', 'BPR. Sukabumi', 'PD BPR BPR. Sukabumi'),
('20151', 'Bumitani Mandiri', 'PT BPR Bumitani Mandiri'),
('20152', 'Cicurug Bumiasih', 'PT BPR Cicurug Bumiasih'),
('20153', 'Nusamba Sukaraja', 'PT BPR Nusamba Sukaraja'),
('20154', 'Semesta Megadana', 'PT BPR Semesta Megadana'),
('20155', 'Supra Artapersada', 'PT BPR Supra Artapersada'),
('20156', 'Nusamba Plered', 'PT BPR Nusamba Plered'),
('20157', 'Raharja Wanayasa', 'PD BPR Raharja Wanayasa'),
('20158', 'Bina Arta Swadaya Bandung', 'PT BPR Bina Arta Swadaya Bandung'),
('20159', 'BPR Subang', 'PD BPR BPR Subang'),
('20160', 'Nusantara Bona Pasogit 29', 'PT BPR Nusantara Bona Pasogit 29'),
('20161', 'Gede Artaguna', 'PT BPR Gede Artaguna'),
('20162', 'LPK Cisalak', 'PD BPR LPK Cisalak'),
('20163', 'LPK Jalan Cagak', 'PD BPR LPK Jalan Cagak'),
('20164', 'LPK Pagaden', 'PD BPR LPK Pagaden'),
('20165', 'LPK Pamanukan', 'PD BPR LPK Pamanukan'),
('20166', 'LPK Purwadadi', 'PD BPR LPK Purwadadi'),
('20167', 'Markoni Saranajaya', 'PT BPR Markoni Saranajaya'),
('20168', 'Nauli Danaraya', 'PT BPR Nauli Danaraya'),
('20169', 'Nusumma cisalak', 'PT BPR Nusumma cisalak'),
('20170', 'Pamanukan Bangunarta', 'PT BPR Pamanukan Bangunarta'),
('20171', 'Tata Asia', 'PT BPR Tata Asia'),
('20172', 'Tutur Ganda', 'PT BPR Tutur Ganda'),
('20173', 'Kota Sukabumi', 'PD BPR Pasar Kota Sukabumi'),
('20174', 'Karpana Tasia', 'PT BPR Karpana Tasia'),
('20175', 'Nusamba Tanjungsari', 'PT BPR Nusamba Tanjungsari'),
('20176', 'Sumedang', 'PD BPR Sumedang'),
('20177', 'Astambul', 'PD BPR Astambul'),
('20178', 'Gawi Sabumi Mandarsari', 'PT BPR Gawi Sabumi Mandarsari'),
('20179', 'Mitratama  Arthabuana', 'PT BPR Mitratama  Arthabuana'),
('20180', 'Multidhana  Bersama', 'PT BPR Multidhana  Bersama'),
('20181', 'Simpang Empat', 'PD BPR Simpang Empat'),
('20182', 'Sungai Tabuk', 'PD BPR Sungai Tabuk'),
('20183', 'Barkah Gema Dana', 'PT BPRS Barkah Gema Dana'),
('20184', 'Martapura', 'PD BPR Martapura'),
('20185', 'Dana Permata Lestari', 'PT BPR Dana Permata Lestari'),
('20186', 'Kandangan', 'PD BPR Kandangan'),
('20187', 'Labuan Amas Selatan', 'PD BPR Labuan Amas Selatan'),
('20188', 'Amuntai Selatan', 'PD BPR Amuntai Selatan'),
('20189', 'Amuntai Tengah', 'PD BPR Amuntai Tengah'),
('20190', 'Amuntai Utara', 'PD BPR Amuntai Utara'),
('20191', 'Sungai Pandan', 'PD BPR Sungai Pandan'),
('20192', 'Haruai', 'PD BPR Haruai'),
('20193', 'Kelua', 'PD BPR Kelua'),
('20194', 'Muara Uya', 'PD BPR Muara Uya'),
('20195', 'Binuang', 'PD BPR Binuang'),
('20196', 'Candi Laras Utara', 'PD BPR Candi Laras Utara'),
('20197', 'Tapin Selatan', 'PD BPR Tapin Selatan'),
('20198', 'Tapin Tengah', 'PD BPR Tapin Tengah'),
('20199', 'Tapin Utara', 'PD BPR Tapin Utara'),
('202', 'Bajo Donggo', ''),
('20200', 'Agra Dhana', 'PT BPR Agra Dhana'),
('20201', 'Artha Prima Perkasa', 'PT BPR Artha Prima Perkasa'),
('20202', 'Banda Raya', 'PT BPR Banda Raya'),
('20203', 'Barelang Mandiri', 'PT BPR Barelang Mandiri'),
('20204', 'Central Kepri', 'PT BPR Central Kepri'),
('20205', 'Dana Central Mulia', 'PT BPR Dana Central Mulia'),
('20206', 'Dana Makmur', 'PT BPR Dana Makmur'),
('20207', 'Dana Mitra Sukses', 'PT BPR Dana Mitra Sukses'),
('20208', 'Dana Nagoya', 'PT BPR Dana Nagoya'),
('20209', 'Dana Nusantara', 'PT BPR Dana Nusantara'),
('20210', 'Dana Putra', 'PT BPR Dana Putra'),
('20211', 'Danamas Simpan Pinjam', 'PT BPR Danamas Simpan Pinjam'),
('20212', 'Global Mentari', 'PT BPR Global Mentari'),
('20213', 'Harapan Bunda Batam', 'PT BPR Harapan Bunda Batam'),
('20214', 'Indobaru Finansia', 'PT BPR Indobaru Finansia'),
('20215', 'Kapital Batam', 'PT BPR Kapital Batam'),
('20216', 'Kepri Batam', 'PT BPR Kepri Batam'),
('20217', 'Kintamas Mitra Dana', 'PT BPR Kintamas Mitra Dana'),
('20218', 'Majesty Golden Raya', 'PT BPR Majesty Golden Raya'),
('20219', 'Mutiara Cemerlang Barelang', 'PT BPR Mutiara Cemerlang Barelang'),
('20220', 'Pundi Masyarakat', 'PT BPR Pundi Masyarakat'),
('20221', 'Putra Batam', 'PT BPR Putra Batam'),
('20222', 'Sejahtera Batam', 'PT BPR Sejahtera Batam'),
('20223', 'Ukabima Mitra Dana', 'PT BPR Ukabima Mitra Dana'),
('20224', 'Syarikat Madani', 'PT BPRS Syarikat Madani'),
('20225', 'Vitka Central', 'PT BPRS Vitka Central'),
('20226', 'Bintan', 'PD BPR Bintan'),
('20227', 'Buana Arta Mulia', 'PT BPR Buana Arta Mulia'),
('20228', 'Karimun', 'PD BPR Karimun'),
('20229', 'Karimun Sejahtera', 'PT BPR Karimun Sejahtera'),
('20230', 'Sumber Danamas', 'PT BPR Sumber Danamas'),
('20231', 'Cempaka Mandiri', 'PT BPR Cempaka Mandiri'),
('20232', 'Dana Bintan Sejahtera', 'PT BPR Dana Bintan Sejahtera'),
('20233', 'Central Sejahtera', 'PT BPR Central Sejahtera'),
('20234', 'Kepri Bintan', 'PT BPR Kepri Bintan'),
('20235', 'Bestari', 'PD BPR Bestari'),
('20236', 'Duta Kepulauan Riau', 'PT BPR Duta Kepulauan Riau'),
('20237', 'Safir Bengkulu', 'PT BPRS Safir Bengkulu'),
('20238', 'Muamalat Harkat', 'PT BPRS Muamalat Harkat'),
('20239', 'Dian Binarta', 'PT BPR Dian Binarta'),
('20240', 'Mindosari', 'PT BPR Mindosari'),
('20241', 'Maroba Ite', 'PT BPR Maroba Ite'),
('20242', 'Arjawinangun', 'PD BPR Arjawinangun'),
('20243', 'Arthia Sere', 'PT BPR Arthia Sere'),
('20244', 'Astanajapura', 'PD BPR Astanajapura'),
('20245', 'Babakan', 'PD BPR Babakan'),
('20246', 'Baldah Sentosa', 'PT BPR Baldah Sentosa'),
('20247', 'Bank Pasar Kota Cirebon', 'PD BPR Bank Pasar Kota Cirebon'),
('20248', 'Beber', 'PD BPR Beber'),
('20249', 'Nusantara Bona Pasogit 28', 'PT BPR Nusantara Bona Pasogit 28'),
('20250', 'Cahaya Fajar', 'PT BPR Cahaya Fajar'),
('20251', 'Cirebon Barat', 'PD BPR Cirebon Barat'),
('20252', 'Cirebon Selatan', 'PD BPR Cirebon Selatan'),
('20253', 'Cirebon Utara', 'PD BPR Cirebon Utara'),
('20254', 'Ciwaringin', 'PD BPR Ciwaringin'),
('20255', 'Dipon Sejahtera', 'PT BPR Dipon Sejahtera'),
('20256', 'Gegesik', 'PD BPR Gegesik'),
('20257', 'Harap Ganda', 'PT BPR Harap Ganda'),
('20258', 'Hisobhan', 'PT BPR Hisobhan'),
('20259', 'Kapetakan', 'PD BPR Kapetakan'),
('20260', 'Karangsembung', 'PD BPR Karangsembung'),
('20261', 'Klangenan', 'PD BPR Klangenan'),
('20262', 'Lemahabang', 'PD BPR Lemahabang'),
('20263', 'Palimanan', 'PD BPR Palimanan'),
('20264', 'Parasahabat Cirebon', 'PT BPR Parasahabat Cirebon'),
('20265', 'Plumbon', 'PD BPR Plumbon'),
('20266', 'Sumber', 'PD BPR Sumber'),
('20267', 'Sumber Sibapudung', 'PT BPR Sumber Sibapudung'),
('20268', 'Susukan - Cirebon', 'PD BPR Susukan'),
('20269', 'Waled', 'PD BPR Waled'),
('20270', 'Weru', 'PD BPR Weru'),
('20271', 'Syarif Hidayatullah', 'PT BPRS Artamas'),
('20272', 'Anjatan', 'PD BPR Anjatan'),
('20273', 'Bangodua', 'PD BPR Bangodua'),
('20274', 'Cikedung', 'PD BPR Cikedung'),
('20275', 'Dhanagung Karangampel', 'PT BPR Dhanagung Karangampel'),
('20276', 'Gabuswetan', 'PD BPR Gabuswetan'),
('20277', 'Haurgeulis', 'PD BPR Haurgeulis'),
('20278', 'Juntinyuat', 'PD BPR Juntinyuat'),
('20279', 'Kandanghaur', 'PD BPR Kandanghaur'),
('20280', 'Karangampel', 'PD BPR Karangampel'),
('20281', 'Kertasemaya', 'PD BPR Kertasemaya'),
('20282', 'Krangkeng', 'PD BPR Krangkeng'),
('20283', 'Lohbener', 'PD BPR Lohbener'),
('20284', 'Losarang', 'PD BPR Losarang'),
('20285', 'LPK Arahan Kidul', 'PD BPR LPK Arahan Kidul'),
('20286', 'LPK Balongan', 'PD BPR LPK Balongan'),
('20287', 'LPK Bongas', 'PD BPR LPK Bongas'),
('20288', 'LPK Cantigi Kulon', 'PD BPR LPK Cantigi Kulon'),
('20289', 'LPK Kroya - Indramayu', 'PD BPR LPK Kroya'),
('20290', 'LPK Sukra', 'PD BPR LPK Sukra'),
('20291', 'Mitra Harmoni', 'PT BPR Mitra Harmoni'),
('20292', 'Sindang', 'PD BPR Sindang'),
('20293', 'Sliyeg', 'PD BPR Sliyeg'),
('20294', 'Widasari', 'PD BPR Widasari'),
('20295', 'BKPD Kuningan', 'PD BPR BPR Kuningan'),
('20296', 'Raksa Wacana Agri Purnama', 'PT BPR Raksa Wacana Agri Purnama'),
('20297', 'BKPD Sukahaji', 'PD BPR BPR Sukahaji'),
('20298', 'LPK Banjaran', 'PD BPR LPK Banjaran'),
('20299', 'LPK Cigasong', 'PD BPR LPK Cigasong'),
('203', 'Rembang', ''),
('20300', 'LPK Cingambul', 'PD BPR LPK Cingambul'),
('20301', 'LPK Panyingkiran', 'PD BPR LPK Panyingkiran'),
('20302', 'Wahana Sentra Artha', 'PT BPR Wahana Sentra Artha'),
('20303', 'Adiartha Udiana', 'PT BPR Adiartha Udiana'),
('20304', 'Antenk', 'PT BPR Antenk'),
('20305', 'Ashi', 'PT BPR Ashi'),
('20306', 'Bali Artha Anugrah', 'PT BPR Bali Artha Anugrah'),
('20307', 'Bali Sinar Menara', 'PT BPR Bali Sinar Menara'),
('20308', 'Baliharta Santosa', 'PT BPR Baliharta Santosa'),
('20309', 'Bayudhana', 'PT BPR Bayudhana'),
('20310', 'Bukit Tanjung', 'PT BPR Bukit Tanjung'),
('20311', 'Cahaya Artha Bali', 'PT BPR Cahaya Artha Bali'),
('20312', 'Cahaya Binawerdi', 'PT BPR Cahaya Binawerdi'),
('20313', 'Desa Dalung', 'PD BPR Desa Dalung'),
('20314', 'Desa Sangeh', 'PT BPR Desa Sangeh'),
('20315', 'Dewangga Bali Artha', 'PT BPR Dewangga Bali Artha'),
('20316', 'Dinar Jagad', 'PT BPR Dinar Jagad'),
('20317', 'Giri Sariwangi', 'PT BPR Giri Sariwangi'),
('20318', 'Jaya Kerti', 'PT BPR Jaya Kerti'),
('20319', 'Kapal Basak Pursada', 'PT BPR Kapal Basak Pursada'),
('20320', 'Karya Sari Sedana', 'PT BPR Karya Sari Sedana'),
('20321', 'Kita', 'PT BPR Kita'),
('20322', 'Kita Centradana', 'PT BPR Kita Centradana'),
('20323', 'KS Bali Agung Sedana', 'PT BPR KS Bali Agung Sedana'),
('20324', 'Kusemas Dana Mandiri', 'PT BPR Kusemas Dana Mandiri'),
('20325', 'Kusuma Mandala', 'PT BPR Kusuma Mandala'),
('20326', 'Maha Bhoga Marga', 'PT BPR Maha Bhoga Marga'),
('20327', 'Mambal', 'PT BPR Mambal'),
('20328', 'Mayun Utama Perdana', 'PT BPR Mayun Utama Perdana'),
('20329', 'Mertha Sedana', 'PT BPR Mertha Sedana'),
('20330', 'Mini Darma Adipala', 'PT BPR Mini Darma Adipala'),
('20331', 'Mitra Bali Mandiri', 'PT BPR Mitra Bali Mandiri'),
('20332', 'Mitra Balijaya Mandiri', 'PT BPR Mitra Balijaya Mandiri'),
('20333', 'Nusamba Mengwi', 'PT BPR Nusamba Mengwi'),
('20334', 'Nusapanida Kuta', 'PT BPR Nusapanida Kuta'),
('20335', 'Parasari', 'PT BPR Parasari'),
('20336', 'Parasari Sibang', 'PT BPR Parasari Sibang'),
('20337', 'Pasar raya Kuta', 'PT BPR Pasar raya Kuta'),
('20338', 'Pasar Umum', 'PT BPR Pasar Umum'),
('20339', 'Pedungan', 'PT BPR Pedungan'),
('20340', 'Permata Sedana', 'PT BPR Permata Sedana'),
('20341', 'Prima Dewata', 'PT BPR Prima Dewata'),
('20342', 'Santi Pala', 'PT BPR Santi Pala'),
('20343', 'Saptacristy Utama', 'PT BPR Saptacristy Utama'),
('20344', 'Saraswati Ekabumi', 'PT BPR Saraswati Ekabumi'),
('20345', 'Sari Nadi', 'PT BPR Sari Nadi'),
('20346', 'Sari Wira Tama', 'PT BPR Sari Wira Tama'),
('20347', 'Siaga Dana Kuta', 'PT BPR Siaga Dana Kuta'),
('20348', 'Sinar Kuta', 'PT BPR Sinar Kuta'),
('20349', 'Sinar Kuta Mulia', 'PT BPR Sinar Kuta Mulia'),
('20350', 'Siwi Sedana', 'PT BPR Siwi Sedana'),
('20351', 'Suar Artha Dharma', 'PT BPR Suar Artha Dharma'),
('20352', 'Tapa', 'PT BPR Tapa'),
('20353', 'Tulus Dadi', 'PT BPR Tulus Dadi'),
('20354', 'Udiyana Putra', 'PT BPR Udiyana Putra'),
('20355', 'Urip Kalantas', 'PT BPR Urip Kalantas'),
('20356', 'Varis Mandiri', 'PT BPR Varis Mandiri'),
('20357', 'Wahyu Nirmala', 'PT BPR Wahyu Nirmala'),
('20358', 'Fajar Sejahtera Bali', 'PT BPRS Fajar Sejahtera Bali'),
('20359', 'Kabupaten Bangli', 'PD BPR Bank Pasar Kabupaten Bangli'),
('20360', 'Kintamani Perdana', 'PT BPR Kintamani Perdana'),
('20361', 'Mitra Bali Muktijaya Mandiri', 'PT BPR Mitra Bali Muktijaya Mandiri'),
('20362', 'Buleleng 45', 'PD BPR Buleleng 46'),
('20363', 'Cahaya Bina Putra', 'PT BPR Cahaya Bina Putra'),
('20364', 'Kanaya', 'PT BPR Kanaya'),
('20365', 'Nur Abadi', 'PT BPR Nur Abadi'),
('20366', 'Nusamba Kubutambahan', 'PT BPR Nusamba Kubutambahan'),
('20367', 'Suryajaya Kubutambahan', 'PT BPR Suryajaya Kubutambahan'),
('20368', 'Bali Dananiaga', 'PT BPR Bali Dananiaga'),
('20369', 'Desa Sanur', 'PT BPR Desa Sanur'),
('20370', 'Duta Bali', 'PT BPR Duta Bali'),
('20371', 'Padma', 'PT BPR Padma'),
('20372', 'Picu Manunggal Sejahtera', 'PT BPR Picu Manunggal Sejahtera'),
('20373', 'Pusaka', 'PT BPR Pusaka'),
('20374', 'Sari Sedana', 'PT BPR Sari Sedana'),
('20375', 'Sri Artha Lestari', 'PT BPR Sri Artha Lestari'),
('20376', 'Tata Anjungsari', 'PT BPR Tata Anjungsari'),
('20377', 'Uverad Werdi Bhakti', 'PT BPR Uverad Werdi Bhakti'),
('20378', 'Angsa Sedana Yoga', 'PT BPR Angsa Sedana Yoga'),
('20379', 'Artha Bali Jaya', 'PT BPR Artha Bali Jaya'),
('20380', 'Aruna Nirmala Duta', 'PT BPR Aruna Nirmala Duta'),
('20381', 'Ayudhana Semesta', 'PT BPR Ayudhana Semesta'),
('20382', 'Bali Dewata', 'PT BPR Bali Dewata'),
('20383', 'Baskara Dewata', 'PT BPR Baskara Dewata'),
('20384', 'Dewata Candradana', 'PT BPR Dewata Candradana'),
('20385', 'Eka Ayu Artha Bhuwana', 'PT BPR Eka Ayu Artha Bhuwana'),
('20386', 'Gianyar Partasedana', 'PT BPR Gianyar Partasedana'),
('20387', 'Hari Depan', 'PT BPR Hari Depan'),
('20388', 'Kertiawan', 'PT BPR Kertiawan'),
('20389', 'Krisna Yuna Dana', 'PT BPR Krisna Yuna Dana'),
('20390', 'Mas Giri Wangi', 'PT BPR Mas Giri Wangi'),
('20391', 'Mitra Bali Sri Sedana Mandiri', 'PT BPR Mitra Bali Sri Sedana Mandiri'),
('20392', 'Mulia Wacana', 'PT BPR Mulia Wacana'),
('20393', 'Nusamba Tegalalang', 'PT BPR Nusamba Tegalalang'),
('20394', 'Partakencana Tohpati', 'PT BPR Partakencana Tohpati'),
('20395', 'Pertiwi', 'PT BPR Pertiwi'),
('20396', 'Puskusa Balidwipa', 'PT BPR Puskusa Balidwipa'),
('20397', 'Raga Jayatama', 'PT BPR Raga Jayatama'),
('20398', 'Sari Werdhi Sedana', 'PT BPR Sari Werdhi Sedana'),
('20399', 'Suadana', 'PT BPR Suadana'),
('204', 'BKK Gebang', ''),
('20400', 'Sukawati Pancakanti', 'PT BPR Sukawati Pancakanti'),
('20401', 'Suryajaya Ubud', 'PT BPR Suryajaya Ubud'),
('20402', 'Tish', 'PT BPR Tish'),
('20403', 'Ulatidana Rahayu', 'PT BPR Ulatidana Rahayu'),
('20404', 'Werdhi Sedana', 'PD BPR Werdhi Sedana'),
('20405', 'Ukabima Prima', 'PT BPR Ukabima Prima'),
('20406', 'Danamaster Dewata', 'PT BPR Danamaster Dewata'),
('20407', 'Nusamba Manggis', 'PT BPR Nusamba Manggis'),
('20408', 'Seri Artha Dana', 'PT BPR Seri Artha Dana'),
('20409', 'Mitra Bali Artha Mandiri', 'PT BPR Mitra Bali Artha Mandiri'),
('20410', 'Artha Rengganis', 'PT BPR Artha Rengganis'),
('20411', 'Balaguna Perasta', 'PT BPR Balaguna Perasta'),
('20412', 'Sari Jaya Sedana', 'PT BPR Sari Jaya Sedana'),
('20413', 'Sinar Puteramas', 'PT BPR Sinar Puteramas'),
('20414', 'Tridarma Putri', 'PT BPR Tridarma Putri'),
('20415', 'Adi Sedana Ayu', 'PT BPR Adi Sedana Ayu'),
('20416', 'Indra Candra', 'PT BPR Indra Candra'),
('20417', 'Adi Tami Jaya', 'PT BPR Adi Tami Jaya'),
('20418', 'Amerta Sari', 'PT BPR Amerta Sari'),
('20419', 'Artha Adyamurthi', 'PT BPR Artha Adyamurthi'),
('20420', 'Artha Budaya', 'PT BPR Artha Budaya'),
('20421', 'Ayunulus', 'PT BPR Ayunulus'),
('20422', 'Bumi Prima Dana', 'PT BPR Bumi Prima Dana'),
('20423', 'Dewata Indobank', 'PT BPR Dewata Indobank'),
('20424', 'Dharmawarga Utama', 'PT BPR Dharmawarga Utama'),
('20425', 'HOKI', 'PT BPR HOKI'),
('20426', 'Jero Anom', 'PT BPR Jero Anom'),
('20427', 'Kertha Warga', 'PT BPR Kertha Warga'),
('20428', 'Legian', 'PT BPR Legian'),
('20429', 'Luhur Damai', 'PT BPR Luhur Damai'),
('20430', 'Luhur Pucaksari', 'PT BPR Luhur Pucaksari'),
('20431', 'Merta Amerta', 'PT BPR Merta Amerta'),
('20432', 'Penebel', 'PT BPR Penebel'),
('20433', 'Prisma Bali', 'PT BPR Prisma Bali'),
('20434', 'Restu Dewata', 'PT BPR Restu Dewata'),
('20435', 'Sadhu Artha', 'PT BPR Sadhu Artha'),
('20436', 'Sari Dananiaga', 'PT BPR Sari Dananiaga'),
('20437', 'Sedana Murni', 'PT BPR Sedana Murni'),
('20438', 'Sedana Warga', 'PT BPR Sedana Warga'),
('20439', 'Sedana Yasa', 'PT BPR Sedana Yasa'),
('20440', 'Sentral Ekonomi Nusantara', 'PT BPR Sentral Ekonomi Nusantara'),
('20441', 'Mulya Arta', 'PT BPR Mulya Arta'),
('20442', 'Multi Artha Mas Sejahtera', 'PT BPR Multi Artha Mas Sejahtera'),
('20443', 'Aditama Arta', 'PT BPR Aditama Arta'),
('20444', 'Alsaba Prima', 'PT BPR Alsaba Prima'),
('20445', 'Ana Artha', 'PT BPR Ana Artha'),
('20446', 'Antar Guna', 'PT BPR Antar Guna'),
('20447', 'Ardhie Gede', 'PT BPR Ardhie Gede'),
('20448', 'Arta Pundi Mekar', 'PT BPR Arta Pundi Mekar'),
('20449', 'Artaprima Danajasa', 'PT BPR Artaprima Danajasa'),
('20450', 'Artha Sentana Hardja', 'PT BPR Artha Sentana Hardja'),
('20451', 'Arthamutiara Permai', 'PT BPR Arthamutiara Permai'),
('20452', 'Arthasraya Sejahtera', 'PT BPR Arthasraya Sejahtera'),
('20453', 'Bekasi Bina Tanjung Makmur', 'PT BPR Bekasi Bina Tanjung Makmur'),
('20454', 'Paramindo Kurnia Abadi', 'PT BPR Paramindo Kurnia Abadi'),
('20455', 'Bina Dian Citra', 'PT BPR Bina Dian Citra'),
('20456', 'Binadana Makmur', 'PT BPR Binadana Makmur'),
('20457', 'Bintara Pratama Sejahtera', 'PT BPR Bintara Pratama Sejahtera'),
('20458', 'Bringin Dana Sejahtera', 'PT BPR Bringin Dana Sejahtera'),
('20459', 'Bumi Bekasi Artha', 'PT BPR Bumi Bekasi Artha'),
('20460', 'Cibitung Tanjungraya', 'PT BPR Cibitung Tanjungraya'),
('20461', 'Cikarang Raharja', 'PT BPR Cikarang Raharja'),
('20462', 'Citra Artha Sedana', 'PT BPR Citra Artha Sedana'),
('20463', 'Citra Bersada Abadi', 'PT BPR Citra Bersada Abadi'),
('20464', 'Citra Ladon Rahardja', 'PT BPR Citra Ladon Rahardja'),
('20465', 'Dana Multi Guna', 'PT BPR Dana Multi Guna'),
('20466', 'Danasari Persada', 'PT BPR Danasari Persada'),
('20467', 'Danatama Indonesia', 'PT BPR Danatama Indonesia'),
('20468', 'Darmawan Adhiguna Lestari', 'PT BPR Darmawan Adhiguna Lestari'),
('20469', 'Dian Faraqo Gemilang', 'PT BPR Dian Faraqo Gemilang'),
('20470', 'DP Taspen', 'PT BPR DP Taspen'),
('20471', 'DPM Kredit Mandiri', 'PT BPR DPM Kredit Mandiri'),
('20472', 'Genades Putranindo', 'PT BPR Genades Putranindo'),
('20473', 'Gracia Mandiri', 'PT BPR Gracia Mandiri'),
('20474', 'Handalan Danagraha', 'PT BPR Handalan Danagraha'),
('20475', 'Harapan Saudara', 'PT BPR Harapan Saudara'),
('20476', 'Harta Tanamas', 'PT BPR Harta Tanamas'),
('20477', 'Hosing Jaya', 'PT BPR Hosing Jaya'),
('20478', 'Jayamora Krida', 'PT BPR Jayamora Krida'),
('20479', 'Karinamas Permai', 'PT BPR Karinamas Permai'),
('20480', 'Karya Bakti Sejahtera', 'PT BPR Karya Bakti Sejahtera'),
('20481', 'Karya Kurnia Utama', 'PT BPR Karya Kurnia Utama'),
('20482', 'Kranji Krida Sejahtera', 'PT BPR Kranji Krida Sejahtera'),
('20483', 'LPK Bekasi', 'PD BPR LPK Bekasi'),
('20484', 'LPK Cibarusah', 'PD BPR LPK Cibarusah'),
('20485', 'LPK Cibitung', 'PD BPR LPK Cibitung'),
('20486', 'LPK Pondok Gede', 'PD BPR LPK Pondok Gede'),
('20487', 'LPK Setu', 'PD BPR LPK Setu'),
('20488', 'LPK Sukatani', 'PD BPR LPK Sukatani'),
('20489', 'Lugano', 'PT BPR Lugano'),
('20490', 'Metropolitan Putra', 'PT BPR Metropolitan Putra'),
('20491', 'Mitra Ekonomi Andalas', 'PT BPR Mitra Ekonomi Andalas'),
('20492', 'Mitra Sejahtera Lestari', 'PT BPR Mitra Sejahtera Lestari'),
('20494', 'Nasional Nusantara', 'PT BPR Nasional Nusantara'),
('20495', 'Olympindo Primadana', 'PT BPR Olympindo Primadana'),
('20496', 'Pandanaran Jaya', 'PT BPR Pandanaran Jaya'),
('20497', 'Parasahabat  Bekasi', 'PT BPR Parasahabat  Bekasi'),
('20498', 'Pondasi Niaga Perdana', 'PT BPR Pondasi Niaga Perdana'),
('20499', 'Prabu Mitra', 'PT BPR Prabu Mitra'),
('205', 'Ciawigebang', ''),
('20500', 'Prima Nusatama', 'PT BPR Prima Nusatama'),
('20501', 'Prisma Berlian Danarta', 'PT BPR Prisma Berlian Danarta'),
('20503', 'Sekar', 'PT BPR Sekar'),
('20504', 'Sinarenam Permai Jatiasih', 'PT BPR Sinarenam Permai Jatiasih'),
('20505', 'Siraya Karya Bakti', 'PT BPR Siraya Karya Bakti'),
('20506', 'Siwa Raharja Utama', 'PT BPR Siwa Raharja Utama'),
('20507', 'Sumber Artha Rahayu', 'PT BPR Sumber Artha Rahayu'),
('20508', 'Supradana Mas', 'PT BPR Supradana Mas'),
('20509', 'Talabumi Ekapersada', 'PT BPR Talabumi Ekapersada'),
('20510', 'Trisurya Binaartha', 'PT BPR Trisurya Binaartha'),
('20511', 'Ulima Djumpa Marom', 'PT BPR Ulima Djumpa Marom'),
('20512', 'Universal Mega Mandiri Bekasi', 'PT BPR Universal Mega Mandiri Bekasi'),
('20513', 'Varia Central Artha', 'PT BPR Varia Central Artha'),
('20514', 'Wingsati', 'PT BPR Wingsati'),
('20515', 'Amanah Insani', 'PT BPRS Amanah Insani'),
('20516', 'Artha Karimah Irsyadi', 'PT BPRS Artha Karimah Irsyadi'),
('20517', 'Artha Madani', 'PT BPRS Artha Madani'),
('20518', 'Harta Insan Karimah Bekasi', 'PT BPRS Harta Insan Karimah Bekasi'),
('20519', 'Kota Bekasi', 'PD BPRS Kota Bekasi'),
('20520', 'Saleh Artha', 'PT BPRS Saleh Artha'),
('20521', 'Nurani Kami', 'PT BPR Nurani Kami'),
('20522', 'Artamitra Bumimanunggal', 'PT BPR Artamitra Bumimanunggal'),
('20523', 'Artha Bersama Sejahtera', 'PT BPR Artha Bersama Sejahtera'),
('20524', 'Artha Jaya Citeureup', 'PT BPR Artha Jaya Citeureup'),
('20525', 'Artha Karya Sejahtera', 'PT BPR Artha Karya Sejahtera'),
('20526', 'Artha Kurnia Raharja', 'PT BPR Artha Kurnia Raharja'),
('20527', 'Berfasi Raharja', 'PT BPR Berfasi Raharja'),
('20528', 'Nusantara Bona Pasogit 14', 'PT BPR Nusantara Bona Pasogit 14'),
('20529', 'Bumiasih NBP 2', 'PT BPR Bumiasih NBP 2'),
('20530', 'Cileungsi Krida Sejahtera', 'PT BPR Cileungsi Krida Sejahtera'),
('20531', 'Datagita Mustika', 'PT BPR Datagita Mustika'),
('20532', 'Duta Pakuan Mandiri', 'PT BPR Duta Pakuan Mandiri'),
('20533', 'Gebu Kujang Kinantan', 'PT BPR Gebu Kujang Kinantan'),
('20534', 'Hitamajaya Argamandiri', 'PT BPR Hitamajaya Argamandiri'),
('20535', 'Indomitra Artha Pertiwi', 'PT BPR Indomitra Artha Pertiwi'),
('20536', 'Kota Bogor', 'PD BPR Bank Pasar Kota Bogor'),
('20537', 'Kujang Artha Sembada', 'PT BPR Kujang Artha Sembada'),
('20538', 'LPK Citeureup', 'PD BPR LPK Citeureup'),
('20539', 'LPK Leuwiliang', 'PD BPR LPK Leuwiliang'),
('20540', 'LPK Pancoran Mas', 'PD BPR LPK Pancoran Mas'),
('20541', 'LPK Parungpanjang', 'PD BPR LPK Parungpanjang'),
('20542', 'Mitra Daya Mandiri', 'PT BPR Mitra Daya Mandiri'),
('20543', 'Muliatama Dananjaya', 'PT BPR Muliatama Dananjaya'),
('20544', 'Nature Primadana Capital', 'PT BPR Nature Primadana Capital'),
('20545', 'Parasahabat Bogor', 'PT BPR Parasahabat Bogor'),
('20546', 'Rama Ganda', 'PT BPR Rama Ganda'),
('20547', 'Sebaru Sejahtera Lestari', 'PT BPR Sebaru Sejahtera Lestari'),
('20548', 'Sumber Ekonomi', 'PT BPR Sumber Ekonomi'),
('20549', 'Sumber Lumbanmual', 'PT BPR Sumber Lumbanmual'),
('20550', 'Supra Wahana Arta', 'PT BPR Supra Wahana Arta'),
('20551', 'Surya Kencana - Bogor', 'PT BPR Surya Kencana - Bogor'),
('20552', 'Tri Sejahtera Makmur', 'PT BPR Tri Sejahtera Makmur'),
('20553', 'Tricipta Mandiri', 'PT BPR Tricipta Mandiri'),
('20554', 'Universal Karya Mandiri Cibinong', 'PT BPR Universal Karya Mandiri Cibinong'),
('20555', 'Amanah Ummah', 'PT BPRS Amanah Ummah'),
('20556', 'Bina Rahmah', 'PT BPRS Bina Rahmah'),
('20557', 'Insan Cita Artha Jaya', 'PT BPRS Insan Cita Artha Jaya'),
('20558', 'Rif''atul Ummah', 'PT BPRS Rif''atul Ummah'),
('20559', 'Laksana Binacilegon', 'PT BPR Laksana Binacilegon'),
('20560', 'Mega Artha Sejahtera', 'PT BPR Mega Artha Sejahtera'),
('20561', 'Baitul Muawanah', 'PT BPRS Baitul Muawanah'),
('20562', 'Cilegon Mandiri', 'PD BPRS Cilegon Mandiri'),
('20563', 'Apta Sejahtera', 'PT BPR Apta Sejahtera'),
('20564', 'Karunia', 'PT BPR Karunia'),
('20565', 'Artha Bersama', 'PT BPR Artha Bersama'),
('20566', 'Arthaguna Sejahtera', 'PT BPR Arthaguna Sejahtera'),
('20567', 'Arthakelola Cahayatama', 'PT BPR Arthakelola Cahayatama'),
('20568', 'Bantoru Perintis', 'PT BPR Bantoru Perintis'),
('20569', 'Brata Bhakti Sejahtera', 'PT BPR Brata Bhakti Sejahtera'),
('20570', 'Nusantara Bona Pasogit 19', 'PT BPR Nusantara Bona Pasogit 19'),
('20571', 'Cibitung Permai', 'PT BPR Cibitung Permai'),
('20572', 'Cinere Artha Raya', 'PT BPR Cinere Artha Raya'),
('20573', 'Dana Lestari', 'PT BPR Dana Lestari'),
('20574', 'Danaberkah Lestari', 'PT BPR Danaberkah Lestari'),
('20575', 'Daya Perdana Nusantara', 'PT BPR Daya Perdana Nusantara'),
('20576', 'Depo Mitra Mandiri', 'PT BPR Depo Mitra Mandiri'),
('20577', 'Difobutama', 'PT BPR Difobutama'),
('20578', 'Efita Dana Sejahtera', 'PT BPR Efita Dana Sejahtera'),
('20579', 'Fajar Artha Makmur', 'PT BPR Fajar Artha Makmur'),
('20580', 'Laksana Binacimanggis', 'PT BPR Laksana Binacimanggis'),
('20581', 'LPK Sawangan - Depok', 'PD BPR LPK Sawangan'),
('20582', 'Mega Karsa Mandiri', 'PT BPR Mega Karsa Mandiri'),
('20583', 'Mitra Agung Nasari', 'PT BPR Mitra Agung Nasari'),
('20584', 'Mitra Karya', 'PT BPR Mitra Karya'),
('20585', 'Naribi Perkasa', 'PT BPR Naribi Perkasa'),
('20586', 'Panca Danarakyat', 'PT BPR Panca Danarakyat'),
('20587', 'Prima Kredit Mandiri', 'PT BPR Prima Kredit Mandiri'),
('20588', 'Sukma Kemang Agung', 'PT BPR Sukma Kemang Agung'),
('20589', 'Swadana Tridharma', 'PT BPR Swadana Tridharma'),
('20590', 'Tridharma Depok', 'PT BPR Tridharma Depok'),
('20591', 'Tunggal Asamukti', 'PT BPR Tunggal Asamukti'),
('20592', 'Al Barokah', 'PT BPRS Al Barokah'),
('20593', 'Al Salaam Amal Salman', 'PT BPRS Al Salaam Amal Salman'),
('20594', 'Al Hijrah Amanah', 'PT BPRS Al Hijrah Amanah'),
('20595', 'Bina Amwalul Hasanah', 'PT BPRS Bina Amwalul Hasanah'),
('20596', 'Daya Arta', 'PT BPR Daya Arta'),
('20597', 'Puspita Sari', 'Koperasi BPR Puspita Sari'),
('20598', 'Intidana Sukses Makmur', 'PT BPR Intidana Sukses Makmur'),
('20599', 'Multi Sembada Dana', 'PT BPR Sembada Dana'),
('206', 'Pasar Subang', ''),
('20600', 'Mutiara Jaya Sukses', 'PT BPR Mutiara Jaya Sukses'),
('20601', 'Hidayah', 'PT BPRS Hidayah'),
('20602', 'Anugerah Artasentosa Prima', 'PT BPR Anugerah Artasentosa Prima'),
('20603', 'Artharindo', 'PT BPR Artharindo'),
('20604', 'Bahtera Masyarakat', 'PT BPR Bahtera Masyarakat'),
('20605', 'Banksar Dana Loka', 'PT BPR Banksar Dana Loka'),
('20606', 'Mandiri Artha Niaga Prima', 'PT BPR Mandiri Artha Niaga Prima'),
('20607', 'Mitra Dana Utama', 'PT BPR Mitra Dana Utama'),
('20608', 'Mora', 'PT BPR Mora'),
('20609', 'Rasyid', 'PT BPR Rasyid'),
('20610', 'Sarana Utama Multidana', 'PT BPR Sarana Utama Multidana'),
('20611', 'Swadaya Tunggal', 'PT BPR Swadaya Tunggal'),
('20612', 'Nova Trijaya', 'PT BPR Nova Trijaya'),
('20613', 'Pesona Letris Pratama', 'PT BPR Pesona Letris Pratama'),
('20614', 'Cempaka Al Amin', 'PT BPRS Cempaka Al Amin'),
('20615', 'Tapeuna Dana', 'PT BPR Tapeuna Dana'),
('20616', 'Bina Dana Swadaya', 'PT BPR Dana Swadaya'),
('20617', 'Haneda Mitra Usaha', 'PT BPR Haneda Mitra Usaha'),
('20618', 'Bina Dana Cakrawala', 'PT BPR Bina Dana Cakrawala'),
('20619', 'Dana Usaha', 'PT BPR Dana Usaha'),
('20620', 'Kapital Metropolitan', 'PT BPR Kapital Metropolitan'),
('20621', 'Olympindo Sejahtera', 'PT BPR Olympindo Sejahtera'),
('20622', 'Tata Karya Indonesia', 'PT BPR Tata Karya Indonesia'),
('20623', 'Anugerah Multi Dana', 'PT BPR Anugerah Multi Dana'),
('20624', 'Bangun Mitra Wadas', 'PT BPR Bangun Mitra Wadas'),
('20625', 'BKPD Cilamaya', 'PD BPR BKPD Cilamaya'),
('20626', 'Nusantara Bona Pasogit 32', 'PT BPR Nusantara Bona Pasogit 32'),
('20627', 'Gema Esamas Abadi', 'PT BPR Gema Esamas Abadi'),
('20628', 'Laksana Luhurcilamaya', 'PT BPR Laksana Luhurcilamaya'),
('20629', 'Mitra Telagasari Utama', 'PT BPR Mitra Telagasari Utama'),
('20630', 'Pantura Abadi', 'PT BPR Pantura Abadi'),
('20631', 'Polin Jaya', 'PT BPR Polin Jaya'),
('20632', 'Sanggabuana Agung', 'PT BPR Sanggabuana Agung'),
('20633', 'Saudara Kita', 'PT BPR Saudara Kita'),
('20634', 'Sayma Karya', 'PT BPR Sayma Karya'),
('20635', 'Sumber Pangasean', 'PT BPR Sumber Pangasean'),
('20636', 'Suwaya Kurada', 'PT BPR Suwaya Kurada'),
('20637', 'Trisurya Tata Artha', 'PT BPR Trisurya Tata Artha'),
('20638', 'LPK Cipanas', 'PD BPR LPK Cipanas'),
('20639', 'LPK Malingping', 'PD BPR LPK Malingping'),
('20640', 'LPK Warunggunung', 'PD BPR LPK Warunggunung'),
('20641', 'Amal Bhakti Sejahtera', 'PT BPR Amal Bhakti Sejahtera'),
('20642', 'LPK Saketi', 'PD BPR LPK Saketi'),
('20643', 'Swadaya Masyarakat', 'PT BPR Swadaya Masyarakat'),
('20644', 'Cakra Dharma Artamandiri', 'PT BPR Cakra Dharma Artamandiri'),
('20645', 'Lambang Ganda', 'PT BPR Lambang Ganda'),
('20646', 'LPK Serang', 'PD BPR LPK Serang'),
('20647', 'Magga Jaya Utama', 'PT BPR Magga Jaya Utama'),
('20648', 'Aneka Danaraya', 'PT BPR Aneka Danaraya'),
('20649', 'Anugrah Swakerta', 'PT BPR Anugrah Swakerta'),
('20650', 'Arta Jakarta', 'PT BPR Arta Jakarta'),
('20651', 'Arta Mukti Triputra', 'PT BPR Arta Mukti Triputra'),
('20652', 'Artadamas Mandiri', 'PT BPR Artadamas Mandiri'),
('20653', 'Artha Mitra Usaha', 'PT BPR Artha Mitra Usaha'),
('20654', 'Asri Cikupa Karya', 'PT BPR Asri Cikupa Karya'),
('20655', 'Bintang Ekonomi Sejahtera', 'PT BPR Bintang Ekonomi Sejahtera'),
('20656', 'Bumi Dhana Adigraha', 'PT BPR Bumi Dhana Adigraha'),
('20657', 'Nusantara Bona Pasogit 12', 'PT BPR Nusantara Bona Pasogit 12'),
('20658', 'Cahaya Arthasejati', 'PT BPR Cahaya Arthasejati'),
('20659', 'Cakra Danarta', 'PT BPR Cakra Danarta'),
('20660', 'Central Artha Rezeki', 'PT BPR Central Artha Rezeki'),
('20661', 'Ciledug Dhana Semesta', 'PT BPR Ciledug Dhana Semesta'),
('20662', 'Cita Makmur Lestari', 'PT BPR Cita Makmur Lestari'),
('20663', 'Dana Niaga', 'PT BPR Dana Niaga'),
('20664', 'Danamitra Megah', 'PT BPR Danamitra Megah'),
('20665', 'Darbeni Rizki', 'PT BPR Darbeni Rizki'),
('20666', 'Fidusia Civitas', 'PT BPR Fidusia Civitas'),
('20667', 'Gamon', 'PT BPR Gamon'),
('20668', 'Gunung Tambora', 'PT BPR Gunung Tambora'),
('20669', 'Hariarta Sedana', 'PT BPR Hariarta Sedana'),
('20670', 'Hipmi Jaya', 'PT BPR Hipmi Jaya'),
('20671', 'Indomitra Adil Jaya', 'PT BPR Indomitra Adil Jaya'),
('20672', 'Artha Makmur Lestari', 'PT BPR Artha Makmur Lestari'),
('20674', 'Kerta Raharja', 'PD BPR Kerta Raharja'),
('20675', 'Kreo Lestari', 'PT BPR Kreo Lestari'),
('20676', 'Kuta Bumi Sidomukti', 'PT BPR Kuta Bumi Sidomukti'),
('20677', 'Laksana Lestari Serpong', 'PT BPR Laksana Lestari Serpong'),
('20678', 'Lumasindo Perkasa Putra', 'PT BPR Lumasindo Perkasa Putra'),
('20679', 'Lumbung Mekar Sentosa', 'PT BPR Lumbung Mekar Sentosa'),
('20680', 'Mahkota Artha Sejahtera', 'PT BPR Mahkota Artha Sejahtera'),
('20681', 'Makmur Artha Sedaya', 'PT BPR Makmur Artha Sedaya'),
('20682', 'Makmur Merata', 'PT BPR Makmur Merata'),
('20683', 'Marcorindo Perdana', 'PT BPR Marcorindo Perdana'),
('20684', 'Matahari Artadaya', 'PT BPR Matahari Artadaya'),
('20685', 'Menaramas Mitra', 'PT BPR Menaramas Mitra'),
('20686', 'Mitrabina Arthamakmur', 'PT BPR Mitrabina Arthamakmur'),
('20687', 'Muara Sumber Dana', 'PT BPR Muara Sumber Dana'),
('20688', 'Multi Paramindo Abadi', 'PT BPR Multi Paramindo Abadi'),
('20689', 'Niaga Mandiri', 'PT BPR Niaga Mandiri'),
('20690', 'Pinang Artha', 'PT BPR Pinang Artha'),
('20691', 'Prima Kredit Sejahtera', 'PT BPR Prima Kredit Sejahtera'),
('20692', 'Pularta Mandiri', 'PT BPR Pularta Mandiri'),
('20693', 'Pusaka Dana', 'PT BPR Pusaka Dana'),
('20694', 'Ragam Danakencana', 'PT BPR Ragam Danakencana'),
('20695', 'Ragam Peranmandiri', 'PT BPR Ragam Peranmandiri'),
('20696', 'Ragasakti', 'PT BPR Ragasakti'),
('20697', 'Rifi Maligi', 'PT BPR Rifi Maligi'),
('20698', 'Rizky Barokah', 'PT BPR Rizky Barokah'),
('20699', 'Sehat Sejahtera', 'PT BPR Sehat Sejahtera'),
('207', 'Monta Baru', ''),
('20700', 'Sinar Mitra Sejahtera', 'PT BPR Sinar Mitra Sejahtera'),
('20701', 'Sisibahari Dana', 'PT BPR Sisibahari Dana'),
('20702', 'Timika Dinamika Sarana', 'PT BPR Timika Dinamika Sarana'),
('20703', 'Trimahesa Lestari', 'PT BPR Trimahesa Lestari'),
('20704', 'Tritama Lumbung Cemerlang', 'PT BPR Tritama Lumbung Cemerlang'),
('20705', 'Tunas Jaya Global', 'PT BPR Tunas Jaya Global'),
('20706', 'Attaqwa Garuda Utama', 'PT BPRS Attaqwa Garuda Utama'),
('20707', 'Berkah Ramadhan', 'PT BPRS Berkah Ramadhan'),
('20708', 'Harta Insan Karimah', 'PT BPRS Harta Insan Karimah'),
('20709', 'Musyarakah Ummat Indonesia (MUSTINDO)', 'PT BPRS Musyarakah Ummat Indonesia (MUSTINDO)'),
('20710', 'Mulia Berkah Abadi', 'PT BPRS Mulia Berkah Abadi');
INSERT INTO `tref_bank` (`bankID`, `bankName`, `bankFullName`) VALUES
('20711', 'Wakalumi', 'PT BPRS Wakalumi'),
('20712', 'Athena Surya Prima', 'PT BPR Athena Surya Prima'),
('20713', 'Gita Makmur Utama', 'PT BPR Gita Makmur Utama'),
('20714', 'Bungo Mandiri', 'PT BPR Bungo Mandiri'),
('20715', 'Artha Prima Persada', 'PT BPR Artha Prima Persada'),
('20716', 'Batanghari', 'PT BPR Batanghari'),
('20717', 'Central Dana Mandiri', 'PT BPR Central Dana Mandiri'),
('20718', 'Central Niaga Abadi', 'PT BPR Central Niaga Abadi'),
('20719', 'Kencana Mandiri', 'PT BPR Kencana Mandiri'),
('20720', 'Mitra Lestari', 'PT BPR Mitra Lestari'),
('20721', 'Universal Sentosa', 'PT BPR Universal Sentosa'),
('20722', 'Pembangunan Kerinci', 'PT BPR Pembangunan Kerinci'),
('20723', 'Pondok Meja Indah', 'PT BPR Pondok Meja Indah'),
('20724', 'Rap Ganda', 'PT BPR Rap Ganda'),
('20725', 'Tanggo Rajo', 'PD BPR Tanggo Rajo'),
('20726', 'Phidectama  Biak', 'PT BPR Phidectama  Biak'),
('20727', 'Muamalat Yotefa', 'PT BPRS Muamalat Yotefa'),
('20728', 'Irian Sentosa', 'PT BPR Irian Sentosa'),
('20729', 'Nusa Intim Sentani', 'PT BPR Nusa Intim Sentani'),
('20730', 'Papua Mandiri Makmur', 'PT BPR Papua Mandiri Makmur'),
('20731', 'Phidectama Abepura', 'PT BPR Phidectama Abepura'),
('20732', 'Phidectama Sentani', 'PT BPR Phidectama Sentani'),
('20733', 'Arfak Indonesia', 'PT BPR Arfak Indonesia'),
('20734', 'Anugerah Dharmayuwana', 'PT BPR Anugerah Dharmayuwana'),
('20735', 'Artha Nirwana', 'PT BPR Artha Nirwana'),
('20736', 'Bagong Inti Marga', 'PT BPR Bagong Inti Marga'),
('20737', 'Blambangan Makmur', 'PT BPR Blambangan Makmur'),
('20738', 'Bumi Masyarakat Sejahtera', 'PT BPR Bumi Masyarakat Sejahtera'),
('20739', 'Delta Artha Panggung Banyuwangi', 'PT BPR Delta Artha Panggung Banyuwangi'),
('20740', 'Genteng', 'PT BPR Genteng'),
('20741', 'Jajag Lestari', 'PT BPR Jajag Lestari'),
('20742', 'Mahkota Reksaguna Artha', 'PT BPR Mahkota Reksaguna Artha'),
('20743', 'Nusamba Genteng', 'PT BPR Nusamba Genteng'),
('20744', 'Purwoharjo Lestari', 'PT BPR Purwoharjo Lestari'),
('20745', 'Restudhana Citrasejahtera', 'PT BPR Restudhana Citrasejahtera'),
('20746', 'Rogojampi Arta Niaga', 'PT BPR Rogojampi Arta Niaga'),
('20747', 'Sanggar Adiartha Nugraha', 'PT BPR Sanggar Adiartha Nugraha'),
('20748', 'Swadhanamas Pakto', 'PT BPR Swadhanamas Pakto'),
('20749', 'Tawang Alun', 'Koperasi BPR Tawang Alun'),
('20750', 'Wilis Putra Utama', 'PT BPR Wilis Putra Utama'),
('20751', 'Bintang Mas Maesan', 'PT BPR Bintang Mas Maesan'),
('20752', 'Delta Bondowoso', 'PT BPR Delta Bondowoso'),
('20753', 'Manuk Ayu', 'PT BPR Manuk Ayu'),
('20754', 'Manuk Wari', 'PT BPR Manuk Wari'),
('20755', 'Sari Dinarmas', 'PT BPR Sari Dinarmas'),
('20756', 'Ambulu Dhanaartha', 'PT BPR Ambulu Dhanaartha'),
('20757', 'Artha Asri Mulia', 'PT BPR Artha Asri Mulia'),
('20758', 'Artha Tunasmukti', 'PT BPR Artha Tunasmukti'),
('20759', 'Balung Artha Guna', 'PT BPR Balung Artha Guna'),
('20760', 'Bapuri', 'PT BPR Bapuri'),
('20761', 'Bima Hayu Pratama', 'PT BPR Bima Hayu Pratama'),
('20762', 'Bintang Niaga', 'PT BPR Bintang Niaga'),
('20763', 'Bumi Hayu', 'PT BPR Bumi Hayu'),
('20764', 'Cinde Wilis', 'PT BPR Cinde Wilis'),
('20765', 'Delta Jember', 'PT BPR Delta Jember'),
('20766', 'Eka Usaha', 'Koperasi BPR Eka Usaha'),
('20767', 'Gunung Modal Usaha', 'PT BPR Gunung Modal Usaha'),
('20768', 'Jember Lestari', 'PT BPR Jember Lestari'),
('20769', 'Kalisat Arthawira', 'PT BPR Kalisat Arthawira'),
('20770', 'Karunia Pakto', 'PT BPR Karunia Pakto'),
('20771', 'Mitra Jaya Mandiri', 'PT BPR Mitra Jaya Mandiri'),
('20772', 'Nur Semesta Indah', 'PT BPR Nur Semesta Indah'),
('20773', 'Nusamba Rambipuji', 'PT BPR Nusamba Rambipuji'),
('20774', 'Puji Raharja', 'PT BPR Puji Raharja'),
('20775', 'Rambi Artha Putra', 'PT BPR Rambi Artha Putra'),
('20776', 'Rini Bhaktinusa', 'PT BPR Rini Bhaktinusa'),
('20777', 'Sinar Wuluhan Artha', 'PT BPR Sinar Wuluhan Artha'),
('20778', 'Sukowono Arthajaya', 'PT BPR Sukowono Arthajaya'),
('20779', 'Surya Kencana - Jember', 'Koperasi BPR Balung Artha Guna'),
('20780', 'Tanggul Makmur', 'Koperasi BPR Tanggul Makmur'),
('20781', 'Tanggul Mitra Karya', 'PT BPR Tanggul Mitra Karya'),
('20782', 'Artha Sinar Mentari', 'PT BPRS Artha Sinar Mentari'),
('20783', 'Artha Waringin Jaya', 'PT BPR Artha Waringin Jaya'),
('20784', 'Delta Artha Panggung Situbondo', 'PT BPR Delta Artha Panggung Situbondo'),
('20785', 'Manuk Walet', 'PT BPR Manuk Walet'),
('20786', 'Tridana Kencana', 'PT BPR Tridana Kencana'),
('20787', 'Syariah Situbondo', 'PT BPRS Syariah Situbondo'),
('20788', 'Artha Praja', 'PT BPR Artha Praja'),
('20789', 'Cahaya Bumi Artha', 'Koperasi BPR Cahaya Bumi Artha'),
('20790', 'Citrahalim Persada', 'PT BPR Citrahalim Persada'),
('20791', 'Dharmasurya Aditika', 'PT BPR Dharmasurya Aditika'),
('20792', 'Harta Raya Cipta Mulia', 'PT BPR Harta Raya Cipta Mulia'),
('20793', 'Mulya Sri Rejeki', 'PT BPR Mulya Sri Rejeki'),
('20794', 'Nusamba Wlingi', 'PT BPR Nusamba Wlingi'),
('20795', 'Pulau Intan Sejahtera', 'PT BPR Pulau Intan Sejahtera'),
('20796', 'Sum Adiyatra', 'PT BPR Sum Adiyatra'),
('20797', 'Wlingi Pahala Pakto', 'PT BPR Wlingi Pahala Pakto'),
('20798', 'Agro Cipta Adiguna', 'PT BPR Agro Cipta Adiguna'),
('20799', 'Artha Nugraha', 'Koperasi BPR Artha Nugraha'),
('208', 'Artha Swadharma', ''),
('20800', 'Artha Pamenang', 'PT BPR Artha Pamenang'),
('20801', 'Artha Pamenang Wates', 'PT BPR Artha Pamenang Wates'),
('20802', 'Artha Samudera', 'Koperasi BPR Artha Samudera'),
('20803', 'Bank Pasar Kabupaten Kediri', 'PD BPR Bank Daerah Kabupaten Kediri'),
('20804', 'Berkah Pakto', 'PT BPR Berkah Pakto'),
('20805', 'Bina Reksa Karyaartha', 'PT BPR Bina Reksa Karyaartha'),
('20806', 'Bumidinar Kencana', 'PT BPR Bumidinar Kencana'),
('20807', 'Dhaha Ekonomi', 'PT BPR Dhaha Ekonomi'),
('20808', 'Hamindo Natamakmur', 'PT BPR Hamindo Natamakmur'),
('20809', 'Hasta Krida Jaya', 'Koperasi BPR Hasta Krida Jaya'),
('20810', 'Insumo Sumberarto', 'PT BPR Insumo Sumberarto'),
('20811', 'Kota Kediri', 'PD BPR Kota Kediri'),
('20812', 'Mahkota Mitrausaha', 'PT BPR Mahkota Mitrausaha'),
('20813', 'Pare Artorejo', 'PT BPR Pare Artorejo'),
('20814', 'Prima Dadi Arta', 'PT BPR Prima Dadi Arta'),
('20815', 'Surya Artha Guna Mandiri', 'PT BPR Surya Artha Guna Mandiri'),
('20816', 'Tanjung Tani', 'PT BPR Tanjung Tani'),
('20817', 'Toeloengredjo Dasa Nusantara', 'PT BPR Toeloengredjo Dasa Nusantara'),
('20818', 'Tulus Puji Rejeki', 'PT BPR Tulus Puji Rejeki'),
('20819', 'Artha Pamenang Syariah', 'PT BPRS Syariah Artha Pamenang'),
('20820', 'Rahma Syariah', 'PT BPRS Rahma Syariah'),
('20821', 'Tanmiya Artha', 'PT BPRS Tanmiya Artha'),
('20822', 'Arta Kencana', 'Koperasi BPR Arta Kencana'),
('20823', 'Artanawa', 'Koperasi BPR Artanawa'),
('20824', 'Arthatama Caruban', 'PT BPR Arthatama Caruban'),
('20825', 'Bank Pasar Kodya Madiun', 'PD BPR Bank Pasar Kota Madiun'),
('20826', 'Caruban Indah', 'PT BPR Caruban Indah'),
('20827', 'Kabupaten Dati II Madiun', 'PT BPR Artha Prima Persada'),
('20828', 'Mandiri Dhanasejahtera', 'PT BPR Mandiri Dhanasejahtera'),
('20829', 'Polatama Kusuma', 'PT BPR Polatama Kusuma'),
('20830', 'Sapadhana', 'PT BPR Sapadhana'),
('20831', 'Tunas Artha', 'Koperasi BPR Tunas Artha'),
('20832', 'Wijayakusuma', 'Koperasi BPR Wijayakusuma'),
('20833', 'Artha Dharma', 'PT BPR Artha Dharma'),
('20834', 'Buana Citra Sejahtera', 'PT BPR Buana Citra Sejahtera'),
('20835', 'Ekadharma Bhinaraharja', 'PT BPR Ekadharma Bhinaraharja'),
('20836', 'Mulyo Raharjo', 'PT BPR Mulyo Raharjo'),
('20837', 'Takeran', 'Koperasi BPR Takeran'),
('20838', 'Artha Pamenang Warujayeng', 'PT BPR Artha Pamenang Warujayeng'),
('20839', 'Kertosono Saranaartha', 'PT BPR Kertosono Saranaartha'),
('20840', 'Nagajayaraya Sentra Sentosa', 'PT BPR Nagajayaraya Sentra Sentosa'),
('20841', 'Tunas Artha Jaya Abadi', 'PT BPR Tunas Artha Jaya Abadi'),
('20842', 'Pundhi', 'PT BPR Pundhi'),
('20843', 'Utomo Widodo', 'PT BPR Utomo Widodo'),
('20844', 'Ngadirojo - Pacitan', 'Koperasi BPR Ngadirojo - Pacitan'),
('20845', 'Puri Artha Pacitan', 'PT BPR Puri Artha Pacitan'),
('20846', 'Artha Ponorogo', 'PT BPR Artha Ponorogo'),
('20847', 'Aswaja Ponorogo', 'PT BPR Aswaja Ponorogo'),
('20848', 'Dharma Raga', 'PT BPR Dharma Raga'),
('20849', 'Jetis', 'Koperasi BPR Jetis'),
('20850', 'KBPR Babadan', 'Koperasi BPR KBPR Babadan'),
('20851', 'Raga Surya Nuansa', 'PT BPR Raga Surya Nuansa'),
('20852', 'Al Mabrur Babadan', 'PT BPRS Al Mabrur Babadan'),
('20853', 'Artha Panggung Perkasa', 'PT BPR Artha Panggung Perkasa'),
('20854', 'Bangkit Prima Sejahtera', 'PT BPR Bangkit Prima Sejahtera'),
('20855', 'Jwalita', 'PT BPR Jwalita'),
('20856', 'Anugerah Paktomas', 'PT BPR Anugerah Paktomas'),
('20857', 'Bandung Adiartha', 'PT BPR Bandung Adiartha'),
('20858', 'Bank Daerah Tulungagung', 'PD BPR Bank Daerah Tulungagung'),
('20859', 'Bintang Tulungagung', 'PT BPR Bintang Tulungagung'),
('20860', 'Citrahalim Raharja', 'PT BPR Citrahalim Raharja'),
('20861', 'Hambangun Artha Selaras', 'PT BPR Hambangun Artha Selaras'),
('20862', 'Mitra Agung Mandiri', 'PT BPR Mitra Agung Mandiri'),
('20863', 'Ngunut Arta', 'PT BPR Ngunut Arta'),
('20864', 'Nusamba Ngunut', 'PT BPR Nusamba Ngunut'),
('20865', 'Sumberdhana Anda', 'PT BPR Sumberdhana Anda'),
('20866', 'Keraton', 'PT BPR Keraton'),
('20867', 'Ganda Lata', 'PT BPR Ganda Lata'),
('20868', 'Mustika Utama Kendari', 'PT BPR Mustika Utama Kendari'),
('20869', 'Hara Lata', 'PT BPR Hara Lata'),
('20870', 'Mustika Utama Kolaka', 'PT BPR Mustika Utama Kolaka'),
('20871', 'Mustika Utama Raha', 'PT BPR Mustika Utama Raha'),
('20872', 'Tanjung Pratama', 'PT BPR Tanjung Pratama'),
('20873', 'Bina Usaha Dana', 'PT BPR Bina Usaha Dana'),
('20874', 'Central Pitoby', 'PT BPR Central Pitoby'),
('20875', 'Christa Jaya Perdana', 'PT BPR Christa Jaya Perdana'),
('20876', 'Citra Putra Fatuleu', 'PT BPR Citra Putra Fatuleu'),
('20877', 'Sari Dinarkencana', 'PT BPR Sari Dinarkencana'),
('20878', 'Tanaoba Lais Manekat', 'PT BPR Tanaoba Lais Manekat'),
('20879', 'Lugas Ganda', 'PT BPR Lugas Ganda'),
('20880', 'Talenta Raya', 'PT BPR Talenta Raya'),
('20881', 'Suar Data', 'PT BPR Suar Data'),
('20882', 'Abang Pasar', 'Koperasi BPR Abang Pasar'),
('20883', 'Pataru Laba', 'PT BPR Pataru Laba'),
('20884', 'Gowata', 'PT BPRS Gowata'),
('20885', 'Harapan Sejahtera Malili', 'PT BPR Harapan Sejahtera Malili'),
('20886', 'Capta Sakti Sejahtera', 'PT BPR Capta Sakti Sejahtera'),
('20887', 'Bank Pasar Kota Ujung Pandang', 'PD BPR Kodya Dati II Ujung Pandang'),
('20888', 'Batara Wajo', 'PT BPR Batara Wajo'),
('20889', 'Dana Niaga Mandiri', 'PT BPR Dana Niaga Mandiri'),
('20890', 'Hasa Mitra', 'PT BPR Hasa Mitra'),
('20891', 'Sulawesi Danajaya', 'PT BPR Sulawesi Danajaya'),
('20892', 'Sulawesi Mandiri', 'PT BPR Sulawesi Mandiri'),
('20893', 'Tabungan Rakyat', 'PT BPR Tabungan Rakyat'),
('20894', 'Taruna Jujur Sakti', 'PT BPR Taruna Jujur Sakti'),
('20895', 'Dana Moneter', 'PT BPRS Dana Moneter'),
('20896', 'Indo Timur', 'PT BPRS Ikhwanul Ummah'),
('20897', 'Investama Mega Bakti', 'PT BPRS Investama Mega Bakti'),
('20898', 'Niaga Madani', 'PT BPRS Niaga Madani'),
('20899', 'Daramandiri  Palopo', 'PT BPR Daramandiri  Palopo'),
('209', 'Labuhan Sumbawa (Merger ke NTB Sumbawa Tgl 6 Nov 2009)', ''),
('20900', 'Putra Niaga Mandiri', 'PT BPR Putra Niaga Mandiri'),
('20901', 'Agrimakmur Lestari', 'PT BPR Agrimakmur Lestari'),
('20902', 'Citra Mas', 'PT BPR Citra Mas'),
('20903', 'Nurul Ikhwan', 'PT BPRS Nurul Ikhwan'),
('20904', 'Yustima', 'PT BPR Yustima'),
('20905', 'Pesisir Tanadoang', 'PT BPR Pesisir Tanadoang'),
('20906', 'Gerbang Masa Depan', 'PT BPR Gerbang Masa Depan'),
('20907', 'Surya Sejati', 'PT BPRS Surya Sejati Palleko'),
('20908', 'Capta Mulia Abadi', 'PT BPR Capta Mulia Abadi'),
('20909', 'Tritama Abadi Mengkendek', 'PT BPR Tritama Abadi Mengkendek'),
('20910', 'Puangrimanggalatung', 'PT BPR Puangrimanggalatung'),
('20911', 'Artatama Sejahtera', 'PT BPR Artatama Sejahtera'),
('20912', 'Batu Artorejo', 'PT BPR Batu Artorejo'),
('20913', 'Delta Malang', 'PT BPR Delta Malang'),
('20914', 'Dwi Cahaya Nusaperkasa', 'PT BPR Dwi Cahaya Nusaperkasa'),
('20915', 'Krisman Mandala', 'PT BPR Krisman Mandala'),
('20916', 'Pancadana', 'Koperasi BPR Pancadana'),
('20917', 'Sumber Dhana Makmur', 'PT BPR Sumber Dhana Makmur'),
('20918', 'Tripakarti Dhanatama', 'PT BPR Tripakarti Dhanatama'),
('20919', 'Wahana Dhana Batu', 'PT BPR Wahana Dhana Batu'),
('20920', 'Bumi Rinjani - Syariah', 'PT BPRS Bumi Rinjani - Syariah'),
('20921', 'Bumi Rinjani Batu - Syariah', 'PT BPRS Bumi Rinjani Batu - Syariah'),
('20922', 'Bank Pasar Kab. Dati II Lumajang', 'PD BPR Bank Pasar Kabupaten Lumajang'),
('20923', 'Dharma Indra', 'PT BPR Dharma Indra'),
('20924', 'Sentral Arta Asia', 'PT BPR Sentral Arta Asia'),
('20925', 'Tanah Bandar', 'PT BPR Tanah Bandar'),
('20926', 'Tanggul Arto', 'PT BPR Tanggul Arto'),
('20927', 'Yuka Jaya', 'PT BPR Yuka Jaya'),
('20928', 'Adiartha Reksacitra', 'PT BPR Adiartha Reksacitra'),
('20929', 'Amanah', 'Koperasi BPR Amanah'),
('20930', 'Anugerah Kusuma Singosari', 'PT BPR Anugerah Kusuma Singosari'),
('20931', 'Armindo Kencana', 'PT BPR Armindo Kencana'),
('20932', 'Artha Kanjuruhan Pemkab Malang', 'PT BPR Artha Kanjuruhan Pemkab Malang'),
('20933', 'Artha Wiwaha Arjuna', 'PT BPR Artha Wiwaha Arjuna'),
('20934', 'Arthasari Kencana', 'PT BPR Arthasari Kencana'),
('20935', 'Bangil Adyatama', 'PT BPR Bangil Adyatama'),
('20936', 'Bhaskara Pakto', 'PT BPR Bhaskara Pakto'),
('20937', 'Centraldjaja Pratama', 'PT BPR Centraldjaja Pratama'),
('20938', 'Citra Halim Perdana', 'PT BPR Citra Halim Perdana'),
('20939', 'Dampit', 'PT BPR Dampit'),
('20940', 'Dau Anugerah', 'PT BPR Dau Anugerah'),
('20941', 'Dau Kusumadjaja', 'PT BPR Dau Kusumadjaja'),
('20942', 'Dau Lestari', 'PT BPR Dau Lestari'),
('20943', 'Delta Artha Kencana', 'PT BPR Delta Artha Kencana'),
('20944', 'Delta Singosari', 'PT BPR Delta Singosari'),
('20945', 'Dhana Lestari', 'PT BPR Dhana Lestari'),
('20946', 'Eka Dana Mandiri', 'PT BPR Eka Dana Mandiri'),
('20947', 'Eka Dana Utama', 'PT BPR Eka Dana Utama'),
('20948', 'Gunung Arjuna', 'PT BPR Gunung Arjuna'),
('20949', 'Gunung Ringgit', 'PT BPR Gunung Ringgit'),
('20950', 'Kerta Arthamandiri', 'PT BPR Kerta Arthamandiri'),
('20951', 'Kharisma Kusuma Lawang', 'PT BPR Kharisma Kusuma Lawang'),
('20952', 'Kimi Sanda', 'PT BPR Kimi Sanda'),
('20953', 'Kridadhana Citranusa', 'PT BPR Kridadhana Citranusa'),
('20954', 'Mandiri Adiyatra', 'PT BPR Mandiri Adiyatra'),
('20955', 'Mitra Catur Mandiri', 'PT BPR Mitra Catur Mandiri'),
('20956', 'Pujon Jayamakmur', 'PT BPR Pujon Jayamakmur'),
('20957', 'Putera Dana', 'PT BPR Putera Dana'),
('20958', 'Sadhya Muktiparama', 'PT BPR Sadhya Muktiparama'),
('20959', 'Sedayadhana Makmur', 'PT BPR Sedayadhana Makmur'),
('20960', 'Sumber Arto', 'PT BPR Sumber Arto'),
('20961', 'Surya Abadi Bersaudara', 'PT BPR Surya Abadi Bersaudara'),
('20962', 'Tri Dana Sakti', 'PT BPR Tri Dana Sakti'),
('20963', 'Trikarya Waranugraha', 'PT BPR Trikarya Waranugraha'),
('20964', 'Tugu Artha', 'PD BPR Tugu Artha'),
('20965', 'Tumpang Arthasarana', 'PT BPR Tumpang Arthasarana'),
('20966', 'Tumpang Prima Artorejo', 'PT BPR Tumpang Prima Artorejo'),
('20967', 'Bhakti Haji Malang', 'PT BPRS Bhakti Haji Malang'),
('20968', 'Bumi Rinjani Kepanjen', 'PT BPRS Bumi Rinjani Kepanjen'),
('20969', 'Bumi Rinjani Malang', 'PT BPRS Bumi Rinjani Malang'),
('20970', 'MItra Harmoni Kota Malang', 'PT BPRS MItra Harmoni Kota Malang'),
('20971', 'Adhi Purwo', 'PT BPR Adhi Purwo'),
('20972', 'Arta Seruni Surabaya', 'PT BPR Arta Seruni Surabaya'),
('20973', 'Arta Taman Dayu', 'PT BPR Arta Taman Dayu'),
('20974', 'Artha Senapati', 'PT BPR Artha Senapati'),
('20975', 'Bangil Idaman', 'PT BPR Bangil Idaman'),
('20976', 'Bromo Mandiri', 'PT BPR Bromo Mandiri'),
('20977', 'Citrahalim Dhanatama', 'PT BPR Citrahalim Dhanatama'),
('20978', 'Danaputra Sakti', 'PT BPR Danaputra Sakti'),
('20979', 'Gunung Adidana', 'PT BPR Gunung Adidana'),
('20980', 'Harta Swadiri', 'KB BPR Harta Swadiri'),
('20981', 'Kalimasada', 'KB BPR Kalimasada'),
('20982', 'Kota Pasuruan', 'PT BPR Kota Pasuruan'),
('20983', 'Kraton Surapati', 'PT BPR Kraton Surapati'),
('20984', 'Kratonprima Abadi', 'PT BPR Kratonprima Abadi'),
('20985', 'Mina Mandiri', 'PT BPR Mina Mandiri'),
('20986', 'Nusapanida Pandaan', 'PT BPR Nusapanida Pandaan'),
('20987', 'Pandaan Arta Jaya', 'PT BPR Pandaan Arta Jaya'),
('20988', 'Parlaungan', 'PT BPR Parlaungan'),
('20989', 'Purwosari Anugerah', 'PT BPR Purwosari Anugerah'),
('20990', 'Sedulur Artamakmur', 'PT BPR Sedulur Artamakmur'),
('20991', 'Sukorejo Makmur', 'PT BPR Sukorejo Makmur'),
('20992', 'Surasari Hutama', 'PT BPR Surasari Hutama'),
('20993', 'Surya Dana Karya', 'PT BPR Surya Dana Karya'),
('20994', 'Wisman Perkasa', 'PT BPR Wisman Perkasa'),
('20995', 'Al - Hidayah', 'PT BPRS Al - Hidayah'),
('20996', 'Daya Artha Mentari', 'PT BPRS Daya Artha Mentari'),
('20997', 'Jabal Tsur', 'PT BPRS Jabal Tsur'),
('20998', 'Untung Surapati', 'KB BPRS Untung Surapati'),
('20999', 'Semeru Swasti', 'PT BPR Semeru Swasti'),
('210', 'Bahteramas Bau-Bau', 'PD BPR Bahteramas Bau-Bau'),
('21000', 'Sentral Arta Jaya', 'PT BPR Sentral Arta Jaya'),
('21001', 'Angga Perkasa', 'PT BPR Angga Perkasa'),
('21002', 'Antar Parama', 'PT BPR Antar Parama'),
('21003', 'Benua Kraksaan', 'PT BPR Benua Kraksaan'),
('21004', 'Sentral Arta Sejahtera', 'PT BPR Sentral Arta Sejahtera'),
('21005', 'Bumi Rinjani Probolinggo', 'PT BPRS Bumi Rinjani Probolinggo'),
('21006', 'Maesa Waya', 'PT BPR Maesa Waya'),
('21007', 'Citra Dumoga', 'PT BPR Citra Dumoga'),
('21008', 'Asparaga Adiguna Bersama', 'PT BPR Asparaga Adiguna Bersama'),
('21009', 'Mega Zanur', 'PT BPR Mega Zanur'),
('21010', 'Paro Dana', 'PT BPR Paro Dana'),
('21011', 'Telaga Sinar Cahaya', 'PT BPR Telaga Sinar Cahaya'),
('21012', 'Nusa Utara', 'PT BPR Nusa Utara'),
('21013', 'Celebes Mitra Perdana', 'PT BPR Celebes Mitra Perdana'),
('21014', 'Cipta Cemerlang Indonesia', 'PT BPR Cipta Cemerlang Indonesia'),
('21015', 'Dana Raya', 'PT BPR Dana Raya'),
('21016', 'Millenia', 'PT BPR Millenia'),
('21017', 'Prisma Dana', 'PT BPR Prisma Dana'),
('21018', 'Paro Laba', 'PT BPR Paro Laba'),
('21019', 'Pinasungkulan', 'PT BPR Pinasungkulan'),
('21020', 'Pinasungkulan Indah', 'PT BPR Pinasungkulan Indah'),
('21021', 'Amurang Utama', 'PT BPR Amurang Utama'),
('21022', 'Mapalus Tumetenden', 'PT BPR Mapalus Tumetenden'),
('21023', 'Bank Pegawai Pensiunan Indonesia Tomohon', 'Koperasi BPR Bank Pegawai Pensiunan Indonesia (KBPPI) Sulawesi Utara'),
('21024', 'Kartika Matuari', 'PT BPR Kartika Matuari'),
('21025', 'Primaesa Sejahtera', 'PT BPR Primaesa Sejahtera'),
('21026', 'Bima Abdi Swadaya', 'PT BPR Bima Abdi Swadaya'),
('21027', 'Pesisir Akbar', 'PT BPR Pesisir Akbar'),
('21028', 'NTB Dompu', 'PD BPR NTB Dompu'),
('21029', 'Abdi Warga Mulia', 'PT BPR Abdi Warga Mulia'),
('21030', 'Dana Master Surya', 'PT BPR Dana Master Surya'),
('21031', 'Danayasa', 'PT BPR Danayasa'),
('21032', 'Narpada Nusa', 'PT BPR Narpada Nusa'),
('21033', 'NTB Lombok Barat', 'PD BPR NTB Lombok Barat'),
('21034', 'Pesisir Layar Berkembang', 'PT BPR Pesisir Layar Berkembang'),
('21035', 'Ramot Ganda', 'PT BPR Ramot Ganda'),
('21036', 'Tanjung Abdi Swadaya', 'PT BPR Tanjung Abdi Swadaya'),
('21037', 'Wiranadi', 'PT BPR Wiranadi'),
('21038', 'NTB Lombok Tengah', 'PD BPR NTB Lombok Tengah'),
('21039', 'Sowan Utama', 'PT BPR Sowan Utama'),
('21040', 'Tresna Niaga', 'PT BPR Tresna Niaga'),
('21041', 'NTB Lombok Timur', 'PD BPR NTB Lombok Timur'),
('21042', 'Samas', 'PT BPR Samas'),
('21043', 'Segara Anak Kencana', 'PT BPR Segara Anak Kencana'),
('21044', 'Tulen Amanah', 'PT BPRS Tulen Amanah'),
('21045', 'Mitra Harmoni Mataram', 'PT BPR Mitra Harmoni Mataram'),
('21046', 'NTB Mataram', 'PD BPR NTB Mataram'),
('21047', 'Pitih Gumarang', 'PT BPR Pitih Gumarang'),
('21048', 'Prima Nadi', 'PT BPR Prima Nadi'),
('21049', 'Dinar Ashri', 'PT BPRS Dinar Ashri'),
('21050', 'PNM Patuh Beramal', 'PT BPRS PNM Patuh Beramal'),
('21051', 'Kabalong Abdi Swadaya', 'PT BPR Kabalong Abdi Swadaya'),
('21052', 'LKP Seteluk Tengah', 'PD BPR LKP Seteluk Tengah'),
('21053', 'Lopok Ganda', 'PT BPR Lopok Ganda'),
('21054', 'NTB Sumbawa', 'PD BPR NTB Sumbawa'),
('21055', 'Samawa Kencana', 'PT BPR Samawa Kencana'),
('21056', 'LKP Dalam Taliwang', 'PD BPR Dalam Taliwang'),
('21057', 'NTB Bima', 'PD BPR NTB Bima'),
('21058', 'Rahmah Hijrah Agung', 'PT BPRS Rahmah Hijrah Agung'),
('21059', 'Diori Ganda', 'PT BPR Diori Ganda'),
('21060', 'Bumiasih NBP 4', 'PT BPR Bumiasih NBP 4'),
('21061', 'Bumiasih NBP 22', 'PT BPR Bumiasih NBP 22'),
('21062', 'Bumiasih NBP 8', 'PT BPR Bumiasih NBP 8'),
('21063', 'Bumiasih NBP 17', 'PT BPR Bumiasih NBP 17'),
('21064', 'Bumiasih NBP 20', 'PT BPR Bumiasih NBP 20'),
('21065', 'Bumiasih NBP 25', 'PT BPR Bumiasih NBP 25'),
('21066', 'Bumiasih NBP 33', 'PT BPR Bumiasih NBP 33'),
('21067', 'Dana Ganda', 'PT BPR Dana Ganda'),
('21068', 'Disky Suryajaya', 'PT BPR Disky Suryajaya'),
('21069', 'Duta Paramarta', 'PT BPR Duta Paramarta'),
('21070', 'Karyabhakti Ugahari', 'PT BPR Karyabhakti Ugahari'),
('21071', 'Laksana Abadi Sunggal', 'PT BPR Laksana Abadi Sunggal'),
('21072', 'Laksana Guna Percut', 'PT BPR Laksana Guna Percut'),
('21073', 'Mitradana Madani', 'PT BPR Mitradana Madani'),
('21074', 'Multi Tata Perkasa', 'PT BPR Multi Tata Perkasa'),
('21075', 'Nusa Galang Makmur', 'PT BPR Nusa Galang Makmur'),
('21076', 'Nusantara Sunggal', 'PT BPR Nusantara Sunggal'),
('21077', 'Perbaungan Hombar Makmur', 'PT BPR Perbaungan Hombar Makmur'),
('21078', 'Pijer Podi Kekelengen', 'PT BPR Pijer Podi Kekelengen'),
('21079', 'Solider', 'PT BPR Solider'),
('21080', 'Sumber Tiopan Raya', 'PT BPR Sumber Tiopan Raya'),
('21081', 'Talabumi Sunggal', 'PT BPR Talabumi Sunggal'),
('21082', 'Tridana Percut', 'PT BPR Tridana Percut'),
('21083', 'Amanah Insan Cita', 'PT BPRS Amanah Insan Cita'),
('21084', 'Kafalatul Ummah', 'PT BPRS Kafalatul Ummah'),
('21085', 'Puduarta Insani', 'PT BPRS Puduarta Insani'),
('21086', 'Guna Rakyat', 'PT BPR Guna Rakyat'),
('21087', 'Nusantara Bona Pasogit 10', 'PT BPR Nusantara Bona Pasogit 10'),
('21088', 'Bumiasih NBP 15', 'PT BPR Bumiasih NBP 15'),
('21089', 'Logo Karo Asri', 'PT BPR Logo Karo Asri'),
('21090', 'Bumiasih NBP 16', 'PT BPR Bumiasih NBP 16'),
('21091', 'Mangatur Ganda', 'PT BPR Mangatur Ganda'),
('21092', 'Bumiasih NBP 13', 'PT BPR Bumiasih NBP 13'),
('21093', 'Sabee Meusampee', 'PT BPR Sabee Meusampee'),
('21094', 'Bumiasih NBP 21', 'PT BPR Bumiasih NBP 21'),
('21095', 'Sindang Laya Kotanopan', 'PT BPRS Sindanglaya Kotanopan'),
('21096', 'Bank Pasar Medan', 'Koperasi BPR Bank Pasar Kotamadya Medan'),
('21097', 'Duta Adiarta', 'PT BPR Duta Adiarta'),
('21098', 'Eka Prasetya', 'PT BPR Eka Prasetya'),
('21099', 'Milala', 'PT BPR Milala'),
('211', 'Bahteramas Bombana', 'PD BPR Bahteramas Bombana'),
('21100', 'Prima Tata Patumbak', 'PT BPR Prima Tata Patumbak'),
('21101', 'Wahana Bersama KPUM', 'PT BPR Wahana Bersama KPUM'),
('21102', 'Al Washliyah', 'PT BPRS Al Washliyah'),
('21103', 'Gebu Prima', 'PT BPRS Gebu Prima'),
('21104', 'Bumiasih NBP 34', 'PT BPR Bumiasih NBP 34'),
('21105', 'Amanah Bangsa', 'PT BPRS Amanah Bangsa'),
('21106', 'Bumiasih NBP 9', 'PT BPR Bumiasih NBP 9'),
('21107', 'Bumiasih NBP 18', 'PT BPR Bumiasih NBP 18'),
('21108', 'Nusantara Bona Pasogit 3', 'PT BPR Nusantara Bona Pasogit 3'),
('21109', 'Buana Agribisnis', 'PT BPR Buana Agribisnis'),
('21110', 'Bumiasih NBP 6', 'PT BPR Bumiasih NBP 6'),
('21111', 'Bumiasih NBP 7', 'PT BPR Bumiasih NBP 7'),
('21112', 'Al - Yaqin', 'PT BPRS Al - Yaqin'),
('21113', 'Bandar Jaya', 'PT BPR Bandar Jaya'),
('21114', 'Bina Barumun', 'PT BPR Bina Barumun'),
('21115', 'Karya Parhuta', 'PT BPR Karya Parhuta'),
('21116', 'Bumiasih NBP 1', 'PT BPR Bumiasih NBP 1'),
('21117', 'Porsea Jaya', 'PT BPR Porsea Jaya'),
('21118', 'Bumiasih NBP 5', 'PT BPR Bumiasih NBP 5'),
('21119', 'Surungan Nauli', 'PT BPR Surungan Nauli'),
('21120', 'Dana Mandiri', 'PT BPR Dana Mandiri'),
('21121', 'Gebu Harapan', 'PT BPR Gebu Harapan'),
('21122', 'Gema Ampekkoto Sejahtera', 'PT BPR Gema Ampekkoto Sejahtera'),
('21123', 'LPN Magek', 'BP BPR LPN Magek'),
('21124', 'Mutiara Pesisir', 'BP BPR Mutiara Pesisir'),
('21125', 'Padang Tarab', 'PT BPR Padang Tarab'),
('21126', 'Panampung', 'BP BPR LPN Panampung'),
('21127', 'Pembangunan Nagari', 'PT BPR Pembangunan Nagari'),
('21128', 'Raga Dana Sejahtera', 'BP BPR Raga Dana Sejahtera'),
('21129', 'Sungai Puar', 'PT BPR Sungai Puar'),
('21130', 'Tilatang Kamang', 'PT BPR Tilatang Kamang'),
('21131', 'Carana Kiat Andalas', 'PT BPRS Carana Kiat Andalas'),
('21132', 'Rangkiang Aur', 'PT BPR Rangkiang Aur'),
('21133', 'Jam Gadang', 'PT BPR Jam Gadang'),
('21134', 'Ampek Angkek Candung', 'PT BPRS Ampek Angkek Candung'),
('21135', 'Dharma Nagari', 'PT BPR Dharma Nagari'),
('21136', 'LPN Sungai Rumbai', 'BP BPR LPN Sungai Rumbai'),
('21137', 'Pulau Punjung', 'PT BPR Pulau Punjung'),
('21138', 'Sungai Rumbai', 'PT BPR Sungai Rumbai'),
('21139', 'Tarantang', 'BP BPR LPN Tarantang'),
('21140', 'Pagai Utara Selatan', 'PT BPR Pagai Utara Selatan'),
('21141', 'Sipora', 'PT BPR Sipora'),
('21142', 'Artha Niaga Solok', 'BP BPR Artha Niaga Solok'),
('21143', 'Tambun Ijuk', 'PT BPR Tambun Ijuk'),
('21144', 'Dharma Pejuang Empatlima', 'PT BPR Dharma Pejuang Empatlima'),
('21145', 'Gonjong Limo', 'PD BPR Gonjong Limo'),
('21146', 'Guguk Mas Makmur', 'BP BPR Guguk Mas Makmur'),
('21147', 'Harau', 'PT BPR Harau'),
('21148', 'Labuh Gunung', 'BP BPR Labuh Gunung'),
('21149', 'LPN Kampung Baru', 'PT BPR LPN Kampung Baru Muara Paiti'),
('21150', 'LPN Taeh Baruh', 'BP BPR LPN Taeh Baruh'),
('21151', 'Mitra Usaha Muaro Paiti', 'BP BPR Mitra Usaha Muaro Paiti'),
('21152', 'Padang Kuning', 'BP BPR LPN Padang Kuning'),
('21153', 'Sago Luhak Limapuluh', 'PT BPR Sago Luhak Limapuluh'),
('21154', 'Suliki Gunung Mas', 'PT BPR Suliki Gunung Mas'),
('21155', 'Al Makmur', 'PT BPRS Al Makmur'),
('21156', 'Artha Nagari Madani', 'PT BPR Artha Nagari Madani'),
('21157', 'Berok Gunung Pangilun', 'PT BPR Berok Gunung Pangilun'),
('21158', 'Budisetia', 'PT BPR Budisetia'),
('21159', 'Cempaka Mitra Nagari Kephil', 'PT BPR Cempaka Mitra Nagari Kephil'),
('21160', 'Central Micro', 'BP BPR Central Micro'),
('21161', 'Dharma Bhakti Smadang', 'PT BPR Dharma Bhakti Smadang'),
('21162', 'Mitra Danagung', 'PT BPR Mitra Danagung'),
('21163', 'Stigma Andalas', 'PT BPR Stigma Andalas'),
('21164', 'Baringin Pdg. Panjang Sakato', 'PT BPR Baringin Pdg. Panjang Sakato'),
('21165', 'Kampung Manggis', 'BP BPR LPN Kampung Manggis'),
('21166', 'Cincin Permata Andalas', 'PT BPR Cincin Permata Andalas'),
('21167', 'Ganto Nagari 1954', 'PT BPR Ganto Nagari 1954'),
('21168', 'Koto Dalam', 'PT BPR Koto Dalam'),
('21169', 'Nagari Kasang', 'BP BPR LPN Kasang'),
('21170', 'Nurul Barokah', 'PT BPR Nurul Barokah'),
('21171', 'Pembangunan Kab. Padang Pariaman', 'PT BPR Pembangunan Kab. Padang Pariaman'),
('21172', 'Piala Makmur', 'PT BPR Piala Makmur'),
('21173', 'VII Koto', 'Koperasi BPR VII Koto Sungai Sariak'),
('21174', 'Jorong Kampung Tangah', 'BP BPR Jorong Kampung Tangah'),
('21175', 'La Mangau Sejahtera', 'BP BPR La Mangau Sejahtera'),
('21176', 'Khatulistiwa Bonjol', 'PT BPR Khatulistiwa Bonjol'),
('21177', 'Air Bangis', 'BP BPR Air Bangis'),
('21178', 'Mitra Dana', 'BP BPR Mitra Dana'),
('21179', 'Ophir Pasaman', 'Koperasi BPR Ophir'),
('21180', 'Swadaya Anak Nagari', 'BP BPR Swadaya Anak Nagari'),
('21181', 'Mentari Pasaman Saiyo', 'PT BPRS Mentari Pasaman Saiyo'),
('21182', 'Rangkiang Denai', 'PT BPR Rangkiang Denai'),
('21183', 'Batang Kapas', 'PT BPR Batang Kapas'),
('21184', 'Batang Tarusan', 'BP BPR Batang Tarusan'),
('21185', 'Gema Pesisir', 'PT BPR Gema Pesisir'),
('21186', 'Kotosebelas Tarusan', 'PT BPR Kotosebelas Tarusan'),
('21187', 'Lengayang', 'PT BPR Lengayang'),
('21188', 'LPN Tapan', 'BP BPR LPN Tapan'),
('21189', 'Samudera', 'PT BPR Samudera'),
('21190', 'Gajah Tongga Kotopiliang', 'PT BPR Gajah Tongga Kotopiliang'),
('21191', 'Kubang', 'BP BPR LPN Kubang'),
('21192', 'LPN Mudik Air', 'PD BPR LPN Mudik Air'),
('21193', 'Pasar Baru Durian', 'BP BPR LPN Pasar Baru Durian'),
('21194', 'Pondok Kapur', 'PT BPR Pondok Kapur'),
('21195', 'Batang Palangki', 'BP BPR Batang Palangki'),
('21196', 'Bukit Cati Pematang Panjang', 'PT BPR Bukit Cati Pematang Panjang'),
('21197', 'Kampung Dalam', 'BP BPR LPN Kampung Dalam'),
('21198', 'Mutiara Nagari', 'PT BPR Mutiara Nagari'),
('21199', 'LPN Talawi Sakato', 'BP BPR LPN Talawi Sakato'),
('212', 'LKP Belo', ''),
('21200', 'Muaro Bodi', 'BP BPR LPN Muaro Bodi'),
('21201', 'Sijunjung', 'BP BPR Sijunjung'),
('21202', 'Gunung Talang', 'PT BPR Gunung Talang'),
('21203', 'LPN Kinari', 'BP BPR LPN Kinari'),
('21204', 'LPN Bukit Tandang', 'BP BPR Bukit Tandang Mandiri'),
('21205', 'Mos Muara Panas', 'PT BPR Mos Muara Panas'),
('21206', 'Solok Sakato', 'BP BPR Solok Sakato'),
('21207', 'Surya Katialo', 'PT BPR Surya Katialo'),
('21208', 'X Koto Singkarak', 'PT BPR X Koto Singkarak'),
('21209', 'Barakah Nawaitul Ikhlas', 'PT BPRS Barakah Nawaitul Ikhlas'),
('21210', 'LPN Pakan Raba''a', 'BP BPR LPN Pakan Rabaa'),
('21211', 'Sarantau Sasurambi', 'PT BPR Sarantau Sasurambi'),
('21212', 'Solok Selatan', 'PT BPR Solok Selatan'),
('21213', 'Batang Selo (Batu)', 'BP BPR Batang Selo (Batu)'),
('21214', 'Batipuh', 'PT BPR Batipuh'),
('21215', 'Carano Nagari', 'PT BPR Carano Nagari'),
('21216', 'Gudam Pagaruyung', 'BP BPR LPN Gudam Pagaruyung'),
('21217', 'LPN Andalas Baruh Bukit', 'BP BPR LPN Andalas Baruh Bukit'),
('21218', 'LPN Pandaisikek', 'BP BPR LPN Pandaisikek'),
('21219', 'LPN Tanjung Barulak', 'BP BPR LPN Tanjung Barulak'),
('21220', 'Luhak Nan Tuo', 'BP BPR Luhak Nan Tuo'),
('21221', 'Masyarakat Lintau Buo (Malibu)', 'PT BPR Masyarakat Lintau Buo (Malibu)'),
('21222', 'Padang Magek', 'BP BPR Padang Magek'),
('21223', 'Pagaruyung', 'BP BPR LPN Pagaruyung'),
('21224', 'Pariangan', 'PT BPR Pariangan'),
('21225', 'Rangkiang Nagari', 'PT BPR Rangkiang Nagari'),
('21227', 'Haji Miskin', 'PT BPRS Haji Miskin'),
('21228', 'Balerong Bunta', 'BP BPR LPN Balerong Bunta'),
('21229', 'Guguk Sarai', 'BP BPR Guguk Sarai'),
('21230', 'Marunting Sejahtera', 'PD BPR Marunting Sejahtera'),
('21231', 'Lingga Sejahtera', 'PT BPR Lingga Sejahtera'),
('21232', 'Bangka Belitung', 'PT BPRS Bangka Belitung'),
('21233', 'Rarat Ganda', 'PT BPR Rarat Ganda'),
('21234', 'Al-Falah', 'PT BPRS Al-Falah'),
('21235', 'Sindang Binaharta', 'PT BPR Sindang Binaharta'),
('21236', 'Tiur Ganda', 'PT BPR Tiur Ganda'),
('21237', 'Cinta Manis Agroloka', 'PT BPR Cinta Manis Agroloka'),
('21238', 'Agritrans Batumarta', 'PT BPR Agritrans Batumarta'),
('21239', 'Musi Arta Lestari', 'PT BPR Musi Arta Lestari'),
('21240', 'Mitra Central Dana', 'PT BPR Mitra Central Dana'),
('21241', 'Multidana Mandiri', 'PT BPR Multidana Mandiri'),
('21242', 'Musi Artha Surya', 'PT BPR Musi Artha Surya'),
('21243', 'Prabumegah Kencana', 'PT BPR Prabumegah Kencana'),
('21244', 'Prima Dana Abadi', 'PT BPR Prima Dana Abadi'),
('21245', 'Puskopat', 'PT BPR Puskopat'),
('21246', 'Sukasada', 'PT BPR Sukasada'),
('21247', 'Sumatera Selatan', 'PT BPR Sumatera Selatan'),
('21248', 'Tri Gunung Selatan', 'PT BPR Tri Gunung Selatan'),
('21249', 'Ukabima Grazia', 'PT BPR Ukabima Grazia'),
('21250', 'Ukabima Lestari', 'PT BPR Ukabima Lestari'),
('21251', 'Tahap Ganda', 'PT BPR Tahap Ganda'),
('21252', 'Cipta Dana Prima', 'PT BPR Cipta Dana Prima'),
('21253', 'Palu Anugerah', 'PT BPR Palu Anugerah'),
('21254', 'Palu Lokadana Utama', 'PT BPR Palu Lokadana Utama'),
('21255', 'Alimo Dana Prima', 'PT BPR Alimo Dana Prima'),
('21256', 'Nustria Mitra Abadi', 'PT BPR Nustria Mitra Abadi'),
('21257', 'Prima Artha Sejahtera', 'PT BPR Prima Artha Sejahtera'),
('21258', 'Akarumi', 'PT BPR Akarumi'),
('21259', 'Binarta Luhur', 'PT BPR Binarta Luhur'),
('21260', 'Yaspis Dana Prima', 'PT BPR Yaspis Dana Prima'),
('21261', 'Bumiasih NBP 24', 'PT BPR Bumiasih NBP 24'),
('21262', 'Mandar', 'PT BPR Mandar'),
('21263', 'Mitra Arta Mulia', 'PT BPR Mitra Arta Mulia'),
('21264', 'Terabina Seraya Mulia', 'PT BPR Terabina Seraya Mulia'),
('21265', 'Dumai Kapital Lestari', 'PT BPR Dumai Kapital Lestari'),
('21266', 'Gemilang', 'PD BPR Gemilang'),
('21267', 'Indra Arta', 'PD BPR Indra Arta'),
('21268', 'Bumi Riau Insani', 'PT BPR Bumi Riau Insani'),
('21269', 'Sarimadu', 'PD BPR Sarimadu'),
('21270', 'Unisritama', 'PT BPR Unisritama'),
('21271', 'Berkah Dana Fadhlillah', 'PT BPRS Berkah Dana Fadhlillah'),
('21272', 'Cempaka Mitra Nagori Kuansing', 'PT BPR Cempaka Mitra Nagori Kuansing'),
('21273', 'Dana Amanah', 'PD BPR Dana Amanah'),
('21274', 'Delta Dana Mandiri', 'PT BPR Delta Dana Mandiri'),
('21275', 'Artha Margahayu', 'PT BPR Artha Margahayu'),
('21276', 'Duta Perdana', 'PT BPR Duta Perdana'),
('21277', 'Faiza Pradani Andi', 'PT BPR Faiza Pradani Andi'),
('21278', 'Harta Mandiri', 'PT BPR Harta Mandiri'),
('21279', 'Indomitra Mega Kapital', 'PT BPR Indomitra Mega Kapital'),
('21280', 'Mandiri Jaya Perkasa', 'PT BPR Mandiri Jaya Perkasa'),
('21281', 'Mitra Rakyat Riau', 'PT BPR Mitra Rakyat Riau'),
('21282', 'Payung Negeri Bestari', 'PT BPR Payung Negeri Bestari'),
('21283', 'Pekanbaru', 'PT BPR Pekanbaru'),
('21284', 'Tuah Negeri Mandiri', 'PT BPR Tuah Negeri Mandiri'),
('21285', 'Tunas Mitra Mandiri', 'PT BPR Tunas Mitra Mandiri'),
('21286', 'Universal Karya Mandiri Riau', 'PT BPR Universal Karya Mandiri Riau'),
('21287', 'Cempaka Wadah Sejahtera', 'PT BPR Cempaka Wadah Sejahtera'),
('21288', 'Rokan Hilir', 'PD BPR Rokan Hilir'),
('21289', 'Rokan Hulu', 'PT BPR Rokan Hulu'),
('21290', 'Hasanah', 'PT BPRS Hasanah'),
('21291', 'Cahaya Wiraputra', 'PT BPR Cahaya Wiraputra'),
('21292', 'Pancur Banua Khatulistiwa', 'PT BPR Pancur Banua Khatulistiwa'),
('21293', 'Melawi Mandiri', 'PT BPR Melawi Mandiri'),
('21294', 'Bank Pasar Kota Pontianak', 'PD BPR Bank Pasar Kota Pontianak'),
('21295', 'Cemerlang Kapuas Makmur', 'PT BPR Cemerlang Kapuas Makmur'),
('21296', 'Centradana Kapuas', 'PT BPR Centradana Kapuas'),
('21297', 'Dana Tirtaraya', 'PT BPR Dana Tirtaraya'),
('21298', 'Dana Wira Buana', 'PT BPR Dana Wira Buana'),
('21299', 'Lokadana Sentosa', 'PT BPR Lokadana Sentosa'),
('213', 'Kopang Rembiga', ''),
('21300', 'Perdana Lintas Khatulistiwa', 'PT BPR Perdana Lintas Khatulistiwa'),
('21301', 'Prima Multi Makmur', 'PT BPR Prima Multi Makmur'),
('21302', 'Sukadana Prima', 'PT BPR Sukadana Prima'),
('21303', 'Universal Karya Mandiri Tangerang', 'PT BPR Universal Karya Mandiri Tangerang'),
('21304', 'Tebas Lokarizki', 'PT BPR Tebas Lokarizki'),
('21305', 'Dana Sanggau Mandiri', 'PT BPR Dana Sanggau Mandiri'),
('21306', 'Mitra Primalestari', 'PT BPR Mitra Primalestari'),
('21307', 'Panca Arta Graha', 'PT BPR Panca Arta Graha'),
('21308', 'Sambas Arta', 'PT BPR Sambas Arta'),
('21309', 'BKK Mandiraja', 'PD BPR BKK Mandiraja'),
('21310', 'Surya Yudhakencana', 'PT BPR Surya Yudhakencana'),
('21311', 'Artha Mekar Sokaraja', 'PT BPR Artha Mekar Sokaraja'),
('21312', 'BKK Purwokerto Utara', 'PD BPR BKK Purwokerto Utara'),
('21313', 'Danamitra Sokaraja', 'PT BPR Danamitra Sokaraja'),
('21314', 'Gunung Simping Artha', 'PT BPR Gunung Simping Artha'),
('21315', 'Mitra Gema Mandiri', 'PT BPR Mitra Gema Mandiri'),
('21316', 'Sahabat Purwokerto', 'PT BPR Sahabat Purwokerto'),
('21317', 'Soka Panca Artha', 'PT BPR Soka Panca Artha'),
('21318', 'Dana Mitra Sakti', 'PT BPR Dana Mitra Sakti'),
('21319', 'Arta Leksana', 'PT BPRS Arta Leksana'),
('21320', 'Bina Amanah Satria', 'PT BPRS Bina Amanah Satria'),
('21321', 'Khasanah Ummat', 'PT BPRS Khasanah Ummat'),
('21322', 'Artha Rahayu', 'PT BPR Artha Rahayu'),
('21323', 'Banyu Arthacitra', 'PT BPR Banyu Arthacitra'),
('21324', 'BKK Cilacap Tengah', 'PD BPR BKK Cilacap Tengah'),
('21325', 'Citanduy Artha', 'PT BPR Citanduy Artha'),
('21326', 'Gunung Slamet', 'PT BPR Gunung Slamet'),
('21327', 'Kroya Bangunartha', 'PT BPR Kroya Bangunartha'),
('21328', 'Ukabima Sejahtera', 'PT BPR Ukabima Sejahtera'),
('21329', 'Bumi Artha Sampang', 'PT BPRS Bumi Artha Sampang'),
('21330', 'Gunung Slamet Syariah', 'PT BPRS Syariah Gunung Slamet'),
('21331', 'Suriyah', 'PT BPRS Suriyah'),
('21332', 'Artha Perwira', 'PD BPR Artha Perwira Kab Purbalingga'),
('21333', 'BKK Purbalingga', 'PD BPR BKK Purbalingga'),
('21334', 'Buana Mitra Perwira', 'PT BPRS Buana Mitra Perwira'),
('21335', 'Bontang Sejahtera', 'PT BPR Bontang Sejahtera'),
('21336', 'Dhanarta Dwiprima', 'PT BPR Dhanarta Dwiprima'),
('21337', 'Paro Tua', 'PT BPR Paro Tua'),
('21338', 'Bepede Kutai Sejahtera', 'PT BPR Bepede Kutai Sejahtera'),
('21339', 'Ingertad Kota Bangun', 'PT BPR Ingertad Kota Bangun'),
('21340', 'Kutai Timur', 'PT BPR Kutai Timur'),
('21341', 'Artha Karya Perdana', 'PT BPR Artha Karya Perdana'),
('21342', 'Kota Samarinda', 'PD BPR Kota Samarinda'),
('21343', 'Permata Hati Jaya', 'PT BPR Permata Hati Jaya'),
('21344', 'Ronggolawe', 'PT BPR Ronggolawe Samarinda'),
('21345', 'Semoga Jaya Artha', 'PT BPR Semoga Jaya Artha'),
('21346', 'Zebra Surya Prima', 'PT BPR Zebra Surya Prima'),
('21347', 'BAPERA', 'PT BPR BAPERA'),
('21348', 'BKK TPI Klidang Lor', 'PD BKK TPI Klidang Lor'),
('21349', 'Limpungarta Utama', 'PT BPR Limpungarta Utama'),
('21350', 'Bank Pasar Kabupaten Dati II  Blora', 'PD BPR Bank Pasar Kabupaten Dati II  Blora'),
('21351', 'BKK Blora Kota', 'PD BPR BKK Blora Kota'),
('21352', 'Cepu Nasionalbank', 'PT BPR Cepu Nasionalbank'),
('21353', 'Dhana Mitratama', 'PT BPR Dhana Mitratama'),
('21354', 'Dutabhakti Insani', 'PT BPR Dutabhakti Insani'),
('21355', 'Arisma Mandiri', 'PT BPR Arisma Mandiri'),
('21356', 'BKK Banjarharjo', 'PD BPR BKK Banjarharjo'),
('21357', 'Bumiayu Bangun Citra', 'PT BPR Bumiayu Bangun Citra'),
('21358', 'Eleska Artha', 'PT BPR Eleska Artha'),
('21359', 'Jatibarang Sediaguna', 'PT BPR Jatibarang Sediaguna'),
('21360', 'Puspakencana Brebes', 'PD BPR Puspakencana Brebes'),
('21361', 'Artamas', 'PT BPR Artamas'),
('21362', 'Artha Mranggenjaya', 'PT BPR Artha Mranggenjaya'),
('21363', 'Arthanugraha Makmursejahtera', 'PT BPR Arthanugraha Makmursejahtera'),
('21364', 'BKK Demak Kota', 'PD BPR BKK Demak Kota'),
('21365', 'Karticentra Artha', 'PT BPR Karticentra Artha'),
('21366', 'Kusuma Langgeng', 'PT BPR Kusuma Langgeng'),
('21367', 'Mranggen Mitrapersada', 'PT BPR Mranggen Mitrapersada'),
('21368', 'Restu Mranggen Makmur', 'PT BPR Restu Mranggen Makmur'),
('21369', 'Sindhur Arta Mulia Kencana', 'PT BPR Sindhur Arta Mulia Kencana'),
('21370', 'Swadharma Mranggen', 'PT BPR Swadharma Mranggen'),
('21371', 'BKK Purwodadi', 'PD BPR BKK Purwodadi'),
('21372', 'Purwa Artha', 'PT BPR Purwa Artha'),
('21373', 'Wirosari  Ijo', 'PT BPR Wirosari  Ijo'),
('21374', 'Ben Salamah Abadi', 'PT BPRS Ben Salamah Abadi'),
('21375', 'BKK Jepara', 'PD BPR BKK Jepara'),
('21376', 'Jepara Artha', 'PD BPR Jepara Artha'),
('21377', 'Nusamba Pecangaan', 'PT BPR Nusamba Pecangaan'),
('21378', 'Artha Mitragombong', 'PT BPR Artha Mitragombong'),
('21379', 'Bank Pasar Kabupaten Kebumen', 'PD BPR Bank Pasar Kabupaten Kebumen'),
('21380', 'BKK Kebumen', 'PD BPR BKK Kebumen'),
('21381', 'Dana Mitra Sejahtera', 'PT BPR Dana Mitra Sejahtera'),
('21382', 'Gunung Merapi', 'PT BPR Gunung Merapi'),
('21383', 'Sinararta Sejahtera', 'PT BPR Sinararta Sejahtera'),
('21384', 'Ikhsanul Amal', 'PT BPRS Ikhsanul Amal'),
('21385', 'Agung Sejahtera', 'PT BPR Agung Sejahtera'),
('21386', 'Anugerah Harta Kaliwungu', 'PT BPR Anugerah Harta Kaliwungu'),
('21387', 'Artha Kaliwungu', 'PT BPR Artha Kaliwungu'),
('21388', 'Arthama Cerah', 'PT BPR Arthama Cerah'),
('21389', 'BKK Boja', 'PT BPR Pasar Boja'),
('21390', 'Citra Darian', 'PT BPR Citra Darian'),
('21391', 'Dhanatani Cepiring', 'PT BPR Dhanatani Cepiring'),
('21392', 'Enggal Makmur Adi Santoso', 'PT BPR Enggal Makmur Adi Santoso'),
('21393', 'Kendali Artha', 'PD BPR Kendali Artha'),
('21394', 'Kusuma Rejo', 'PT BPR Kusuma Rejo'),
('21395', 'Kusuma Sari', 'PT BPR Kusuma Sari'),
('21396', 'Nusamba Cepiring', 'PT BPR Nusamba Cepiring'),
('21397', 'Pasar Boja', 'PT BPR Pasar Boja'),
('21398', 'Sukorejo Menara Mulya', 'PT BPR Sukorejo Menara Mulya'),
('21399', 'Swadharma Makmur Artha Sembada', 'PT BPR Swadharma Makmur Artha Sembada'),
('214', 'Bahteramas Kolaka', 'PD BPR Bahteramas Kolaka'),
('21400', 'Weleri Jayapersada', 'PT BPR Weleri Jayapersada'),
('21401', 'Asad Alif', 'PT BPRS Syariah Asad Alif'),
('21402', 'Bank Pasar Kabupaten Kudus', 'PT BPR Hartha Muriatama'),
('21403', 'BKK Jati - Kudus', 'PD BPR BKK Jati - Kudus'),
('21404', 'Catur Artha Jaya', 'PT BPR Catur Artha Jaya'),
('21405', 'Dananta', 'PT BPR Dananta'),
('21406', 'Hartha Muriatama', 'PT BPR Hartha Muriatama'),
('21407', 'Mitra Budikusuma Mandiri', 'PT BPR Mitra Budikusuma Mandiri'),
('21408', 'Taruna Adidaya Santosa', 'PT BPR Taruna Adidaya Santosa'),
('21409', 'Artha Mertoyudan', 'PT BPR Artha Mertoyudan'),
('21410', 'Artha Sambhara', 'PT BPR Artha Sambhara'),
('21411', 'Bank Bapas 69', 'PD BPR Bank Bapas 70'),
('21412', 'Bank Pasar Kota Magelang', 'PD BPR Bank Magelang'),
('21413', 'BKK Magelang Utara', 'PD BPR BKK Magelang Utara'),
('21414', 'BKK Muntilan', 'PD BPR BKK Muntilan'),
('21415', 'Danarakyat Sentosa', 'PT BPR Danarakyat Sentosa'),
('21416', 'Dwiartha Sagriya', 'PT BPR Dwiartha Sagriya'),
('21417', 'Hidup Arthagraha', 'PT BPR Hidup Arthagraha'),
('21418', 'Kembang Parama', 'PT BPR Kembang Parama'),
('21419', 'Lumbung Artha Muntilanindo', 'PT BPR Lumbung Artha Muntilanindo'),
('21420', 'Mertoyudan Makmur', 'PT BPR Mertoyudan Makmur'),
('21421', 'Mitra', 'PT BPR Mitra'),
('21422', 'Mulyo Lumintu', 'PT BPR Mulyo Lumintu'),
('21423', 'Niji', 'PT BPR Niji'),
('21424', 'Prima Mertoyudan Sejahtera', 'PT BPR Prima Mertoyudan Sejahtera'),
('21425', 'Sinar Garuda Prima', 'PT BPR Sinar Garuda Prima'),
('21426', 'Meru Sankara', 'PT BPRS Meru Sankara'),
('21427', 'Bank Daerah Pati', 'PD BPR Bank Daerah Pati'),
('21428', 'Artaperdana Delta Sentosa', 'PT BPR Artaperdana Delta Sentosa'),
('21429', 'Artha Huda Abadi', 'PT BPR Artha Huda Abadi'),
('21430', 'Asabahana Sejahtera', 'PT BPR Asabahana Sejahtera'),
('21431', 'BKK Pati Kota', 'PD BPR BKK Pati Kota'),
('21432', 'Juwana Arthasurya', 'PT BPR Juwana Arthasurya'),
('21433', 'Kusuma Arta Rini', 'PT BPR Kusuma Arta Rini'),
('21434', 'Mitra Pati Mandiri', 'PT BPR Mitra Pati Mandiri'),
('21435', 'Sungkunandhana', 'PT BPR Sungkunandhana'),
('21436', 'Tayu Dutapersada', 'PT BPR Tayu Dutapersada'),
('21437', 'Wedarijaksa', 'Koperasi BPR Wedarijaksa'),
('21438', 'Artha Mas Abadi', 'PT BPRS Artha Mas Abadi'),
('21439', 'BKK Karanganyar - Pekalongan', 'PD BPR BKK Karanganyar Kab Pekalongan'),
('21440', 'BKK Pekalongan Barat', 'PD BPR BKK Pekalongan Barat'),
('21441', 'Sejahtera Artha Sembada', 'PT BPR Sejahtera Artha Sembada'),
('21442', 'Bank Pasar Kota Pekalongan', 'PD BPR Bank Pasar Kota Pekalongan'),
('21443', 'Bank Pasar Kabupaten Pemalang', 'PD BPR Bank Pasar Kabupaten Pemalang'),
('21444', 'BKK Taman', 'PD BPR BKK Taman'),
('21445', 'Hidup Artha Putra', 'PT BPR Hidup Artha Putra'),
('21446', 'Panasayu Arthalayan Sejahtera', 'PT BPR Panasayu Arthalayan Sejahtera'),
('21447', 'Semeru', 'PT BPR Semeru'),
('21448', 'Bank Pasar Kabupaten Purworejo', 'PD BPR Bank Pasar Kabupaten Purworejo'),
('21449', 'BKK Purworejo', 'PD BPR BKK Purworejo'),
('21450', 'Bank Pasar Kabupaten Rembang', 'PD BPR Bank Pasar Kabupaten Rembang'),
('21451', 'BKK Lasem', 'PD BPR BKK Lasem Kabupaten Rembang'),
('21452', 'Dinamika Bangun Arta', 'PT BPR Dinamika Bangun Arta'),
('21453', 'Kota Salatiga', 'PD BPR Bank Salatiga'),
('21454', 'Kridaharta Salatiga', 'PT BPR Kridaharta Salatiga'),
('21455', 'Adil Jaya Artha', 'PT BPR Adil Jaya Artha'),
('21456', 'Ambarawa Hartasarana', 'PT BPR Ambarawa Hartasarana'),
('21457', 'Ambarawa Persada', 'PT BPR Ambarawa Persada'),
('21458', 'Argo Dana Ungaran', 'PT BPR Argo Dana Ungaran'),
('21459', 'Artha Mukti Santosa', 'PT BPR Artha Mukti Santosa'),
('21460', 'Artha Mutiara', 'PT BPR Artha Mutiara'),
('21461', 'Artha Tanah Mas', 'PT BPR Artha Tanah Mas'),
('21462', 'Arto Moro', 'PT BPR Arto Moro'),
('21463', 'Bank Pasar Kota Semarang', 'PD BPR Bank Pasar Kota Semarang'),
('21464', 'BKK Semarang Tengah', 'PD BPR BKK Semarang Tengah'),
('21465', 'BKK Ungaran', 'PD BPR BKK Ungaran'),
('21466', 'BPR Jateng', 'PT BPR BPR Jateng'),
('21467', 'Dana Mitra Sentosa', 'PT BPR Dana Mitra Sentosa'),
('21468', 'Estetika Artha Guna', 'PT BPR Estetika Artha Guna'),
('21469', 'Gunung Kawi', 'PT BPR Gunung Kawi'),
('21470', 'Gunung Kinibalu', 'PT BPR Gunung Kinibalu'),
('21471', 'Gunung Merbabu', 'PT BPR Gunung Merbabu'),
('21472', 'Gunung Rizki Pusaka Utama', 'PT BPR Gunung Rizki Pusaka Utama'),
('21473', 'Inti Ambarawa Sejahtera', 'PT BPR Inti Ambarawa Sejahtera'),
('21474', 'Kedung Arto', 'PT BPR Kedung Arto'),
('21475', 'Klepu Mitra Kencana', 'PT BPR Klepu Mitra Kencana'),
('21476', 'Kusuma Makmur', 'PT BPR Kusuma Makmur'),
('21477', 'Kusuma Palagan Ambarawa', 'PT BPR Kusuma Palagan Ambarawa'),
('21478', 'Mandiri Artha Abadi', 'PT BPR Mandiri Artha Abadi'),
('21479', 'Mekar Nugraha Klepu', 'PT BPR Mekar Nugraha Klepu'),
('21480', 'Mitra Mulia Persada', 'PT BPR Mitra Mulia Persada'),
('21481', 'Persada Ganda', 'PT BPR Persada Ganda'),
('21482', 'Restu Artha Makmur', 'PT BPR Restu Artha Makmur'),
('21483', 'Restu Klepu Makmur', 'PT BPR Restu Klepu Makmur'),
('21484', 'Rudo Indobank', 'PT BPR Rudo Indobank'),
('21485', 'Satria Pertiwi Semarang', 'PT BPR Satria Pertiwi Semarang'),
('21486', 'Semarang Margatama Gunadana', 'PT BPR Semarang Margatama Gunadana'),
('21487', 'Setia Karib Abadi', 'PT BPR Setia Karib Abadi'),
('21488', 'Weleri Makmur', 'PT BPR Weleri Makmur'),
('21489', 'Artha Amanah Ummat', 'PT BPRS Artha Amanah Ummat'),
('21490', 'Artha Surya Barokah', 'PT BPRS Artha Surya Barokah'),
('21491', 'Mitra Harmoni Kota Semarang', 'PT BPRS Mitra Harmoni Kota Semarang'),
('21492', 'PNM Binama', 'PT BPRS PNM Binama'),
('21493', 'Arismentari Ayu', 'PT BPR Arismentari Ayu'),
('21494', 'Artha Kramat', 'PT BPR Artha Kramat'),
('21495', 'Arthapuspa Mega', 'PT BPR Arthapuspa Mega'),
('21496', 'Bank Pasar Kota Tegal', 'PD BPR Bank Pasar Kota Tegal'),
('21497', 'Bank Tegal Gotong Royong', 'PD BPR Bank Tegal Gotong Royong (TGR)'),
('21498', 'BKK Margadana', 'PD BPR BKK Margadana'),
('21499', 'BKK Talang', 'PD BPR BKK Talang'),
('215', 'Bahteramas Konawe', 'PD BPR Bahteramas Konawe'),
('21500', 'Bumi Sediaguna', 'PT BPR Bumi Sediaguna'),
('21501', 'Central Artha', 'PT BPR Central Artha'),
('21502', 'Dhana Adiwerna', 'PT BPR Dhana Adiwerna'),
('21503', 'Mega Artha Mustika', 'PT BPR Mega Artha Mustika'),
('21504', 'Nusamba Adiwerna', 'PT BPR Nusamba Adiwerna'),
('21505', 'Nusumma Jateng', 'PT BPR Nusumma Jateng'),
('21506', 'Sahabat Tata', 'PT BPR Sahabat Tata'),
('21507', 'Bank Pasar Kabupaten Temanggung', 'PD BPR Bank Pasar Kabupaten Temanggung'),
('21508', 'BKK Temanggung', 'PD BPR BKK Temanggung'),
('21509', 'Intan Surya', 'PT BPR Intan Surya'),
('21510', 'Kedu Arthasetia', 'PT BPR Kedu Arthasetia'),
('21511', 'Kusuma Sumbing', 'PT BPR Kusuma Sumbing'),
('21512', 'Multi Arthanusa', 'PT BPR Multi Arthanusa'),
('21513', 'Suryakusuma Kranggan', 'PT BPR Suryakusuma Kranggan'),
('21514', 'Artha Selomanik Putra', 'PT BPR Artha Selomanik Putra'),
('21515', 'Bank Wonosobo', 'PD BPR Bank Wonosobo'),
('21516', 'BKK Wonosobo', 'PD BPR BKK Wonosobo'),
('21517', 'Puspa Kencana', 'PT BPR Puspa Kencana'),
('21518', 'Surya Yudha', 'PT BPR Surya Yudha'),
('21519', 'Arthayasa Ageng', 'PT BPR Arthayasa Ageng'),
('21520', 'BKK Boyolali  Kota', 'PD BPR BKK Boyolali  Kota'),
('21521', 'Guna Daya', 'PT BPR Guna Daya'),
('21522', 'Bank Pasar Kabupaten Boyolali', 'PD BPR Bank Pasar Kabupaten Boyolali'),
('21523', 'Mitra Pandanaran Mandiri', 'PT BPR Mitra Pandanaran Mandiri'),
('21524', 'Nusamba Ampel', 'PT BPR Nusamba Ampel'),
('21525', 'Yekti Insan Sembada', 'PT BPR Yekti Insan Sembada'),
('21526', 'Antar Rumeksa Arta', 'PT BPR Antar Rumeksa Arta'),
('21527', 'Arta Mas Surakarta', 'PT BPR Arta Mas Surakarta'),
('21528', 'Bank Pasar Kabupaten Karanganyar', 'PD BPR Bank Daerah Karanganyar'),
('21529', 'Bina Sejahtera Insani', 'PT BPR Bina Sejahtera Insani'),
('21530', 'Bank Karanganyar', 'PD BPR Bank Karanganyar'),
('21531', 'BKK Tasikmadu', 'PD BPR BKK Tasikmadu'),
('21532', 'Buana Artha Lestari', 'PT BPR Buana Artha Lestari'),
('21533', 'Cita Dewi', 'PT BPR Cita Dewi'),
('21534', 'Gondangrejo', 'PT BPR Gondangrejo'),
('21535', 'Kandimadu Arta', 'PT BPR Kandimadu Arta'),
('21536', 'Lawu Artha', 'PT BPR Lawu Artha'),
('21537', 'Pura Artha Kencana Jatipuro', 'PT BPR Pura Artha Kencana Jatipuro'),
('21538', 'Tawangmangu Jaya', 'PT BPR Tawangmangu Jaya'),
('21539', 'Trihasta Prasodjo', 'PT BPR Trihasta Prasodjo'),
('21540', 'Artha Daya', 'PT BPR Artha Daya'),
('21541', 'Bhakti Riyadi', 'PT BPR Bhakti Riyadi'),
('21542', 'BKK Pedan', 'PD BPR BKK Pedan'),
('21543', 'BKK Tulung', 'PD BPR BKK Tulung'),
('21544', 'Ceper', 'Koperasi BPR Ceper'),
('21545', 'Danamas Pratama', 'PT BPR Danamas Pratama'),
('21546', 'Delanggu Raya', 'PT BPR Delanggu Raya'),
('21547', 'Gunung Lawu', 'PT BPR Gunung Lawu'),
('21548', 'Gunung Mas', 'PT BPR Gunung Mas'),
('21549', 'Hardi Mas Mandiri', 'PT BPR Hardi Mas Mandiri'),
('21550', 'Kab. Dati II  Klaten', 'PD BPR Bank Kalaten Kabupaten Klaten'),
('21551', 'Klaten Sejahtera', 'PT BPR Klaten Sejahtera'),
('21552', 'Kusuma Danaraja', 'PT BPR Kusuma Danaraja'),
('21553', 'Patma "Klaten"', 'Koperasi BPR Bank Pasar Patma'),
('21554', 'Restu Klaten Makmur', 'PT BPR Restu Klaten Makmur'),
('21555', 'Shinta Bhakti Wedi', 'PT BPR Shinta Bhakti Wedi'),
('21556', 'Sinarenam Permai Delanggu', 'PT BPR Sinarenam Permai Delanggu'),
('21557', 'Ukabima BMMS', 'PT BPR Ukabima BMMS'),
('21558', 'Wuni Artha Utama', 'PT BPR Wuni Artha Utama'),
('21559', 'Al Mabrur Klaten', 'PT BPRS Al Mabrur Klaten'),
('21560', 'Binalanggeng Mulia', 'PT BPR Binalanggeng Mulia'),
('21561', 'Central International', 'PT BPR Central International'),
('21562', 'Dana Utama', 'PT BPR Dana Utama'),
('21563', 'Nguter Surakarta', 'PT BPR Nguter Surakarta'),
('21564', 'Rejeki Insani', 'PT BPR Rejeki Insani'),
('21565', 'Sukadana', 'PT BPR Sukadana'),
('21566', 'Sukadyarindang', 'PT BPR Sukadyarindang'),
('21567', 'Bank Solo', 'PD BPR Bank Solo'),
('21568', 'Suryamas', 'PT BPR Suryamas'),
('21569', 'Central Syariah Utama', 'PT BPRS Central Syariah Utama'),
('21570', 'BKK Karangmalang', 'PD BPR BKK Karangmalang'),
('21571', 'Djoko Tingkir', 'PD BPR Djoko Tingkir'),
('21572', 'Gemolong Artha Mulyo', 'PT BPR Gemolong Artha Mulyo'),
('21573', 'Ghadira Danamulia', 'PT BPR Ghadira Danamulia'),
('21574', 'Mitra Banaran Mandiri', 'PT BPR Mitra Banaran Mandiri'),
('21575', 'Sukowati Jaya', 'PT BPR Sukowati Jaya'),
('21576', 'Sumber Arta', 'PT BPR Sumber Arta'),
('21577', 'Sragen', 'PD BPRS Sragen'),
('21578', 'Artha Sari Sentosa', 'PT BPR Artha Sari Sentosa'),
('21579', 'Bank Pasar Kabupaten Sukoharjo', 'PD BPR Bank Pasar Kabupaten Sukoharjo'),
('21580', 'Bekonang  Sukoharjo', 'PT BPR Bekonang  Sukoharjo'),
('21581', 'BKK Baki', 'PD BPR BKK Baki'),
('21582', 'BKK Bendosari', 'PD BPR BKK Bendosari'),
('21583', 'BKK Grogol', 'PD BPR BKK Grogol'),
('21584', 'BKK Mojolaban', 'PD BPR BKK Mojolaban'),
('21585', 'Grogol Joyo', 'PT BPR Grogol Joyo'),
('21586', 'Ihuthan  Ganda', 'PT BPR Ihuthan  Ganda'),
('21587', 'Restu Artha Abadi', 'PT BPR Restu Artha Abadi'),
('21588', 'Jadi Manunggal Abadi', 'PT BPR Jadi Manunggal Abadi'),
('21589', 'Kartadhani  Mulya', 'PT BPR Kartadhani  Mulya'),
('21590', 'Kartasura Makmur', 'PT BPR Kartasura Makmur'),
('21591', 'Kartasura Saribumi', 'PT BPR Kartasura Saribumi'),
('21592', 'Sami Makmur', 'PT BPR Sami Makmur'),
('21593', 'Sinarguna Sejahtera', 'PT BPR Sinarguna Sejahtera');
INSERT INTO `tref_bank` (`bankID`, `bankName`, `bankFullName`) VALUES
('21594', 'Solobaru Permai', 'PT BPR Solobaru Permai'),
('21595', 'Surya Utama', 'PT BPR Surya Utama'),
('21596', 'Tugu Kencana', 'PT BPR Tugu Kencana'),
('21597', 'Wira Ardana Sejahtera', 'PT BPR Wira Ardana Sejahtera'),
('21598', 'Insan Madani', 'PT BPRS Insan Madani'),
('21599', 'Sabar Arthapalur', 'PT BPR Sabar Arthapalur'),
('216', 'Bahteramas Konawe Selatan', 'PD BPR Bahteramas Konawe Selatan'),
('21600', 'Usaha Madani Karya Mulia', 'PT BPR Usaha Madani Karya Mulia'),
('21601', 'Dana Amanah Syariah', 'PT BPRS Syariah Dana Amanah'),
('21602', 'Dana Mulia', 'PT BPRS Dana Mulia'),
('21603', 'BKK Wonogiri  Kota', 'PD BPR BKK Wonogiri  Kota'),
('21604', 'Gajah Mungkur', 'PT BPR Gajah Mungkur'),
('21605', 'Giri Suka Dana', 'PD BPR Giri Sukadana'),
('21606', 'Danakerja  Putra', 'PT BPR Danakerja  Putra'),
('21607', 'Kabupaten Dati II Bangkalan', 'PD BPR Bank Pasar Kabupaten Bangkalan'),
('21608', 'Delta Bojonegoro', 'PT BPR Delta Bojonegoro'),
('21609', 'Bank Daerah Bojonegoro', 'PD BPR Bank Daerah Bojonegoro'),
('21610', 'Rajekwesi', 'PT BPR Rajekwesi'),
('21611', 'Tanah Kondang', 'PT BPR Tanah Kondang'),
('21612', 'Aneka Dana Sejahtera', 'PT BPR Aneka Dana Sejahtera'),
('21613', 'Arindomegah Abadi', 'PT BPR Arindomegah Abadi'),
('21614', 'Balongpanggang Sentosa', 'PT BPR Balongpanggang Sentosa'),
('21615', 'Bumi Sanggabuana', 'PT BPR Bumi Sanggabuana'),
('21616', 'Dana Rajabally', 'PT BPR Dana Rajabally'),
('21617', 'Delta Gresik', 'PT BPR Delta Gresik'),
('21618', 'Intan Kita', 'PT BPR Intan Kita'),
('21619', 'Intan Nasional', 'PT BPR Intan Nasional'),
('21620', 'Kabupaten Dati II Gresik', 'PD BPR Kabupaten Dati II Gresik'),
('21621', 'Kebomas', 'PT BPR Kebomas'),
('21622', 'Mitra Cemawis Mandiri', 'PT BPR Mitra Cemawis Mandiri'),
('21623', 'Rajadana Menganti', 'PT BPR Rajadana Menganti'),
('21624', 'Amanah Sejahtera', 'PT BPRS Amanah Sejahtera'),
('21625', 'Mandiri Mitra Sukses', 'PT BPRS Mandiri Mitra Sukses'),
('21626', 'Arta Muktigraha', 'PT BPR Arta Muktigraha'),
('21627', 'Artha Anugrah Kencana', 'PT BPR Artha Anugrah Kencana'),
('21628', 'Bhapertim Persada', 'PT BPR Bhapertim Persada'),
('21629', 'Bumi Arta', 'Koperasi BPR Bumi Arta'),
('21630', 'Kabupaten Dati II Jombang', 'PD BPR Kabupaten Dati II Jombang'),
('21631', 'Mojoagung Pahalapakto', 'PT BPR Mojoagung Pahalapakto'),
('21632', 'Nusumma Tebuireng', 'PT BPR Nusumma Tebuireng'),
('21633', 'Panji Aronta', 'PT BPR Panji Aronta'),
('21634', 'Ploso Saranaartha', 'PT BPR Ploso Saranaartha'),
('21635', 'Surya Arthaguna  Abadi', 'PT BPR Surya Arthaguna  Abadi'),
('21636', 'Tjoekir Dasa Nusantara', 'PT BPR Tjoekir Dasa Nusantara'),
('21637', 'Wijaya Prima', 'PT BPR Wijaya Prima'),
('21638', 'Lantabur', 'PT BPRS Lantabur'),
('21639', 'Arta Swasembada Mojokerto', 'PT BPR Arta Swasembada Mojokerto'),
('21640', 'Babat Lestari', 'PT BPR Babat Lestari'),
('21641', 'Bank Daerah Lamongan', 'PD BPR Bank Daerah Lamongan'),
('21642', 'Damata Arthanugraha', 'PT BPR Damata Arthanugraha'),
('21643', 'Delta Lamongan', 'PT BPR Delta Lamongan'),
('21644', 'Mitra Dhanaceswara', 'PT BPR Mitra Dhanaceswara'),
('21645', 'Nusamba Brondong', 'PT BPR Nusamba Brondong'),
('21646', 'Rukun Karya Sari', 'Koperasi BPR Rukun Karya Sari'),
('21647', 'Ulintha Ganda', 'PT BPR Ulintha Ganda'),
('21648', 'Madinah', 'PT BPRS Madinah'),
('21649', 'Arta Bangsal Utama', 'PT BPR Arta Bangsal Utama'),
('21650', 'Arta Haksaprima', 'PT BPR Arta Haksaprima'),
('21651', 'Arta Swasembada Mojosari', 'PT BPR Arta Swasembada Mojosari'),
('21652', 'Bank Pasar Kabupaten Mojokerto', 'PD BPR Bank Pasar Kabupaten Mojokerto'),
('21653', 'Bumi Jaya', 'PT BPR Bumi Jaya'),
('21654', 'Delta Artha Panggung Mojokerto', 'PT BPR Delta Artha Panggung Mojokerto'),
('21655', 'Indoartha Bintang Mulia', 'PT BPR Indoartha Bintang Mulia'),
('21656', 'Kurnia Dadi Arta', 'PT BPR Kurnia Dadi Arta'),
('21657', 'Mojosari Pahalapakto', 'PT BPR Mojosari Pahalapakto'),
('21658', 'Puriseger Sentosa', 'PT BPR Puriseger Sentosa'),
('21659', 'Sejahtera', 'Koperasi BPR Sejahtera'),
('21660', 'Terusan Jaya', 'PT BPR Terusan Jaya'),
('21661', 'Pamekasan Purapersada', 'PT BPR Pamekasan Purapersada'),
('21662', 'Sarana Pamekasan Membangun', 'PT BPRS Sarana Pamekasan Membangun'),
('21663', 'Bakti Artha Sejahtera', 'PT BPR Bakti Artha Sejahtera'),
('21664', 'Abrin Centra Artha', 'PT BPR Abrin Centra Artha'),
('21665', 'Anglomas Indah', 'PT BPR Anglomas Indah'),
('21666', 'Aridha Artha Nugraha', 'PT BPR Aridha Artha Nugraha'),
('21667', 'Arta Mulya Bumi Mukti', 'PT BPR Arta Mulya Bumi Mukti'),
('21668', 'Arta Waru Surya', 'PT BPR Arta Waru Surya'),
('21669', 'Artha Buana', 'PT BPR Artha Buana'),
('21670', 'Bandataman', 'PT BPR Bandataman'),
('21671', 'Bank Pasar Bhakti', 'PT BPR Bank Pasar Bhakti'),
('21672', 'Benta Tesa', 'PT BPR Benta Tesa'),
('21673', 'Buana Dana Makmur', 'PT BPR Buana Dana Makmur'),
('21674', 'Buduran Delta Purnama', 'PT BPR Buduran Delta Purnama'),
('21675', 'Bumi Gora Jaya', 'PT BPR Bumi Gora Jaya'),
('21676', 'Candisaka Arta', 'PT BPR Candisaka Arta'),
('21677', 'Danamas Makmur', 'PT BPR Danamas Makmur'),
('21678', 'Danumas Binadhana', 'PT BPR Danumas Binadhana'),
('21679', 'Delta Artha', 'PT BPR Delta Artha'),
('21680', 'Delta Sidoarjo', 'PT BPR Delta Sidoarjo'),
('21681', 'Surabaya Lestari', 'PT BPR Surabaya Lestari'),
('21682', 'Dinar Pusaka', 'PT BPR Dinar Pusaka'),
('21683', 'Dirgadhana Arthamas', 'PT BPR Dirgadhana Arthamas'),
('21684', 'Djojo Mandiri Raya', 'PT BPR Djojo Mandiri Raya'),
('21685', 'Gema Nusa', 'PT BPR Gema Nusa'),
('21686', 'Handalniaga Bumindo', 'PT BPR Handalniaga Bumindo'),
('21687', 'Indodana Hargotama', 'PT BPR Indodana Hargotama'),
('21688', 'Inti Danita', 'PT BPR Inti Danita'),
('21689', 'Iswara Artha', 'PT BPR Iswara Artha'),
('21690', 'Jati Lestari', 'PT BPR Jati Lestari'),
('21691', 'Jenjen Wahana Niagamas', 'PT BPR Jenjen Wahana Niagamas'),
('21692', 'Karya Perdana Sejahtera', 'PT BPR Karya Perdana Sejahtera'),
('21693', 'Krian Nusantara', 'PT BPR Krian Nusantara'),
('21694', 'Krian Wijaya', 'PT BPR Krian Wijaya'),
('21695', 'Kudamas Sentosa', 'PT BPR Kudamas Sentosa'),
('21696', 'Masyarakat Mandiri', 'PT BPR Masyarakat Mandiri'),
('21697', 'Megakerta Swadiri', 'PT BPR Megakerta Swadiri'),
('21698', 'Mitra Maju Jaya Mandiri', 'PT BPR Mitra Maju Jaya Mandiri'),
('21699', 'Padat Ganda', 'PT BPR Padat Ganda'),
('217', 'Kec. Malangbong', ''),
('21700', 'Porong Idaman', 'PT BPR Porong Idaman'),
('21701', 'Porong Lestari', 'PT BPR Porong Lestari'),
('21702', 'Puridana Artamas', 'PT BPR Puridana Artamas'),
('21703', 'Rejeki Datang', 'PT BPR Rejeki Datang'),
('21704', 'Sahabat Sedati', 'PT BPR Sahabat Sedati'),
('21705', 'Sarana Sukses', 'PT BPR Sarana Sukses'),
('21706', 'Sekar Tarunamulia', 'PT BPR Sekar Tarunamulia'),
('21707', 'Sentra Dana Makmur', 'PT BPR Sentra Dana Makmur'),
('21708', 'Sepanjang Sumber Dharmaarta', 'PT BPR Sepanjang Sumber Dharmaarta'),
('21709', 'Sinardana Buana', 'PT BPR Sinardana Buana'),
('21710', 'Sriekaya', 'PT BPR Sriekaya'),
('21711', 'Sumber Artha Waru Agung', 'PT BPR Sumber Artha Waru Agung'),
('21712', 'Sumber Usahawan Bersama', 'PT BPR Sumber Usahawan Bersama'),
('21713', 'Taman Adimakmur', 'PT BPR Taman Adimakmur'),
('21714', 'Taman Artha Kencana', 'PT BPR Taman Artha Kencana'),
('21715', 'Taman Dhana', 'PT BPR Taman Dhana'),
('21716', 'Toelangan Dasa Nusantara', 'PT BPR Toelangan Dasa Nusantara'),
('21717', 'Tri Harta Indah', 'PT BPR Tri Harta Indah'),
('21718', 'Vita Jasaguna', 'PT BPR Vita Jasaguna'),
('21719', 'Waru Dhanasejahtera', 'PT BPR Waru Dhanasejahtera'),
('21720', 'Wiradhana Putramas', 'PT BPR Wiradhana Putramas'),
('21721', 'Annisa Mukti', 'PT BPRS Annisa Mukti'),
('21722', 'Baktimakmur Indah', 'PT BPRS Baktimakmur Indah'),
('21723', 'Unawi Barokah', 'PT BPRS Unawi Barokah'),
('21724', 'Bhakti Sumekar', 'PT BPRS Bhakti Sumekar'),
('21725', 'Bintang Mitra', 'PT BPR Bintang Mitra'),
('21726', 'Central Niaga', 'PT BPR Central Niaga'),
('21727', 'Danamas', 'PT BPR Danamas'),
('21728', 'Danamitra Surya', 'PT BPR Danamitra Surya'),
('21729', 'Guna Yatra', 'PT BPR Guna Yatra'),
('21730', 'Jawa Timur', 'PT BPR Jawa Timur'),
('21731', 'Kosanda', 'PT BPR Kosanda'),
('21732', 'Permata Artha Surya', 'PT BPR Permata Artha Surya'),
('21733', 'Prima Kredit Utama', 'PT BPR Prima Kredit Utama'),
('21734', 'Surya Artha Utama', 'PT BPR Surya Artha Utama'),
('21735', 'Jabal Nur', 'PT BPRS Jabal Nur'),
('21736', 'Karya Mugi Sentosa', 'PT BPRS Karya Mugi Sentosa'),
('21737', 'Charis Utama', 'PT BPR Charis Utama'),
('21738', 'Mentari Terang', 'PT BPR Mentari Terang'),
('21739', 'Semanding', 'Koperasi BPR Semanding'),
('21740', 'Banjar Arthasariguna', 'PT BPR Banjar Arthasariguna'),
('21741', 'BKPD Cijulang', 'PD BPR BKPD Cijulang'),
('21742', 'BKPD Lakbok', 'PD BPR BKPD Lakbok'),
('21743', 'BKPD Pangandaran', 'PD BPR BKPD Pangandaran'),
('21744', 'LPK Cimerak', 'PD BPR LPK Cimerak'),
('21745', 'Sehat Ekonomi', 'PT BPR Sehat Ekonomi'),
('21746', 'Nusantara Bona Pasogit 31', 'PT BPR Nusantara Bona Pasogit 31'),
('21747', 'LPK Bojonggambir', 'PD BPR LPK Bojonggambir'),
('21748', 'LPK Cipatujah', 'PD BPR LPK Cipatujah'),
('21749', 'Mitra Kopjaya Mandiri', 'PT BPR Mitra Kopjaya Mandiri'),
('21750', 'Nusamba Singaparna', 'PT BPR Nusamba Singaparna'),
('21751', 'Nusumma Singaparna', 'PT BPR Nusumma Singaparna'),
('21752', 'Sahat Sentosa', 'PT BPR Sahat Sentosa'),
('21754', 'Artha Jaya Mandiri', 'PT BPR Artha Jaya Mandiri'),
('21756', 'Pola Dana', 'PT BPR Pola Dana'),
('21757', 'Siliwangi', 'PT BPR Siliwangi'),
('21758', 'Al Wadi''ah', 'PT BPRS Al Wadi''ah'),
('21759', 'Al-Madinah Tasikmalaya', 'PT BPRS Al-Madinah Tasikmalaya'),
('21760', 'Ambarketawang Persada', 'PT BPR Ambarketawang Persada'),
('21761', 'Arga Tata', 'PT BPR Arga Tata'),
('21762', 'Arum Mandiri Kenanga', 'PT BPR Arum Mandiri Kenanga'),
('21763', 'Bank Pasar Bantul', 'PD BPR Bank Pasar Bantul'),
('21764', 'Bina Arta Swadaya Yogyakarta', 'PT BPR Bina Arta Swadaya Yogyakarta'),
('21765', 'Chandra Muktiartha', 'PT BPR Chandra Muktiartha'),
('21766', 'Kartikaartha Kencanajaya', 'PT BPR Kartikaartha Kencanajaya'),
('21767', 'Kurnia Sewon', 'PT BPR Kurnia Sewon'),
('21768', 'Nusamba Banguntapan', 'PT BPR Nusamba Banguntapan'),
('21769', 'Profidana Paramitra', 'PT BPR Profidana Paramitra'),
('21770', 'Swadharma Artha Nusa', 'PT BPR Swadharma Artha Nusa'),
('21771', 'Swadharma Bangun Artha', 'PT BPR Swadharma Bangun Artha'),
('21772', 'Tandu Artha', 'PT BPR Tandu Artha'),
('21773', 'Bangun Drajat Warga', 'PT BPRS Bangun Drajat Warga'),
('21774', 'Madina Mandiri Sejahtera', 'PT BPRS Madina Mandiri Sejahtera'),
('21775', 'Margirizki Bahagia', 'PT BPRS Margirizki Bahagia'),
('21776', 'Agra Arthaka Mulya', 'PT BPR Agra Arthaka Mulya'),
('21777', 'Arum Mandiri Melati', 'PT BPR Arum Mandiri Melati'),
('21778', 'Kabupaten Gunung Kidul', 'PD BPR Bank Daerah Gunung Kidul'),
('21779', 'Ukabima Nindya Raharja', 'PT BPR Ukabima Nindya Raharja'),
('21780', 'Kulon Progo', 'PD BPR Kulon Progo'),
('21781', 'Nusamba Temon', 'PT BPR Nusamba Temon'),
('21782', 'Shinta Putra Pengasih', 'PT BPR Shinta Putra Pengasih'),
('21783', 'Alto Makmur', 'PT BPR Alto Makmur'),
('21784', 'Arta Agung Yogyakarta', 'PT BPR Arta Agung Yogyakarta'),
('21785', 'Arta Yogyakarta', 'PT BPR Arta Yogyakarta'),
('21786', 'Artajaya Bhaktimulia', 'PT BPR Artajaya Bhaktimulia'),
('21787', 'Artha Mlatiindah', 'PT BPR Artha Mlatiindah'),
('21788', 'Artha Sumber Arum', 'PT BPR Artha Sumber Arum'),
('21789', 'Berlian Bumi Arta', 'PT BPR Berlian Bumi Arta'),
('21790', 'Bhakti Daya Ekonomi', 'PT BPR Bhakti Daya Ekonomi'),
('21791', 'Bhumikarya Pala', 'PT BPR Bhumikarya Pala'),
('21792', 'Danagung Abadi', 'PT BPR Danagung Abadi'),
('21793', 'Danagung Bakti', 'PT BPR Danagung Bakti'),
('21794', 'Danagung Ramulti', 'PT BPR Danagung Ramulti'),
('21795', 'Danamas Prima', 'PT BPR Danamas Prima'),
('21796', 'Dewa Arthaka Mulya', 'PT BPR Dewa Arthaka Mulya'),
('21797', 'Duta Gama', 'PT BPR Duta Gama'),
('21798', 'Gamping Artha Raya', 'PT BPR Gamping Artha Raya'),
('21799', 'Kabupaten Sleman', 'PD BPR Bank Pasar Kab Sleman'),
('218', 'BKK Gembong', ''),
('21800', 'Karangwaru Pratama', 'PT BPR Karangwaru Pratama'),
('21801', 'Mlati Pundi Artha', 'PT BPR Mlati Pundi Artha'),
('21802', 'Nusapanida Godean', 'PT BPR Nusapanida Godean'),
('21803', 'Nusumma Tempel', 'PT BPR Nusumma Tempel'),
('21804', 'Panca Arta Monjali', 'PT BPR Panca Arta Monjali'),
('21805', 'Redjo Bhawono', 'PT BPR Redjo Bhawono'),
('21806', 'Restu Mandiri Makmur', 'PT BPR Restu Mandiri Makmur'),
('21807', 'Shinta Daya', 'PT BPR Shinta Daya'),
('21808', 'Sindu Adi', 'PT BPR Sindu Adi'),
('21809', 'Wijayamulya Santosa', 'PT BPR Wijayamulya Santosa'),
('21810', 'Danagung Syari?ah', 'PT BPRS Danagung Syari?ah'),
('21811', 'Formes', 'PT BPRS Formes'),
('21812', 'Mitra Amal Mulia', 'PT BPRS Mitra Amal Mulia'),
('21813', 'Mitra Cahaya Indonesia', 'PT BPRS Mitra Cahaya Indonesia'),
('21814', 'Artha Berkah Cemerlang', 'PT BPR Artha Berkah Cemerlang'),
('21815', 'Artha Parama', 'PT BPR Artha Parama'),
('21816', 'Bank Jogja Kota Yogyakarta', 'PD BPR Bank Jogja Kota Yogyakarta'),
('21817', 'Lestari Darmo Mulyo', 'PT BPR Lestari Darmo Mulyo'),
('21818', 'Madani Sejahtera Abadi', 'PT BPR Madani Sejahtera Abadi'),
('21819', 'Mataram Mitra Manunggal', 'PT BPR Mataram Mitra Manunggal'),
('21820', 'Walet Jaya Abadi', 'PT BPR Walet Jaya Abadi'),
('21821', 'Barokah Dana Sejahtera', 'PT BPRS Barokah Dana Sejahtera'),
('21822', 'Dana Hidayatullah', 'PT BPRS Dana Hidayatullah'),
('21823', 'Mitra Harmoni Yogyakarta', 'PT BPRS Mitra Harmoni Yogyakarta'),
('219', 'BKK Gombong', ''),
('220', 'Bahteramas Kendari', 'PD BPR Bahteramas Kendari'),
('221', 'Bahteramas Wakatobi', 'PT BPR Bahteramas Wakatobi'),
('22100', '', 'Bank yy'),
('22106', 'Bank Test 2', 'PT. Bank Test 2'),
('222', 'LKP Lembuak', ''),
('223', 'Bank UOB Buana Tbk', ''),
('224', 'BKK Bulu', ''),
('225', 'Bank Windu Kentjana', ''),
('226', 'Bangun Randu Kencana', ''),
('227', 'Salaman Argakencana', ''),
('228', 'Ampel Guna Kencana', ''),
('229', 'Nusumma Cepu', ''),
('230', 'Karangpucung', ''),
('231', 'BKK Undaan', ''),
('232', 'Kecamatan Purwadadi', ''),
('233', 'Wanadadi', ''),
('23306', 'Bank DT', 'PT Bank DT'),
('234', 'BKK Purwodadi - Purworejo', ''),
('235', 'Cidahu', ''),
('236', 'Dana Mitra Utama', 'PT BPR Dana Mitra Utama'),
('237', 'Tripanca Setiadana', ''),
('238', 'Musajaya Arthadana', ''),
('239', 'Kallyana Adhikamandana', ''),
('240', 'Satya Adhi Perdana', ''),
('241', 'Kaligondang', ''),
('242', 'BKK Sadang', ''),
('243', 'BKK Gondang', ''),
('244', 'BKK Dawe', ''),
('245', 'Mataram Godean', ''),
('246', 'Swadharma Godean', ''),
('247', 'BKK Wiradesa', ''),
('248', 'LPK Cipeundeuy', ''),
('249', 'kec. Cipeundeuy (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', ''),
('250', 'Citraloka Danamandiri', ''),
('251', 'Kencana Artha Mandiri', ''),
('252', 'Indomitra Mandiri Ciputat', ''),
('253', 'Danaku Mapan Lestari', 'PT BPR Danaku Mapan Lestari'),
('254', 'Dharma Kuwera', 'PT BPRS Dharma Kuwera'),
('255', 'BKK Godong', ''),
('256', 'Andong', ''),
('257', 'BKK Sukodono', ''),
('258', 'Banyudono', ''),
('259', 'BKK Doro', ''),
('260', 'BKK Wedung', ''),
('261', 'Kec. Soreang (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', ''),
('262', 'BKK Reban', ''),
('263', 'Mrebet', ''),
('264', 'BKK Gebog', ''),
('265', 'BKK Patebon', ''),
('266', 'BKK Sedan', ''),
('267', 'Bank Ekspor Indonesia (Persero) (cabut ijin 1 September 2009)', ''),
('268', 'Punggelan', ''),
('269', 'BKK Bagelen', ''),
('270', 'BKK Gumelar', ''),
('271', 'Leles', ''),
('272', 'LKP Sambelia (Merger ke BPR NTB Lombok Timur Tgl31/8/2009)', ''),
('273', 'LPK Kasemen', ''),
('274', 'BKK Gemuh', ''),
('275', 'BKK Jakenan', ''),
('276', 'BKK Kradenan', ''),
('277', 'Nusumma Durenan (merger ke Nusumma Tebuireng Tgl. 20/1/2009)', ''),
('278', 'BKK Jenar', ''),
('279', 'BKK Bener', ''),
('280', 'LKP Tente Bima', ''),
('281', 'Nusumma Ceper', ''),
('282', 'Swadharma Depok', ''),
('283', 'Mapalus Keketeran (Merger Ke Mapalus Tumetenden Tgl 15/4/2009)', ''),
('284', 'Teras BKK', ''),
('285', 'Mustaqim Blangkejeren', ''),
('286', 'BKK Adiwerna', ''),
('287', 'Tanjung Teros (Merger ke BPR NTB Lombok Timur Tgl31/8/2009)', ''),
('288', 'Kec. Sindangkerta (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', ''),
('289', 'BKK Selomerto', ''),
('290', 'Kec. Cikeruh', ''),
('291', 'Matesih BKK', ''),
('292', 'Kec. Cikalong Wetan (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', ''),
('293', 'Baturetno BKK', ''),
('294', 'Montong Betok (Merger ke BPR NTB Lombok Timur Tgl31/8/2009)', ''),
('295', 'Pameungpeuk  -  Banjaran (merger ke BPR Kabupaten Bandung Tgl 15/12/200', ''),
('296', 'Pameungpeuk- Garut', ''),
('297', 'BKPD Pagerageung', ''),
('298', 'BKK Karanglewas', ''),
('299', 'Mataram Sewon', ''),
('300', 'BKK Geyer', ''),
('301', 'Nusumma Pecangaan', ''),
('302', 'Pusakanagara', ''),
('303', 'BKK Somagede', ''),
('304', 'Karanggede BKK', ''),
('305', 'Kec. Kadugede', ''),
('306', 'Kutoarjo Arthalanggeng', ''),
('307', 'BKK Wonotunggal', ''),
('308', 'BKPD Karangnunggal', ''),
('309', 'BKK Mranggen', ''),
('310', 'BKK Gunung Wungkal', ''),
('311', 'BKK Mungkid', ''),
('312', 'LKP Sengkol (Merger ke BPR NTB Lombok Tengah tgl 31/08/2009)', ''),
('313', 'Kemangkon', ''),
('314', 'Mataram Ngaglik', ''),
('315', 'BKK Pejagoan', ''),
('316', 'LPK Talegong', ''),
('317', 'Kadungora', ''),
('318', 'Purwonegoro', ''),
('319', 'Wonosegoro BKK', ''),
('320', 'Lenangguar (Merger ke NTB Sumbawa Tgl 6 Nov 2009)', ''),
('321', 'BKPD Ligung', ''),
('322', 'Bank Haga (Merger ke Rabobank)', ''),
('323', 'Bank Hagakita', ''),
('324', 'Kec. Gununghalu', ''),
('325', 'Samadhana', ''),
('326', 'Bank Harmoni Internasional (merger ke Bank Index Selindo)', ''),
('327', 'Handayani Cipta Sehati', ''),
('328', 'Binacitra Rahayu', ''),
('329', 'Kec. Buahdua', ''),
('330', 'Slogohimo BKK', ''),
('331', 'Mranggen Mitraniaga', ''),
('332', 'Anugrah Arta Niaga', ''),
('333', 'Bank Pasar Indihiang', ''),
('334', 'BKPD Indihiang', ''),
('335', 'Swadharma Leuwiliang', ''),
('336', 'BKPD Ciawi', ''),
('337', 'BKK Bumiayu', ''),
('338', 'Kec. Ciwidey (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', ''),
('339', 'Bank IFI  (cabut ijin 17 April 2009)', ''),
('340', 'BKK Mijen', ''),
('341', 'LPK Kragilan', ''),
('342', 'BKPD Sodonghilir', ''),
('343', 'Kota Liman', ''),
('344', 'BKK Purwokerto Timur', ''),
('345', 'Artha Nusa Guna', ''),
('346', 'BKK Mirit', ''),
('347', 'Tayu Argatirta', ''),
('348', 'BKK Tirto', ''),
('349', 'Karangpawitan', ''),
('350', 'Rejeki Anugerah Mitra', ''),
('351', 'Darbeni Mitra', ''),
('352', 'LKP Soriutu', ''),
('353', 'BKK Purwojati', ''),
('354', 'BKK Kedungjati', ''),
('355', 'BKPD Kertajati', ''),
('356', 'Kalijati', ''),
('357', 'Singajaya', ''),
('358', 'Bank Pasar Manonjaya', ''),
('359', 'BKPD Manonjaya', ''),
('360', 'Tripillar Arthajaya', ''),
('361', 'BKPD Cikijing', ''),
('362', 'BKK Mejobo', ''),
('363', 'BKK Bojong - Tegal', ''),
('364', 'BKK Bojong - Pekalongan', ''),
('365', 'BKK Jumo', ''),
('366', 'Madukara', ''),
('367', 'Asparaga Abadi Perkasa', ''),
('368', 'BKK Kedu', ''),
('369', 'BKK Rowokele', ''),
('370', 'LKP Aikmel (Merger ke BPR NTB Lombok Timur Tgl31/8/2009)', ''),
('371', 'Kota Mojokerto', 'PT BPRS Kota Mojokerto'),
('372', 'LKP Dasan Lekong (Merger ke BPR NTB Lombok Timur Tgl31/8/2009)', ''),
('373', 'BKK Rembang Kota', ''),
('374', 'BKK Kudus Kota', ''),
('375', 'BKK Batang Kota', ''),
('376', 'BKK Sragen Kota', ''),
('377', 'BKK Kaliangkrik', ''),
('378', 'BKK Jekulo', ''),
('379', 'Kec. Cimalaka', ''),
('380', 'BKK Watumalang', ''),
('381', 'BKK Sulang', ''),
('382', 'BKK Bantarbolang', ''),
('383', 'Sukadana Cemerlang (Self Liquidation ref srt BI tg 31 Juli 2009)', ''),
('384', 'Bungbulang', ''),
('385', 'Swadharma Mlati', ''),
('386', 'BKPD Salawu', ''),
('387', 'Kec. Majalaya (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', ''),
('388', 'I. Tasikmalaya', ''),
('389', 'Kota Tasikmalaya', ''),
('390', 'BKK Jeruklegi', ''),
('391', 'Nusumma Gondanglegi (merger ke Nusumma Tebuireng Tgl. 20/1/2009)', ''),
('392', 'Klego BKK', ''),
('393', 'BKK Alian', ''),
('394', 'BKK Sukolilo', ''),
('395', 'Bank Lippo Tbk.', ''),
('396', 'Rancakalong', ''),
('397', 'BKK Gemolong', ''),
('398', 'BKPD Bantarkalong', ''),
('399', 'BKPD Cibalong', ''),
('400', 'BKPD Cikalong', ''),
('401', 'BKPD Salopa', ''),
('402', 'BKK Sluke', ''),
('403', 'Nusumma Balung (merger ke Nusumma Tebuireng Tgl 20/1/2009)', ''),
('404', 'Primabasak Utama', ''),
('405', 'Argawa Utama', ''),
('406', 'Colomadu BKK', ''),
('407', 'Kec. Cimahi', ''),
('408', 'Maos', ''),
('409', 'BKK Tambak', ''),
('410', 'BKK Ambal', ''),
('411', 'BKK Lumbir', ''),
('412', 'LKP Labuhan Lombok (Merger ke BPR NTB Lombok Timur Tgl31/8/2009)', ''),
('413', 'BKK Ngombol', ''),
('414', 'BKK Prembun', ''),
('415', 'Prima Artha Sentana', ''),
('416', 'Mustaqim Seulimeum', ''),
('417', 'BKK Kemiri', ''),
('418', 'BKK Miri', ''),
('419', 'BKK Moga', ''),
('420', 'LKP Moyo (Merger ke NTB Sumbawa Tgl 6 Nov 2009)', ''),
('421', 'Tirtomoyo BKK', ''),
('422', 'Ampel BKK', ''),
('423', 'Purworejo Klampok', ''),
('424', 'BKK Sempor', ''),
('425', 'BKK Watukumpul', ''),
('426', 'Kemusu BKK', ''),
('427', 'BKK Majenang', ''),
('428', 'Angkinang', ''),
('429', 'LPK Carenang', ''),
('430', 'LKP Naru', ''),
('431', 'Jenawi BKK', ''),
('432', 'Mandirancan', ''),
('433', 'BKK Pekuncen', ''),
('434', 'BKK Pancur', ''),
('435', 'Japanan Indah', ''),
('436', 'Karangpandan BKK', ''),
('437', 'BKK Pegandon', ''),
('438', 'BKPD Cineam', ''),
('439', 'BKK Karangtengah', ''),
('440', 'Cimahi Tengah', ''),
('441', 'LKP Kayangan', ''),
('442', 'Kec. Pangalengan (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', ''),
('443', 'Gunung Rogojembangan', ''),
('444', 'BKK Sawangan', ''),
('445', 'BKK Plantungan', ''),
('446', 'BKK Penawangan', ''),
('447', 'BKK Batangan', ''),
('448', 'BKK Ngaringan', ''),
('449', 'BKK Limbangan', ''),
('450', 'BKK Kandangan', ''),
('451', 'Mustaqim Tangan-Tangan', ''),
('452', 'Balubur Limbangan', ''),
('453', 'Mapalus Kamangen (Merger Ke Mapalus Tumetenden Tgl 15/4/2009)', ''),
('454', 'BKK Tangen', ''),
('455', 'BKK Wonopringgo', ''),
('456', 'Cimanggu BKK', ''),
('457', 'LPK Cinangka', ''),
('458', 'kec. Cicalengka (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', ''),
('459', 'BKK Cilongok', ''),
('460', 'BKK Wangon', ''),
('461', 'BKK Binangun', ''),
('462', 'BKK Kutowinangun', ''),
('463', 'Kalibening', ''),
('464', 'Bank OCBC NISP Tbk.', ''),
('465', 'BKK Kemranjen', ''),
('466', 'BKK Winong', ''),
('467', 'Binong', ''),
('468', 'Pagentan', ''),
('469', 'Giritontro', ''),
('470', 'Karanganyar - Purbalingga', ''),
('471', 'BKK Karanganyar - Kebumen', ''),
('472', 'LPK Anyar', ''),
('473', 'BKK Loano', ''),
('474', 'Karangkobar BKK', ''),
('475', 'Bank OCBC Indonesia', ''),
('476', 'BKK Grobogan', ''),
('477', 'Bank Pasar Rajapolah', ''),
('478', 'BKPD Rajapolah', ''),
('479', 'BKPD Cikatomas', ''),
('480', 'Mustaqim Lhoong', ''),
('481', 'Lopok (Merger ke NTB Sumbawa Tgl 6 Nov 2009)', ''),
('482', 'BKK Toroh', ''),
('483', 'Mapalus Lo''Orta (Merger Ke Mapalus Tumetenden Tgl 15/4/2009)', ''),
('484', 'BKK Pamotan', ''),
('485', 'BKK Adipala', ''),
('486', 'LKP Plampang (Merger ke NTB Sumbawa Tgl 6 Nov 2009)', ''),
('487', 'Salido Empati', ''),
('488', 'Mataram Gamping', ''),
('489', 'BKK Sumpiuh', ''),
('490', 'Ngemplak', ''),
('491', 'Cepogo BKK', ''),
('492', 'Jumapolo BKK', ''),
('493', 'BKK Sirampog', ''),
('494', 'LKP Janapria (Merger ke BPR NTB Lombok Tengah tgl 31/08/2009)', ''),
('495', 'LKP Perampuan', ''),
('496', 'BKK Limpung', ''),
('497', 'Putra Riau Mandiri', 'PT BPR Putra Riau Mandiri'),
('498', 'LKP Sarae', ''),
('499', 'Jagaraga', ''),
('500', 'BKK Sragi', ''),
('501', 'LKP Kotaraja (Merger ke BPR NTB Lombok Timur Tgl31/8/2009)', ''),
('502', 'BKK Sokaraja', ''),
('503', 'BKPD Sukaraja', ''),
('504', 'Darmaraja', ''),
('505', 'BKPD Taraju', ''),
('506', 'Kec. Padalarang (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', ''),
('507', 'Kec. Sagalaherang', ''),
('508', 'BKK Ajibarang', ''),
('509', 'BKK Kalorang', ''),
('510', 'LPK Samarang', ''),
('511', 'BKK Sarang', ''),
('512', 'BKK Lebakbarang', ''),
('513', 'LKP Pringgarata (Merger ke BPR NTB Lombok Tengah tgl 31/08/2009)', ''),
('514', 'BKK Brati', ''),
('515', 'LKP Rato Bolo', ''),
('516', 'Swadharma Ambarawa', ''),
('517', 'Mustaqim Meuraxa (korban tsunami)', ''),
('518', 'LKP Praya (Merger ke BPR NTB Lombok Tengah tgl 31/08/2009)', ''),
('519', 'BKK Kutoarjo', ''),
('520', 'Karangreja', ''),
('521', 'Wanareja', ''),
('522', 'Kedungreja', ''),
('523', 'Sidareja', ''),
('524', 'BKK Tegalrejo', ''),
('525', 'BKK Margorejo', ''),
('526', 'BKK Sukorejo', ''),
('527', 'BKK Ngadirejo - Temanggung', ''),
('528', 'BKK Sambirejo', ''),
('529', 'BKPD Cibeureum', ''),
('530', 'BKK Puring', ''),
('531', 'BKK Cepiring', ''),
('532', 'Mejayan Permai', ''),
('533', 'BKK Singorojo', ''),
('534', 'Ngadirojo (BKK) - Wonogiri', ''),
('535', 'BKK Tambakromo', ''),
('536', 'BKK Klirong', ''),
('537', 'BKK Candiroto', ''),
('538', 'Jatiroto BKK', ''),
('539', 'Kroya - Cilacap', ''),
('540', 'Manca Danarta', ''),
('541', 'Kawicentra Artha', ''),
('542', 'Adicentra Artha', ''),
('543', 'Wahyucakra Artha', ''),
('544', 'Swasad Artha', ''),
('545', 'Bekasi Istana Arta', ''),
('546', 'Ronatama Mandiri', 'PT BPR Ronatama Mandiri'),
('547', 'LKP Gerung', ''),
('548', 'BKK Garung', ''),
('549', 'BKK Bruno', ''),
('550', 'Bank Mandiri PT. Tbk.', 'PT Bank Mandiri'),
('5500', 'Naratama Bersada', ''),
('551', 'Kadiri Kartapersada', ''),
('552', 'Asparaga Mitra Usaha', ''),
('553', 'Prismadana Wirausaha', ''),
('554', 'BKK Sale', ''),
('555', 'LKP Gunung Sari', ''),
('556', 'Kec. Tanjungsari', ''),
('557', 'Bobotsari', ''),
('558', 'BKK Kutasari', ''),
('559', 'BKK Windusari', ''),
('560', 'BKK Wirosari', ''),
('561', 'Nogosari BKK', ''),
('562', 'BKPD Leuwisari', ''),
('563', 'Selo BKK', ''),
('564', 'BKK Kesesi', ''),
('565', 'BKK Dukuhseti', ''),
('566', 'Cisewu', ''),
('567', 'Pancasila', ''),
('568', 'Simo', ''),
('569', 'BKK Gringsing', ''),
('570', 'BKK Kaligesing', ''),
('571', 'BKK Brangsong', ''),
('572', 'BKK Leksono', ''),
('573', 'Artha Sembada', ''),
('574', 'Tegowanu Dieng Pratama', ''),
('575', 'Godong Merapi Pratama', ''),
('576', 'Dana Mitra Sejati  (Merger ke Dana Mitra Sentosa Tgl 28/4/2009)', ''),
('577', 'Juwangi Gajahmungkur Pratama', ''),
('578', 'Candimas Adipratama', ''),
('579', 'Sri Utama', ''),
('580', 'Margot Artha Utama', ''),
('581', 'LKP Mantang (Merger ke BPR NTB Lombok Tengah tgl 31/08/2009)', ''),
('582', 'BKK Wadaslintang', ''),
('583', 'BKPD Cigalontang', ''),
('584', 'LPK Pontang', ''),
('585', 'BKK Cilacap Utara', ''),
('586', 'Mustaqim Kluet Utara', ''),
('587', 'Asparaga Sejahtera Lestari', ''),
('588', 'BKK Patean', ''),
('589', 'Bukateja', ''),
('590', 'Seketeng (Merger ke NTB Sumbawa Tgl 6 Nov 2009)', ''),
('591', 'BKK Kedungbanteng', ''),
('592', 'Bangunkarsa Arthasejahtera', ''),
('593', 'Handayani Cipta Sejahtera', ''),
('594', 'Tomo', ''),
('595', 'LKP Paok Motong (Merger ke BPR NTB Lombok Timur Tgl31/8/2009)', ''),
('596', 'Jumantono BKK', ''),
('597', 'Purwantoro BKK', ''),
('598', 'Cakraputra Sentosa', ''),
('599', 'Harta Sentosa (Self liquidation surat BI 7 Nov 2008)', ''),
('600', 'Tumou Tou', ''),
('601', 'Swadharma Cibitung', ''),
('602', 'BKK Dukuh Turi', ''),
('603', 'Mustaqim Kuala', ''),
('604', 'BKK Gubug', ''),
('605', 'BKK Borobudur', ''),
('606', 'Bank UFJ Indonesia (cabut izin 5/10/06)', ''),
('607', 'Dayeuhluhur', ''),
('608', 'LKP Penujak (Merger ke BPR NTB Lombok Tengah tgl 31/08/2009)', ''),
('609', 'BKPD Bantarujeg', ''),
('610', 'BKPD Jatitujuh', ''),
('611', 'LKP Mujur (Merger ke BPR NTB Lombok Tengah tgl 31/08/2009)', ''),
('612', 'Susukan - Banjarnegara', ''),
('613', 'BKK Petarukan', ''),
('614', 'Pamanukan Kec', ''),
('615', 'BKK Dukun', ''),
('616', 'BKK Tulis', ''),
('617', 'BKK Pulokulon', ''),
('618', 'BKK Candimulyo', ''),
('619', 'BKK Adimulyo', ''),
('620', 'BKK Banyumas', ''),
('621', 'Utomo Manunggal Sejahtera Sumsel', 'PT BPR Utomo Manunggal Sejahtera Sumsel'),
('622', 'BKK Gunem', ''),
('623', 'Mapalus Wangunen (Merger Ke Mapalus Tumetenden Tgl 15/4/2009)', ''),
('624', 'Nusawungu', ''),
('625', 'BKK Kaliwungu - Kendal', ''),
('626', 'BKK Kaliwungu - Kudus', ''),
('627', 'BKK Tlogowungu', ''),
('628', 'Arthaguna Sembada', ''),
('629', 'Bank UOB Indonesia', ''),
('630', 'Kec. Cisurupan', ''),
('631', 'BKK Plupuh', ''),
('632', 'BKK Sapuran', ''),
('633', 'Cipta Artha Nusa', ''),
('634', 'BKK Banyuurip', ''),
('635', 'Jatipurno BKK', ''),
('636', 'BKK Pituruh', ''),
('637', 'Musuk', ''),
('638', 'LKP Motong Utan (Merger ke NTB Sumbawa Tgl 6 Nov 2009)', ''),
('639', 'BKK Cluwak', ''),
('640', 'BKK Ngluwar', ''),
('641', 'Ciawi BPR', ''),
('642', 'kec. Wado', ''),
('643', 'BKK Rawalo', ''),
('644', 'Kawalu', ''),
('645', 'BKK TPI Juwana', ''),
('646', 'BKK Juwana', ''),
('647', 'BKK Jatilawang', ''),
('648', 'BKK Bawang', ''),
('649', 'BKK Tegowanu', ''),
('650', 'BKK Kaliwiro', ''),
('651', 'Giriwoyo BKK', ''),
('652', 'BKK Kedawung', ''),
('653', 'BKK Kedungwuni', ''),
('654', 'Mustaqim Kaway XVI', ''),
('655', 'Wanayasa', ''),
('656', 'BKPD Cisayong', ''),
('657', 'BKK Margoyoso', ''),
('658', 'Ngargoyoso', ''),
('659', 'Jatiyoso BKK', ''),
('660', 'LKP Puyung (Merger ke BPR NTB Lombok Tengah tgl 31/08/2009)', ''),
('661', 'BKK Pageruyung', ''),
('662', 'BKK Karang Rayung', ''),
('663', 'BKK Sayung', ''),
('664', 'Era Aneka Rezeki', ''),
('665', 'Bank Sami''un', 'Bank Thoyib');

-- --------------------------------------------------------

--
-- Table structure for table `tref_bank_cabang`
--

DROP TABLE IF EXISTS `tref_bank_cabang`;
CREATE TABLE IF NOT EXISTS `tref_bank_cabang` (
  `bankID` varchar(5) NOT NULL DEFAULT '',
  `cabangID` bigint(20) NOT NULL AUTO_INCREMENT,
  `cabangNama` varchar(150) DEFAULT NULL,
  `alamat` varchar(150) DEFAULT NULL,
  `propinsiID` varchar(4) DEFAULT NULL,
  `kotaID` int(10) DEFAULT NULL,
  `kodePos` varchar(6) DEFAULT NULL,
  `namaKontak` varchar(50) DEFAULT NULL,
  `telepon` varchar(150) DEFAULT NULL,
  `fax` varchar(150) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `keterangan` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`cabangID`,`bankID`),
  KEY `bankID` (`bankID`),
  KEY `cabangID` (`cabangID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `tref_bank_cabang`
--

INSERT INTO `tref_bank_cabang` (`bankID`, `cabangID`, `cabangNama`, `alamat`, `propinsiID`, `kotaID`, `kodePos`, `namaKontak`, `telepon`, `fax`, `email`, `keterangan`) VALUES
('10002', 1, 'BNI KCK BDG', 'Kopooooo', '32', 1, '40225', 'dfd', '1234132', '2113', 'ddd', 'nope'),
('10002', 2, 'Mandiri KCP BDG', 'Asia Afrika', '32', 18, '123123', 'hjh', '123142', '2432', 'qwert@qwertz.com', '243refefgege'),
('10003', 3, 'BRI KCP BDG', 'Asia Afrika', '32', 18, '798788', 'dss', '876876', '22423422', '', 'asdasd'),
('550', 4, 'Persada Mandiri', 'Jalan Vetera', '32', 18, '123456', 'aksjd', '231321', '32a1sd3', 'asdjlkJ@laksjd.cocom', '321'),
('10011', 8, '123', '123', '31', 154, '123', '123', '123', '123', '123', NULL),
('10018', 9, 'asdasd', 'qweqwe', '34', 223, '123', '123', '123', '123', '123', NULL),
('10106', 10, 'BKR', 'Jalan BKR', '32', 169, '12345', 'Vina', '123456789', '321654', 'vina@gmail.com', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tref_city`
--

DROP TABLE IF EXISTS `tref_city`;
CREATE TABLE IF NOT EXISTS `tref_city` (
  `kotaID` int(10) NOT NULL AUTO_INCREMENT,
  `propinsiID` varchar(4) NOT NULL DEFAULT '',
  `kotaNama` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`kotaID`,`propinsiID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=502 ;

--
-- Dumping data for table `tref_city`
--

INSERT INTO `tref_city` (`kotaID`, `propinsiID`, `kotaNama`) VALUES
(1, '11', 'Kabupaten Aceh Barat'),
(2, '11', 'Kabupaten Aceh Timur'),
(3, '11', 'Kabupaten Aceh Utara'),
(4, '11', 'Kabupaten Bener Meriah'),
(5, '11', 'Kabupaten Bireuen'),
(6, '11', 'Kabupaten Gayo Lues'),
(7, '11', 'Kabupaten Nagan Raya'),
(8, '11', 'Kabupaten Pidie'),
(9, '11', 'Kabupaten Pidie Jaya'),
(10, '11', 'Kabupaten Simeulue'),
(11, '11', 'Kota Banda Aceh'),
(12, '11', 'Kabupaten Aceh Barat Daya'),
(13, '11', 'Kota Langsa'),
(14, '11', 'Kota Lhokseumawe'),
(15, '11', 'Kota Sabang'),
(16, '11', 'Kota Subulussalam'),
(17, '11', 'Kabupaten Aceh Barat'),
(18, '11', 'Kabupaten Aceh Barat'),
(19, '11', 'Kabupaten Aceh Besar'),
(20, '11', 'Kabupaten Aceh Jaya'),
(21, '11', 'Kabupaten Aceh Selatan'),
(22, '11', 'Kabupaten Aceh Singkil'),
(23, '11', 'Kabupaten Aceh Tamiang'),
(24, '11', 'Kabupaten Aceh Tengah'),
(25, '11', 'Kabupaten Aceh Tenggara'),
(26, '12', 'Kabupaten Asahan'),
(27, '12', 'Kabupaten Langkat'),
(28, '12', 'Kabupaten Mandailing Natal'),
(29, '12', 'Kabupaten Nias'),
(30, '12', 'Kabupaten Nias Barat'),
(31, '12', 'Kabupaten Nias Selatan'),
(32, '12', 'Kabupaten Nias Utara'),
(33, '12', 'Kabupaten Padang Lawas'),
(34, '12', 'Kabupaten Padang Lawas Utara'),
(35, '12', 'Kabupaten Pakpak Bharat'),
(36, '12', 'Kabupaten Samosir'),
(37, '12', 'Kabupaten Batubara'),
(38, '12', 'Kabupaten Serdang Bedagai'),
(39, '12', 'Kabupaten Simalungun'),
(40, '12', 'Kabupaten Tapanuli Selatan'),
(41, '12', 'Kabupaten Tapanuli Tengah'),
(42, '12', 'Kabupaten Tapanuli Utara'),
(43, '12', 'Kabupaten Toba Samosir'),
(44, '12', 'Kota Binjai'),
(45, '12', 'Kota Gunungsitoli'),
(46, '12', 'Kota Medan'),
(47, '12', 'Kota Padangsidempuan'),
(48, '12', 'Kabupaten Dairi'),
(49, '12', 'Kota Pematangsiantar'),
(50, '12', 'Kota Sibolga'),
(51, '12', 'Kota Tanjungbalai'),
(52, '12', 'Kota Tebing Tinggi'),
(53, '12', 'Kabupaten Deli Serdang'),
(54, '12', 'Kabupaten Humbang Hasundutan'),
(55, '12', 'Kabupaten Karo'),
(56, '12', 'Kabupaten Labuhanbatu'),
(57, '12', 'Kabupaten Labuhanbatu Selatan'),
(58, '12', 'Kabupaten Labuhanbatu Utara'),
(59, '13', 'Kabupaten Agam'),
(60, '13', 'Kabupaten Solok'),
(61, '13', 'Kabupaten Solok Selatan'),
(62, '13', 'Kabupaten Tanah Datar'),
(63, '13', 'Kota Bukittinggi'),
(64, '13', 'Kota Padang'),
(65, '13', 'Kota Padangpanjang'),
(66, '13', 'Kota Pariaman'),
(67, '13', 'Kota Payakumbuh'),
(68, '13', 'Kota Sawahlunto'),
(69, '13', 'Kota Solok'),
(70, '13', 'Kabupaten Dharmasraya'),
(71, '13', 'Kabupaten Kepulauan Mentawa'),
(72, '13', 'Kabupaten Lima Puluh Kota'),
(73, '13', 'Kabupaten Padang Pariaman'),
(74, '13', 'Kabupaten Pasaman'),
(75, '13', 'Kabupaten Pasaman Barat'),
(76, '13', 'Kabupaten Pesisir Selatan'),
(77, '13', 'Kabupaten Sijunjung'),
(78, '14', 'Kabupaten Bengkalis'),
(79, '14', 'Kabupaten Kepulauan Meranti'),
(80, '14', 'Kota Dumai'),
(81, '14', 'Kota Pekanbaru'),
(82, '14', 'Kabupaten Indragiri Hilir'),
(83, '14', 'Kabupaten Indragiri Hulu'),
(84, '14', 'Kabupaten Kampar'),
(85, '14', 'Kabupaten Kuantan Singingi'),
(86, '14', 'Kabupaten Pelalawan'),
(87, '14', 'Kabupaten Rokan Hilir'),
(88, '14', 'Kabupaten Rokan Hulu'),
(89, '14', 'Kabupaten Siak'),
(90, '15', 'Kabupaten Batanghari'),
(91, '15', 'Kota Jambi'),
(92, '15', 'Kota Sungai Penuh'),
(93, '15', 'Kabupaten Bungo'),
(94, '15', 'Kabupaten Kerinci'),
(95, '15', 'Kabupaten Merangin'),
(96, '15', 'Kabupaten Muaro Jambi'),
(97, '15', 'Kabupaten Sarolangun'),
(98, '15', 'Kabupaten Tanjung Jabung Barat '),
(99, '15', 'Kabupaten Tanjung Jabung Timur '),
(100, '15', 'Kabupaten Tebo'),
(101, '16', 'Kabupaten Banyuasin'),
(102, '16', 'Kabupaten Ogan Komering Ulu Selatan'),
(103, '16', 'Kabupaten Ogan Komering Ulu Timur'),
(104, '16', 'Kota Lubuklinggau'),
(105, '16', 'Kota Pagar Alam'),
(106, '16', 'Kota Palembang'),
(107, '16', 'Kota Prabumulih'),
(108, '16', 'Kabupaten Empat Lawang'),
(109, '16', 'Kabupaten Lahat'),
(110, '16', 'Kabupaten Muara Enim'),
(111, '16', 'Kabupaten Musi Banyuasin'),
(112, '16', 'Kabupaten Musi Rawas'),
(113, '16', 'Kabupaten Ogan Ilir'),
(114, '16', 'Kabupaten Ogan Komering Ilir'),
(115, '16', 'Kabupaten Ogan Komering Ulu'),
(116, '17', 'Kabupaten Bengkulu Selatan'),
(117, '17', 'Kota Bengkulu'),
(118, '17', 'Kabupaten Bengkulu Tengah '),
(119, '17', 'Kabupaten Bengkulu Utara '),
(120, '17', 'Kabupaten Kaur'),
(121, '17', 'Kabupaten Kepahiang'),
(122, '17', 'Kabupaten Lebong'),
(123, '17', 'Kabupaten Mukomuko'),
(124, '17', 'Kabupaten Rejang Lebong'),
(125, '17', 'Kabupaten Seluma'),
(126, '18', 'Kabupaten Lampung Barat'),
(127, '18', 'Kabupaten Tulang Bawang'),
(128, '18', 'Kabupaten Tulang Bawang Barat '),
(129, '18', 'Kabupaten Way Kanan'),
(130, '18', 'Kota Bandar Lampung'),
(131, '18', 'Kota Metro'),
(132, '18', 'Kabupaten Lampung Selatan'),
(133, '18', 'Kabupaten Lampung Tengah'),
(134, '18', 'Kabupaten Lampung Timur'),
(135, '18', 'Kabupaten Lampung Utara'),
(136, '18', 'Kabupaten Mesuji'),
(137, '18', 'Kabupaten Pesawaran'),
(138, '18', 'Kabupaten Pringsewu'),
(139, '18', 'Kabupaten Tanggamus'),
(140, '19', 'Kabupaten Bangka'),
(141, '19', 'Kabupaten Bangka Barat'),
(142, '19', 'Kabupaten Bangka Selatan'),
(143, '19', 'Kabupaten Bangka Tengah'),
(144, '19', 'Kabupaten Belitung'),
(145, '19', 'Kabupaten Belitung Timur'),
(146, '19', 'Kota Pangkal Pinang'),
(147, '21', 'Kabupaten Bintan'),
(148, '21', 'Kabupaten Karimun'),
(149, '21', 'Kabupaten Kepulauan Anambas'),
(150, '21', 'Kabupaten Lingga'),
(151, '21', 'Kabupaten Natuna'),
(152, '21', 'Kota Batam'),
(153, '21', 'Kota Tanjung Pinang'),
(154, '31', 'Kabupaten Administrasi Kepulauan Seribu'),
(155, '31', 'Kota Administrasi Jakarta Barat'),
(156, '31', 'Kota Administrasi Jakarta Pusat'),
(157, '31', 'Kota Administrasi Jakarta Selatan'),
(158, '31', 'Kota Administrasi Jakarta Timur'),
(159, '31', 'Kota Administrasi Jakarta Utara'),
(160, '32', 'Kabupaten Bandung'),
(161, '32', 'Kabupaten Karawang'),
(162, '32', 'Kabupaten Kuningan'),
(163, '32', 'Kabupaten Majalengka'),
(164, '32', 'Kabupaten Purwakarta'),
(165, '32', 'Kabupaten Subang'),
(166, '32', 'Kabupaten Sukabumi'),
(167, '32', 'Kabupaten Sumedang'),
(168, '32', 'Kabupaten Tasikmalaya'),
(169, '32', 'Kota Bandung'),
(170, '32', 'Kota Banjar'),
(171, '32', 'Kabupaten Bandung Barat'),
(172, '32', 'Kota Bekasi'),
(173, '32', 'Kota Bogor'),
(174, '32', 'Kota Cimahi'),
(175, '32', 'Kota Cirebon'),
(176, '32', 'Kota Depok'),
(177, '32', 'Kota Sukabumi'),
(178, '32', 'Kota Tasikmalaya'),
(179, '32', 'Kabupaten Bekasi'),
(180, '32', 'Kabupaten Bogor'),
(181, '32', 'Kabupaten Ciamis'),
(182, '32', 'Kabupaten Cianjur'),
(183, '32', 'Kabupaten Cirebon'),
(184, '32', 'Kabupaten Garut'),
(185, '32', 'Kabupaten Indramayu'),
(186, '33', 'Kabupaten Banjarnegara'),
(187, '33', 'Kabupaten Jepara'),
(188, '33', 'Kabupaten Karanganyar'),
(189, '33', 'Kabupaten Kebumen'),
(190, '33', 'Kabupaten Kendal'),
(191, '33', 'Kabupaten Klaten'),
(192, '33', 'Kabupaten Kudus'),
(193, '33', 'Kabupaten Magelang'),
(194, '33', 'Kabupaten Pati'),
(195, '33', 'Kabupaten Pekalongan'),
(196, '33', 'Kabupaten Pemalang'),
(197, '33', 'Kabupaten Banyumas'),
(198, '33', 'Kabupaten Purbalingga'),
(199, '33', 'Kabupaten Purworejo'),
(200, '33', 'Kabupaten Rembang'),
(201, '33', 'Kabupaten Semarang'),
(202, '33', 'Kabupaten Sragen'),
(203, '33', 'Kabupaten Sukoharjo'),
(204, '33', 'Kabupaten Tegal'),
(205, '33', 'Kabupaten Temanggung'),
(206, '33', 'Kabupaten Wonogiri'),
(207, '33', 'Kabupaten Wonosobo'),
(208, '33', 'Kabupaten Batang'),
(209, '33', 'Kota Magelang'),
(210, '33', 'Kota Pekalongan'),
(211, '33', 'Kota Salatiga'),
(212, '33', 'Kota Semarang'),
(213, '33', 'Kota Surakarta'),
(214, '33', 'Kota Tegal'),
(215, '33', 'Kabupaten Blora'),
(216, '33', 'Kabupaten Boyolali'),
(217, '33', 'Kabupaten Brebes'),
(218, '33', 'Kabupaten Cilacap'),
(219, '33', 'Kabupaten Demak'),
(220, '33', 'Kabupaten Grobogan'),
(221, '34', 'Kabupaten Bantul'),
(222, '34', 'Kabupaten Gunung Kidul'),
(223, '34', 'Kabupaten Kulon Progo'),
(224, '34', 'Kabupaten Sleman'),
(225, '34', 'Kota Yogyakarta'),
(226, '35', 'Kabupaten Bangkalan'),
(227, '35', 'Kabupaten Lamongan'),
(228, '35', 'Kabupaten Lumajang'),
(229, '35', 'Kabupaten Madiun'),
(230, '35', 'Kabupaten Magetan'),
(231, '35', 'Kabupaten Malang'),
(232, '35', 'Kabupaten Mojokerto'),
(233, '35', 'Kabupaten Nganjuk'),
(234, '35', 'Kabupaten Ngawi'),
(235, '35', 'Kabupaten Pacitan'),
(236, '35', 'Kabupaten Pamekasan'),
(237, '35', 'Kabupaten Banyuwangi'),
(238, '35', 'Kabupaten Pasuruan'),
(239, '35', 'Kabupaten Ponorogo'),
(240, '35', 'Kabupaten Probolinggo'),
(241, '35', 'Kabupaten Sampang'),
(242, '35', 'Kabupaten Sidoarjo'),
(243, '35', 'Kabupaten Situbondo'),
(244, '35', 'Kabupaten Sumenep'),
(245, '35', 'Kabupaten Trenggalek'),
(246, '35', 'Kabupaten Tuban'),
(247, '35', 'Kabupaten Tulungagung'),
(248, '35', 'Kabupaten Blitar'),
(249, '35', 'Kota Batu'),
(250, '35', 'Kota Blitar'),
(251, '35', 'Kota Kediri'),
(252, '35', 'Kota Madiun'),
(253, '35', 'Kota Malang'),
(254, '35', 'Kota Mojokerto'),
(255, '35', 'Kota Pasuruan'),
(256, '35', 'Kota Probolinggo'),
(257, '35', 'Kota Surabaya'),
(258, '35', 'Kabupaten Bojonegoro'),
(259, '35', 'Kabupaten Bondowoso'),
(260, '35', 'Kabupaten Gresik'),
(261, '35', 'Kabupaten Jember'),
(262, '35', 'Kabupaten Jombang'),
(263, '35', 'Kabupaten Kediri'),
(264, '36', 'Kabupaten Tangerang'),
(265, '36', 'Kabupaten Serang'),
(266, '36', 'Kabupaten Lebak'),
(267, '36', 'Kabupaten Pandeglang'),
(268, '36', 'Kota Tangerang'),
(269, '36', 'Kota Serang'),
(270, '36', 'Kota Cilegon'),
(271, '36', 'Kota Tangerang Selatan'),
(272, '51', 'Kabupaten Badung'),
(273, '51', 'Kabupaten Bangli'),
(274, '51', 'Kabupaten Buleleng'),
(275, '51', 'Kabupaten Gianyar'),
(276, '51', 'Kabupaten Jembrana'),
(277, '51', 'Kabupaten Karangasem'),
(278, '51', 'Kabupaten Klungkung'),
(279, '51', 'Kabupaten Tabanan'),
(280, '51', 'Kota Denpasar'),
(281, '52', 'Kabupaten Bima'),
(282, '52', 'Kota Mataram'),
(283, '52', 'Kabupaten Dompu'),
(284, '52', 'Kabupaten Lombok Barat'),
(285, '52', 'Kabupaten Lombok Tengah'),
(286, '52', 'Kabupaten Lombok Timur'),
(287, '52', 'Kabupaten Lombok Utara'),
(288, '52', 'Kabupaten Sumbawa'),
(289, '52', 'Kabupaten Sumbawa Barat'),
(290, '52', 'Kota Bima'),
(291, '53', 'Kabupaten Alor'),
(292, '53', 'Kabupaten Ngada'),
(293, '53', 'Kabupaten Nagekeo'),
(294, '53', 'Kabupaten Rote Ndao'),
(295, '53', 'Kabupaten Sabu Raijua'),
(296, '53', 'Kabupaten Sikka'),
(297, '53', 'Kabupaten Sumba Barat'),
(298, '53', 'Kabupaten Sumba Barat Daya'),
(299, '53', 'Kabupaten Sumba Tengah'),
(300, '53', 'Kabupaten Sumba Timur'),
(301, '53', 'Kabupaten Timor Tengah Selatan'),
(302, '53', 'Kabupaten Belu'),
(303, '53', 'Kabupaten Timor Tengah Utara'),
(304, '53', 'Kota Kupang'),
(305, '53', 'Kabupaten Ende'),
(306, '53', 'Kabupaten Flores Timur'),
(307, '53', 'Kabupaten Kupang'),
(308, '53', 'Kabupaten Lembata'),
(309, '53', 'Kabupaten Manggarai'),
(310, '53', 'Kabupaten Manggarai Barat'),
(311, '53', 'Kabupaten Manggarai Timur'),
(312, '61', 'Kabupaten Bengkayang'),
(313, '61', 'Kabupaten Sanggau'),
(314, '61', 'Kabupaten Sekadau'),
(315, '61', 'Kabupaten Sintang'),
(316, '61', 'Kota Pontianak'),
(317, '61', 'Kota Singkawang'),
(318, '61', 'Kabupaten Bengkayang'),
(319, '61', 'Kabupaten Kayong Utara'),
(320, '61', 'Kabupaten Ketapang'),
(321, '61', 'Kabupaten Kubu Raya'),
(322, '61', 'Kabupaten Landak'),
(323, '61', 'Kabupaten Melawi'),
(324, '61', 'Kabupaten Pontianak'),
(325, '61', 'Kabupaten Sambas'),
(326, '62', 'Kabupaten Barito Selatan'),
(327, '62', 'Kabupaten Murung Raya'),
(328, '62', 'Kabupaten Pulang Pisau'),
(329, '62', 'Kabupaten Sukamara'),
(330, '62', 'Kabupaten Seruyan'),
(331, '62', 'Kota Palangka Raya'),
(332, '62', 'Kabupaten Barito Timur'),
(333, '62', 'Kabupaten Barito Utara'),
(334, '62', 'Kabupaten Gunung Mas'),
(335, '62', 'Kabupaten Kapuas'),
(336, '62', 'Kabupaten Katingan'),
(337, '62', 'Kabupaten Kotawaringin Barat'),
(338, '62', 'Kabupaten Kotawaringin Timur'),
(339, '62', 'Kabupaten Lamandau'),
(340, '63', 'Kabupaten Balangan'),
(341, '63', 'Kabupaten Tanah Laut'),
(342, '63', 'Kabupaten Tapin'),
(343, '63', 'Kota Banjarbaru'),
(344, '63', 'Kota Banjarmasin'),
(345, '63', 'Kabupaten Banjar'),
(346, '63', 'Kabupaten Barito Kuala'),
(347, '63', 'Kabupaten Hulu Sungai Selatan'),
(348, '63', 'Kabupaten Hulu Sungai Tengah'),
(349, '63', 'Kabupaten Hulu Sungai Utara'),
(350, '63', 'Kabupaten Kotabaru'),
(351, '63', 'Kabupaten Tabalong'),
(352, '63', 'Kabupaten Tanah Bumbu'),
(353, '64', 'Kabupaten Berau'),
(354, '64', 'Kabupaten Tana Tidung'),
(355, '64', 'Kota Balikpapan'),
(356, '64', 'Kota Bontang'),
(357, '64', 'Kota Samarinda'),
(358, '64', 'Kota Tarakan'),
(359, '64', 'Kabupaten Bulungan'),
(360, '64', 'Kabupaten Kutai Barat'),
(361, '64', 'Kabupaten Kutai Kartanegara'),
(362, '64', 'Kabupaten Kutai Timur'),
(363, '64', 'Kabupaten Malinau'),
(364, '64', 'Kabupaten Nunukan'),
(365, '64', 'Kabupaten Paser'),
(366, '64', 'Kabupaten Penajam Paser Utara'),
(367, '71', 'Kabupaten Bolaang Mongondow'),
(368, '71', 'Kabupaten Minahasa Tenggara'),
(369, '71', 'Kabupaten Minahasa Utara'),
(370, '71', 'Kota Bitung'),
(371, '71', 'Kota Kotamobagu'),
(372, '71', 'Kota Manado'),
(373, '71', 'Kota Tomohon'),
(374, '71', 'Kabupaten Bolaang Mongondow Selatan'),
(375, '71', 'Kabupaten Bolaang Mongondow Timur'),
(376, '71', 'Kabupaten Bolaang Mongondow utara'),
(377, '71', 'Kabupaten Kepulauan Sangihe'),
(378, '71', 'Kabupaten Kepulauan Siau Tagulandang Biaro'),
(379, '71', 'Kabupaten Kepulauan Talaud'),
(380, '71', 'Kabupaten Minahasa'),
(381, '71', 'Kabupaten Minahasa Selatan'),
(382, '72', 'Kabupaten Banggai'),
(383, '72', 'Kabupaten Sigi'),
(384, '72', 'Kota Palu'),
(385, '72', 'Kabupaten Banggai Kepulauan'),
(386, '72', 'Kabupaten Buol'),
(387, '72', 'Kabupaten Donggala'),
(388, '72', 'Kabupaten Morowali'),
(389, '72', 'Kabupaten Parigi Moutong'),
(390, '72', 'Kabupaten Poso'),
(391, '72', 'Kabupaten Tojo Una-Una'),
(392, '72', 'Kabupaten Toli-Toli'),
(393, '73', 'Kabupaten Bantaeng'),
(394, '73', 'Kabupaten Luwu Timur'),
(395, '73', 'Kabupaten Luwu Utara'),
(396, '73', 'Kabupaten Maros'),
(397, '73', 'Kabupaten Pangkajene dan Kepulauan'),
(398, '73', 'Kabupaten Pinrang'),
(399, '73', 'Kabupaten Sidenreng Rappang'),
(400, '73', 'Kabupaten Sinjai'),
(401, '73', 'Kabupaten Soppeng'),
(402, '73', 'Kabupaten Takalar'),
(403, '73', 'Kabupaten Tana Toraja'),
(404, '73', 'Kabupaten Barru'),
(405, '73', 'Kabupaten Toraja Utara'),
(406, '73', 'Kabupaten Wajo'),
(407, '73', 'Kota Makassar'),
(408, '73', 'Kota Palopo'),
(409, '73', 'Kota Parepare'),
(410, '73', 'Kabupaten Bone'),
(411, '73', 'Kabupaten Bulukumba'),
(412, '73', 'Kabupaten Enrekang'),
(413, '73', 'Kabupaten Gowa'),
(414, '73', 'Kabupaten Jeneponto'),
(415, '73', 'Kabupaten Kepulauan Selayar'),
(416, '73', 'Kabupaten Luwu'),
(417, '74', 'Kabupaten Bombana'),
(418, '74', 'Kabupaten Wakatobi'),
(419, '74', 'Kota Bau-Bau'),
(420, '74', 'Kota Kendari'),
(421, '74', 'Kabupaten Buton'),
(422, '74', 'Kabupaten Buton Utara'),
(423, '74', 'Kabupaten Kolaka'),
(424, '74', 'Kabupaten Kolaka Utara'),
(425, '74', 'Kabupaten Konawe'),
(426, '74', 'Kabupaten Konawe Selatan'),
(427, '74', 'Kabupaten Konawe Utar'),
(428, '74', 'Kabupaten Muna'),
(429, '75', 'Kabupaten Boalemo'),
(430, '75', 'Kabupaten Bone Bolango'),
(431, '75', 'Kabupaten Gorontalo'),
(432, '75', 'Kabupaten Gorontalo Utara'),
(433, '75', 'Kabupaten Pohuwato'),
(434, '75', 'Kota Gorontalo'),
(435, '76', 'Kabupaten Majene'),
(436, '76', 'Kabupaten Mamasa'),
(437, '76', 'Kabupaten Mamuju'),
(438, '76', 'Kabupaten Mamuju Utara'),
(439, '76', 'Kabupaten Polewali Mandar'),
(440, '81', 'Kabupaten Buru'),
(441, '81', 'Kota Ambon'),
(442, '81', 'Kota Tual'),
(443, '81', 'Kabupaten Buru Selatan'),
(444, '81', 'Kabupaten Kepulauan Aru'),
(445, '81', 'Kabupaten Maluku Barat Daya'),
(446, '81', 'Kabupaten Maluku Tengah'),
(447, '81', 'Kabupaten Maluku Tenggara'),
(448, '81', 'Kabupaten Maluku Tenggara Barat'),
(449, '81', 'Kabupaten Seram Bagian Barat'),
(450, '81', 'Kabupaten Seram Bagian Timur'),
(451, '82', 'Kabupaten Halmahera Barat'),
(452, '82', 'Kabupaten Halmahera Tengah'),
(453, '82', 'Kabupaten Halmahera Utara'),
(454, '82', 'Kabupaten Halmahera Selatan'),
(455, '82', 'Kabupaten Kepulauan Sula'),
(456, '82', 'Kabupaten Halmahera Timur'),
(457, '82', 'Kabupaten Pulau Morotai'),
(458, '82', 'Kota Ternate'),
(459, '82', 'Kota Tidore Kepulauan'),
(460, '91', 'Kabupaten Fakfak'),
(461, '91', 'Kabupaten Teluk Wondama'),
(462, '91', 'Kota Sorong'),
(463, '91', 'Kabupaten Kaimana'),
(464, '91', 'Kabupaten Manokwari'),
(465, '91', 'Kabupaten Maybrat'),
(466, '91', 'Kabupaten Raja Ampat'),
(467, '91', 'Kabupaten Sorong'),
(468, '91', 'Kabupaten Sorong Selatan'),
(469, '91', 'Kabupaten Tambrauw'),
(470, '91', 'Kabupaten Teluk Bintuni'),
(471, '94', 'Kabupaten Asmat'),
(472, '94', 'Kabupaten Kepulauan Yapen'),
(473, '94', 'Kabupaten Lanny Jaya'),
(474, '94', 'Kabupaten Mamberamo Raya'),
(475, '94', 'Kabupaten Mamberamo Tengah'),
(476, '94', 'Kabupaten Mappi'),
(477, '94', 'Kabupaten Merauke'),
(478, '94', 'Kabupaten Mimika'),
(479, '94', 'Kabupaten Nabire'),
(480, '94', 'Kabupaten Nduga'),
(481, '94', 'Kabupaten Paniai'),
(482, '94', 'Kabupaten Biak Numfor'),
(483, '94', 'Kabupaten Pegunungan Bintang'),
(484, '94', 'Kabupaten Puncak'),
(485, '94', 'Kabupaten Puncak Jaya'),
(486, '94', 'Kabupaten Sarmi'),
(487, '94', 'Kabupaten Supiori'),
(488, '94', 'Kabupaten Tolikara'),
(489, '94', 'Kabupaten Waropen'),
(490, '94', 'Kabupaten Yahukimo'),
(491, '94', 'Kabupaten Yalimo'),
(492, '94', 'Kota Jayapura'),
(493, '94', 'Kabupaten Boven Digoel'),
(494, '94', 'Kabupaten Deiyai'),
(495, '94', 'Kabupaten Dogiyai'),
(496, '94', 'Kabupaten Intan Jaya'),
(497, '94', 'Kabupaten Jayapura'),
(498, '94', 'Kabupaten Jayawijaya'),
(499, '94', 'Kabupaten Keerom'),
(500, '11', 'asdasd'),
(501, '11', 'AAA');

-- --------------------------------------------------------

--
-- Table structure for table `tref_departemen`
--

DROP TABLE IF EXISTS `tref_departemen`;
CREATE TABLE IF NOT EXISTS `tref_departemen` (
  `departemenID` varchar(5) NOT NULL,
  `departemenNama` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`departemenID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tref_departemen`
--

INSERT INTO `tref_departemen` (`departemenID`, `departemenNama`) VALUES
('1', 'Salesman'),
('2', 'Informasi dan Teknologi'),
('3', 'Bengkel'),
('4', 'Finance'),
('5', 'Accounting'),
('6', 'Customer Service'),
('D-001', 'Administrasi');

-- --------------------------------------------------------

--
-- Table structure for table `tref_instansi`
--

DROP TABLE IF EXISTS `tref_instansi`;
CREATE TABLE IF NOT EXISTS `tref_instansi` (
  `instansiID` varchar(15) NOT NULL DEFAULT '',
  `instansiNama` varchar(75) DEFAULT NULL,
  `alamat` text,
  `propinsiID` varchar(4) NOT NULL DEFAULT '0',
  `kotaID` int(10) NOT NULL DEFAULT '0',
  `kodePos` varchar(5) DEFAULT NULL,
  `nomorTelepon` varchar(30) DEFAULT NULL,
  `namaKontak` varchar(100) DEFAULT NULL,
  `jabatanKontak` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`instansiID`,`kotaID`,`propinsiID`),
  KEY `propinsiID` (`propinsiID`),
  KEY `FK_tref_konsumen_tref_kota` (`kotaID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tref_instansi`
--

INSERT INTO `tref_instansi` (`instansiID`, `instansiNama`, `alamat`, `propinsiID`, `kotaID`, `kodePos`, `nomorTelepon`, `namaKontak`, `jabatanKontak`) VALUES
('I201209060001', 'CITSTUDIO', 'Jalan Rengasdengklok', '32', 160, '40291', '123456', 'Suhendra', 'CEO');

-- --------------------------------------------------------

--
-- Table structure for table `tref_jabatan`
--

DROP TABLE IF EXISTS `tref_jabatan`;
CREATE TABLE IF NOT EXISTS `tref_jabatan` (
  `jabatanID` varchar(5) NOT NULL,
  `jabatanNama` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`jabatanID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tref_jabatan`
--

INSERT INTO `tref_jabatan` (`jabatanID`, `jabatanNama`) VALUES
('1', 'Staff'),
('10', 'Admin Assistant & Technician 4'),
('100', 'SHE&S Safety Site 3'),
('101', 'SHE&S Safety Site EPC 5'),
('102', 'SHE&S Safety-Export System'),
('103', 'SHE&S Security  EPC 5'),
('104', 'SHE&S Security Site FF '),
('105', 'Site Admin Support'),
('106', 'Site Material Coordinator 1'),
('107', 'Site Staff Admin '),
('108', 'Site Staff Admin 2'),
('109', 'Site Staff Admin Export System'),
('11', 'Admin Assistant 3'),
('110', 'Sosioeconomic Monitoring & Reporting  Advisor'),
('111', 'Spread Supervisor 1 '),
('112', 'Spread Supravisor 2 '),
('113', 'Stewardship & Reporting Technician'),
('114', 'Translator'),
('115', 'Travel JMC'),
('116', 'Valve/Pipping Inspector'),
('117', 'Welding Inspector EPC 1'),
('12', 'Admin Assistant 4'),
('13', 'Admin Asst'),
('14', 'Admin Support - Development'),
('15', 'Admin Support FSO'),
('16', 'Admin Support HR'),
('17', 'Admin Support-Export System'),
('18', 'Administrative Assistant'),
('19', 'Admint Assisstant 1'),
('2', 'Koordinator'),
('20', 'Admint Assisstant SHE&S'),
('21', 'Amdal Monitoring Report Advisor POS ID 96 CN'),
('22', 'AMDAL Monitoring Reporting Advisor '),
('23', 'Civil Inspector'),
('24', 'Civil Inspector 3 Export System'),
('25', 'Civil Inspector Export System'),
('26', 'Civil Structural Inspector 2 Pos ID 1253 CB'),
('27', 'Coating Inspector'),
('28', 'Coating Inspector Export System EPC2'),
('29', 'Construction Advisor'),
('3', 'Supervisor'),
('30', 'Contract Assistant'),
('31', 'Contract Specialist'),
('32', 'Contract Support Staff 1 Pos. ID 92 CN.'),
('33', 'Controls Reporting Specialist'),
('34', 'Cost Engineer'),
('35', 'Cost Technician'),
('36', 'Data Assistant'),
('37', 'Doct Cont'),
('38', 'Document Control'),
('39', 'Document Controller'),
('4', 'Manager'),
('40', 'Document Controller - DFO'),
('41', 'Document Controller 1 - Export System'),
('42', 'Document Controller 3 - Export System '),
('43', 'Document Controller FSO 1'),
('44', 'Domestic Content Coordinator'),
('45', 'E&I  Inspector 1 -Export System-'),
('46', 'Envinronmental Project Spcecialist'),
('47', 'Enviromental ,Regulatory & Permit Eng'),
('48', 'Environmental Special Project Officer'),
('49', 'EPC 1 - Regulatory & Permit Site Support'),
('5', 'Direktur'),
('50', 'EPC 5 Civil/Structural Inspecto'),
('51', 'EPC 5 Material Coordinator'),
('52', 'EPC-1 Contract Assistant '),
('53', 'EPC2 - Environmental & Socioeconomic - Exp Sys '),
('54', 'EPC2 Spread Supervisor 3 '),
('55', 'GIS Coordinator'),
('56', 'Inspection Lead 2 Export Syteme '),
('57', 'Inspection Lead 3 Export System'),
('58', 'Inspection Lead 4 Export System'),
('59', 'Interface Technician'),
('6', 'Adm Asst'),
('60', 'Lead Negotiator Team Coordinator'),
('61', 'Material Coordinator'),
('62', 'Mechanical/Piping Inspector EPC 5'),
('63', 'OIMS Coordinator'),
('64', 'OIMS Technician '),
('65', 'Pipeline Designer-EPC3'),
('66', 'Pipeline Engineer - Export System'),
('67', 'Planning  and Schedule Engineer'),
('68', 'Procurement Interface Coordinator'),
('69', 'Procurement Staff'),
('7', 'Adm Asst'),
('70', 'Project Accountant'),
('71', 'Project Control Engineer 1'),
('72', 'Project Control Engineer 2'),
('73', 'Project Training Coordinator '),
('74', 'Quality Inspection Coordinator'),
('75', 'Regulatory & Permit Site '),
('76', 'Regulatory & Permitting Support'),
('77', 'Regulatory Document Coordinator'),
('78', 'Regulatory Staff 1'),
('79', 'Regulatory Staff 3'),
('8', 'Admin Assistant'),
('80', 'Regulatory Staff 5'),
('81', 'Regulatory Staff 7'),
('82', 'Regulatory Staff 8'),
('83', 'Safety Advisor'),
('84', 'Safety Site 2 EPC 5'),
('85', 'Sec Field Adm Asst'),
('86', 'Security - Field '),
('87', 'Security Field Coord'),
('88', 'Security Field Coord'),
('89', 'Security Support Technician Pos ID 448 CN'),
('9', 'Admin Assistant - Quality'),
('90', 'SHE & S Safety Advisor-Export System '),
('91', 'SHE & S Safety Coordinator-Export System '),
('92', 'SHE & S Security Coordinator'),
('93', 'SHE & Safety Advisor Export System'),
('94', 'SHE & Safety Site'),
('95', 'SHE & Safety Site 4'),
('96', 'SHE&S Safety Coordinator'),
('97', 'SHE&S Safety EPC 1'),
('98', 'SHE&S Safety Lead'),
('99', 'SHE&S Safety Site 2'),
('M01', 'Office Boy');

-- --------------------------------------------------------

--
-- Table structure for table `tref_karyawan`
--

DROP TABLE IF EXISTS `tref_karyawan`;
CREATE TABLE IF NOT EXISTS `tref_karyawan` (
  `nip` varchar(9) NOT NULL,
  `npwp` varchar(50) DEFAULT 'L',
  `noKTPSIM` varchar(150) DEFAULT NULL,
  `noJamsostek` varchar(150) DEFAULT NULL,
  `namaLengkap` varchar(150) NOT NULL,
  `namaPanggilan` varchar(50) DEFAULT NULL,
  `tanggalLahir` date DEFAULT NULL,
  `tempatLahir` int(10) DEFAULT NULL,
  `gender` enum('L','P') DEFAULT 'L',
  `agama` enum('islam','protestan','katholik','hindu','budha','kepercayaan lain') DEFAULT 'islam',
  `alamat` text,
  `propinsiID` varchar(4) DEFAULT NULL,
  `kotaID` int(10) DEFAULT NULL,
  `kodePos` varchar(5) DEFAULT NULL,
  `nomortelepon` varchar(150) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `noregistrasikaryawan` varchar(32) NOT NULL DEFAULT '',
  `bankID` varchar(5) DEFAULT NULL,
  `cabangID` bigint(20) DEFAULT NULL,
  `noRekening` varchar(100) DEFAULT NULL,
  `accRekening` varchar(150) DEFAULT NULL,
  `status` enum('N','Y') DEFAULT 'N',
  `NoPKWT` varchar(150) DEFAULT NULL,
  `noKontrak` varchar(50) DEFAULT NULL,
  `tanggalmasuk` date DEFAULT NULL,
  PRIMARY KEY (`nip`,`noregistrasikaryawan`),
  UNIQUE KEY `accRekening` (`accRekening`),
  KEY `propinsiID` (`propinsiID`),
  KEY `FK_tref_karyawan_tref_kota` (`kotaID`),
  KEY `FK_tref_karyawan_tref_kota_2` (`tempatLahir`),
  KEY `nip` (`nip`),
  KEY `cabangID` (`cabangID`),
  KEY `FK_tref_karyawan_tref_bank` (`bankID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tref_karyawan`
--

INSERT INTO `tref_karyawan` (`nip`, `npwp`, `noKTPSIM`, `noJamsostek`, `namaLengkap`, `namaPanggilan`, `tanggalLahir`, `tempatLahir`, `gender`, `agama`, `alamat`, `propinsiID`, `kotaID`, `kodePos`, `nomortelepon`, `email`, `noregistrasikaryawan`, `bankID`, `cabangID`, `noRekening`, `accRekening`, `status`, `NoPKWT`, `noKontrak`, `tanggalmasuk`) VALUES
('6304194', 'NPWP123456', 'KTP123456789', 'JAM123456', 'Suhendra Yohana Putra', 'Hendra', '1986-09-04', 6, 'L', 'islam', 'Jalan Rengasdengklok 3 No 17 Bandung', '32', 169, '40291', '0123', 'suhendra@citstudio.com', 'REG2407976304194', '10002', 1, '13000-58810', 'Suhendra', 'N', NULL, NULL, '2012-01-01'),
('NIP120910', '102475222', '102456885', '3215648', 'Julia Devi Anastiane', 'Ane', '1993-07-21', 169, 'P', 'islam', 'Permata Biru Blok w 124', '32', 160, '12345', '02292978149', 'devialicious@gmail.com', 'REG120910001', '10002', 1, '6304194040986', 'Julia Devi', 'N', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tref_leveluser`
--

DROP TABLE IF EXISTS `tref_leveluser`;
CREATE TABLE IF NOT EXISTS `tref_leveluser` (
  `levelID` int(8) NOT NULL AUTO_INCREMENT COMMENT 'ID Level dari User',
  `levelName` varchar(25) NOT NULL DEFAULT 'Administrator' COMMENT 'Nama Level dari User',
  `levelSlug` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`levelID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `tref_leveluser`
--

INSERT INTO `tref_leveluser` (`levelID`, `levelName`, `levelSlug`) VALUES
(1, 'Super Administrator', 'sa'),
(2, 'Administrator', 'admin'),
(3, 'Manager', 'mgr'),
(4, 'Operator', 'opr');

-- --------------------------------------------------------

--
-- Table structure for table `tref_propinsi`
--

DROP TABLE IF EXISTS `tref_propinsi`;
CREATE TABLE IF NOT EXISTS `tref_propinsi` (
  `propinsiID` varchar(4) NOT NULL,
  `propinsiNama` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`propinsiID`),
  UNIQUE KEY `propinsiNama` (`propinsiNama`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tref_propinsi`
--

INSERT INTO `tref_propinsi` (`propinsiID`, `propinsiNama`) VALUES
('11', 'Aceh'),
('51', 'Bali'),
('36', 'Banten'),
('17', 'Bengkulu'),
('34', 'Daerah Istimewa Yogyakarta'),
('31', 'Daerah Khusus Ibukota Jakarta'),
('75', 'Gorontalo'),
('15', 'Jambi'),
('32', 'Jawa Barat'),
('33', 'Jawa Tengah'),
('35', 'Jawa Timur'),
('61', 'Kalimantan Barat'),
('63', 'Kalimantan Selatan'),
('62', 'Kalimantan Tengah'),
('64', 'Kalimantan Timur'),
('19', 'Kepulauan Bangka Belitung'),
('21', 'Kepulauan Riau'),
('18', 'Lampung'),
('81', 'Maluku'),
('82', 'Maluku Utara'),
('52', 'Nusa Tenggara Barat'),
('53', 'Nusa Tenggara Timur'),
('94', 'Papua'),
('91', 'Papua Barat'),
('14', 'Riau'),
('76', 'Sulawesi Barat'),
('73', 'Sulawesi Selatan'),
('72', 'Sulawesi Tengah'),
('74', 'Sulawesi Tenggara'),
('71', 'Sulawesi Utara'),
('13', 'Sumatera Barat'),
('12', 'Sumatera Utara'),
('16', 'Sumatra Selatan');

-- --------------------------------------------------------

--
-- Table structure for table `tref_user`
--

DROP TABLE IF EXISTS `tref_user`;
CREATE TABLE IF NOT EXISTS `tref_user` (
  `userID` varchar(8) NOT NULL,
  `levelID` int(8) NOT NULL DEFAULT '0',
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `nip` varchar(9) NOT NULL,
  PRIMARY KEY (`userID`,`levelID`,`nip`),
  UNIQUE KEY `nip` (`nip`),
  UNIQUE KEY `username` (`username`),
  KEY `FK_tref_user_tref_leveluser` (`levelID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tref_user`
--

INSERT INTO `tref_user` (`userID`, `levelID`, `username`, `password`, `nip`) VALUES
('UID00001', 1, 'sa01', 'sa01', '6304194');

-- --------------------------------------------------------

--
-- Table structure for table `t_hakakses`
--

DROP TABLE IF EXISTS `t_hakakses`;
CREATE TABLE IF NOT EXISTS `t_hakakses` (
  `username` varchar(50) NOT NULL,
  `modulID` varchar(10) NOT NULL,
  `is_grant` enum('N','Y') DEFAULT 'Y',
  PRIMARY KEY (`username`,`modulID`),
  KEY `modulID` (`modulID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_hakakses`
--

INSERT INTO `t_hakakses` (`username`, `modulID`, `is_grant`) VALUES
('sa01', '1', 'Y'),
('sa01', '2', 'Y'),
('sa01', '3', 'Y');

-- --------------------------------------------------------

--
-- Table structure for table `t_log`
--

DROP TABLE IF EXISTS `t_log`;
CREATE TABLE IF NOT EXISTS `t_log` (
  `logID` varchar(64) NOT NULL DEFAULT '',
  `logAktivitas` enum('INSERT','UPDATE','DELETE') NOT NULL DEFAULT 'INSERT',
  `logTable` varchar(50) DEFAULT NULL,
  `logPenjelasan` text,
  `logKomputer` varchar(64) DEFAULT NULL,
  `logTerakhir` datetime DEFAULT NULL,
  `logUser` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`logID`,`logAktivitas`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_log`
--

INSERT INTO `t_log` (`logID`, `logAktivitas`, `logTable`, `logPenjelasan`, `logKomputer`, `logTerakhir`, `logUser`) VALUES
('02a391ec-f59a-11e1-aa1b-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=aaa', '127.0.0.1', '2012-09-03 14:36:01', 'sa01'),
('041b007d-d98c-11e1-bf13-5442495fad6a', 'UPDATE', 'TREF_MANUFAKTUR', 'manufakturID=M02|manufakturNama=Toyota XX', '127.0.0.1', '2012-07-29 21:45:18', 'sa01'),
('0608e803-f59a-11e1-aa1b-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=96|propinsiNama=abc', '127.0.0.1', '2012-09-03 14:36:07', 'sa01'),
('0b6468e8-f59a-11e1-aa1b-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 14:36:16', 'sa01'),
('0b6ba7f7-f59a-11e1-aa1b-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=96|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 14:36:16', 'sa01'),
('168552f6-f52b-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', NULL, '127.0.0.1', '2012-09-03 01:22:03', 'sa01'),
('16c089b3-f52b-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', NULL, '127.0.0.1', '2012-09-03 01:22:03', 'sa01'),
('16f7c8ee-f52b-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', NULL, '127.0.0.1', '2012-09-03 01:22:03', 'sa01'),
('1aead571-f55e-11e1-86a1-f07bcbe0bf28', 'UPDATE', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=Aceh Darussalam', '127.0.0.1', '2012-09-03 07:27:15', 'sa01'),
('20bc6ded-f528-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=123', '127.0.0.1', '2012-09-03 01:00:51', 'sa01'),
('226653cc-f57d-11e1-a0e7-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 11:09:19', 'sa01'),
('298b405b-f554-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=96|propinsiNama=aa', '127.0.0.1', '2012-09-03 06:16:04', 'sa01'),
('2e3b32b9-f83f-11e1-9460-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', NULL, '127.0.0.1', '2012-09-06 23:23:24', 'sa01'),
('310fe2b4-f527-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_DEPARTEMEN', 'departemenID=|departemenNama=asd', '127.0.0.1', '2012-09-03 00:54:09', ''),
('336e2fe8-f562-11e1-86a1-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=0|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 07:56:34', 'sa01'),
('39051a30-f554-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=97|propinsiNama=abcd', '127.0.0.1', '2012-09-03 06:16:30', 'sa01'),
('3c948e84-f57d-11e1-a0e7-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 11:10:03', 'sa01'),
('4490db7a-f527-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=231321', '127.0.0.1', '2012-09-03 00:54:42', 'admin'),
('57ae097f-f59c-11e1-aa1b-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=aaa', '127.0.0.1', '2012-09-03 14:52:43', 'sa01'),
('5c51788f-f59c-11e1-aa1b-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 14:52:51', 'sa01'),
('638c3281-d81e-11e1-9bee-5442495fad6a', 'INSERT', 'TREF_KATEGORI', 'kategoriID=K01|kategoriNama=Sedan', '127.0.0.1', '2012-07-28 02:08:02', 'sa01'),
('74eace12-f62f-11e1-9920-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', NULL, '127.0.0.1', '2012-09-04 08:25:48', 'sa01'),
('7982d653-f62f-11e1-9920-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-04 08:25:56', 'sa01'),
('79dbed2b-f59c-11e1-aa1b-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=aaaa', '127.0.0.1', '2012-09-03 14:53:40', 'sa01'),
('7de2d2b1-f59c-11e1-aa1b-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 14:53:47', 'sa01'),
('8692e80b-f52b-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=qwe', '127.0.0.1', '2012-09-03 01:25:11', 'sa01'),
('8afafb62-f555-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=98|propinsiNama=asd', '127.0.0.1', '2012-09-03 06:25:57', 'sa01'),
('9342061e-d824-11e1-9bee-5442495fad6a', 'INSERT', 'TREF_PROPINSI', 'propinsiID=K01|propinsiNama=Bali', '127.0.0.1', '2012-07-28 02:52:19', 'sa01'),
('9452be20-d8ae-11e1-99a8-5442495fad6a', 'INSERT', 'TREF_JABATAN', 'jabatanID=M01|jabatanNama=Office Boy', '127.0.0.1', '2012-07-28 19:20:12', 'sa01'),
('980d81a2-f527-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_DEPARTEMEN', 'departemenID=X|departemenNama=123', '127.0.0.1', '2012-09-03 00:57:02', 'sa01'),
('98c48277-d827-11e1-9bee-5442495fad6a', 'UPDATE', 'TREF_DEPARTEMEN', 'departemenID=2|departemenNama=Informasi dan Teknologi', '127.0.0.1', '2012-07-28 03:13:57', 'sa01'),
('99539e7f-d81d-11e1-9bee-5442495fad6a', 'INSERT', 'TREF_KATEGORI', 'kategoriID=K01|kategoriNama=Truk', '127.0.0.1', '2012-07-28 02:02:23', 'sa01'),
('9b63248d-f52d-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=100|propinsiNama=qweqwe', '127.0.0.1', '2012-09-03 01:40:04', 'sa01'),
('9edba2f1-d824-11e1-9bee-5442495fad6a', 'UPDATE', 'TREF_PROPINSI', 'propinsiID=P001|propinsiNama=Jakarta', '127.0.0.1', '2012-07-28 02:52:39', 'sa01'),
('a1062034-d81e-11e1-9bee-5442495fad6a', 'INSERT', 'TREF_KATEGORI', 'kategoriID=K03|kategoriNama=Mobil Box', '127.0.0.1', '2012-07-28 02:09:46', 'sa01'),
('a2f8c08f-f52a-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=ert', '127.0.0.1', '2012-09-03 01:18:49', 'sa01'),
('a32a260d-d824-11e1-9bee-5442495fad6a', 'DELETE', 'TREF_KATEGORI', 'propinsiID=K01|propinsiNama=Bali', '127.0.0.1', '2012-07-28 02:52:46', 'sa01'),
('a44bf1b5-f596-11e1-aa1b-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 14:11:54', 'sa01'),
('a455551e-f596-11e1-aa1b-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', NULL, '127.0.0.1', '2012-09-03 14:11:54', 'sa01'),
('a909c3e4-f595-11e1-aa1b-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 14:04:53', 'sa01'),
('a90e0b2a-f595-11e1-aa1b-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', NULL, '127.0.0.1', '2012-09-03 14:04:53', 'sa01'),
('abd28a7c-d756-11e1-b4f0-5442495fad6a', 'INSERT', 'TREF_MANUFAKTUR', 'manufakturID=M01|manufakturNama=Toyota', '127.0.0.1', '2012-07-27 02:18:25', 'sa01'),
('b05177f3-d756-11e1-b4f0-5442495fad6a', 'DELETE', 'TREF_MANUFAKTUR', 'manufakturID=M01|manufakturNama=Toyota', '127.0.0.1', '2012-07-27 02:18:32', 'sa01'),
('b5d78df3-d756-11e1-b4f0-5442495fad6a', 'INSERT', 'TREF_MANUFAKTUR', 'manufakturID=M01|manufakturNama=Toyota', '127.0.0.1', '2012-07-27 02:18:41', 'sa01'),
('b6591700-f596-11e1-aa1b-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 14:12:25', 'sa01'),
('b65d58dc-f596-11e1-aa1b-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', NULL, '127.0.0.1', '2012-09-03 14:12:25', 'sa01'),
('b84cdadd-d756-11e1-b4f0-5442495fad6a', 'DELETE', 'TREF_MANUFAKTUR', 'manufakturID=M01|manufakturNama=Toyota', '127.0.0.1', '2012-07-27 02:18:45', 'sa01'),
('c051b90b-f52a-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=96|propinsiNama=xcv', '127.0.0.1', '2012-09-03 01:19:38', 'sa01'),
('c0b840d9-f7a8-11e1-a394-f07bcbe0bf28', 'UPDATE', 'TREF_PROPINSI', NULL, '127.0.0.1', '2012-09-06 05:26:35', 'sa01'),
('c469acb0-f7a8-11e1-a394-f07bcbe0bf28', 'UPDATE', 'TREF_PROPINSI', NULL, '127.0.0.1', '2012-09-06 05:26:42', 'sa01'),
('c4ec09ae-d99e-11e1-bf13-5442495fad6a', 'INSERT', 'TREF_MANUFAKTUR', 'manufakturID=M04|manufakturNama=Mobil', '127.0.0.1', '2012-07-29 23:59:33', 'sa01'),
('c8c8e528-d827-11e1-9bee-5442495fad6a', 'INSERT', 'TREF_DEPARTEMEN', 'departemenID=M01|departemenNama=RnD', '127.0.0.1', '2012-07-28 03:15:18', 'sa01'),
('c9596993-d820-11e1-9bee-5442495fad6a', 'INSERT', 'TREF_MANUFAKTUR', 'manufakturID=M01|manufakturNama=Honda', '127.0.0.1', '2012-07-28 02:25:12', 'sa01'),
('ca2e3b75-f596-11e1-aa1b-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 14:12:58', 'sa01'),
('d10027e6-f52b-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=96|propinsiNama=asdasd', '127.0.0.1', '2012-09-03 01:27:15', 'sa01'),
('d94b00f3-f55f-11e1-86a1-f07bcbe0bf28', 'UPDATE', 'TREF_PROPINSI', 'propinsiID=|propinsiNama=', '127.0.0.1', '2012-09-03 07:39:44', 'sa01'),
('e01cefd6-f52c-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=97|propinsiNama=zzzz', '127.0.0.1', '2012-09-03 01:34:50', 'sa01'),
('e91ffbd8-f553-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=Aduh', '127.0.0.1', '2012-09-03 06:14:16', 'sa01'),
('e9a658d5-f870-11e1-9460-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-07 05:19:24', 'sa01'),
('eb8cf8b9-f52a-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=97|propinsiNama=cvb', '127.0.0.1', '2012-09-03 01:20:50', 'sa01'),
('ec95dbb3-f599-11e1-aa1b-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=aaaa', '127.0.0.1', '2012-09-03 14:35:24', 'sa01'),
('f0034690-f52c-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=98|propinsiNama=ccc', '127.0.0.1', '2012-09-03 01:35:17', 'sa01'),
('f0782fe0-f557-11e1-86a1-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=96|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 06:43:07', 'sa01'),
('f19e1e7a-f527-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_DEPARTEMEN', 'departemenID=ID|departemenNama=123', '127.0.0.1', '2012-09-03 00:59:32', 'sa01'),
('f1fba016-f599-11e1-aa1b-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 14:35:33', 'sa01'),
('f3a36db9-f557-11e1-86a1-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=97|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 06:43:12', 'sa01'),
('f47f3b66-d820-11e1-9bee-5442495fad6a', 'INSERT', 'TREF_MANUFAKTUR', 'manufakturID=M02|manufakturNama=Toyota', '127.0.0.1', '2012-07-28 02:26:25', 'sa01'),
('f7b62656-f52c-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=99|propinsiNama=sss', '127.0.0.1', '2012-09-03 01:35:30', 'sa01'),
('fd57a0e8-f557-11e1-86a1-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=98|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 06:43:28', 'sa01'),
('fe549894-d820-11e1-9bee-5442495fad6a', 'INSERT', 'TREF_MANUFAKTUR', 'manufakturID=M03|manufakturNama=Nissan', '127.0.0.1', '2012-07-28 02:26:41', 'sa01');

-- --------------------------------------------------------

--
-- Table structure for table `t_menjabat`
--

DROP TABLE IF EXISTS `t_menjabat`;
CREATE TABLE IF NOT EXISTS `t_menjabat` (
  `menjabatID` varchar(9) NOT NULL DEFAULT '',
  `periodeAwal` date DEFAULT NULL,
  `periodeAkhir` date DEFAULT NULL,
  `nip` varchar(9) NOT NULL DEFAULT '',
  `departemenID` varchar(5) DEFAULT NULL,
  `jabatanID` varchar(5) DEFAULT NULL,
  `periodeTahunAwal` varchar(5) DEFAULT NULL,
  `periodeTahunAkhir` varchar(5) DEFAULT NULL,
  `besarTHP` double DEFAULT NULL,
  `jenisGaji` enum('Perhari','Perbulan') DEFAULT NULL,
  PRIMARY KEY (`menjabatID`,`nip`),
  KEY `FK_t_menjabat_tref_karyawan` (`nip`),
  KEY `FK_t_menjabat_tref_departemen` (`departemenID`),
  KEY `FK_t_menjabat_tref_jabatan` (`jabatanID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `t_menjabat`
--

INSERT INTO `t_menjabat` (`menjabatID`, `periodeAwal`, `periodeAkhir`, `nip`, `departemenID`, `jabatanID`, `periodeTahunAwal`, `periodeTahunAkhir`, `besarTHP`, `jenisGaji`) VALUES
('JB0000107', '2012-07-28', '2015-07-28', '6304194', '2', '4', '2012', '2015', NULL, NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_instansi`
--
DROP VIEW IF EXISTS `view_instansi`;
CREATE TABLE IF NOT EXISTS `view_instansi` (
`instansiID` varchar(15)
,`instansiNama` varchar(75)
,`alamat` text
,`propinsiID` varchar(4)
,`propinsi` varchar(50)
,`kotaID` int(10)
,`kota` varchar(50)
,`kodePos` varchar(5)
,`nomorTelepon` varchar(30)
,`namaKontak` varchar(100)
,`jabatanKontak` varchar(50)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_karyawan`
--
DROP VIEW IF EXISTS `view_karyawan`;
CREATE TABLE IF NOT EXISTS `view_karyawan` (
`nip` varchar(9)
,`npwp` varchar(50)
,`noKTPSIM` varchar(150)
,`noJamsostek` varchar(150)
,`namaLengkap` varchar(150)
,`namaPanggilan` varchar(50)
,`tanggalLahir` date
,`tempatLahir` int(10)
,`kotaLahir` varchar(150)
,`gender` enum('L','P')
,`agama` enum('islam','protestan','katholik','hindu','budha','kepercayaan lain')
,`alamat` text
,`propinsiID` varchar(4)
,`kotaID` int(10)
,`propinsi` varchar(50)
,`kota` varchar(50)
,`kodePos` varchar(5)
,`nomortelepon` varchar(150)
,`email` varchar(150)
,`NoPKWT` varchar(150)
,`noKontrak` varchar(50)
,`noregistrasikaryawan` varchar(32)
,`tanggalmasuk` date
,`bankID` varchar(5)
,`namaBank` varchar(150)
,`cabangID` bigint(20)
,`namaCabang` varchar(150)
,`noRekening` varchar(100)
,`accRekening` varchar(150)
,`status` enum('N','Y')
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_kota`
--
DROP VIEW IF EXISTS `view_kota`;
CREATE TABLE IF NOT EXISTS `view_kota` (
`kotaID` int(10)
,`kotaNama` varchar(150)
,`propinsiNama` varchar(255)
,`propinsiID` varchar(4)
);
-- --------------------------------------------------------

--
-- Structure for view `view_instansi`
--
DROP TABLE IF EXISTS `view_instansi`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_instansi` AS select `tref_instansi`.`instansiID` AS `instansiID`,`tref_instansi`.`instansiNama` AS `instansiNama`,`tref_instansi`.`alamat` AS `alamat`,`tref_instansi`.`propinsiID` AS `propinsiID`,`fnPropinsiByID`(`tref_instansi`.`propinsiID`) AS `propinsi`,`tref_instansi`.`kotaID` AS `kotaID`,`fnKotaByID`(`tref_instansi`.`kotaID`,`tref_instansi`.`propinsiID`) AS `kota`,`tref_instansi`.`kodePos` AS `kodePos`,`tref_instansi`.`nomorTelepon` AS `nomorTelepon`,`tref_instansi`.`namaKontak` AS `namaKontak`,`tref_instansi`.`jabatanKontak` AS `jabatanKontak` from `tref_instansi`;

-- --------------------------------------------------------

--
-- Structure for view `view_karyawan`
--
DROP TABLE IF EXISTS `view_karyawan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_karyawan` AS select `tref_karyawan`.`nip` AS `nip`,`tref_karyawan`.`npwp` AS `npwp`,`tref_karyawan`.`noKTPSIM` AS `noKTPSIM`,`tref_karyawan`.`noJamsostek` AS `noJamsostek`,`tref_karyawan`.`namaLengkap` AS `namaLengkap`,`tref_karyawan`.`namaPanggilan` AS `namaPanggilan`,`tref_karyawan`.`tanggalLahir` AS `tanggalLahir`,`tref_karyawan`.`tempatLahir` AS `tempatLahir`,`fnCityByID`(`tref_karyawan`.`tempatLahir`) AS `kotaLahir`,`tref_karyawan`.`gender` AS `gender`,`tref_karyawan`.`agama` AS `agama`,`tref_karyawan`.`alamat` AS `alamat`,`tref_karyawan`.`propinsiID` AS `propinsiID`,`tref_karyawan`.`kotaID` AS `kotaID`,`fnPropinsiByID`(`tref_karyawan`.`propinsiID`) AS `propinsi`,`fnKotaByID`(`tref_karyawan`.`kotaID`,`tref_karyawan`.`propinsiID`) AS `kota`,`tref_karyawan`.`kodePos` AS `kodePos`,`tref_karyawan`.`nomortelepon` AS `nomortelepon`,`tref_karyawan`.`email` AS `email`,`tref_karyawan`.`NoPKWT` AS `NoPKWT`,`tref_karyawan`.`noKontrak` AS `noKontrak`,`tref_karyawan`.`noregistrasikaryawan` AS `noregistrasikaryawan`,`tref_karyawan`.`tanggalmasuk` AS `tanggalmasuk`,`tref_karyawan`.`bankID` AS `bankID`,`fnBankByID`(`tref_karyawan`.`bankID`) AS `namaBank`,`tref_karyawan`.`cabangID` AS `cabangID`,`fnCabangByIDBankIDCabang`(`tref_karyawan`.`bankID`,`tref_karyawan`.`cabangID`) AS `namaCabang`,`tref_karyawan`.`noRekening` AS `noRekening`,`tref_karyawan`.`accRekening` AS `accRekening`,`tref_karyawan`.`status` AS `status` from `tref_karyawan`;

-- --------------------------------------------------------

--
-- Structure for view `view_kota`
--
DROP TABLE IF EXISTS `view_kota`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_kota` AS select `tref_city`.`kotaID` AS `kotaID`,`tref_city`.`kotaNama` AS `kotaNama`,`tref_propinsi`.`propinsiNama` AS `propinsiNama`,`tref_propinsi`.`propinsiID` AS `propinsiID` from (`tref_city` join `tref_propinsi` on((`tref_city`.`propinsiID` = `tref_propinsi`.`propinsiID`)));

--
-- Constraints for dumped tables
--

--
-- Constraints for table `conf_menu`
--
ALTER TABLE `conf_menu`
  ADD CONSTRAINT `FK_conf_menu_conf_submodul` FOREIGN KEY (`submodulID`) REFERENCES `conf_submodul` (`submodulID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `conf_submodul`
--
ALTER TABLE `conf_submodul`
  ADD CONSTRAINT `conf_submodul_ibfk_1` FOREIGN KEY (`modulID`) REFERENCES `conf_modul` (`modulID`) ON UPDATE CASCADE;

--
-- Constraints for table `tref_bank_cabang`
--
ALTER TABLE `tref_bank_cabang`
  ADD CONSTRAINT `tref_bank_cabang_ibfk_1` FOREIGN KEY (`bankID`) REFERENCES `tref_bank` (`bankID`) ON UPDATE CASCADE;

--
-- Constraints for table `tref_instansi`
--
ALTER TABLE `tref_instansi`
  ADD CONSTRAINT `FK_tref_instansi_tref_city` FOREIGN KEY (`kotaID`) REFERENCES `tref_city` (`kotaID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tref_instansi_ibfk_1` FOREIGN KEY (`propinsiID`) REFERENCES `tref_propinsi` (`propinsiID`) ON UPDATE CASCADE;

--
-- Constraints for table `tref_karyawan`
--
ALTER TABLE `tref_karyawan`
  ADD CONSTRAINT `FK_tref_karyawan_tref_bank` FOREIGN KEY (`bankID`) REFERENCES `tref_bank` (`bankID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_tref_karyawan_tref_city` FOREIGN KEY (`kotaID`) REFERENCES `tref_city` (`kotaID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_tref_karyawan_tref_city_2` FOREIGN KEY (`tempatLahir`) REFERENCES `tref_city` (`kotaID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tref_karyawan_ibfk_1` FOREIGN KEY (`propinsiID`) REFERENCES `tref_propinsi` (`propinsiID`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tref_karyawan_ibfk_2` FOREIGN KEY (`cabangID`) REFERENCES `tref_bank_cabang` (`cabangID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `tref_user`
--
ALTER TABLE `tref_user`
  ADD CONSTRAINT `FK_tref_user_tref_leveluser` FOREIGN KEY (`levelID`) REFERENCES `tref_leveluser` (`levelID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tref_user_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `tref_karyawan` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `t_hakakses`
--
ALTER TABLE `t_hakakses`
  ADD CONSTRAINT `FK_t_hakakses_tref_user` FOREIGN KEY (`username`) REFERENCES `tref_user` (`username`) ON UPDATE CASCADE,
  ADD CONSTRAINT `t_hakakses_ibfk_1` FOREIGN KEY (`modulID`) REFERENCES `conf_modul` (`modulID`) ON UPDATE CASCADE;

--
-- Constraints for table `t_menjabat`
--
ALTER TABLE `t_menjabat`
  ADD CONSTRAINT `FK_t_menjabat_tref_departemen` FOREIGN KEY (`departemenID`) REFERENCES `tref_departemen` (`departemenID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_t_menjabat_tref_jabatan` FOREIGN KEY (`jabatanID`) REFERENCES `tref_jabatan` (`jabatanID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_t_menjabat_tref_karyawan` FOREIGN KEY (`nip`) REFERENCES `tref_karyawan` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
