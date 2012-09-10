/*
Navicat MySQL Data Transfer

Source Server         : MYSQL - Localhost
Source Server Version : 50525
Source Host           : localhost:3306
Source Database       : db_opm

Target Server Type    : MYSQL
Target Server Version : 50525
File Encoding         : 65001

Date: 2012-09-10 08:44:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `ci_sessions`
-- ----------------------------
DROP TABLE IF EXISTS `ci_sessions`;
CREATE TABLE `ci_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `last_activity_idx` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ci_sessions
-- ----------------------------
INSERT INTO `ci_sessions` VALUES ('cb54964f79dc68856d70381a5bfbbdfb', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20100101 Firefox/15.0.1 FirePHP/0.7.1', '1347228019', 'a:10:{s:9:\"user_data\";s:0:\"\";s:7:\"levelID\";s:1:\"1\";s:3:\"nip\";s:7:\"6304194\";s:8:\"username\";s:4:\"sa01\";s:8:\"password\";s:32:\"cad06946b642c2597817d939d31e1715\";s:9:\"levelName\";s:32:\"6fb73e8a536739deba2f642ebfc4282c\";s:6:\"userID\";s:8:\"UID00001\";s:11:\"namalengkap\";s:8:\"Suhendra\";s:13:\"namapanggilan\";s:6:\"hendra\";s:9:\"setmodule\";s:15:\"human_resources\";}');

-- ----------------------------
-- Table structure for `conf_menu`
-- ----------------------------
DROP TABLE IF EXISTS `conf_menu`;
CREATE TABLE `conf_menu` (
  `menuID` int(10) NOT NULL AUTO_INCREMENT,
  `submodulID` int(10) NOT NULL DEFAULT '0',
  `menuNama` varchar(50) DEFAULT '0',
  `controller` varchar(50) DEFAULT '0',
  `function` varchar(50) DEFAULT '0',
  `is_aktif` enum('Y','N') DEFAULT 'Y',
  PRIMARY KEY (`menuID`,`submodulID`),
  KEY `submodulID` (`submodulID`),
  CONSTRAINT `FK_conf_menu_conf_submodul` FOREIGN KEY (`submodulID`) REFERENCES `conf_submodul` (`submodulID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of conf_menu
-- ----------------------------
INSERT INTO `conf_menu` VALUES ('1', '1', 'Provinsi', 'provinsi', '0', 'Y');
INSERT INTO `conf_menu` VALUES ('2', '1', 'Kota', 'kota', '0', 'Y');
INSERT INTO `conf_menu` VALUES ('3', '1', 'Bank', 'bank', '0', 'Y');
INSERT INTO `conf_menu` VALUES ('4', '2', 'Departmen', 'department', '0', 'Y');
INSERT INTO `conf_menu` VALUES ('5', '2', 'Jabatan', 'jabatan', '0', 'Y');
INSERT INTO `conf_menu` VALUES ('6', '1', 'Instansi', 'instansi', '0', 'Y');
INSERT INTO `conf_menu` VALUES ('7', '3', 'Karyawan', 'karyawan', '0', 'Y');
INSERT INTO `conf_menu` VALUES ('8', '3', 'Penempatan', 'penempatan', '0', 'Y');

-- ----------------------------
-- Table structure for `conf_modul`
-- ----------------------------
DROP TABLE IF EXISTS `conf_modul`;
CREATE TABLE `conf_modul` (
  `modulID` varchar(10) NOT NULL,
  `modulNama` varchar(50) NOT NULL DEFAULT '0',
  `modulPage_Form_Controller` varchar(150) NOT NULL DEFAULT '0',
  `picture` varchar(150) DEFAULT NULL,
  `link` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`modulID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Contoh, Modul Master, Transaksi Booking, Pengadaan Barang, Penjualan, Pembelian';

-- ----------------------------
-- Records of conf_modul
-- ----------------------------
INSERT INTO `conf_modul` VALUES ('1', 'Reference', 'references', 'config.png', 'konfigurasi');
INSERT INTO `conf_modul` VALUES ('2', 'Project Management', 'project_management', 'calendar.png', null);
INSERT INTO `conf_modul` VALUES ('3', 'Human Resource', 'human_resources', 'hire-me.png', null);

-- ----------------------------
-- Table structure for `conf_submodul`
-- ----------------------------
DROP TABLE IF EXISTS `conf_submodul`;
CREATE TABLE `conf_submodul` (
  `submodulID` int(10) NOT NULL AUTO_INCREMENT,
  `modulID` varchar(10) NOT NULL DEFAULT '0',
  `submodulNama` varchar(150) DEFAULT NULL,
  `submodulPage_Form_Controller` varchar(150) DEFAULT NULL,
  `is_aktif` enum('N','Y') DEFAULT 'Y',
  `label` varchar(150) DEFAULT 'Y',
  PRIMARY KEY (`submodulID`),
  KEY `modulID` (`modulID`),
  CONSTRAINT `conf_submodul_ibfk_1` FOREIGN KEY (`modulID`) REFERENCES `conf_modul` (`modulID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COMMENT='Contoh : Master Kendaraan, master Manufaktur (table yang bersifat stand-alone';

-- ----------------------------
-- Records of conf_submodul
-- ----------------------------
INSERT INTO `conf_submodul` VALUES ('1', '1', 'Master Pendukung', 'Trefmanufaktur', 'Y', 'Y');
INSERT INTO `conf_submodul` VALUES ('2', '3', 'Master Pendukung', 'Trefmodel', 'Y', 'Y');
INSERT INTO `conf_submodul` VALUES ('3', '3', 'Kepegawaian', 'Trefkategori', 'Y', 'Y');
INSERT INTO `conf_submodul` VALUES ('4', '1', 'Propinsi', 'Trefpropinsi', 'Y', 'Y');
INSERT INTO `conf_submodul` VALUES ('5', '1', 'Departemen', 'Trefdepartemen', 'Y', 'Y');
INSERT INTO `conf_submodul` VALUES ('6', '1', 'Jabatan', 'Trefjabatan', 'Y', 'Y');
INSERT INTO `conf_submodul` VALUES ('7', '1', 'Kota', 'Trefkota', 'N', 'Y');

-- ----------------------------
-- Table structure for `tref_bank`
-- ----------------------------
DROP TABLE IF EXISTS `tref_bank`;
CREATE TABLE `tref_bank` (
  `bankID` varchar(5) NOT NULL DEFAULT '',
  `bankName` varchar(150) DEFAULT NULL,
  `bankFullName` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`bankID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tref_bank
-- ----------------------------
INSERT INTO `tref_bank` VALUES ('10002', 'BNI (Persero) Tbk.', 'PT Bank Negara Indonesia (Persero) Tbk');
INSERT INTO `tref_bank` VALUES ('10003', 'Bank Rakyat Indonesia (Persero) Tbk.', 'PT Bank Rakyat Indonesia (Persero) Tbk.');
INSERT INTO `tref_bank` VALUES ('10004', 'Bank Tabungan Negara (Persero)', 'PT Bank Tabungan Negara (Persero) Tbk.');
INSERT INTO `tref_bank` VALUES ('10005', 'Bank Bengkulu', 'PT Bank Pembangunan Daerah Bengkulu');
INSERT INTO `tref_bank` VALUES ('10006', 'Bank BPD Bali', 'PT Bank Pembangunan Daerah Bali');
INSERT INTO `tref_bank` VALUES ('10007', 'Bank Jabar Banten', 'PT Bank Jabar Banten');
INSERT INTO `tref_bank` VALUES ('10008', 'Bank Jambi', 'PT Bank Jambi');
INSERT INTO `tref_bank` VALUES ('10009', 'Bank Lampung', 'PT Bank Lampung');
INSERT INTO `tref_bank` VALUES ('10010', 'Bank Maluku', 'PT Bank Maluku');
INSERT INTO `tref_bank` VALUES ('10011', 'Bank Nusa Tenggara Timur', 'PT Bank Nusa Tenggara Timur');
INSERT INTO `tref_bank` VALUES ('10012', 'Bank Kalimantan Tengah', 'PT Bank Pembangunan Daerah Kalimantan Tengah');
INSERT INTO `tref_bank` VALUES ('10013', 'Bank Papua', 'PT Bank Papua');
INSERT INTO `tref_bank` VALUES ('10014', 'Bank Sulawesi Tenggara', 'PD Bank Pembangunan Daerah Sulawesi Tenggara');
INSERT INTO `tref_bank` VALUES ('10015', 'Bank Sulawesi Tengah', 'PT Bank Pembangunan Daerah Sulawesi Tengah');
INSERT INTO `tref_bank` VALUES ('10016', 'Bank Aceh', 'PT Bank BPD Aceh');
INSERT INTO `tref_bank` VALUES ('10017', 'Bank Daerah Istimewa Yogyakarta', 'PD Bank Pembangunan Daerah Istimewa Yogyakarta');
INSERT INTO `tref_bank` VALUES ('10018', 'Bank DKI', 'PT Bank DKI');
INSERT INTO `tref_bank` VALUES ('10019', 'Bank Jawa Tengah', 'PT Bank Pembangunan Daerah Jawa Tengah');
INSERT INTO `tref_bank` VALUES ('10020', 'Bank Jawa Timur', 'PT Bank Pembangunan Daerah Jawa Timur');
INSERT INTO `tref_bank` VALUES ('10021', 'Bank Nagari', 'PT Bank Nagari');
INSERT INTO `tref_bank` VALUES ('10022', 'Bank Nusa Tenggara Barat', 'PT Bank Nusa Tenggara Barat');
INSERT INTO `tref_bank` VALUES ('10023', 'Bank Kalimantan Barat', 'PT Bank Pembangunan Daerah Kalimantan Barat');
INSERT INTO `tref_bank` VALUES ('10024', 'Bank Kalimantan Selatan', 'PD Bank Pembangunan Daerah Kalimantan Selatan');
INSERT INTO `tref_bank` VALUES ('10025', 'Bank Kalimantan Timur', 'PD Bank Pembangunan Daerah Kalimantan Timur');
INSERT INTO `tref_bank` VALUES ('10026', 'Bank Riau dan Kepri', 'PT Bank BPD Riau');
INSERT INTO `tref_bank` VALUES ('10027', 'Bank Sulawesi Selatan', 'PT Bank Pembangunan Daerah Sulawesi Selatan dan Sulawesi Barat');
INSERT INTO `tref_bank` VALUES ('10028', 'Bank Sulawesi Utara', 'PT Bank Pembangunan Daerah Sulawesi Utara');
INSERT INTO `tref_bank` VALUES ('10029', 'Bank Sumatera Selatan dan Bangka Belitung', 'PT Bank Pembangunan Daerah Sumatera Selatan');
INSERT INTO `tref_bank` VALUES ('10030', 'Bank Sumatera Utara', 'PT Bank Pembangunan Daerah Sumatera Utara');
INSERT INTO `tref_bank` VALUES ('10031', 'Anglomas International Bank', 'PT Anglomas International Bank');
INSERT INTO `tref_bank` VALUES ('10032', 'ANZ Panin Bank', 'PT ANZ Panin Bank');
INSERT INTO `tref_bank` VALUES ('10033', 'Bank Agris', 'PT Bank Agris');
INSERT INTO `tref_bank` VALUES ('10034', 'Bank Agroniaga Tbk.', 'PT Bank Agroniaga Tbk.');
INSERT INTO `tref_bank` VALUES ('10035', 'Bank Andara', 'PT Bank Andara');
INSERT INTO `tref_bank` VALUES ('10036', 'Bank Antar Daerah', 'PT Bank Antar Daerah');
INSERT INTO `tref_bank` VALUES ('10037', 'Bank Artha Graha', 'PT Bank Artha Graha Internasional Tbk.');
INSERT INTO `tref_bank` VALUES ('10038', 'Bank Artos Indonesia', 'PT Bank Artos Indonesia');
INSERT INTO `tref_bank` VALUES ('10039', 'Bank Bisnis Internasional', 'PT Bank Bisnis Internasional');
INSERT INTO `tref_bank` VALUES ('10040', 'Bank BNP Paribas Indonesia', 'PT Bank BNP Paribas Indonesia');
INSERT INTO `tref_bank` VALUES ('10041', 'Bank Bukopin', 'PT Bank Bukopin');
INSERT INTO `tref_bank` VALUES ('10042', 'Bank Bumi Arta', 'PT Bank Bumi Arta Tbk.');
INSERT INTO `tref_bank` VALUES ('10043', 'Bank Capital Indonesia, Tbk.', 'PT Bank Capital Indonesia, Tbk.');
INSERT INTO `tref_bank` VALUES ('10044', 'Bank Central Asia Tbk.', 'PT Bank Central Asia Tbk.');
INSERT INTO `tref_bank` VALUES ('10045', 'Bank China Trust Indonesia', 'PT Bank ChinaTrust Indonesia');
INSERT INTO `tref_bank` VALUES ('10046', 'Bank Commonwealth', 'PT Bank Commonwealth');
INSERT INTO `tref_bank` VALUES ('10047', 'Bank DBS Indonesia', 'PT Bank DBS Indonesia');
INSERT INTO `tref_bank` VALUES ('10048', 'Bank Dipo Internasional', 'PT Bank Dipo Internasional');
INSERT INTO `tref_bank` VALUES ('10049', 'Bank Ekonomi Raharja', 'PT Bank Ekonomi Raharja Tbk.');
INSERT INTO `tref_bank` VALUES ('10050', 'Bank Fama Internasional', 'PT Bank Fama Internasional');
INSERT INTO `tref_bank` VALUES ('10051', 'Bank Ganesha', 'PT Bank Ganesha');
INSERT INTO `tref_bank` VALUES ('10052', 'Bank Hana', 'PT Bank Hana');
INSERT INTO `tref_bank` VALUES ('10053', 'Bank Harda Internasional', 'PT Bank Harda Internasional');
INSERT INTO `tref_bank` VALUES ('10054', 'Bank ICB Bumiputera, Tbk.', 'PT Bank ICB Bumiputera, Tbk.');
INSERT INTO `tref_bank` VALUES ('10055', 'Bank INA Perdana', 'PT Bank INA Perdana');
INSERT INTO `tref_bank` VALUES ('10056', 'Bank Index Selindo', 'PT Bank Index Selindo');
INSERT INTO `tref_bank` VALUES ('10057', 'Bank Jasa Jakarta', 'PT Bank Jasa Jakarta');
INSERT INTO `tref_bank` VALUES ('10058', 'Bank KEB Indonesia', 'PT Bank KEB Indonesia');
INSERT INTO `tref_bank` VALUES ('10059', 'Bank Kesawan', 'PT Bank Kesawan');
INSERT INTO `tref_bank` VALUES ('10060', 'Bank Kesejahteraan Ekonomi', 'PT Bank Kesejahteraan Ekonomi');
INSERT INTO `tref_bank` VALUES ('10061', 'Bank Liman International', 'PT Bank Liman International');
INSERT INTO `tref_bank` VALUES ('10062', 'Bank Maspion Indonesia', 'PT Bank Maspion Indonesia');
INSERT INTO `tref_bank` VALUES ('10063', 'Bank Mayapada Internasional', 'PT Bank Mayapada Internasional Tbk.');
INSERT INTO `tref_bank` VALUES ('10064', 'Bank Mayora', 'PT Bank Mayora');
INSERT INTO `tref_bank` VALUES ('10065', 'Bank Mega Tbk.', 'PT Bank Mega Tbk.');
INSERT INTO `tref_bank` VALUES ('10066', 'Bank Mestika Dharma', 'PT Bank Mestika Dharma Tbk.');
INSERT INTO `tref_bank` VALUES ('10067', 'Bank Metro Express', 'PT Bank Metro Express');
INSERT INTO `tref_bank` VALUES ('10068', 'Bank Mitraniaga', 'PT Bank Mitraniaga');
INSERT INTO `tref_bank` VALUES ('10069', 'Bank Mizuho Indonesia', 'PT Bank Mizuho Indonesia');
INSERT INTO `tref_bank` VALUES ('10070', 'Bank Multiarta Sentosa', 'PT Bank Multiarta Sentosa');
INSERT INTO `tref_bank` VALUES ('10071', 'Bank Mutiara', 'PT Bank Mutiara Tbk.');
INSERT INTO `tref_bank` VALUES ('10072', 'Bank Nationalnobu', 'PT Bank Nationalnobu');
INSERT INTO `tref_bank` VALUES ('10073', 'Bank Nusantara Parahyangan', 'PT Bank Nusantara Parahyangan Tbk.');
INSERT INTO `tref_bank` VALUES ('10074', 'Bank OCBC NISP', 'PT Bank OCBC NISP Tbk.');
INSERT INTO `tref_bank` VALUES ('10075', 'Bank Panin Tbk.', 'PT Bank Panin Tbk.');
INSERT INTO `tref_bank` VALUES ('10076', 'Bank Pundi Indonesia Tbk.', 'PT Bank Pundi');
INSERT INTO `tref_bank` VALUES ('10077', 'Bank Resona Perdania', 'PT Bank Resona Perdania');
INSERT INTO `tref_bank` VALUES ('10078', 'Bank Royal Indonesia', 'PT Bank Royal Indonesia');
INSERT INTO `tref_bank` VALUES ('10079', 'Bank Sahabat Purba Danarta', 'PT Bank Sahabat Purba Danarta');
INSERT INTO `tref_bank` VALUES ('10080', 'Bank Saudara', 'PT Bank Saudara');
INSERT INTO `tref_bank` VALUES ('10081', 'Bank SBI Indonesia', 'PT Bank SBI Indonesia');
INSERT INTO `tref_bank` VALUES ('10082', 'Bank Sinar Harapan Bali', 'PT Bank Sinar Harapan Bali');
INSERT INTO `tref_bank` VALUES ('10083', 'Bank Sumitomo Mitsui Indoneasia', 'PT Bank Sumitomo Mitsui Indoneasia');
INSERT INTO `tref_bank` VALUES ('10084', 'Bank Swadesi Tbk.', 'PT Bank Swadesi Tbk.');
INSERT INTO `tref_bank` VALUES ('10085', 'Bank UOB Indonesia Tbk.', 'PT Bank UOB Indonesia Tbk.');
INSERT INTO `tref_bank` VALUES ('10086', 'Bank Victoria Internasional Tbk', 'PT Bank Victoria Internasional Tbk');
INSERT INTO `tref_bank` VALUES ('10087', 'Bank Windu Kentjana International Tbk.', 'PT Bank Windu Kentjana International Tbk.');
INSERT INTO `tref_bank` VALUES ('10088', 'Bank Woori Indonesia', 'PT Bank Woori Indonesia');
INSERT INTO `tref_bank` VALUES ('10089', 'Bank Yudha Bakti', 'PT Bank Yudha Bakti');
INSERT INTO `tref_bank` VALUES ('10090', 'Centratama Nasional Bank', 'PT Centratama Nasional Bank');
INSERT INTO `tref_bank` VALUES ('10091', 'Prima Master Bank', 'Prima Master Bank');
INSERT INTO `tref_bank` VALUES ('10092', 'Rabobank Internasional', 'PT Bank Rabobank Internasional Indonesia');
INSERT INTO `tref_bank` VALUES ('10093', 'Bank CIMB Niaga Tbk.', 'PT Bank CIMB Niaga Tbk.');
INSERT INTO `tref_bank` VALUES ('10094', 'Bank Danamon Indonesia Tbk.', 'PT Bank Danamon Indonesia Tbk.');
INSERT INTO `tref_bank` VALUES ('10095', 'Bank ICBC Indonesia', 'PT Bank ICBC Indonesia');
INSERT INTO `tref_bank` VALUES ('10096', 'Bank Internasional Indonesia Tbk.', 'PT Bank Internasional Indonesia Tbk.');
INSERT INTO `tref_bank` VALUES ('10097', 'Bank Permata Tbk.', 'PT Bank Permata Tbk.');
INSERT INTO `tref_bank` VALUES ('10098', 'Bank Sinarmas', 'PT Bank Sinarmas');
INSERT INTO `tref_bank` VALUES ('10099', 'Bank Tabungan Pensiunan Nasional', 'PT Bank Tabungan Pensiunan Nasional');
INSERT INTO `tref_bank` VALUES ('101', 'BKK Grabag', '');
INSERT INTO `tref_bank` VALUES ('10100', 'Bank Muamalat Indonesia', 'PT Bank Syariah Muamalat Indonesia Tbk.');
INSERT INTO `tref_bank` VALUES ('10101', 'Bank Syariah BCA', 'PT Bank BCA Syariah');
INSERT INTO `tref_bank` VALUES ('10102', 'Bank Syariah BNI', 'PT Bank BNI Syariah');
INSERT INTO `tref_bank` VALUES ('10103', 'Bank Syariah BRI', 'PT Bank BRI Syariah');
INSERT INTO `tref_bank` VALUES ('10104', 'Bank Syariah Bukopin', 'PT Bank Syariah Bukopin');
INSERT INTO `tref_bank` VALUES ('10105', 'Bank Syariah Jabar Banten', 'PT Bank Jabar Banten Syariah');
INSERT INTO `tref_bank` VALUES ('10106', 'Bank Syariah Mandiri', 'PT Bank Syariah Mandiri');
INSERT INTO `tref_bank` VALUES ('10107', 'Bank Syariah Maybank', 'PT Bank Maybank Syariah Indonesia');
INSERT INTO `tref_bank` VALUES ('10108', 'Bank Syariah Mega Indonesia', 'PT Bank Syariah Mega Indonesia');
INSERT INTO `tref_bank` VALUES ('10109', 'Bank Syariah Panin', 'PT Bank Panin Syariah');
INSERT INTO `tref_bank` VALUES ('10110', 'Bank Syariah Victoria', 'PT Bank Victoria Syariah');
INSERT INTO `tref_bank` VALUES ('10111', 'The Royal Bank Of Scotland N.V', 'The Royal Bank Of Scotland N.V');
INSERT INTO `tref_bank` VALUES ('10112', 'Bangkok Bank Public Company Limited', 'The Bangkok Bank Public Company Limited');
INSERT INTO `tref_bank` VALUES ('10113', 'Bank Of America, N.A', 'Bank Of America, National Association');
INSERT INTO `tref_bank` VALUES ('10114', 'Bank Of China Limited', 'Bank Of China Limited');
INSERT INTO `tref_bank` VALUES ('10115', 'Citibank N.A.', 'Citibank N.A.');
INSERT INTO `tref_bank` VALUES ('10116', 'Deutsche Bank AG.', 'Deutsche Bank AG.');
INSERT INTO `tref_bank` VALUES ('10117', 'JP. Morgan Chase Bank N.A.', 'JP. Morgan Chase Bank National Association');
INSERT INTO `tref_bank` VALUES ('10118', 'Standard Chartered Bank', 'Standard Chartered Bank');
INSERT INTO `tref_bank` VALUES ('10119', 'The Bank Of Tokyo - Mitsubishi UFJ, Ltd.', 'The Bank Of Tokyo - Mitsubishi UFJ, Ltd.');
INSERT INTO `tref_bank` VALUES ('10120', 'The Hongkong & Shanghai B.C', 'The Hongkong & Shanghai Banking Corporation Limited');
INSERT INTO `tref_bank` VALUES ('102', 'LKP Rasabou', '');
INSERT INTO `tref_bank` VALUES ('103', 'BKK Gabus - Grobogan', '');
INSERT INTO `tref_bank` VALUES ('104', 'BKK Gabus - Pati', '');
INSERT INTO `tref_bank` VALUES ('105', 'Cicadas (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', '');
INSERT INTO `tref_bank` VALUES ('106', 'Kec. Pagaden', '');
INSERT INTO `tref_bank` VALUES ('107', 'BKK Baturraden', '');
INSERT INTO `tref_bank` VALUES ('108', 'BKK Kragan', '');
INSERT INTO `tref_bank` VALUES ('109', 'Mustaqim Seunagan', '');
INSERT INTO `tref_bank` VALUES ('110', 'BKK Kalibagor', '');
INSERT INTO `tref_bank` VALUES ('111', 'BKK Petanahan', '');
INSERT INTO `tref_bank` VALUES ('11106', 'Bank Tests', 'Pt Bank Tests');
INSERT INTO `tref_bank` VALUES ('112', 'BKK Gajah', '');
INSERT INTO `tref_bank` VALUES ('113', 'BKK Kejajar', '');
INSERT INTO `tref_bank` VALUES ('114', 'Kec. Batujajar (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', '');
INSERT INTO `tref_bank` VALUES ('115', 'BKK Parakan', '');
INSERT INTO `tref_bank` VALUES ('116', 'Swadharma Pakem', '');
INSERT INTO `tref_bank` VALUES ('117', 'BKK Jaken', '');
INSERT INTO `tref_bank` VALUES ('118', 'Rakit', '');
INSERT INTO `tref_bank` VALUES ('119', 'Bank Barclays Indonesia', '');
INSERT INTO `tref_bank` VALUES ('120', 'BKK Wedarijaksa', '');
INSERT INTO `tref_bank` VALUES ('121', 'Tunas Artha Jaya Abadi', '');
INSERT INTO `tref_bank` VALUES ('122', 'Ngadiluwih Sakti', '');
INSERT INTO `tref_bank` VALUES ('123', 'Kec. Cisalak', '');
INSERT INTO `tref_bank` VALUES ('124', 'BKK Salam', '');
INSERT INTO `tref_bank` VALUES ('125', 'BKK Wonosalam', '');
INSERT INTO `tref_bank` VALUES ('126', 'Babussalam', '');
INSERT INTO `tref_bank` VALUES ('127', 'LKP Dalam  Alas (Merger ke NTB Sumbawa Tgl 6 Nov 2009)', '');
INSERT INTO `tref_bank` VALUES ('128', 'Mustaqim Lawe Alas (alamat surat menyurat ke Mustaqim Blangkejeren)', '');
INSERT INTO `tref_bank` VALUES ('129', 'BKPD Rajagaluh', '');
INSERT INTO `tref_bank` VALUES ('130', 'Artha Nusa Graha', '');
INSERT INTO `tref_bank` VALUES ('131', 'BKK Kramat', '');
INSERT INTO `tref_bank` VALUES ('132', 'BKK Bulakamba', '');
INSERT INTO `tref_bank` VALUES ('133', 'BKK Kalijambe', '');
INSERT INTO `tref_bank` VALUES ('134', 'Sambi BKK', '');
INSERT INTO `tref_bank` VALUES ('135', 'BKK Klambu', '');
INSERT INTO `tref_bank` VALUES ('136', 'American Express Bank Ltd.', '');
INSERT INTO `tref_bank` VALUES ('137', 'BKK Ulujami', '');
INSERT INTO `tref_bank` VALUES ('138', 'Kalimanah', '');
INSERT INTO `tref_bank` VALUES ('139', 'Anugerah Bintang Sejahtera', 'PT BPR Anugerah Bintang Sejahtera');
INSERT INTO `tref_bank` VALUES ('140', 'Masaran Mitra Anda', '');
INSERT INTO `tref_bank` VALUES ('141', 'LPK Sukamandi', '');
INSERT INTO `tref_bank` VALUES ('142', 'BKK Pucakwangi', '');
INSERT INTO `tref_bank` VALUES ('143', 'Juwangi BKK', '');
INSERT INTO `tref_bank` VALUES ('144', 'Garawangi', '');
INSERT INTO `tref_bank` VALUES ('145', 'Lebakwangi', '');
INSERT INTO `tref_bank` VALUES ('146', 'BKK Banjarmangu', '');
INSERT INTO `tref_bank` VALUES ('147', 'Gandrungmangu', '');
INSERT INTO `tref_bank` VALUES ('148', 'Tawangmangu BKK', '');
INSERT INTO `tref_bank` VALUES ('149', 'Bank Arta Niaga Kencana (Merger ke Bank Commonwealth tgl 10/12/2007)', '');
INSERT INTO `tref_bank` VALUES ('150', 'Mataram Banguntapan', '');
INSERT INTO `tref_bank` VALUES ('151', 'BKK Tembarak', '');
INSERT INTO `tref_bank` VALUES ('152', 'Kec. Pabuaran', '');
INSERT INTO `tref_bank` VALUES ('153', 'BKK Kembaran', '');
INSERT INTO `tref_bank` VALUES ('154', 'Pejawaran', '');
INSERT INTO `tref_bank` VALUES ('155', 'LPK Pabuaran', '');
INSERT INTO `tref_bank` VALUES ('156', 'BKK Masaran', '');
INSERT INTO `tref_bank` VALUES ('157', 'Mitra Banjaran', '');
INSERT INTO `tref_bank` VALUES ('158', 'Banjaran (Merger ke Kabupaten Bandung Tgl 15/12/2009)', '');
INSERT INTO `tref_bank` VALUES ('159', 'BKK Purwokerto Barat', '');
INSERT INTO `tref_bank` VALUES ('160', 'Kecamatan Ciparay (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', '');
INSERT INTO `tref_bank` VALUES ('161', 'Sidomulyo Sarana Raharja', '');
INSERT INTO `tref_bank` VALUES ('162', 'BKK Tawangharjo', '');
INSERT INTO `tref_bank` VALUES ('163', 'BKK Sidoharjo', '');
INSERT INTO `tref_bank` VALUES ('164', 'Singaparna', '');
INSERT INTO `tref_bank` VALUES ('165', 'BKPD Singaparna', '');
INSERT INTO `tref_bank` VALUES ('166', 'Batuwarno BKK', '');
INSERT INTO `tref_bank` VALUES ('167', 'Kedungwuni Arta', '');
INSERT INTO `tref_bank` VALUES ('168', 'Langgeng Sewuarta', '');
INSERT INTO `tref_bank` VALUES ('169', 'Pundi Artha Sejahtera', '');
INSERT INTO `tref_bank` VALUES ('170', 'Taruna Mitra Danarta', '');
INSERT INTO `tref_bank` VALUES ('171', 'Prismamutiara Danarta', '');
INSERT INTO `tref_bank` VALUES ('172', 'Girimarto', '');
INSERT INTO `tref_bank` VALUES ('173', 'BKK Kuwarasan', '');
INSERT INTO `tref_bank` VALUES ('174', 'Kec. Paseh (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', '');
INSERT INTO `tref_bank` VALUES ('175', 'Kecamatan Ciasem', '');
INSERT INTO `tref_bank` VALUES ('176', 'BKK Kebasen', '');
INSERT INTO `tref_bank` VALUES ('177', 'Mataram Kasih', '');
INSERT INTO `tref_bank` VALUES ('178', 'Samudra Air Tawar', '');
INSERT INTO `tref_bank` VALUES ('179', 'BKK Magelang Selatan', '');
INSERT INTO `tref_bank` VALUES ('180', 'Daha Selatan (merger ke Kandangan 3 Maret 2009)', '');
INSERT INTO `tref_bank` VALUES ('181', 'Salimpaung Sepakat', '');
INSERT INTO `tref_bank` VALUES ('182', 'LKP Empang Atas (merger ke NTB Sumbawa Tgl 6 Nov 2009)', '');
INSERT INTO `tref_bank` VALUES ('183', 'Mustaqim Kuala Batee', '');
INSERT INTO `tref_bank` VALUES ('184', 'Jaten BKK', '');
INSERT INTO `tref_bank` VALUES ('185', 'BKPD Kadipaten', '');
INSERT INTO `tref_bank` VALUES ('186', 'Artha Galunggung', 'PD BPR Artha Galunggung');
INSERT INTO `tref_bank` VALUES ('187', 'Artha Mitra Niaga', 'PT BPR Artha Mitra Niaga');
INSERT INTO `tref_bank` VALUES ('188', 'Tolutug Naton', '');
INSERT INTO `tref_bank` VALUES ('189', 'Artha Sukapura', 'PD BPR Artha Sukapura');
INSERT INTO `tref_bank` VALUES ('190', 'Junjung Sirih', '');
INSERT INTO `tref_bank` VALUES ('191', 'BKK Karangawen', '');
INSERT INTO `tref_bank` VALUES ('192', 'Sawit  BKK', '');
INSERT INTO `tref_bank` VALUES ('193', 'BKK Ayah', '');
INSERT INTO `tref_bank` VALUES ('194', 'BKK Karanggayam', '');
INSERT INTO `tref_bank` VALUES ('195', 'Anyar Bayan', '');
INSERT INTO `tref_bank` VALUES ('196', 'BKK Bayan', '');
INSERT INTO `tref_bank` VALUES ('197', 'BKK Buayan', '');
INSERT INTO `tref_bank` VALUES ('198', 'BKK Kayen', '');
INSERT INTO `tref_bank` VALUES ('199', 'Bada Dompu', '');
INSERT INTO `tref_bank` VALUES ('200', 'BKK Bae', '');
INSERT INTO `tref_bank` VALUES ('20001', 'Modern Express', 'PT BPR Modern Express');
INSERT INTO `tref_bank` VALUES ('20002', 'Bobato Lestari', 'PT BPR Bobato Lestari');
INSERT INTO `tref_bank` VALUES ('20003', 'Malifut Danatama', 'PT BPR Malifut Danatama');
INSERT INTO `tref_bank` VALUES ('20004', 'Artha Tual', 'PT BPR Artha Tual');
INSERT INTO `tref_bank` VALUES ('20005', 'Ronabasa', 'PT BPR Ronabasa');
INSERT INTO `tref_bank` VALUES ('20006', 'Ibadurrahman', 'PT BPRS Ibadurrahman');
INSERT INTO `tref_bank` VALUES ('20007', 'Darul Imarah Jaya', 'PT BPR Darul Imarah Jaya');
INSERT INTO `tref_bank` VALUES ('20008', 'Ingin Jaya', 'Koperasi BPR Ingin Jaya');
INSERT INTO `tref_bank` VALUES ('20009', 'Mustaqim Sukamakmur', 'PD BPR Mustaqim Sukamakmur');
INSERT INTO `tref_bank` VALUES ('20010', 'Baiturrahman', 'PT BPRS Baiturrahman');
INSERT INTO `tref_bank` VALUES ('20011', 'Hareukat', 'PT BPRS Hareukat');
INSERT INTO `tref_bank` VALUES ('20012', 'Renggali', 'PT BPRS Renggali');
INSERT INTO `tref_bank` VALUES ('20013', 'Berlian Global Aceh', 'PT BPR Berlian Global Aceh');
INSERT INTO `tref_bank` VALUES ('20014', 'Hikmah  Wakilah', 'PT BPRS Hikmah  Wakilah');
INSERT INTO `tref_bank` VALUES ('20015', 'Kota Juang', 'PT BPRS Kota Juang');
INSERT INTO `tref_bank` VALUES ('20016', 'Rahmania Dana Sejahtera', 'PT BPRS Rahmania Dana Sejahtera');
INSERT INTO `tref_bank` VALUES ('20017', 'Adeco', 'PT BPRS Adeco');
INSERT INTO `tref_bank` VALUES ('20018', 'Ar-Raihan', 'PT BPRS Ar-Raihan');
INSERT INTO `tref_bank` VALUES ('20019', 'Tengku Chiek Dipante', 'PT BPRS Tengku Chiek Dipante');
INSERT INTO `tref_bank` VALUES ('20020', 'Aji Caka', 'PT BPR Aji Caka');
INSERT INTO `tref_bank` VALUES ('20021', 'Arta Kedaton Makmur', 'PT BPR Arta Kedaton Makmur');
INSERT INTO `tref_bank` VALUES ('20022', 'Bank Pasar Kota Bandar Lampung', 'PD BPR Bank Pasar Kota Bandar Lampung');
INSERT INTO `tref_bank` VALUES ('20023', 'Citra Dana Mandiri', 'PT BPR Citra Dana Mandiri');
INSERT INTO `tref_bank` VALUES ('20024', 'Desa Sanggalangit', 'PT BPR Desa Sanggalangit');
INSERT INTO `tref_bank` VALUES ('20025', 'Dhana Sewu', 'PT BPR Dhana Sewu');
INSERT INTO `tref_bank` VALUES ('20026', 'Lampung Bina Sejahtera', 'PT BPR Lampung Bina Sejahtera');
INSERT INTO `tref_bank` VALUES ('20027', 'Langgeng Lestari Bersama', 'PT BPR Langgeng Lestari Bersama');
INSERT INTO `tref_bank` VALUES ('20028', 'Trisurya Bumindo', 'PT BPR Trisurya Bumindo');
INSERT INTO `tref_bank` VALUES ('20029', 'Bandar Lampung', 'PT BPRS Bandar Lampung');
INSERT INTO `tref_bank` VALUES ('20030', 'Dana Master Bahtera', 'PT BPR Dana Master Bahtera');
INSERT INTO `tref_bank` VALUES ('20031', 'Tahuan Ganda', 'PT BPR Tahuan Ganda');
INSERT INTO `tref_bank` VALUES ('20032', 'Cipta Dana Mulia', 'PT BPR Cipta Dana Mulia');
INSERT INTO `tref_bank` VALUES ('20033', 'Paramaarta Dina', 'PT BPR Paramaarta Dina');
INSERT INTO `tref_bank` VALUES ('20034', 'Tara Dharma Artha', 'PT BPR Tara Dharma Artha');
INSERT INTO `tref_bank` VALUES ('20035', 'Tataarta Swadaya', 'PT BPR Tataarta Swadaya');
INSERT INTO `tref_bank` VALUES ('20036', 'Rajasa', 'PD BPRS Rajasa');
INSERT INTO `tref_bank` VALUES ('20037', 'Fajar Warapastika', 'PT BPR Fajar Warapastika');
INSERT INTO `tref_bank` VALUES ('20038', 'Labuhan Dana Sentosa', 'PT BPR Labuhan Dana Sentosa');
INSERT INTO `tref_bank` VALUES ('20039', 'Lipat Ganda', 'PT BPR Lipat Ganda');
INSERT INTO `tref_bank` VALUES ('20040', 'Lampung Timur', 'PT BPRS Lampung Timur');
INSERT INTO `tref_bank` VALUES ('20041', 'Bungamayang Agroloka', 'PT BPR Bungamayang Agroloka');
INSERT INTO `tref_bank` VALUES ('20042', 'Kotabumi', 'PD BPRS Kotabumi');
INSERT INTO `tref_bank` VALUES ('20043', 'Eka Bumi Artha', 'PT BPR Eka Bumi Artha');
INSERT INTO `tref_bank` VALUES ('20044', 'Inti Dana Sentosa', 'PT BPR Inti Dana Sentosa');
INSERT INTO `tref_bank` VALUES ('20045', 'Metro Madani', 'PT BPRS Metro Madani');
INSERT INTO `tref_bank` VALUES ('20046', 'Syariah Tanggamus', 'PD BPRS Syariah Tanggamus');
INSERT INTO `tref_bank` VALUES ('20047', 'Tunas Jaya Graha', 'PT BPR Tunas Jaya Graha');
INSERT INTO `tref_bank` VALUES ('20048', 'Utomo Manunggal Sejahtera Lampung', 'PT BPR Utomo Manunggal Sejahtera Lampung');
INSERT INTO `tref_bank` VALUES ('20049', 'Cempaka Mitra Usaha', 'PT BPR Cempaka Mitra Usaha');
INSERT INTO `tref_bank` VALUES ('20050', 'Way Kanan', 'PT BPRS Way Kanan');
INSERT INTO `tref_bank` VALUES ('20051', 'Mitra Agro Usaha', 'PT BPR Mitra Agro Usaha');
INSERT INTO `tref_bank` VALUES ('20052', 'Artamas Priangan', 'PT BPR Artamas Priangan');
INSERT INTO `tref_bank` VALUES ('20053', 'Artha Karya Usaha', 'PT BPR Artha Karya Usaha');
INSERT INTO `tref_bank` VALUES ('20054', 'Artha Mitra Kencana', 'PT BPR Artha Mitra Kencana');
INSERT INTO `tref_bank` VALUES ('20055', 'Artha Niaga Finatama', 'PT BPR Artha Niaga Finatama');
INSERT INTO `tref_bank` VALUES ('20056', 'Artos Parahyangan', 'Koperasi BPR Bank Pasar Artos Parahyangan');
INSERT INTO `tref_bank` VALUES ('20057', 'Bara Ujungberung', 'Koperasi BPR Bara Ujungberung');
INSERT INTO `tref_bank` VALUES ('20058', 'Bina Maju Usaha', 'PT BPR Bina Maju Usaha');
INSERT INTO `tref_bank` VALUES ('20059', 'Citradana Rahayu', 'PT BPR Citradana Rahayu');
INSERT INTO `tref_bank` VALUES ('20060', 'Emasnusantara Sentosa', 'PT BPR Emasnusantara Sentosa');
INSERT INTO `tref_bank` VALUES ('20061', 'Kabupaten Bandung', 'PD BPR Kabupaten Bandung');
INSERT INTO `tref_bank` VALUES ('20062', 'Kertamulia', 'PT BPR Kertamulia');
INSERT INTO `tref_bank` VALUES ('20063', 'Kop. Jawa Barat', 'PT BPR Kop. Jawa Barat');
INSERT INTO `tref_bank` VALUES ('20064', 'Kota Bandung', 'PD BPR Kota Bandung');
INSERT INTO `tref_bank` VALUES ('20065', 'Metro Asia Mandiri', 'PT BPR Metro Asia Mandiri');
INSERT INTO `tref_bank` VALUES ('20066', 'Mitra Anditta', 'PT BPR Mitra Anditta');
INSERT INTO `tref_bank` VALUES ('20067', 'Nata Citraperdana', 'PT BPR Nata Citraperdana');
INSERT INTO `tref_bank` VALUES ('20068', 'Permata Dhanawira', 'PT BPR Permata Dhanawira');
INSERT INTO `tref_bank` VALUES ('20069', 'Pundi Kencana Makmur', 'PT BPR Pundi Kencana Makmur');
INSERT INTO `tref_bank` VALUES ('20070', 'Ratna Artha Pusaka', 'PT BPR Ratna Artha Pusaka');
INSERT INTO `tref_bank` VALUES ('20071', 'Sentral Investasi Prima', 'PT BPR Sentral Investasi Prima');
INSERT INTO `tref_bank` VALUES ('20072', 'Trisurya Marga Artha', 'PT BPR Trisurya Marga Artha');
INSERT INTO `tref_bank` VALUES ('20073', 'Utama Kita Mandiri', 'PT BPR Utama Kita Mandiri');
INSERT INTO `tref_bank` VALUES ('20074', 'Berkah Amal Salman', 'PT BPRS Berkah Amal Salman');
INSERT INTO `tref_bank` VALUES ('20075', 'Harta Insan Karimah Parahyangan', 'PT BPRS Harta Insan Karimah Parahyangan');
INSERT INTO `tref_bank` VALUES ('20076', 'Arta Gandhita', 'PT BPR Arta Gandhita');
INSERT INTO `tref_bank` VALUES ('20077', 'Bumi Pendawa Raharja', 'PT BPR Bumi Pendawa Raharja');
INSERT INTO `tref_bank` VALUES ('20078', 'Cikalong Kulon', 'PD BPR LPK Cikalongkulon');
INSERT INTO `tref_bank` VALUES ('20079', 'Cipanas Artha', 'PT BPR Cipanas Artha');
INSERT INTO `tref_bank` VALUES ('20080', 'Dana Pos', 'PT BPR Dana Pos');
INSERT INTO `tref_bank` VALUES ('20081', 'Kadupandak', 'PD BPR LPK Kadupandak');
INSERT INTO `tref_bank` VALUES ('20082', 'LPK Bojongpicung', 'PD BPR LPK Bojongpicung');
INSERT INTO `tref_bank` VALUES ('20083', 'LPK Cibeber', 'PD BPR LPK Cibeber');
INSERT INTO `tref_bank` VALUES ('20084', 'LPK Cidaun', 'PD BPR LPK Cidaun');
INSERT INTO `tref_bank` VALUES ('20085', 'LPK Ciranjang', 'PD BPR LPK Ciranjang');
INSERT INTO `tref_bank` VALUES ('20086', 'LPK Pacet', 'PD BPR LPK Pacet');
INSERT INTO `tref_bank` VALUES ('20087', 'LPK Sukanagara', 'PD BPR LPK Sukanagara');
INSERT INTO `tref_bank` VALUES ('20088', 'LPK Warungkondang', 'PD BPR LPK Warungkondang');
INSERT INTO `tref_bank` VALUES ('20089', 'Putra Pertiwi Sejati', 'PT BPR Putra Pertiwi Sejati');
INSERT INTO `tref_bank` VALUES ('20090', 'Sindangbarang', 'PD BPR LPK Sindangbarang');
INSERT INTO `tref_bank` VALUES ('20091', 'Universal Karya Mandiri Puncak', 'PT BPR Universal Karya Mandiri Puncak');
INSERT INTO `tref_bank` VALUES ('20092', 'Artha Fisabilillah', 'PT BPRS Artha Fisabilillah');
INSERT INTO `tref_bank` VALUES ('20093', 'Multidana Indonesia', 'PT BPR Multidana Indonesia');
INSERT INTO `tref_bank` VALUES ('20094', 'Baiturridha', 'PT BPRS Baiturridha');
INSERT INTO `tref_bank` VALUES ('20095', 'BPR Garut', 'PD BPR BPR Garut');
INSERT INTO `tref_bank` VALUES ('20096', 'LPK Banjarwangi', 'PD BPR LPK Banjarwangi');
INSERT INTO `tref_bank` VALUES ('20097', 'LPK Bayongbong', 'PD BPR LPK Bayongbong');
INSERT INTO `tref_bank` VALUES ('20098', 'LPK Cibalong', 'PD BPR LPK Cibalong');
INSERT INTO `tref_bank` VALUES ('20099', 'LPK Cikajang', 'PD BPR LPK Cikajang');
INSERT INTO `tref_bank` VALUES ('201', 'Sumber Hiobaja', '');
INSERT INTO `tref_bank` VALUES ('20100', 'LPK Garut Kota', 'PD BPR LPK Garut Kota');
INSERT INTO `tref_bank` VALUES ('20101', 'LPK Leuwigoong', 'PD BPR LPK Leuwigoong');
INSERT INTO `tref_bank` VALUES ('20102', 'LPK Sukawening', 'PD BPR LPK Sukawening');
INSERT INTO `tref_bank` VALUES ('20103', 'Mustika Permai', 'PT BPR Mustika Permai');
INSERT INTO `tref_bank` VALUES ('20104', 'Harum Hikmahnugraha', 'PT BPRS Harum Hikmahnugraha');
INSERT INTO `tref_bank` VALUES ('20105', 'PNM Mentari', 'PT BPRS PNM Mentari');
INSERT INTO `tref_bank` VALUES ('20106', 'Adhierresa', 'PT BPR Adhierresa');
INSERT INTO `tref_bank` VALUES ('20107', 'Bale Endah Rahayu', 'PT BPR Bale Endah Rahayu');
INSERT INTO `tref_bank` VALUES ('20108', 'Bandung Kidul', 'PT BPR Bandung Kidul');
INSERT INTO `tref_bank` VALUES ('20109', 'Bina Sono Artha', 'PT BPR Bina Sono Artha');
INSERT INTO `tref_bank` VALUES ('20110', 'Brata Nusantara', 'PT BPR Brata Nusantara');
INSERT INTO `tref_bank` VALUES ('20111', 'Bumi Bandung Kencana', 'PT BPR Bumi Bandung Kencana');
INSERT INTO `tref_bank` VALUES ('20112', 'Nusantara Bona Pasogit 26', 'PT BPR Nusantara Bona Pasogit 26');
INSERT INTO `tref_bank` VALUES ('20113', 'Bumiasih NBP 27', 'PT BPR Bumiasih NBP 27');
INSERT INTO `tref_bank` VALUES ('20114', 'Nusantara Bona Pasogit 30', 'PT BPR Nusantara Bona Pasogit 30');
INSERT INTO `tref_bank` VALUES ('20115', 'Dana Putra Mandiri', 'PT BPR Dana Putra Mandiri');
INSERT INTO `tref_bank` VALUES ('20116', 'Danamasa Cimahi', 'PT BPR Danamasa Cimahi');
INSERT INTO `tref_bank` VALUES ('20117', 'Daya Lumbung Asia', 'PT BPR Daya Lumbung Asia');
INSERT INTO `tref_bank` VALUES ('20118', 'Duta Artha Sejahtera', 'PT BPR Duta Artha Sejahtera');
INSERT INTO `tref_bank` VALUES ('20119', 'Duta Pasundan', 'PT BPR Duta Pasundan');
INSERT INTO `tref_bank` VALUES ('20120', 'Gunadhana Mitrasembada', 'PT BPR Gunadhana Mitrasembada');
INSERT INTO `tref_bank` VALUES ('20121', 'Hayura Artalola', 'PT BPR Hayura Artalola');
INSERT INTO `tref_bank` VALUES ('20122', 'Jelita Arta', 'PT BPR Jelita Arta');
INSERT INTO `tref_bank` VALUES ('20123', 'Jujur Arghadana', 'PT BPR Jujur Arghadana');
INSERT INTO `tref_bank` VALUES ('20124', 'Karyajatnika Sadaya', 'PT BPR Karyajatnika Sadaya');
INSERT INTO `tref_bank` VALUES ('20125', 'Kencana', 'PT BPR Kencana');
INSERT INTO `tref_bank` VALUES ('20126', 'Lembangsari Arthatama', 'PT BPR Lembangsari Arthatama');
INSERT INTO `tref_bank` VALUES ('20127', 'Lexi Pratama Mandiri', 'PT BPR Lexi Pratama Mandiri');
INSERT INTO `tref_bank` VALUES ('20128', 'Mangun Pundiyasa', 'PT BPR Mangun Pundiyasa');
INSERT INTO `tref_bank` VALUES ('20129', 'Margahayu Arthatama', 'PT BPR Margahayu Arthatama');
INSERT INTO `tref_bank` VALUES ('20130', 'Mitra Kanaka Santosa', 'PT BPR Mitra Kanaka Santosa');
INSERT INTO `tref_bank` VALUES ('20131', 'Mitra Rukun Mandiri', 'PT BPR Mitra Rukun Mandiri');
INSERT INTO `tref_bank` VALUES ('20132', 'Mutiara Artha Pratama', 'PT BPR Mutiara Artha Pratama');
INSERT INTO `tref_bank` VALUES ('20133', 'Nehemia', 'PT BPR Nehemia');
INSERT INTO `tref_bank` VALUES ('20134', 'Niaga Mitra Usaha', 'PT BPR Niaga Mitra Usaha');
INSERT INTO `tref_bank` VALUES ('20135', 'Pangandaran', 'PT BPR Pangandaran');
INSERT INTO `tref_bank` VALUES ('20136', 'Panjawan Mitrausaha', 'PT BPR Panjawan Mitrausaha');
INSERT INTO `tref_bank` VALUES ('20137', 'Sadayana Artha', 'PT BPR Sadayana Artha');
INSERT INTO `tref_bank` VALUES ('20138', 'Sagitarius Pembangunan', 'PT BPR Sagitarius Pembangunan');
INSERT INTO `tref_bank` VALUES ('20139', 'Sarikusuma Surya', 'PT BPR Sarikusuma Surya');
INSERT INTO `tref_bank` VALUES ('20140', 'Sembada', 'PT BPR Sembada');
INSERT INTO `tref_bank` VALUES ('20141', 'Sinar Mas Pelita', 'PT BPR Sinar Mas Pelita');
INSERT INTO `tref_bank` VALUES ('20142', 'Tanjung Raya', 'Koperasi BPR Tanjung Raya');
INSERT INTO `tref_bank` VALUES ('20143', 'Teguh Ayusuastika', 'PT BPR Teguh Ayusuastika');
INSERT INTO `tref_bank` VALUES ('20144', 'Al Ihsan', 'Koperasi BPRS Al Ihsan');
INSERT INTO `tref_bank` VALUES ('20145', 'Amanah Rabbaniah', 'PT BPRS Amanah Rabbaniah');
INSERT INTO `tref_bank` VALUES ('20146', 'Cipaganti', 'PT BPRS Cipaganti');
INSERT INTO `tref_bank` VALUES ('20147', 'Ishlahul Ummah', 'PT BPRS Ishlahul Ummah');
INSERT INTO `tref_bank` VALUES ('20148', 'PNM Al Ma\'soem Syariah', 'PT BPRS PNM Al Ma\'soem Syariah');
INSERT INTO `tref_bank` VALUES ('20149', 'Arthaguna Mandiri', 'PT BPR Arthaguna Mandiri');
INSERT INTO `tref_bank` VALUES ('20150', 'BPR. Sukabumi', 'PD BPR BPR. Sukabumi');
INSERT INTO `tref_bank` VALUES ('20151', 'Bumitani Mandiri', 'PT BPR Bumitani Mandiri');
INSERT INTO `tref_bank` VALUES ('20152', 'Cicurug Bumiasih', 'PT BPR Cicurug Bumiasih');
INSERT INTO `tref_bank` VALUES ('20153', 'Nusamba Sukaraja', 'PT BPR Nusamba Sukaraja');
INSERT INTO `tref_bank` VALUES ('20154', 'Semesta Megadana', 'PT BPR Semesta Megadana');
INSERT INTO `tref_bank` VALUES ('20155', 'Supra Artapersada', 'PT BPR Supra Artapersada');
INSERT INTO `tref_bank` VALUES ('20156', 'Nusamba Plered', 'PT BPR Nusamba Plered');
INSERT INTO `tref_bank` VALUES ('20157', 'Raharja Wanayasa', 'PD BPR Raharja Wanayasa');
INSERT INTO `tref_bank` VALUES ('20158', 'Bina Arta Swadaya Bandung', 'PT BPR Bina Arta Swadaya Bandung');
INSERT INTO `tref_bank` VALUES ('20159', 'BPR Subang', 'PD BPR BPR Subang');
INSERT INTO `tref_bank` VALUES ('20160', 'Nusantara Bona Pasogit 29', 'PT BPR Nusantara Bona Pasogit 29');
INSERT INTO `tref_bank` VALUES ('20161', 'Gede Artaguna', 'PT BPR Gede Artaguna');
INSERT INTO `tref_bank` VALUES ('20162', 'LPK Cisalak', 'PD BPR LPK Cisalak');
INSERT INTO `tref_bank` VALUES ('20163', 'LPK Jalan Cagak', 'PD BPR LPK Jalan Cagak');
INSERT INTO `tref_bank` VALUES ('20164', 'LPK Pagaden', 'PD BPR LPK Pagaden');
INSERT INTO `tref_bank` VALUES ('20165', 'LPK Pamanukan', 'PD BPR LPK Pamanukan');
INSERT INTO `tref_bank` VALUES ('20166', 'LPK Purwadadi', 'PD BPR LPK Purwadadi');
INSERT INTO `tref_bank` VALUES ('20167', 'Markoni Saranajaya', 'PT BPR Markoni Saranajaya');
INSERT INTO `tref_bank` VALUES ('20168', 'Nauli Danaraya', 'PT BPR Nauli Danaraya');
INSERT INTO `tref_bank` VALUES ('20169', 'Nusumma cisalak', 'PT BPR Nusumma cisalak');
INSERT INTO `tref_bank` VALUES ('20170', 'Pamanukan Bangunarta', 'PT BPR Pamanukan Bangunarta');
INSERT INTO `tref_bank` VALUES ('20171', 'Tata Asia', 'PT BPR Tata Asia');
INSERT INTO `tref_bank` VALUES ('20172', 'Tutur Ganda', 'PT BPR Tutur Ganda');
INSERT INTO `tref_bank` VALUES ('20173', 'Kota Sukabumi', 'PD BPR Pasar Kota Sukabumi');
INSERT INTO `tref_bank` VALUES ('20174', 'Karpana Tasia', 'PT BPR Karpana Tasia');
INSERT INTO `tref_bank` VALUES ('20175', 'Nusamba Tanjungsari', 'PT BPR Nusamba Tanjungsari');
INSERT INTO `tref_bank` VALUES ('20176', 'Sumedang', 'PD BPR Sumedang');
INSERT INTO `tref_bank` VALUES ('20177', 'Astambul', 'PD BPR Astambul');
INSERT INTO `tref_bank` VALUES ('20178', 'Gawi Sabumi Mandarsari', 'PT BPR Gawi Sabumi Mandarsari');
INSERT INTO `tref_bank` VALUES ('20179', 'Mitratama  Arthabuana', 'PT BPR Mitratama  Arthabuana');
INSERT INTO `tref_bank` VALUES ('20180', 'Multidhana  Bersama', 'PT BPR Multidhana  Bersama');
INSERT INTO `tref_bank` VALUES ('20181', 'Simpang Empat', 'PD BPR Simpang Empat');
INSERT INTO `tref_bank` VALUES ('20182', 'Sungai Tabuk', 'PD BPR Sungai Tabuk');
INSERT INTO `tref_bank` VALUES ('20183', 'Barkah Gema Dana', 'PT BPRS Barkah Gema Dana');
INSERT INTO `tref_bank` VALUES ('20184', 'Martapura', 'PD BPR Martapura');
INSERT INTO `tref_bank` VALUES ('20185', 'Dana Permata Lestari', 'PT BPR Dana Permata Lestari');
INSERT INTO `tref_bank` VALUES ('20186', 'Kandangan', 'PD BPR Kandangan');
INSERT INTO `tref_bank` VALUES ('20187', 'Labuan Amas Selatan', 'PD BPR Labuan Amas Selatan');
INSERT INTO `tref_bank` VALUES ('20188', 'Amuntai Selatan', 'PD BPR Amuntai Selatan');
INSERT INTO `tref_bank` VALUES ('20189', 'Amuntai Tengah', 'PD BPR Amuntai Tengah');
INSERT INTO `tref_bank` VALUES ('20190', 'Amuntai Utara', 'PD BPR Amuntai Utara');
INSERT INTO `tref_bank` VALUES ('20191', 'Sungai Pandan', 'PD BPR Sungai Pandan');
INSERT INTO `tref_bank` VALUES ('20192', 'Haruai', 'PD BPR Haruai');
INSERT INTO `tref_bank` VALUES ('20193', 'Kelua', 'PD BPR Kelua');
INSERT INTO `tref_bank` VALUES ('20194', 'Muara Uya', 'PD BPR Muara Uya');
INSERT INTO `tref_bank` VALUES ('20195', 'Binuang', 'PD BPR Binuang');
INSERT INTO `tref_bank` VALUES ('20196', 'Candi Laras Utara', 'PD BPR Candi Laras Utara');
INSERT INTO `tref_bank` VALUES ('20197', 'Tapin Selatan', 'PD BPR Tapin Selatan');
INSERT INTO `tref_bank` VALUES ('20198', 'Tapin Tengah', 'PD BPR Tapin Tengah');
INSERT INTO `tref_bank` VALUES ('20199', 'Tapin Utara', 'PD BPR Tapin Utara');
INSERT INTO `tref_bank` VALUES ('202', 'Bajo Donggo', '');
INSERT INTO `tref_bank` VALUES ('20200', 'Agra Dhana', 'PT BPR Agra Dhana');
INSERT INTO `tref_bank` VALUES ('20201', 'Artha Prima Perkasa', 'PT BPR Artha Prima Perkasa');
INSERT INTO `tref_bank` VALUES ('20202', 'Banda Raya', 'PT BPR Banda Raya');
INSERT INTO `tref_bank` VALUES ('20203', 'Barelang Mandiri', 'PT BPR Barelang Mandiri');
INSERT INTO `tref_bank` VALUES ('20204', 'Central Kepri', 'PT BPR Central Kepri');
INSERT INTO `tref_bank` VALUES ('20205', 'Dana Central Mulia', 'PT BPR Dana Central Mulia');
INSERT INTO `tref_bank` VALUES ('20206', 'Dana Makmur', 'PT BPR Dana Makmur');
INSERT INTO `tref_bank` VALUES ('20207', 'Dana Mitra Sukses', 'PT BPR Dana Mitra Sukses');
INSERT INTO `tref_bank` VALUES ('20208', 'Dana Nagoya', 'PT BPR Dana Nagoya');
INSERT INTO `tref_bank` VALUES ('20209', 'Dana Nusantara', 'PT BPR Dana Nusantara');
INSERT INTO `tref_bank` VALUES ('20210', 'Dana Putra', 'PT BPR Dana Putra');
INSERT INTO `tref_bank` VALUES ('20211', 'Danamas Simpan Pinjam', 'PT BPR Danamas Simpan Pinjam');
INSERT INTO `tref_bank` VALUES ('20212', 'Global Mentari', 'PT BPR Global Mentari');
INSERT INTO `tref_bank` VALUES ('20213', 'Harapan Bunda Batam', 'PT BPR Harapan Bunda Batam');
INSERT INTO `tref_bank` VALUES ('20214', 'Indobaru Finansia', 'PT BPR Indobaru Finansia');
INSERT INTO `tref_bank` VALUES ('20215', 'Kapital Batam', 'PT BPR Kapital Batam');
INSERT INTO `tref_bank` VALUES ('20216', 'Kepri Batam', 'PT BPR Kepri Batam');
INSERT INTO `tref_bank` VALUES ('20217', 'Kintamas Mitra Dana', 'PT BPR Kintamas Mitra Dana');
INSERT INTO `tref_bank` VALUES ('20218', 'Majesty Golden Raya', 'PT BPR Majesty Golden Raya');
INSERT INTO `tref_bank` VALUES ('20219', 'Mutiara Cemerlang Barelang', 'PT BPR Mutiara Cemerlang Barelang');
INSERT INTO `tref_bank` VALUES ('20220', 'Pundi Masyarakat', 'PT BPR Pundi Masyarakat');
INSERT INTO `tref_bank` VALUES ('20221', 'Putra Batam', 'PT BPR Putra Batam');
INSERT INTO `tref_bank` VALUES ('20222', 'Sejahtera Batam', 'PT BPR Sejahtera Batam');
INSERT INTO `tref_bank` VALUES ('20223', 'Ukabima Mitra Dana', 'PT BPR Ukabima Mitra Dana');
INSERT INTO `tref_bank` VALUES ('20224', 'Syarikat Madani', 'PT BPRS Syarikat Madani');
INSERT INTO `tref_bank` VALUES ('20225', 'Vitka Central', 'PT BPRS Vitka Central');
INSERT INTO `tref_bank` VALUES ('20226', 'Bintan', 'PD BPR Bintan');
INSERT INTO `tref_bank` VALUES ('20227', 'Buana Arta Mulia', 'PT BPR Buana Arta Mulia');
INSERT INTO `tref_bank` VALUES ('20228', 'Karimun', 'PD BPR Karimun');
INSERT INTO `tref_bank` VALUES ('20229', 'Karimun Sejahtera', 'PT BPR Karimun Sejahtera');
INSERT INTO `tref_bank` VALUES ('20230', 'Sumber Danamas', 'PT BPR Sumber Danamas');
INSERT INTO `tref_bank` VALUES ('20231', 'Cempaka Mandiri', 'PT BPR Cempaka Mandiri');
INSERT INTO `tref_bank` VALUES ('20232', 'Dana Bintan Sejahtera', 'PT BPR Dana Bintan Sejahtera');
INSERT INTO `tref_bank` VALUES ('20233', 'Central Sejahtera', 'PT BPR Central Sejahtera');
INSERT INTO `tref_bank` VALUES ('20234', 'Kepri Bintan', 'PT BPR Kepri Bintan');
INSERT INTO `tref_bank` VALUES ('20235', 'Bestari', 'PD BPR Bestari');
INSERT INTO `tref_bank` VALUES ('20236', 'Duta Kepulauan Riau', 'PT BPR Duta Kepulauan Riau');
INSERT INTO `tref_bank` VALUES ('20237', 'Safir Bengkulu', 'PT BPRS Safir Bengkulu');
INSERT INTO `tref_bank` VALUES ('20238', 'Muamalat Harkat', 'PT BPRS Muamalat Harkat');
INSERT INTO `tref_bank` VALUES ('20239', 'Dian Binarta', 'PT BPR Dian Binarta');
INSERT INTO `tref_bank` VALUES ('20240', 'Mindosari', 'PT BPR Mindosari');
INSERT INTO `tref_bank` VALUES ('20241', 'Maroba Ite', 'PT BPR Maroba Ite');
INSERT INTO `tref_bank` VALUES ('20242', 'Arjawinangun', 'PD BPR Arjawinangun');
INSERT INTO `tref_bank` VALUES ('20243', 'Arthia Sere', 'PT BPR Arthia Sere');
INSERT INTO `tref_bank` VALUES ('20244', 'Astanajapura', 'PD BPR Astanajapura');
INSERT INTO `tref_bank` VALUES ('20245', 'Babakan', 'PD BPR Babakan');
INSERT INTO `tref_bank` VALUES ('20246', 'Baldah Sentosa', 'PT BPR Baldah Sentosa');
INSERT INTO `tref_bank` VALUES ('20247', 'Bank Pasar Kota Cirebon', 'PD BPR Bank Pasar Kota Cirebon');
INSERT INTO `tref_bank` VALUES ('20248', 'Beber', 'PD BPR Beber');
INSERT INTO `tref_bank` VALUES ('20249', 'Nusantara Bona Pasogit 28', 'PT BPR Nusantara Bona Pasogit 28');
INSERT INTO `tref_bank` VALUES ('20250', 'Cahaya Fajar', 'PT BPR Cahaya Fajar');
INSERT INTO `tref_bank` VALUES ('20251', 'Cirebon Barat', 'PD BPR Cirebon Barat');
INSERT INTO `tref_bank` VALUES ('20252', 'Cirebon Selatan', 'PD BPR Cirebon Selatan');
INSERT INTO `tref_bank` VALUES ('20253', 'Cirebon Utara', 'PD BPR Cirebon Utara');
INSERT INTO `tref_bank` VALUES ('20254', 'Ciwaringin', 'PD BPR Ciwaringin');
INSERT INTO `tref_bank` VALUES ('20255', 'Dipon Sejahtera', 'PT BPR Dipon Sejahtera');
INSERT INTO `tref_bank` VALUES ('20256', 'Gegesik', 'PD BPR Gegesik');
INSERT INTO `tref_bank` VALUES ('20257', 'Harap Ganda', 'PT BPR Harap Ganda');
INSERT INTO `tref_bank` VALUES ('20258', 'Hisobhan', 'PT BPR Hisobhan');
INSERT INTO `tref_bank` VALUES ('20259', 'Kapetakan', 'PD BPR Kapetakan');
INSERT INTO `tref_bank` VALUES ('20260', 'Karangsembung', 'PD BPR Karangsembung');
INSERT INTO `tref_bank` VALUES ('20261', 'Klangenan', 'PD BPR Klangenan');
INSERT INTO `tref_bank` VALUES ('20262', 'Lemahabang', 'PD BPR Lemahabang');
INSERT INTO `tref_bank` VALUES ('20263', 'Palimanan', 'PD BPR Palimanan');
INSERT INTO `tref_bank` VALUES ('20264', 'Parasahabat Cirebon', 'PT BPR Parasahabat Cirebon');
INSERT INTO `tref_bank` VALUES ('20265', 'Plumbon', 'PD BPR Plumbon');
INSERT INTO `tref_bank` VALUES ('20266', 'Sumber', 'PD BPR Sumber');
INSERT INTO `tref_bank` VALUES ('20267', 'Sumber Sibapudung', 'PT BPR Sumber Sibapudung');
INSERT INTO `tref_bank` VALUES ('20268', 'Susukan - Cirebon', 'PD BPR Susukan');
INSERT INTO `tref_bank` VALUES ('20269', 'Waled', 'PD BPR Waled');
INSERT INTO `tref_bank` VALUES ('20270', 'Weru', 'PD BPR Weru');
INSERT INTO `tref_bank` VALUES ('20271', 'Syarif Hidayatullah', 'PT BPRS Artamas');
INSERT INTO `tref_bank` VALUES ('20272', 'Anjatan', 'PD BPR Anjatan');
INSERT INTO `tref_bank` VALUES ('20273', 'Bangodua', 'PD BPR Bangodua');
INSERT INTO `tref_bank` VALUES ('20274', 'Cikedung', 'PD BPR Cikedung');
INSERT INTO `tref_bank` VALUES ('20275', 'Dhanagung Karangampel', 'PT BPR Dhanagung Karangampel');
INSERT INTO `tref_bank` VALUES ('20276', 'Gabuswetan', 'PD BPR Gabuswetan');
INSERT INTO `tref_bank` VALUES ('20277', 'Haurgeulis', 'PD BPR Haurgeulis');
INSERT INTO `tref_bank` VALUES ('20278', 'Juntinyuat', 'PD BPR Juntinyuat');
INSERT INTO `tref_bank` VALUES ('20279', 'Kandanghaur', 'PD BPR Kandanghaur');
INSERT INTO `tref_bank` VALUES ('20280', 'Karangampel', 'PD BPR Karangampel');
INSERT INTO `tref_bank` VALUES ('20281', 'Kertasemaya', 'PD BPR Kertasemaya');
INSERT INTO `tref_bank` VALUES ('20282', 'Krangkeng', 'PD BPR Krangkeng');
INSERT INTO `tref_bank` VALUES ('20283', 'Lohbener', 'PD BPR Lohbener');
INSERT INTO `tref_bank` VALUES ('20284', 'Losarang', 'PD BPR Losarang');
INSERT INTO `tref_bank` VALUES ('20285', 'LPK Arahan Kidul', 'PD BPR LPK Arahan Kidul');
INSERT INTO `tref_bank` VALUES ('20286', 'LPK Balongan', 'PD BPR LPK Balongan');
INSERT INTO `tref_bank` VALUES ('20287', 'LPK Bongas', 'PD BPR LPK Bongas');
INSERT INTO `tref_bank` VALUES ('20288', 'LPK Cantigi Kulon', 'PD BPR LPK Cantigi Kulon');
INSERT INTO `tref_bank` VALUES ('20289', 'LPK Kroya - Indramayu', 'PD BPR LPK Kroya');
INSERT INTO `tref_bank` VALUES ('20290', 'LPK Sukra', 'PD BPR LPK Sukra');
INSERT INTO `tref_bank` VALUES ('20291', 'Mitra Harmoni', 'PT BPR Mitra Harmoni');
INSERT INTO `tref_bank` VALUES ('20292', 'Sindang', 'PD BPR Sindang');
INSERT INTO `tref_bank` VALUES ('20293', 'Sliyeg', 'PD BPR Sliyeg');
INSERT INTO `tref_bank` VALUES ('20294', 'Widasari', 'PD BPR Widasari');
INSERT INTO `tref_bank` VALUES ('20295', 'BKPD Kuningan', 'PD BPR BPR Kuningan');
INSERT INTO `tref_bank` VALUES ('20296', 'Raksa Wacana Agri Purnama', 'PT BPR Raksa Wacana Agri Purnama');
INSERT INTO `tref_bank` VALUES ('20297', 'BKPD Sukahaji', 'PD BPR BPR Sukahaji');
INSERT INTO `tref_bank` VALUES ('20298', 'LPK Banjaran', 'PD BPR LPK Banjaran');
INSERT INTO `tref_bank` VALUES ('20299', 'LPK Cigasong', 'PD BPR LPK Cigasong');
INSERT INTO `tref_bank` VALUES ('203', 'Rembang', '');
INSERT INTO `tref_bank` VALUES ('20300', 'LPK Cingambul', 'PD BPR LPK Cingambul');
INSERT INTO `tref_bank` VALUES ('20301', 'LPK Panyingkiran', 'PD BPR LPK Panyingkiran');
INSERT INTO `tref_bank` VALUES ('20302', 'Wahana Sentra Artha', 'PT BPR Wahana Sentra Artha');
INSERT INTO `tref_bank` VALUES ('20303', 'Adiartha Udiana', 'PT BPR Adiartha Udiana');
INSERT INTO `tref_bank` VALUES ('20304', 'Antenk', 'PT BPR Antenk');
INSERT INTO `tref_bank` VALUES ('20305', 'Ashi', 'PT BPR Ashi');
INSERT INTO `tref_bank` VALUES ('20306', 'Bali Artha Anugrah', 'PT BPR Bali Artha Anugrah');
INSERT INTO `tref_bank` VALUES ('20307', 'Bali Sinar Menara', 'PT BPR Bali Sinar Menara');
INSERT INTO `tref_bank` VALUES ('20308', 'Baliharta Santosa', 'PT BPR Baliharta Santosa');
INSERT INTO `tref_bank` VALUES ('20309', 'Bayudhana', 'PT BPR Bayudhana');
INSERT INTO `tref_bank` VALUES ('20310', 'Bukit Tanjung', 'PT BPR Bukit Tanjung');
INSERT INTO `tref_bank` VALUES ('20311', 'Cahaya Artha Bali', 'PT BPR Cahaya Artha Bali');
INSERT INTO `tref_bank` VALUES ('20312', 'Cahaya Binawerdi', 'PT BPR Cahaya Binawerdi');
INSERT INTO `tref_bank` VALUES ('20313', 'Desa Dalung', 'PD BPR Desa Dalung');
INSERT INTO `tref_bank` VALUES ('20314', 'Desa Sangeh', 'PT BPR Desa Sangeh');
INSERT INTO `tref_bank` VALUES ('20315', 'Dewangga Bali Artha', 'PT BPR Dewangga Bali Artha');
INSERT INTO `tref_bank` VALUES ('20316', 'Dinar Jagad', 'PT BPR Dinar Jagad');
INSERT INTO `tref_bank` VALUES ('20317', 'Giri Sariwangi', 'PT BPR Giri Sariwangi');
INSERT INTO `tref_bank` VALUES ('20318', 'Jaya Kerti', 'PT BPR Jaya Kerti');
INSERT INTO `tref_bank` VALUES ('20319', 'Kapal Basak Pursada', 'PT BPR Kapal Basak Pursada');
INSERT INTO `tref_bank` VALUES ('20320', 'Karya Sari Sedana', 'PT BPR Karya Sari Sedana');
INSERT INTO `tref_bank` VALUES ('20321', 'Kita', 'PT BPR Kita');
INSERT INTO `tref_bank` VALUES ('20322', 'Kita Centradana', 'PT BPR Kita Centradana');
INSERT INTO `tref_bank` VALUES ('20323', 'KS Bali Agung Sedana', 'PT BPR KS Bali Agung Sedana');
INSERT INTO `tref_bank` VALUES ('20324', 'Kusemas Dana Mandiri', 'PT BPR Kusemas Dana Mandiri');
INSERT INTO `tref_bank` VALUES ('20325', 'Kusuma Mandala', 'PT BPR Kusuma Mandala');
INSERT INTO `tref_bank` VALUES ('20326', 'Maha Bhoga Marga', 'PT BPR Maha Bhoga Marga');
INSERT INTO `tref_bank` VALUES ('20327', 'Mambal', 'PT BPR Mambal');
INSERT INTO `tref_bank` VALUES ('20328', 'Mayun Utama Perdana', 'PT BPR Mayun Utama Perdana');
INSERT INTO `tref_bank` VALUES ('20329', 'Mertha Sedana', 'PT BPR Mertha Sedana');
INSERT INTO `tref_bank` VALUES ('20330', 'Mini Darma Adipala', 'PT BPR Mini Darma Adipala');
INSERT INTO `tref_bank` VALUES ('20331', 'Mitra Bali Mandiri', 'PT BPR Mitra Bali Mandiri');
INSERT INTO `tref_bank` VALUES ('20332', 'Mitra Balijaya Mandiri', 'PT BPR Mitra Balijaya Mandiri');
INSERT INTO `tref_bank` VALUES ('20333', 'Nusamba Mengwi', 'PT BPR Nusamba Mengwi');
INSERT INTO `tref_bank` VALUES ('20334', 'Nusapanida Kuta', 'PT BPR Nusapanida Kuta');
INSERT INTO `tref_bank` VALUES ('20335', 'Parasari', 'PT BPR Parasari');
INSERT INTO `tref_bank` VALUES ('20336', 'Parasari Sibang', 'PT BPR Parasari Sibang');
INSERT INTO `tref_bank` VALUES ('20337', 'Pasar raya Kuta', 'PT BPR Pasar raya Kuta');
INSERT INTO `tref_bank` VALUES ('20338', 'Pasar Umum', 'PT BPR Pasar Umum');
INSERT INTO `tref_bank` VALUES ('20339', 'Pedungan', 'PT BPR Pedungan');
INSERT INTO `tref_bank` VALUES ('20340', 'Permata Sedana', 'PT BPR Permata Sedana');
INSERT INTO `tref_bank` VALUES ('20341', 'Prima Dewata', 'PT BPR Prima Dewata');
INSERT INTO `tref_bank` VALUES ('20342', 'Santi Pala', 'PT BPR Santi Pala');
INSERT INTO `tref_bank` VALUES ('20343', 'Saptacristy Utama', 'PT BPR Saptacristy Utama');
INSERT INTO `tref_bank` VALUES ('20344', 'Saraswati Ekabumi', 'PT BPR Saraswati Ekabumi');
INSERT INTO `tref_bank` VALUES ('20345', 'Sari Nadi', 'PT BPR Sari Nadi');
INSERT INTO `tref_bank` VALUES ('20346', 'Sari Wira Tama', 'PT BPR Sari Wira Tama');
INSERT INTO `tref_bank` VALUES ('20347', 'Siaga Dana Kuta', 'PT BPR Siaga Dana Kuta');
INSERT INTO `tref_bank` VALUES ('20348', 'Sinar Kuta', 'PT BPR Sinar Kuta');
INSERT INTO `tref_bank` VALUES ('20349', 'Sinar Kuta Mulia', 'PT BPR Sinar Kuta Mulia');
INSERT INTO `tref_bank` VALUES ('20350', 'Siwi Sedana', 'PT BPR Siwi Sedana');
INSERT INTO `tref_bank` VALUES ('20351', 'Suar Artha Dharma', 'PT BPR Suar Artha Dharma');
INSERT INTO `tref_bank` VALUES ('20352', 'Tapa', 'PT BPR Tapa');
INSERT INTO `tref_bank` VALUES ('20353', 'Tulus Dadi', 'PT BPR Tulus Dadi');
INSERT INTO `tref_bank` VALUES ('20354', 'Udiyana Putra', 'PT BPR Udiyana Putra');
INSERT INTO `tref_bank` VALUES ('20355', 'Urip Kalantas', 'PT BPR Urip Kalantas');
INSERT INTO `tref_bank` VALUES ('20356', 'Varis Mandiri', 'PT BPR Varis Mandiri');
INSERT INTO `tref_bank` VALUES ('20357', 'Wahyu Nirmala', 'PT BPR Wahyu Nirmala');
INSERT INTO `tref_bank` VALUES ('20358', 'Fajar Sejahtera Bali', 'PT BPRS Fajar Sejahtera Bali');
INSERT INTO `tref_bank` VALUES ('20359', 'Kabupaten Bangli', 'PD BPR Bank Pasar Kabupaten Bangli');
INSERT INTO `tref_bank` VALUES ('20360', 'Kintamani Perdana', 'PT BPR Kintamani Perdana');
INSERT INTO `tref_bank` VALUES ('20361', 'Mitra Bali Muktijaya Mandiri', 'PT BPR Mitra Bali Muktijaya Mandiri');
INSERT INTO `tref_bank` VALUES ('20362', 'Buleleng 45', 'PD BPR Buleleng 46');
INSERT INTO `tref_bank` VALUES ('20363', 'Cahaya Bina Putra', 'PT BPR Cahaya Bina Putra');
INSERT INTO `tref_bank` VALUES ('20364', 'Kanaya', 'PT BPR Kanaya');
INSERT INTO `tref_bank` VALUES ('20365', 'Nur Abadi', 'PT BPR Nur Abadi');
INSERT INTO `tref_bank` VALUES ('20366', 'Nusamba Kubutambahan', 'PT BPR Nusamba Kubutambahan');
INSERT INTO `tref_bank` VALUES ('20367', 'Suryajaya Kubutambahan', 'PT BPR Suryajaya Kubutambahan');
INSERT INTO `tref_bank` VALUES ('20368', 'Bali Dananiaga', 'PT BPR Bali Dananiaga');
INSERT INTO `tref_bank` VALUES ('20369', 'Desa Sanur', 'PT BPR Desa Sanur');
INSERT INTO `tref_bank` VALUES ('20370', 'Duta Bali', 'PT BPR Duta Bali');
INSERT INTO `tref_bank` VALUES ('20371', 'Padma', 'PT BPR Padma');
INSERT INTO `tref_bank` VALUES ('20372', 'Picu Manunggal Sejahtera', 'PT BPR Picu Manunggal Sejahtera');
INSERT INTO `tref_bank` VALUES ('20373', 'Pusaka', 'PT BPR Pusaka');
INSERT INTO `tref_bank` VALUES ('20374', 'Sari Sedana', 'PT BPR Sari Sedana');
INSERT INTO `tref_bank` VALUES ('20375', 'Sri Artha Lestari', 'PT BPR Sri Artha Lestari');
INSERT INTO `tref_bank` VALUES ('20376', 'Tata Anjungsari', 'PT BPR Tata Anjungsari');
INSERT INTO `tref_bank` VALUES ('20377', 'Uverad Werdi Bhakti', 'PT BPR Uverad Werdi Bhakti');
INSERT INTO `tref_bank` VALUES ('20378', 'Angsa Sedana Yoga', 'PT BPR Angsa Sedana Yoga');
INSERT INTO `tref_bank` VALUES ('20379', 'Artha Bali Jaya', 'PT BPR Artha Bali Jaya');
INSERT INTO `tref_bank` VALUES ('20380', 'Aruna Nirmala Duta', 'PT BPR Aruna Nirmala Duta');
INSERT INTO `tref_bank` VALUES ('20381', 'Ayudhana Semesta', 'PT BPR Ayudhana Semesta');
INSERT INTO `tref_bank` VALUES ('20382', 'Bali Dewata', 'PT BPR Bali Dewata');
INSERT INTO `tref_bank` VALUES ('20383', 'Baskara Dewata', 'PT BPR Baskara Dewata');
INSERT INTO `tref_bank` VALUES ('20384', 'Dewata Candradana', 'PT BPR Dewata Candradana');
INSERT INTO `tref_bank` VALUES ('20385', 'Eka Ayu Artha Bhuwana', 'PT BPR Eka Ayu Artha Bhuwana');
INSERT INTO `tref_bank` VALUES ('20386', 'Gianyar Partasedana', 'PT BPR Gianyar Partasedana');
INSERT INTO `tref_bank` VALUES ('20387', 'Hari Depan', 'PT BPR Hari Depan');
INSERT INTO `tref_bank` VALUES ('20388', 'Kertiawan', 'PT BPR Kertiawan');
INSERT INTO `tref_bank` VALUES ('20389', 'Krisna Yuna Dana', 'PT BPR Krisna Yuna Dana');
INSERT INTO `tref_bank` VALUES ('20390', 'Mas Giri Wangi', 'PT BPR Mas Giri Wangi');
INSERT INTO `tref_bank` VALUES ('20391', 'Mitra Bali Sri Sedana Mandiri', 'PT BPR Mitra Bali Sri Sedana Mandiri');
INSERT INTO `tref_bank` VALUES ('20392', 'Mulia Wacana', 'PT BPR Mulia Wacana');
INSERT INTO `tref_bank` VALUES ('20393', 'Nusamba Tegalalang', 'PT BPR Nusamba Tegalalang');
INSERT INTO `tref_bank` VALUES ('20394', 'Partakencana Tohpati', 'PT BPR Partakencana Tohpati');
INSERT INTO `tref_bank` VALUES ('20395', 'Pertiwi', 'PT BPR Pertiwi');
INSERT INTO `tref_bank` VALUES ('20396', 'Puskusa Balidwipa', 'PT BPR Puskusa Balidwipa');
INSERT INTO `tref_bank` VALUES ('20397', 'Raga Jayatama', 'PT BPR Raga Jayatama');
INSERT INTO `tref_bank` VALUES ('20398', 'Sari Werdhi Sedana', 'PT BPR Sari Werdhi Sedana');
INSERT INTO `tref_bank` VALUES ('20399', 'Suadana', 'PT BPR Suadana');
INSERT INTO `tref_bank` VALUES ('204', 'BKK Gebang', '');
INSERT INTO `tref_bank` VALUES ('20400', 'Sukawati Pancakanti', 'PT BPR Sukawati Pancakanti');
INSERT INTO `tref_bank` VALUES ('20401', 'Suryajaya Ubud', 'PT BPR Suryajaya Ubud');
INSERT INTO `tref_bank` VALUES ('20402', 'Tish', 'PT BPR Tish');
INSERT INTO `tref_bank` VALUES ('20403', 'Ulatidana Rahayu', 'PT BPR Ulatidana Rahayu');
INSERT INTO `tref_bank` VALUES ('20404', 'Werdhi Sedana', 'PD BPR Werdhi Sedana');
INSERT INTO `tref_bank` VALUES ('20405', 'Ukabima Prima', 'PT BPR Ukabima Prima');
INSERT INTO `tref_bank` VALUES ('20406', 'Danamaster Dewata', 'PT BPR Danamaster Dewata');
INSERT INTO `tref_bank` VALUES ('20407', 'Nusamba Manggis', 'PT BPR Nusamba Manggis');
INSERT INTO `tref_bank` VALUES ('20408', 'Seri Artha Dana', 'PT BPR Seri Artha Dana');
INSERT INTO `tref_bank` VALUES ('20409', 'Mitra Bali Artha Mandiri', 'PT BPR Mitra Bali Artha Mandiri');
INSERT INTO `tref_bank` VALUES ('20410', 'Artha Rengganis', 'PT BPR Artha Rengganis');
INSERT INTO `tref_bank` VALUES ('20411', 'Balaguna Perasta', 'PT BPR Balaguna Perasta');
INSERT INTO `tref_bank` VALUES ('20412', 'Sari Jaya Sedana', 'PT BPR Sari Jaya Sedana');
INSERT INTO `tref_bank` VALUES ('20413', 'Sinar Puteramas', 'PT BPR Sinar Puteramas');
INSERT INTO `tref_bank` VALUES ('20414', 'Tridarma Putri', 'PT BPR Tridarma Putri');
INSERT INTO `tref_bank` VALUES ('20415', 'Adi Sedana Ayu', 'PT BPR Adi Sedana Ayu');
INSERT INTO `tref_bank` VALUES ('20416', 'Indra Candra', 'PT BPR Indra Candra');
INSERT INTO `tref_bank` VALUES ('20417', 'Adi Tami Jaya', 'PT BPR Adi Tami Jaya');
INSERT INTO `tref_bank` VALUES ('20418', 'Amerta Sari', 'PT BPR Amerta Sari');
INSERT INTO `tref_bank` VALUES ('20419', 'Artha Adyamurthi', 'PT BPR Artha Adyamurthi');
INSERT INTO `tref_bank` VALUES ('20420', 'Artha Budaya', 'PT BPR Artha Budaya');
INSERT INTO `tref_bank` VALUES ('20421', 'Ayunulus', 'PT BPR Ayunulus');
INSERT INTO `tref_bank` VALUES ('20422', 'Bumi Prima Dana', 'PT BPR Bumi Prima Dana');
INSERT INTO `tref_bank` VALUES ('20423', 'Dewata Indobank', 'PT BPR Dewata Indobank');
INSERT INTO `tref_bank` VALUES ('20424', 'Dharmawarga Utama', 'PT BPR Dharmawarga Utama');
INSERT INTO `tref_bank` VALUES ('20425', 'HOKI', 'PT BPR HOKI');
INSERT INTO `tref_bank` VALUES ('20426', 'Jero Anom', 'PT BPR Jero Anom');
INSERT INTO `tref_bank` VALUES ('20427', 'Kertha Warga', 'PT BPR Kertha Warga');
INSERT INTO `tref_bank` VALUES ('20428', 'Legian', 'PT BPR Legian');
INSERT INTO `tref_bank` VALUES ('20429', 'Luhur Damai', 'PT BPR Luhur Damai');
INSERT INTO `tref_bank` VALUES ('20430', 'Luhur Pucaksari', 'PT BPR Luhur Pucaksari');
INSERT INTO `tref_bank` VALUES ('20431', 'Merta Amerta', 'PT BPR Merta Amerta');
INSERT INTO `tref_bank` VALUES ('20432', 'Penebel', 'PT BPR Penebel');
INSERT INTO `tref_bank` VALUES ('20433', 'Prisma Bali', 'PT BPR Prisma Bali');
INSERT INTO `tref_bank` VALUES ('20434', 'Restu Dewata', 'PT BPR Restu Dewata');
INSERT INTO `tref_bank` VALUES ('20435', 'Sadhu Artha', 'PT BPR Sadhu Artha');
INSERT INTO `tref_bank` VALUES ('20436', 'Sari Dananiaga', 'PT BPR Sari Dananiaga');
INSERT INTO `tref_bank` VALUES ('20437', 'Sedana Murni', 'PT BPR Sedana Murni');
INSERT INTO `tref_bank` VALUES ('20438', 'Sedana Warga', 'PT BPR Sedana Warga');
INSERT INTO `tref_bank` VALUES ('20439', 'Sedana Yasa', 'PT BPR Sedana Yasa');
INSERT INTO `tref_bank` VALUES ('20440', 'Sentral Ekonomi Nusantara', 'PT BPR Sentral Ekonomi Nusantara');
INSERT INTO `tref_bank` VALUES ('20441', 'Mulya Arta', 'PT BPR Mulya Arta');
INSERT INTO `tref_bank` VALUES ('20442', 'Multi Artha Mas Sejahtera', 'PT BPR Multi Artha Mas Sejahtera');
INSERT INTO `tref_bank` VALUES ('20443', 'Aditama Arta', 'PT BPR Aditama Arta');
INSERT INTO `tref_bank` VALUES ('20444', 'Alsaba Prima', 'PT BPR Alsaba Prima');
INSERT INTO `tref_bank` VALUES ('20445', 'Ana Artha', 'PT BPR Ana Artha');
INSERT INTO `tref_bank` VALUES ('20446', 'Antar Guna', 'PT BPR Antar Guna');
INSERT INTO `tref_bank` VALUES ('20447', 'Ardhie Gede', 'PT BPR Ardhie Gede');
INSERT INTO `tref_bank` VALUES ('20448', 'Arta Pundi Mekar', 'PT BPR Arta Pundi Mekar');
INSERT INTO `tref_bank` VALUES ('20449', 'Artaprima Danajasa', 'PT BPR Artaprima Danajasa');
INSERT INTO `tref_bank` VALUES ('20450', 'Artha Sentana Hardja', 'PT BPR Artha Sentana Hardja');
INSERT INTO `tref_bank` VALUES ('20451', 'Arthamutiara Permai', 'PT BPR Arthamutiara Permai');
INSERT INTO `tref_bank` VALUES ('20452', 'Arthasraya Sejahtera', 'PT BPR Arthasraya Sejahtera');
INSERT INTO `tref_bank` VALUES ('20453', 'Bekasi Bina Tanjung Makmur', 'PT BPR Bekasi Bina Tanjung Makmur');
INSERT INTO `tref_bank` VALUES ('20454', 'Paramindo Kurnia Abadi', 'PT BPR Paramindo Kurnia Abadi');
INSERT INTO `tref_bank` VALUES ('20455', 'Bina Dian Citra', 'PT BPR Bina Dian Citra');
INSERT INTO `tref_bank` VALUES ('20456', 'Binadana Makmur', 'PT BPR Binadana Makmur');
INSERT INTO `tref_bank` VALUES ('20457', 'Bintara Pratama Sejahtera', 'PT BPR Bintara Pratama Sejahtera');
INSERT INTO `tref_bank` VALUES ('20458', 'Bringin Dana Sejahtera', 'PT BPR Bringin Dana Sejahtera');
INSERT INTO `tref_bank` VALUES ('20459', 'Bumi Bekasi Artha', 'PT BPR Bumi Bekasi Artha');
INSERT INTO `tref_bank` VALUES ('20460', 'Cibitung Tanjungraya', 'PT BPR Cibitung Tanjungraya');
INSERT INTO `tref_bank` VALUES ('20461', 'Cikarang Raharja', 'PT BPR Cikarang Raharja');
INSERT INTO `tref_bank` VALUES ('20462', 'Citra Artha Sedana', 'PT BPR Citra Artha Sedana');
INSERT INTO `tref_bank` VALUES ('20463', 'Citra Bersada Abadi', 'PT BPR Citra Bersada Abadi');
INSERT INTO `tref_bank` VALUES ('20464', 'Citra Ladon Rahardja', 'PT BPR Citra Ladon Rahardja');
INSERT INTO `tref_bank` VALUES ('20465', 'Dana Multi Guna', 'PT BPR Dana Multi Guna');
INSERT INTO `tref_bank` VALUES ('20466', 'Danasari Persada', 'PT BPR Danasari Persada');
INSERT INTO `tref_bank` VALUES ('20467', 'Danatama Indonesia', 'PT BPR Danatama Indonesia');
INSERT INTO `tref_bank` VALUES ('20468', 'Darmawan Adhiguna Lestari', 'PT BPR Darmawan Adhiguna Lestari');
INSERT INTO `tref_bank` VALUES ('20469', 'Dian Faraqo Gemilang', 'PT BPR Dian Faraqo Gemilang');
INSERT INTO `tref_bank` VALUES ('20470', 'DP Taspen', 'PT BPR DP Taspen');
INSERT INTO `tref_bank` VALUES ('20471', 'DPM Kredit Mandiri', 'PT BPR DPM Kredit Mandiri');
INSERT INTO `tref_bank` VALUES ('20472', 'Genades Putranindo', 'PT BPR Genades Putranindo');
INSERT INTO `tref_bank` VALUES ('20473', 'Gracia Mandiri', 'PT BPR Gracia Mandiri');
INSERT INTO `tref_bank` VALUES ('20474', 'Handalan Danagraha', 'PT BPR Handalan Danagraha');
INSERT INTO `tref_bank` VALUES ('20475', 'Harapan Saudara', 'PT BPR Harapan Saudara');
INSERT INTO `tref_bank` VALUES ('20476', 'Harta Tanamas', 'PT BPR Harta Tanamas');
INSERT INTO `tref_bank` VALUES ('20477', 'Hosing Jaya', 'PT BPR Hosing Jaya');
INSERT INTO `tref_bank` VALUES ('20478', 'Jayamora Krida', 'PT BPR Jayamora Krida');
INSERT INTO `tref_bank` VALUES ('20479', 'Karinamas Permai', 'PT BPR Karinamas Permai');
INSERT INTO `tref_bank` VALUES ('20480', 'Karya Bakti Sejahtera', 'PT BPR Karya Bakti Sejahtera');
INSERT INTO `tref_bank` VALUES ('20481', 'Karya Kurnia Utama', 'PT BPR Karya Kurnia Utama');
INSERT INTO `tref_bank` VALUES ('20482', 'Kranji Krida Sejahtera', 'PT BPR Kranji Krida Sejahtera');
INSERT INTO `tref_bank` VALUES ('20483', 'LPK Bekasi', 'PD BPR LPK Bekasi');
INSERT INTO `tref_bank` VALUES ('20484', 'LPK Cibarusah', 'PD BPR LPK Cibarusah');
INSERT INTO `tref_bank` VALUES ('20485', 'LPK Cibitung', 'PD BPR LPK Cibitung');
INSERT INTO `tref_bank` VALUES ('20486', 'LPK Pondok Gede', 'PD BPR LPK Pondok Gede');
INSERT INTO `tref_bank` VALUES ('20487', 'LPK Setu', 'PD BPR LPK Setu');
INSERT INTO `tref_bank` VALUES ('20488', 'LPK Sukatani', 'PD BPR LPK Sukatani');
INSERT INTO `tref_bank` VALUES ('20489', 'Lugano', 'PT BPR Lugano');
INSERT INTO `tref_bank` VALUES ('20490', 'Metropolitan Putra', 'PT BPR Metropolitan Putra');
INSERT INTO `tref_bank` VALUES ('20491', 'Mitra Ekonomi Andalas', 'PT BPR Mitra Ekonomi Andalas');
INSERT INTO `tref_bank` VALUES ('20492', 'Mitra Sejahtera Lestari', 'PT BPR Mitra Sejahtera Lestari');
INSERT INTO `tref_bank` VALUES ('20494', 'Nasional Nusantara', 'PT BPR Nasional Nusantara');
INSERT INTO `tref_bank` VALUES ('20495', 'Olympindo Primadana', 'PT BPR Olympindo Primadana');
INSERT INTO `tref_bank` VALUES ('20496', 'Pandanaran Jaya', 'PT BPR Pandanaran Jaya');
INSERT INTO `tref_bank` VALUES ('20497', 'Parasahabat  Bekasi', 'PT BPR Parasahabat  Bekasi');
INSERT INTO `tref_bank` VALUES ('20498', 'Pondasi Niaga Perdana', 'PT BPR Pondasi Niaga Perdana');
INSERT INTO `tref_bank` VALUES ('20499', 'Prabu Mitra', 'PT BPR Prabu Mitra');
INSERT INTO `tref_bank` VALUES ('205', 'Ciawigebang', '');
INSERT INTO `tref_bank` VALUES ('20500', 'Prima Nusatama', 'PT BPR Prima Nusatama');
INSERT INTO `tref_bank` VALUES ('20501', 'Prisma Berlian Danarta', 'PT BPR Prisma Berlian Danarta');
INSERT INTO `tref_bank` VALUES ('20503', 'Sekar', 'PT BPR Sekar');
INSERT INTO `tref_bank` VALUES ('20504', 'Sinarenam Permai Jatiasih', 'PT BPR Sinarenam Permai Jatiasih');
INSERT INTO `tref_bank` VALUES ('20505', 'Siraya Karya Bakti', 'PT BPR Siraya Karya Bakti');
INSERT INTO `tref_bank` VALUES ('20506', 'Siwa Raharja Utama', 'PT BPR Siwa Raharja Utama');
INSERT INTO `tref_bank` VALUES ('20507', 'Sumber Artha Rahayu', 'PT BPR Sumber Artha Rahayu');
INSERT INTO `tref_bank` VALUES ('20508', 'Supradana Mas', 'PT BPR Supradana Mas');
INSERT INTO `tref_bank` VALUES ('20509', 'Talabumi Ekapersada', 'PT BPR Talabumi Ekapersada');
INSERT INTO `tref_bank` VALUES ('20510', 'Trisurya Binaartha', 'PT BPR Trisurya Binaartha');
INSERT INTO `tref_bank` VALUES ('20511', 'Ulima Djumpa Marom', 'PT BPR Ulima Djumpa Marom');
INSERT INTO `tref_bank` VALUES ('20512', 'Universal Mega Mandiri Bekasi', 'PT BPR Universal Mega Mandiri Bekasi');
INSERT INTO `tref_bank` VALUES ('20513', 'Varia Central Artha', 'PT BPR Varia Central Artha');
INSERT INTO `tref_bank` VALUES ('20514', 'Wingsati', 'PT BPR Wingsati');
INSERT INTO `tref_bank` VALUES ('20515', 'Amanah Insani', 'PT BPRS Amanah Insani');
INSERT INTO `tref_bank` VALUES ('20516', 'Artha Karimah Irsyadi', 'PT BPRS Artha Karimah Irsyadi');
INSERT INTO `tref_bank` VALUES ('20517', 'Artha Madani', 'PT BPRS Artha Madani');
INSERT INTO `tref_bank` VALUES ('20518', 'Harta Insan Karimah Bekasi', 'PT BPRS Harta Insan Karimah Bekasi');
INSERT INTO `tref_bank` VALUES ('20519', 'Kota Bekasi', 'PD BPRS Kota Bekasi');
INSERT INTO `tref_bank` VALUES ('20520', 'Saleh Artha', 'PT BPRS Saleh Artha');
INSERT INTO `tref_bank` VALUES ('20521', 'Nurani Kami', 'PT BPR Nurani Kami');
INSERT INTO `tref_bank` VALUES ('20522', 'Artamitra Bumimanunggal', 'PT BPR Artamitra Bumimanunggal');
INSERT INTO `tref_bank` VALUES ('20523', 'Artha Bersama Sejahtera', 'PT BPR Artha Bersama Sejahtera');
INSERT INTO `tref_bank` VALUES ('20524', 'Artha Jaya Citeureup', 'PT BPR Artha Jaya Citeureup');
INSERT INTO `tref_bank` VALUES ('20525', 'Artha Karya Sejahtera', 'PT BPR Artha Karya Sejahtera');
INSERT INTO `tref_bank` VALUES ('20526', 'Artha Kurnia Raharja', 'PT BPR Artha Kurnia Raharja');
INSERT INTO `tref_bank` VALUES ('20527', 'Berfasi Raharja', 'PT BPR Berfasi Raharja');
INSERT INTO `tref_bank` VALUES ('20528', 'Nusantara Bona Pasogit 14', 'PT BPR Nusantara Bona Pasogit 14');
INSERT INTO `tref_bank` VALUES ('20529', 'Bumiasih NBP 2', 'PT BPR Bumiasih NBP 2');
INSERT INTO `tref_bank` VALUES ('20530', 'Cileungsi Krida Sejahtera', 'PT BPR Cileungsi Krida Sejahtera');
INSERT INTO `tref_bank` VALUES ('20531', 'Datagita Mustika', 'PT BPR Datagita Mustika');
INSERT INTO `tref_bank` VALUES ('20532', 'Duta Pakuan Mandiri', 'PT BPR Duta Pakuan Mandiri');
INSERT INTO `tref_bank` VALUES ('20533', 'Gebu Kujang Kinantan', 'PT BPR Gebu Kujang Kinantan');
INSERT INTO `tref_bank` VALUES ('20534', 'Hitamajaya Argamandiri', 'PT BPR Hitamajaya Argamandiri');
INSERT INTO `tref_bank` VALUES ('20535', 'Indomitra Artha Pertiwi', 'PT BPR Indomitra Artha Pertiwi');
INSERT INTO `tref_bank` VALUES ('20536', 'Kota Bogor', 'PD BPR Bank Pasar Kota Bogor');
INSERT INTO `tref_bank` VALUES ('20537', 'Kujang Artha Sembada', 'PT BPR Kujang Artha Sembada');
INSERT INTO `tref_bank` VALUES ('20538', 'LPK Citeureup', 'PD BPR LPK Citeureup');
INSERT INTO `tref_bank` VALUES ('20539', 'LPK Leuwiliang', 'PD BPR LPK Leuwiliang');
INSERT INTO `tref_bank` VALUES ('20540', 'LPK Pancoran Mas', 'PD BPR LPK Pancoran Mas');
INSERT INTO `tref_bank` VALUES ('20541', 'LPK Parungpanjang', 'PD BPR LPK Parungpanjang');
INSERT INTO `tref_bank` VALUES ('20542', 'Mitra Daya Mandiri', 'PT BPR Mitra Daya Mandiri');
INSERT INTO `tref_bank` VALUES ('20543', 'Muliatama Dananjaya', 'PT BPR Muliatama Dananjaya');
INSERT INTO `tref_bank` VALUES ('20544', 'Nature Primadana Capital', 'PT BPR Nature Primadana Capital');
INSERT INTO `tref_bank` VALUES ('20545', 'Parasahabat Bogor', 'PT BPR Parasahabat Bogor');
INSERT INTO `tref_bank` VALUES ('20546', 'Rama Ganda', 'PT BPR Rama Ganda');
INSERT INTO `tref_bank` VALUES ('20547', 'Sebaru Sejahtera Lestari', 'PT BPR Sebaru Sejahtera Lestari');
INSERT INTO `tref_bank` VALUES ('20548', 'Sumber Ekonomi', 'PT BPR Sumber Ekonomi');
INSERT INTO `tref_bank` VALUES ('20549', 'Sumber Lumbanmual', 'PT BPR Sumber Lumbanmual');
INSERT INTO `tref_bank` VALUES ('20550', 'Supra Wahana Arta', 'PT BPR Supra Wahana Arta');
INSERT INTO `tref_bank` VALUES ('20551', 'Surya Kencana - Bogor', 'PT BPR Surya Kencana - Bogor');
INSERT INTO `tref_bank` VALUES ('20552', 'Tri Sejahtera Makmur', 'PT BPR Tri Sejahtera Makmur');
INSERT INTO `tref_bank` VALUES ('20553', 'Tricipta Mandiri', 'PT BPR Tricipta Mandiri');
INSERT INTO `tref_bank` VALUES ('20554', 'Universal Karya Mandiri Cibinong', 'PT BPR Universal Karya Mandiri Cibinong');
INSERT INTO `tref_bank` VALUES ('20555', 'Amanah Ummah', 'PT BPRS Amanah Ummah');
INSERT INTO `tref_bank` VALUES ('20556', 'Bina Rahmah', 'PT BPRS Bina Rahmah');
INSERT INTO `tref_bank` VALUES ('20557', 'Insan Cita Artha Jaya', 'PT BPRS Insan Cita Artha Jaya');
INSERT INTO `tref_bank` VALUES ('20558', 'Rif\'atul Ummah', 'PT BPRS Rif\'atul Ummah');
INSERT INTO `tref_bank` VALUES ('20559', 'Laksana Binacilegon', 'PT BPR Laksana Binacilegon');
INSERT INTO `tref_bank` VALUES ('20560', 'Mega Artha Sejahtera', 'PT BPR Mega Artha Sejahtera');
INSERT INTO `tref_bank` VALUES ('20561', 'Baitul Muawanah', 'PT BPRS Baitul Muawanah');
INSERT INTO `tref_bank` VALUES ('20562', 'Cilegon Mandiri', 'PD BPRS Cilegon Mandiri');
INSERT INTO `tref_bank` VALUES ('20563', 'Apta Sejahtera', 'PT BPR Apta Sejahtera');
INSERT INTO `tref_bank` VALUES ('20564', 'Karunia', 'PT BPR Karunia');
INSERT INTO `tref_bank` VALUES ('20565', 'Artha Bersama', 'PT BPR Artha Bersama');
INSERT INTO `tref_bank` VALUES ('20566', 'Arthaguna Sejahtera', 'PT BPR Arthaguna Sejahtera');
INSERT INTO `tref_bank` VALUES ('20567', 'Arthakelola Cahayatama', 'PT BPR Arthakelola Cahayatama');
INSERT INTO `tref_bank` VALUES ('20568', 'Bantoru Perintis', 'PT BPR Bantoru Perintis');
INSERT INTO `tref_bank` VALUES ('20569', 'Brata Bhakti Sejahtera', 'PT BPR Brata Bhakti Sejahtera');
INSERT INTO `tref_bank` VALUES ('20570', 'Nusantara Bona Pasogit 19', 'PT BPR Nusantara Bona Pasogit 19');
INSERT INTO `tref_bank` VALUES ('20571', 'Cibitung Permai', 'PT BPR Cibitung Permai');
INSERT INTO `tref_bank` VALUES ('20572', 'Cinere Artha Raya', 'PT BPR Cinere Artha Raya');
INSERT INTO `tref_bank` VALUES ('20573', 'Dana Lestari', 'PT BPR Dana Lestari');
INSERT INTO `tref_bank` VALUES ('20574', 'Danaberkah Lestari', 'PT BPR Danaberkah Lestari');
INSERT INTO `tref_bank` VALUES ('20575', 'Daya Perdana Nusantara', 'PT BPR Daya Perdana Nusantara');
INSERT INTO `tref_bank` VALUES ('20576', 'Depo Mitra Mandiri', 'PT BPR Depo Mitra Mandiri');
INSERT INTO `tref_bank` VALUES ('20577', 'Difobutama', 'PT BPR Difobutama');
INSERT INTO `tref_bank` VALUES ('20578', 'Efita Dana Sejahtera', 'PT BPR Efita Dana Sejahtera');
INSERT INTO `tref_bank` VALUES ('20579', 'Fajar Artha Makmur', 'PT BPR Fajar Artha Makmur');
INSERT INTO `tref_bank` VALUES ('20580', 'Laksana Binacimanggis', 'PT BPR Laksana Binacimanggis');
INSERT INTO `tref_bank` VALUES ('20581', 'LPK Sawangan - Depok', 'PD BPR LPK Sawangan');
INSERT INTO `tref_bank` VALUES ('20582', 'Mega Karsa Mandiri', 'PT BPR Mega Karsa Mandiri');
INSERT INTO `tref_bank` VALUES ('20583', 'Mitra Agung Nasari', 'PT BPR Mitra Agung Nasari');
INSERT INTO `tref_bank` VALUES ('20584', 'Mitra Karya', 'PT BPR Mitra Karya');
INSERT INTO `tref_bank` VALUES ('20585', 'Naribi Perkasa', 'PT BPR Naribi Perkasa');
INSERT INTO `tref_bank` VALUES ('20586', 'Panca Danarakyat', 'PT BPR Panca Danarakyat');
INSERT INTO `tref_bank` VALUES ('20587', 'Prima Kredit Mandiri', 'PT BPR Prima Kredit Mandiri');
INSERT INTO `tref_bank` VALUES ('20588', 'Sukma Kemang Agung', 'PT BPR Sukma Kemang Agung');
INSERT INTO `tref_bank` VALUES ('20589', 'Swadana Tridharma', 'PT BPR Swadana Tridharma');
INSERT INTO `tref_bank` VALUES ('20590', 'Tridharma Depok', 'PT BPR Tridharma Depok');
INSERT INTO `tref_bank` VALUES ('20591', 'Tunggal Asamukti', 'PT BPR Tunggal Asamukti');
INSERT INTO `tref_bank` VALUES ('20592', 'Al Barokah', 'PT BPRS Al Barokah');
INSERT INTO `tref_bank` VALUES ('20593', 'Al Salaam Amal Salman', 'PT BPRS Al Salaam Amal Salman');
INSERT INTO `tref_bank` VALUES ('20594', 'Al Hijrah Amanah', 'PT BPRS Al Hijrah Amanah');
INSERT INTO `tref_bank` VALUES ('20595', 'Bina Amwalul Hasanah', 'PT BPRS Bina Amwalul Hasanah');
INSERT INTO `tref_bank` VALUES ('20596', 'Daya Arta', 'PT BPR Daya Arta');
INSERT INTO `tref_bank` VALUES ('20597', 'Puspita Sari', 'Koperasi BPR Puspita Sari');
INSERT INTO `tref_bank` VALUES ('20598', 'Intidana Sukses Makmur', 'PT BPR Intidana Sukses Makmur');
INSERT INTO `tref_bank` VALUES ('20599', 'Multi Sembada Dana', 'PT BPR Sembada Dana');
INSERT INTO `tref_bank` VALUES ('206', 'Pasar Subang', '');
INSERT INTO `tref_bank` VALUES ('20600', 'Mutiara Jaya Sukses', 'PT BPR Mutiara Jaya Sukses');
INSERT INTO `tref_bank` VALUES ('20601', 'Hidayah', 'PT BPRS Hidayah');
INSERT INTO `tref_bank` VALUES ('20602', 'Anugerah Artasentosa Prima', 'PT BPR Anugerah Artasentosa Prima');
INSERT INTO `tref_bank` VALUES ('20603', 'Artharindo', 'PT BPR Artharindo');
INSERT INTO `tref_bank` VALUES ('20604', 'Bahtera Masyarakat', 'PT BPR Bahtera Masyarakat');
INSERT INTO `tref_bank` VALUES ('20605', 'Banksar Dana Loka', 'PT BPR Banksar Dana Loka');
INSERT INTO `tref_bank` VALUES ('20606', 'Mandiri Artha Niaga Prima', 'PT BPR Mandiri Artha Niaga Prima');
INSERT INTO `tref_bank` VALUES ('20607', 'Mitra Dana Utama', 'PT BPR Mitra Dana Utama');
INSERT INTO `tref_bank` VALUES ('20608', 'Mora', 'PT BPR Mora');
INSERT INTO `tref_bank` VALUES ('20609', 'Rasyid', 'PT BPR Rasyid');
INSERT INTO `tref_bank` VALUES ('20610', 'Sarana Utama Multidana', 'PT BPR Sarana Utama Multidana');
INSERT INTO `tref_bank` VALUES ('20611', 'Swadaya Tunggal', 'PT BPR Swadaya Tunggal');
INSERT INTO `tref_bank` VALUES ('20612', 'Nova Trijaya', 'PT BPR Nova Trijaya');
INSERT INTO `tref_bank` VALUES ('20613', 'Pesona Letris Pratama', 'PT BPR Pesona Letris Pratama');
INSERT INTO `tref_bank` VALUES ('20614', 'Cempaka Al Amin', 'PT BPRS Cempaka Al Amin');
INSERT INTO `tref_bank` VALUES ('20615', 'Tapeuna Dana', 'PT BPR Tapeuna Dana');
INSERT INTO `tref_bank` VALUES ('20616', 'Bina Dana Swadaya', 'PT BPR Dana Swadaya');
INSERT INTO `tref_bank` VALUES ('20617', 'Haneda Mitra Usaha', 'PT BPR Haneda Mitra Usaha');
INSERT INTO `tref_bank` VALUES ('20618', 'Bina Dana Cakrawala', 'PT BPR Bina Dana Cakrawala');
INSERT INTO `tref_bank` VALUES ('20619', 'Dana Usaha', 'PT BPR Dana Usaha');
INSERT INTO `tref_bank` VALUES ('20620', 'Kapital Metropolitan', 'PT BPR Kapital Metropolitan');
INSERT INTO `tref_bank` VALUES ('20621', 'Olympindo Sejahtera', 'PT BPR Olympindo Sejahtera');
INSERT INTO `tref_bank` VALUES ('20622', 'Tata Karya Indonesia', 'PT BPR Tata Karya Indonesia');
INSERT INTO `tref_bank` VALUES ('20623', 'Anugerah Multi Dana', 'PT BPR Anugerah Multi Dana');
INSERT INTO `tref_bank` VALUES ('20624', 'Bangun Mitra Wadas', 'PT BPR Bangun Mitra Wadas');
INSERT INTO `tref_bank` VALUES ('20625', 'BKPD Cilamaya', 'PD BPR BKPD Cilamaya');
INSERT INTO `tref_bank` VALUES ('20626', 'Nusantara Bona Pasogit 32', 'PT BPR Nusantara Bona Pasogit 32');
INSERT INTO `tref_bank` VALUES ('20627', 'Gema Esamas Abadi', 'PT BPR Gema Esamas Abadi');
INSERT INTO `tref_bank` VALUES ('20628', 'Laksana Luhurcilamaya', 'PT BPR Laksana Luhurcilamaya');
INSERT INTO `tref_bank` VALUES ('20629', 'Mitra Telagasari Utama', 'PT BPR Mitra Telagasari Utama');
INSERT INTO `tref_bank` VALUES ('20630', 'Pantura Abadi', 'PT BPR Pantura Abadi');
INSERT INTO `tref_bank` VALUES ('20631', 'Polin Jaya', 'PT BPR Polin Jaya');
INSERT INTO `tref_bank` VALUES ('20632', 'Sanggabuana Agung', 'PT BPR Sanggabuana Agung');
INSERT INTO `tref_bank` VALUES ('20633', 'Saudara Kita', 'PT BPR Saudara Kita');
INSERT INTO `tref_bank` VALUES ('20634', 'Sayma Karya', 'PT BPR Sayma Karya');
INSERT INTO `tref_bank` VALUES ('20635', 'Sumber Pangasean', 'PT BPR Sumber Pangasean');
INSERT INTO `tref_bank` VALUES ('20636', 'Suwaya Kurada', 'PT BPR Suwaya Kurada');
INSERT INTO `tref_bank` VALUES ('20637', 'Trisurya Tata Artha', 'PT BPR Trisurya Tata Artha');
INSERT INTO `tref_bank` VALUES ('20638', 'LPK Cipanas', 'PD BPR LPK Cipanas');
INSERT INTO `tref_bank` VALUES ('20639', 'LPK Malingping', 'PD BPR LPK Malingping');
INSERT INTO `tref_bank` VALUES ('20640', 'LPK Warunggunung', 'PD BPR LPK Warunggunung');
INSERT INTO `tref_bank` VALUES ('20641', 'Amal Bhakti Sejahtera', 'PT BPR Amal Bhakti Sejahtera');
INSERT INTO `tref_bank` VALUES ('20642', 'LPK Saketi', 'PD BPR LPK Saketi');
INSERT INTO `tref_bank` VALUES ('20643', 'Swadaya Masyarakat', 'PT BPR Swadaya Masyarakat');
INSERT INTO `tref_bank` VALUES ('20644', 'Cakra Dharma Artamandiri', 'PT BPR Cakra Dharma Artamandiri');
INSERT INTO `tref_bank` VALUES ('20645', 'Lambang Ganda', 'PT BPR Lambang Ganda');
INSERT INTO `tref_bank` VALUES ('20646', 'LPK Serang', 'PD BPR LPK Serang');
INSERT INTO `tref_bank` VALUES ('20647', 'Magga Jaya Utama', 'PT BPR Magga Jaya Utama');
INSERT INTO `tref_bank` VALUES ('20648', 'Aneka Danaraya', 'PT BPR Aneka Danaraya');
INSERT INTO `tref_bank` VALUES ('20649', 'Anugrah Swakerta', 'PT BPR Anugrah Swakerta');
INSERT INTO `tref_bank` VALUES ('20650', 'Arta Jakarta', 'PT BPR Arta Jakarta');
INSERT INTO `tref_bank` VALUES ('20651', 'Arta Mukti Triputra', 'PT BPR Arta Mukti Triputra');
INSERT INTO `tref_bank` VALUES ('20652', 'Artadamas Mandiri', 'PT BPR Artadamas Mandiri');
INSERT INTO `tref_bank` VALUES ('20653', 'Artha Mitra Usaha', 'PT BPR Artha Mitra Usaha');
INSERT INTO `tref_bank` VALUES ('20654', 'Asri Cikupa Karya', 'PT BPR Asri Cikupa Karya');
INSERT INTO `tref_bank` VALUES ('20655', 'Bintang Ekonomi Sejahtera', 'PT BPR Bintang Ekonomi Sejahtera');
INSERT INTO `tref_bank` VALUES ('20656', 'Bumi Dhana Adigraha', 'PT BPR Bumi Dhana Adigraha');
INSERT INTO `tref_bank` VALUES ('20657', 'Nusantara Bona Pasogit 12', 'PT BPR Nusantara Bona Pasogit 12');
INSERT INTO `tref_bank` VALUES ('20658', 'Cahaya Arthasejati', 'PT BPR Cahaya Arthasejati');
INSERT INTO `tref_bank` VALUES ('20659', 'Cakra Danarta', 'PT BPR Cakra Danarta');
INSERT INTO `tref_bank` VALUES ('20660', 'Central Artha Rezeki', 'PT BPR Central Artha Rezeki');
INSERT INTO `tref_bank` VALUES ('20661', 'Ciledug Dhana Semesta', 'PT BPR Ciledug Dhana Semesta');
INSERT INTO `tref_bank` VALUES ('20662', 'Cita Makmur Lestari', 'PT BPR Cita Makmur Lestari');
INSERT INTO `tref_bank` VALUES ('20663', 'Dana Niaga', 'PT BPR Dana Niaga');
INSERT INTO `tref_bank` VALUES ('20664', 'Danamitra Megah', 'PT BPR Danamitra Megah');
INSERT INTO `tref_bank` VALUES ('20665', 'Darbeni Rizki', 'PT BPR Darbeni Rizki');
INSERT INTO `tref_bank` VALUES ('20666', 'Fidusia Civitas', 'PT BPR Fidusia Civitas');
INSERT INTO `tref_bank` VALUES ('20667', 'Gamon', 'PT BPR Gamon');
INSERT INTO `tref_bank` VALUES ('20668', 'Gunung Tambora', 'PT BPR Gunung Tambora');
INSERT INTO `tref_bank` VALUES ('20669', 'Hariarta Sedana', 'PT BPR Hariarta Sedana');
INSERT INTO `tref_bank` VALUES ('20670', 'Hipmi Jaya', 'PT BPR Hipmi Jaya');
INSERT INTO `tref_bank` VALUES ('20671', 'Indomitra Adil Jaya', 'PT BPR Indomitra Adil Jaya');
INSERT INTO `tref_bank` VALUES ('20672', 'Artha Makmur Lestari', 'PT BPR Artha Makmur Lestari');
INSERT INTO `tref_bank` VALUES ('20674', 'Kerta Raharja', 'PD BPR Kerta Raharja');
INSERT INTO `tref_bank` VALUES ('20675', 'Kreo Lestari', 'PT BPR Kreo Lestari');
INSERT INTO `tref_bank` VALUES ('20676', 'Kuta Bumi Sidomukti', 'PT BPR Kuta Bumi Sidomukti');
INSERT INTO `tref_bank` VALUES ('20677', 'Laksana Lestari Serpong', 'PT BPR Laksana Lestari Serpong');
INSERT INTO `tref_bank` VALUES ('20678', 'Lumasindo Perkasa Putra', 'PT BPR Lumasindo Perkasa Putra');
INSERT INTO `tref_bank` VALUES ('20679', 'Lumbung Mekar Sentosa', 'PT BPR Lumbung Mekar Sentosa');
INSERT INTO `tref_bank` VALUES ('20680', 'Mahkota Artha Sejahtera', 'PT BPR Mahkota Artha Sejahtera');
INSERT INTO `tref_bank` VALUES ('20681', 'Makmur Artha Sedaya', 'PT BPR Makmur Artha Sedaya');
INSERT INTO `tref_bank` VALUES ('20682', 'Makmur Merata', 'PT BPR Makmur Merata');
INSERT INTO `tref_bank` VALUES ('20683', 'Marcorindo Perdana', 'PT BPR Marcorindo Perdana');
INSERT INTO `tref_bank` VALUES ('20684', 'Matahari Artadaya', 'PT BPR Matahari Artadaya');
INSERT INTO `tref_bank` VALUES ('20685', 'Menaramas Mitra', 'PT BPR Menaramas Mitra');
INSERT INTO `tref_bank` VALUES ('20686', 'Mitrabina Arthamakmur', 'PT BPR Mitrabina Arthamakmur');
INSERT INTO `tref_bank` VALUES ('20687', 'Muara Sumber Dana', 'PT BPR Muara Sumber Dana');
INSERT INTO `tref_bank` VALUES ('20688', 'Multi Paramindo Abadi', 'PT BPR Multi Paramindo Abadi');
INSERT INTO `tref_bank` VALUES ('20689', 'Niaga Mandiri', 'PT BPR Niaga Mandiri');
INSERT INTO `tref_bank` VALUES ('20690', 'Pinang Artha', 'PT BPR Pinang Artha');
INSERT INTO `tref_bank` VALUES ('20691', 'Prima Kredit Sejahtera', 'PT BPR Prima Kredit Sejahtera');
INSERT INTO `tref_bank` VALUES ('20692', 'Pularta Mandiri', 'PT BPR Pularta Mandiri');
INSERT INTO `tref_bank` VALUES ('20693', 'Pusaka Dana', 'PT BPR Pusaka Dana');
INSERT INTO `tref_bank` VALUES ('20694', 'Ragam Danakencana', 'PT BPR Ragam Danakencana');
INSERT INTO `tref_bank` VALUES ('20695', 'Ragam Peranmandiri', 'PT BPR Ragam Peranmandiri');
INSERT INTO `tref_bank` VALUES ('20696', 'Ragasakti', 'PT BPR Ragasakti');
INSERT INTO `tref_bank` VALUES ('20697', 'Rifi Maligi', 'PT BPR Rifi Maligi');
INSERT INTO `tref_bank` VALUES ('20698', 'Rizky Barokah', 'PT BPR Rizky Barokah');
INSERT INTO `tref_bank` VALUES ('20699', 'Sehat Sejahtera', 'PT BPR Sehat Sejahtera');
INSERT INTO `tref_bank` VALUES ('207', 'Monta Baru', '');
INSERT INTO `tref_bank` VALUES ('20700', 'Sinar Mitra Sejahtera', 'PT BPR Sinar Mitra Sejahtera');
INSERT INTO `tref_bank` VALUES ('20701', 'Sisibahari Dana', 'PT BPR Sisibahari Dana');
INSERT INTO `tref_bank` VALUES ('20702', 'Timika Dinamika Sarana', 'PT BPR Timika Dinamika Sarana');
INSERT INTO `tref_bank` VALUES ('20703', 'Trimahesa Lestari', 'PT BPR Trimahesa Lestari');
INSERT INTO `tref_bank` VALUES ('20704', 'Tritama Lumbung Cemerlang', 'PT BPR Tritama Lumbung Cemerlang');
INSERT INTO `tref_bank` VALUES ('20705', 'Tunas Jaya Global', 'PT BPR Tunas Jaya Global');
INSERT INTO `tref_bank` VALUES ('20706', 'Attaqwa Garuda Utama', 'PT BPRS Attaqwa Garuda Utama');
INSERT INTO `tref_bank` VALUES ('20707', 'Berkah Ramadhan', 'PT BPRS Berkah Ramadhan');
INSERT INTO `tref_bank` VALUES ('20708', 'Harta Insan Karimah', 'PT BPRS Harta Insan Karimah');
INSERT INTO `tref_bank` VALUES ('20709', 'Musyarakah Ummat Indonesia (MUSTINDO)', 'PT BPRS Musyarakah Ummat Indonesia (MUSTINDO)');
INSERT INTO `tref_bank` VALUES ('20710', 'Mulia Berkah Abadi', 'PT BPRS Mulia Berkah Abadi');
INSERT INTO `tref_bank` VALUES ('20711', 'Wakalumi', 'PT BPRS Wakalumi');
INSERT INTO `tref_bank` VALUES ('20712', 'Athena Surya Prima', 'PT BPR Athena Surya Prima');
INSERT INTO `tref_bank` VALUES ('20713', 'Gita Makmur Utama', 'PT BPR Gita Makmur Utama');
INSERT INTO `tref_bank` VALUES ('20714', 'Bungo Mandiri', 'PT BPR Bungo Mandiri');
INSERT INTO `tref_bank` VALUES ('20715', 'Artha Prima Persada', 'PT BPR Artha Prima Persada');
INSERT INTO `tref_bank` VALUES ('20716', 'Batanghari', 'PT BPR Batanghari');
INSERT INTO `tref_bank` VALUES ('20717', 'Central Dana Mandiri', 'PT BPR Central Dana Mandiri');
INSERT INTO `tref_bank` VALUES ('20718', 'Central Niaga Abadi', 'PT BPR Central Niaga Abadi');
INSERT INTO `tref_bank` VALUES ('20719', 'Kencana Mandiri', 'PT BPR Kencana Mandiri');
INSERT INTO `tref_bank` VALUES ('20720', 'Mitra Lestari', 'PT BPR Mitra Lestari');
INSERT INTO `tref_bank` VALUES ('20721', 'Universal Sentosa', 'PT BPR Universal Sentosa');
INSERT INTO `tref_bank` VALUES ('20722', 'Pembangunan Kerinci', 'PT BPR Pembangunan Kerinci');
INSERT INTO `tref_bank` VALUES ('20723', 'Pondok Meja Indah', 'PT BPR Pondok Meja Indah');
INSERT INTO `tref_bank` VALUES ('20724', 'Rap Ganda', 'PT BPR Rap Ganda');
INSERT INTO `tref_bank` VALUES ('20725', 'Tanggo Rajo', 'PD BPR Tanggo Rajo');
INSERT INTO `tref_bank` VALUES ('20726', 'Phidectama  Biak', 'PT BPR Phidectama  Biak');
INSERT INTO `tref_bank` VALUES ('20727', 'Muamalat Yotefa', 'PT BPRS Muamalat Yotefa');
INSERT INTO `tref_bank` VALUES ('20728', 'Irian Sentosa', 'PT BPR Irian Sentosa');
INSERT INTO `tref_bank` VALUES ('20729', 'Nusa Intim Sentani', 'PT BPR Nusa Intim Sentani');
INSERT INTO `tref_bank` VALUES ('20730', 'Papua Mandiri Makmur', 'PT BPR Papua Mandiri Makmur');
INSERT INTO `tref_bank` VALUES ('20731', 'Phidectama Abepura', 'PT BPR Phidectama Abepura');
INSERT INTO `tref_bank` VALUES ('20732', 'Phidectama Sentani', 'PT BPR Phidectama Sentani');
INSERT INTO `tref_bank` VALUES ('20733', 'Arfak Indonesia', 'PT BPR Arfak Indonesia');
INSERT INTO `tref_bank` VALUES ('20734', 'Anugerah Dharmayuwana', 'PT BPR Anugerah Dharmayuwana');
INSERT INTO `tref_bank` VALUES ('20735', 'Artha Nirwana', 'PT BPR Artha Nirwana');
INSERT INTO `tref_bank` VALUES ('20736', 'Bagong Inti Marga', 'PT BPR Bagong Inti Marga');
INSERT INTO `tref_bank` VALUES ('20737', 'Blambangan Makmur', 'PT BPR Blambangan Makmur');
INSERT INTO `tref_bank` VALUES ('20738', 'Bumi Masyarakat Sejahtera', 'PT BPR Bumi Masyarakat Sejahtera');
INSERT INTO `tref_bank` VALUES ('20739', 'Delta Artha Panggung Banyuwangi', 'PT BPR Delta Artha Panggung Banyuwangi');
INSERT INTO `tref_bank` VALUES ('20740', 'Genteng', 'PT BPR Genteng');
INSERT INTO `tref_bank` VALUES ('20741', 'Jajag Lestari', 'PT BPR Jajag Lestari');
INSERT INTO `tref_bank` VALUES ('20742', 'Mahkota Reksaguna Artha', 'PT BPR Mahkota Reksaguna Artha');
INSERT INTO `tref_bank` VALUES ('20743', 'Nusamba Genteng', 'PT BPR Nusamba Genteng');
INSERT INTO `tref_bank` VALUES ('20744', 'Purwoharjo Lestari', 'PT BPR Purwoharjo Lestari');
INSERT INTO `tref_bank` VALUES ('20745', 'Restudhana Citrasejahtera', 'PT BPR Restudhana Citrasejahtera');
INSERT INTO `tref_bank` VALUES ('20746', 'Rogojampi Arta Niaga', 'PT BPR Rogojampi Arta Niaga');
INSERT INTO `tref_bank` VALUES ('20747', 'Sanggar Adiartha Nugraha', 'PT BPR Sanggar Adiartha Nugraha');
INSERT INTO `tref_bank` VALUES ('20748', 'Swadhanamas Pakto', 'PT BPR Swadhanamas Pakto');
INSERT INTO `tref_bank` VALUES ('20749', 'Tawang Alun', 'Koperasi BPR Tawang Alun');
INSERT INTO `tref_bank` VALUES ('20750', 'Wilis Putra Utama', 'PT BPR Wilis Putra Utama');
INSERT INTO `tref_bank` VALUES ('20751', 'Bintang Mas Maesan', 'PT BPR Bintang Mas Maesan');
INSERT INTO `tref_bank` VALUES ('20752', 'Delta Bondowoso', 'PT BPR Delta Bondowoso');
INSERT INTO `tref_bank` VALUES ('20753', 'Manuk Ayu', 'PT BPR Manuk Ayu');
INSERT INTO `tref_bank` VALUES ('20754', 'Manuk Wari', 'PT BPR Manuk Wari');
INSERT INTO `tref_bank` VALUES ('20755', 'Sari Dinarmas', 'PT BPR Sari Dinarmas');
INSERT INTO `tref_bank` VALUES ('20756', 'Ambulu Dhanaartha', 'PT BPR Ambulu Dhanaartha');
INSERT INTO `tref_bank` VALUES ('20757', 'Artha Asri Mulia', 'PT BPR Artha Asri Mulia');
INSERT INTO `tref_bank` VALUES ('20758', 'Artha Tunasmukti', 'PT BPR Artha Tunasmukti');
INSERT INTO `tref_bank` VALUES ('20759', 'Balung Artha Guna', 'PT BPR Balung Artha Guna');
INSERT INTO `tref_bank` VALUES ('20760', 'Bapuri', 'PT BPR Bapuri');
INSERT INTO `tref_bank` VALUES ('20761', 'Bima Hayu Pratama', 'PT BPR Bima Hayu Pratama');
INSERT INTO `tref_bank` VALUES ('20762', 'Bintang Niaga', 'PT BPR Bintang Niaga');
INSERT INTO `tref_bank` VALUES ('20763', 'Bumi Hayu', 'PT BPR Bumi Hayu');
INSERT INTO `tref_bank` VALUES ('20764', 'Cinde Wilis', 'PT BPR Cinde Wilis');
INSERT INTO `tref_bank` VALUES ('20765', 'Delta Jember', 'PT BPR Delta Jember');
INSERT INTO `tref_bank` VALUES ('20766', 'Eka Usaha', 'Koperasi BPR Eka Usaha');
INSERT INTO `tref_bank` VALUES ('20767', 'Gunung Modal Usaha', 'PT BPR Gunung Modal Usaha');
INSERT INTO `tref_bank` VALUES ('20768', 'Jember Lestari', 'PT BPR Jember Lestari');
INSERT INTO `tref_bank` VALUES ('20769', 'Kalisat Arthawira', 'PT BPR Kalisat Arthawira');
INSERT INTO `tref_bank` VALUES ('20770', 'Karunia Pakto', 'PT BPR Karunia Pakto');
INSERT INTO `tref_bank` VALUES ('20771', 'Mitra Jaya Mandiri', 'PT BPR Mitra Jaya Mandiri');
INSERT INTO `tref_bank` VALUES ('20772', 'Nur Semesta Indah', 'PT BPR Nur Semesta Indah');
INSERT INTO `tref_bank` VALUES ('20773', 'Nusamba Rambipuji', 'PT BPR Nusamba Rambipuji');
INSERT INTO `tref_bank` VALUES ('20774', 'Puji Raharja', 'PT BPR Puji Raharja');
INSERT INTO `tref_bank` VALUES ('20775', 'Rambi Artha Putra', 'PT BPR Rambi Artha Putra');
INSERT INTO `tref_bank` VALUES ('20776', 'Rini Bhaktinusa', 'PT BPR Rini Bhaktinusa');
INSERT INTO `tref_bank` VALUES ('20777', 'Sinar Wuluhan Artha', 'PT BPR Sinar Wuluhan Artha');
INSERT INTO `tref_bank` VALUES ('20778', 'Sukowono Arthajaya', 'PT BPR Sukowono Arthajaya');
INSERT INTO `tref_bank` VALUES ('20779', 'Surya Kencana - Jember', 'Koperasi BPR Balung Artha Guna');
INSERT INTO `tref_bank` VALUES ('20780', 'Tanggul Makmur', 'Koperasi BPR Tanggul Makmur');
INSERT INTO `tref_bank` VALUES ('20781', 'Tanggul Mitra Karya', 'PT BPR Tanggul Mitra Karya');
INSERT INTO `tref_bank` VALUES ('20782', 'Artha Sinar Mentari', 'PT BPRS Artha Sinar Mentari');
INSERT INTO `tref_bank` VALUES ('20783', 'Artha Waringin Jaya', 'PT BPR Artha Waringin Jaya');
INSERT INTO `tref_bank` VALUES ('20784', 'Delta Artha Panggung Situbondo', 'PT BPR Delta Artha Panggung Situbondo');
INSERT INTO `tref_bank` VALUES ('20785', 'Manuk Walet', 'PT BPR Manuk Walet');
INSERT INTO `tref_bank` VALUES ('20786', 'Tridana Kencana', 'PT BPR Tridana Kencana');
INSERT INTO `tref_bank` VALUES ('20787', 'Syariah Situbondo', 'PT BPRS Syariah Situbondo');
INSERT INTO `tref_bank` VALUES ('20788', 'Artha Praja', 'PT BPR Artha Praja');
INSERT INTO `tref_bank` VALUES ('20789', 'Cahaya Bumi Artha', 'Koperasi BPR Cahaya Bumi Artha');
INSERT INTO `tref_bank` VALUES ('20790', 'Citrahalim Persada', 'PT BPR Citrahalim Persada');
INSERT INTO `tref_bank` VALUES ('20791', 'Dharmasurya Aditika', 'PT BPR Dharmasurya Aditika');
INSERT INTO `tref_bank` VALUES ('20792', 'Harta Raya Cipta Mulia', 'PT BPR Harta Raya Cipta Mulia');
INSERT INTO `tref_bank` VALUES ('20793', 'Mulya Sri Rejeki', 'PT BPR Mulya Sri Rejeki');
INSERT INTO `tref_bank` VALUES ('20794', 'Nusamba Wlingi', 'PT BPR Nusamba Wlingi');
INSERT INTO `tref_bank` VALUES ('20795', 'Pulau Intan Sejahtera', 'PT BPR Pulau Intan Sejahtera');
INSERT INTO `tref_bank` VALUES ('20796', 'Sum Adiyatra', 'PT BPR Sum Adiyatra');
INSERT INTO `tref_bank` VALUES ('20797', 'Wlingi Pahala Pakto', 'PT BPR Wlingi Pahala Pakto');
INSERT INTO `tref_bank` VALUES ('20798', 'Agro Cipta Adiguna', 'PT BPR Agro Cipta Adiguna');
INSERT INTO `tref_bank` VALUES ('20799', 'Artha Nugraha', 'Koperasi BPR Artha Nugraha');
INSERT INTO `tref_bank` VALUES ('208', 'Artha Swadharma', '');
INSERT INTO `tref_bank` VALUES ('20800', 'Artha Pamenang', 'PT BPR Artha Pamenang');
INSERT INTO `tref_bank` VALUES ('20801', 'Artha Pamenang Wates', 'PT BPR Artha Pamenang Wates');
INSERT INTO `tref_bank` VALUES ('20802', 'Artha Samudera', 'Koperasi BPR Artha Samudera');
INSERT INTO `tref_bank` VALUES ('20803', 'Bank Pasar Kabupaten Kediri', 'PD BPR Bank Daerah Kabupaten Kediri');
INSERT INTO `tref_bank` VALUES ('20804', 'Berkah Pakto', 'PT BPR Berkah Pakto');
INSERT INTO `tref_bank` VALUES ('20805', 'Bina Reksa Karyaartha', 'PT BPR Bina Reksa Karyaartha');
INSERT INTO `tref_bank` VALUES ('20806', 'Bumidinar Kencana', 'PT BPR Bumidinar Kencana');
INSERT INTO `tref_bank` VALUES ('20807', 'Dhaha Ekonomi', 'PT BPR Dhaha Ekonomi');
INSERT INTO `tref_bank` VALUES ('20808', 'Hamindo Natamakmur', 'PT BPR Hamindo Natamakmur');
INSERT INTO `tref_bank` VALUES ('20809', 'Hasta Krida Jaya', 'Koperasi BPR Hasta Krida Jaya');
INSERT INTO `tref_bank` VALUES ('20810', 'Insumo Sumberarto', 'PT BPR Insumo Sumberarto');
INSERT INTO `tref_bank` VALUES ('20811', 'Kota Kediri', 'PD BPR Kota Kediri');
INSERT INTO `tref_bank` VALUES ('20812', 'Mahkota Mitrausaha', 'PT BPR Mahkota Mitrausaha');
INSERT INTO `tref_bank` VALUES ('20813', 'Pare Artorejo', 'PT BPR Pare Artorejo');
INSERT INTO `tref_bank` VALUES ('20814', 'Prima Dadi Arta', 'PT BPR Prima Dadi Arta');
INSERT INTO `tref_bank` VALUES ('20815', 'Surya Artha Guna Mandiri', 'PT BPR Surya Artha Guna Mandiri');
INSERT INTO `tref_bank` VALUES ('20816', 'Tanjung Tani', 'PT BPR Tanjung Tani');
INSERT INTO `tref_bank` VALUES ('20817', 'Toeloengredjo Dasa Nusantara', 'PT BPR Toeloengredjo Dasa Nusantara');
INSERT INTO `tref_bank` VALUES ('20818', 'Tulus Puji Rejeki', 'PT BPR Tulus Puji Rejeki');
INSERT INTO `tref_bank` VALUES ('20819', 'Artha Pamenang Syariah', 'PT BPRS Syariah Artha Pamenang');
INSERT INTO `tref_bank` VALUES ('20820', 'Rahma Syariah', 'PT BPRS Rahma Syariah');
INSERT INTO `tref_bank` VALUES ('20821', 'Tanmiya Artha', 'PT BPRS Tanmiya Artha');
INSERT INTO `tref_bank` VALUES ('20822', 'Arta Kencana', 'Koperasi BPR Arta Kencana');
INSERT INTO `tref_bank` VALUES ('20823', 'Artanawa', 'Koperasi BPR Artanawa');
INSERT INTO `tref_bank` VALUES ('20824', 'Arthatama Caruban', 'PT BPR Arthatama Caruban');
INSERT INTO `tref_bank` VALUES ('20825', 'Bank Pasar Kodya Madiun', 'PD BPR Bank Pasar Kota Madiun');
INSERT INTO `tref_bank` VALUES ('20826', 'Caruban Indah', 'PT BPR Caruban Indah');
INSERT INTO `tref_bank` VALUES ('20827', 'Kabupaten Dati II Madiun', 'PT BPR Artha Prima Persada');
INSERT INTO `tref_bank` VALUES ('20828', 'Mandiri Dhanasejahtera', 'PT BPR Mandiri Dhanasejahtera');
INSERT INTO `tref_bank` VALUES ('20829', 'Polatama Kusuma', 'PT BPR Polatama Kusuma');
INSERT INTO `tref_bank` VALUES ('20830', 'Sapadhana', 'PT BPR Sapadhana');
INSERT INTO `tref_bank` VALUES ('20831', 'Tunas Artha', 'Koperasi BPR Tunas Artha');
INSERT INTO `tref_bank` VALUES ('20832', 'Wijayakusuma', 'Koperasi BPR Wijayakusuma');
INSERT INTO `tref_bank` VALUES ('20833', 'Artha Dharma', 'PT BPR Artha Dharma');
INSERT INTO `tref_bank` VALUES ('20834', 'Buana Citra Sejahtera', 'PT BPR Buana Citra Sejahtera');
INSERT INTO `tref_bank` VALUES ('20835', 'Ekadharma Bhinaraharja', 'PT BPR Ekadharma Bhinaraharja');
INSERT INTO `tref_bank` VALUES ('20836', 'Mulyo Raharjo', 'PT BPR Mulyo Raharjo');
INSERT INTO `tref_bank` VALUES ('20837', 'Takeran', 'Koperasi BPR Takeran');
INSERT INTO `tref_bank` VALUES ('20838', 'Artha Pamenang Warujayeng', 'PT BPR Artha Pamenang Warujayeng');
INSERT INTO `tref_bank` VALUES ('20839', 'Kertosono Saranaartha', 'PT BPR Kertosono Saranaartha');
INSERT INTO `tref_bank` VALUES ('20840', 'Nagajayaraya Sentra Sentosa', 'PT BPR Nagajayaraya Sentra Sentosa');
INSERT INTO `tref_bank` VALUES ('20841', 'Tunas Artha Jaya Abadi', 'PT BPR Tunas Artha Jaya Abadi');
INSERT INTO `tref_bank` VALUES ('20842', 'Pundhi', 'PT BPR Pundhi');
INSERT INTO `tref_bank` VALUES ('20843', 'Utomo Widodo', 'PT BPR Utomo Widodo');
INSERT INTO `tref_bank` VALUES ('20844', 'Ngadirojo - Pacitan', 'Koperasi BPR Ngadirojo - Pacitan');
INSERT INTO `tref_bank` VALUES ('20845', 'Puri Artha Pacitan', 'PT BPR Puri Artha Pacitan');
INSERT INTO `tref_bank` VALUES ('20846', 'Artha Ponorogo', 'PT BPR Artha Ponorogo');
INSERT INTO `tref_bank` VALUES ('20847', 'Aswaja Ponorogo', 'PT BPR Aswaja Ponorogo');
INSERT INTO `tref_bank` VALUES ('20848', 'Dharma Raga', 'PT BPR Dharma Raga');
INSERT INTO `tref_bank` VALUES ('20849', 'Jetis', 'Koperasi BPR Jetis');
INSERT INTO `tref_bank` VALUES ('20850', 'KBPR Babadan', 'Koperasi BPR KBPR Babadan');
INSERT INTO `tref_bank` VALUES ('20851', 'Raga Surya Nuansa', 'PT BPR Raga Surya Nuansa');
INSERT INTO `tref_bank` VALUES ('20852', 'Al Mabrur Babadan', 'PT BPRS Al Mabrur Babadan');
INSERT INTO `tref_bank` VALUES ('20853', 'Artha Panggung Perkasa', 'PT BPR Artha Panggung Perkasa');
INSERT INTO `tref_bank` VALUES ('20854', 'Bangkit Prima Sejahtera', 'PT BPR Bangkit Prima Sejahtera');
INSERT INTO `tref_bank` VALUES ('20855', 'Jwalita', 'PT BPR Jwalita');
INSERT INTO `tref_bank` VALUES ('20856', 'Anugerah Paktomas', 'PT BPR Anugerah Paktomas');
INSERT INTO `tref_bank` VALUES ('20857', 'Bandung Adiartha', 'PT BPR Bandung Adiartha');
INSERT INTO `tref_bank` VALUES ('20858', 'Bank Daerah Tulungagung', 'PD BPR Bank Daerah Tulungagung');
INSERT INTO `tref_bank` VALUES ('20859', 'Bintang Tulungagung', 'PT BPR Bintang Tulungagung');
INSERT INTO `tref_bank` VALUES ('20860', 'Citrahalim Raharja', 'PT BPR Citrahalim Raharja');
INSERT INTO `tref_bank` VALUES ('20861', 'Hambangun Artha Selaras', 'PT BPR Hambangun Artha Selaras');
INSERT INTO `tref_bank` VALUES ('20862', 'Mitra Agung Mandiri', 'PT BPR Mitra Agung Mandiri');
INSERT INTO `tref_bank` VALUES ('20863', 'Ngunut Arta', 'PT BPR Ngunut Arta');
INSERT INTO `tref_bank` VALUES ('20864', 'Nusamba Ngunut', 'PT BPR Nusamba Ngunut');
INSERT INTO `tref_bank` VALUES ('20865', 'Sumberdhana Anda', 'PT BPR Sumberdhana Anda');
INSERT INTO `tref_bank` VALUES ('20866', 'Keraton', 'PT BPR Keraton');
INSERT INTO `tref_bank` VALUES ('20867', 'Ganda Lata', 'PT BPR Ganda Lata');
INSERT INTO `tref_bank` VALUES ('20868', 'Mustika Utama Kendari', 'PT BPR Mustika Utama Kendari');
INSERT INTO `tref_bank` VALUES ('20869', 'Hara Lata', 'PT BPR Hara Lata');
INSERT INTO `tref_bank` VALUES ('20870', 'Mustika Utama Kolaka', 'PT BPR Mustika Utama Kolaka');
INSERT INTO `tref_bank` VALUES ('20871', 'Mustika Utama Raha', 'PT BPR Mustika Utama Raha');
INSERT INTO `tref_bank` VALUES ('20872', 'Tanjung Pratama', 'PT BPR Tanjung Pratama');
INSERT INTO `tref_bank` VALUES ('20873', 'Bina Usaha Dana', 'PT BPR Bina Usaha Dana');
INSERT INTO `tref_bank` VALUES ('20874', 'Central Pitoby', 'PT BPR Central Pitoby');
INSERT INTO `tref_bank` VALUES ('20875', 'Christa Jaya Perdana', 'PT BPR Christa Jaya Perdana');
INSERT INTO `tref_bank` VALUES ('20876', 'Citra Putra Fatuleu', 'PT BPR Citra Putra Fatuleu');
INSERT INTO `tref_bank` VALUES ('20877', 'Sari Dinarkencana', 'PT BPR Sari Dinarkencana');
INSERT INTO `tref_bank` VALUES ('20878', 'Tanaoba Lais Manekat', 'PT BPR Tanaoba Lais Manekat');
INSERT INTO `tref_bank` VALUES ('20879', 'Lugas Ganda', 'PT BPR Lugas Ganda');
INSERT INTO `tref_bank` VALUES ('20880', 'Talenta Raya', 'PT BPR Talenta Raya');
INSERT INTO `tref_bank` VALUES ('20881', 'Suar Data', 'PT BPR Suar Data');
INSERT INTO `tref_bank` VALUES ('20882', 'Abang Pasar', 'Koperasi BPR Abang Pasar');
INSERT INTO `tref_bank` VALUES ('20883', 'Pataru Laba', 'PT BPR Pataru Laba');
INSERT INTO `tref_bank` VALUES ('20884', 'Gowata', 'PT BPRS Gowata');
INSERT INTO `tref_bank` VALUES ('20885', 'Harapan Sejahtera Malili', 'PT BPR Harapan Sejahtera Malili');
INSERT INTO `tref_bank` VALUES ('20886', 'Capta Sakti Sejahtera', 'PT BPR Capta Sakti Sejahtera');
INSERT INTO `tref_bank` VALUES ('20887', 'Bank Pasar Kota Ujung Pandang', 'PD BPR Kodya Dati II Ujung Pandang');
INSERT INTO `tref_bank` VALUES ('20888', 'Batara Wajo', 'PT BPR Batara Wajo');
INSERT INTO `tref_bank` VALUES ('20889', 'Dana Niaga Mandiri', 'PT BPR Dana Niaga Mandiri');
INSERT INTO `tref_bank` VALUES ('20890', 'Hasa Mitra', 'PT BPR Hasa Mitra');
INSERT INTO `tref_bank` VALUES ('20891', 'Sulawesi Danajaya', 'PT BPR Sulawesi Danajaya');
INSERT INTO `tref_bank` VALUES ('20892', 'Sulawesi Mandiri', 'PT BPR Sulawesi Mandiri');
INSERT INTO `tref_bank` VALUES ('20893', 'Tabungan Rakyat', 'PT BPR Tabungan Rakyat');
INSERT INTO `tref_bank` VALUES ('20894', 'Taruna Jujur Sakti', 'PT BPR Taruna Jujur Sakti');
INSERT INTO `tref_bank` VALUES ('20895', 'Dana Moneter', 'PT BPRS Dana Moneter');
INSERT INTO `tref_bank` VALUES ('20896', 'Indo Timur', 'PT BPRS Ikhwanul Ummah');
INSERT INTO `tref_bank` VALUES ('20897', 'Investama Mega Bakti', 'PT BPRS Investama Mega Bakti');
INSERT INTO `tref_bank` VALUES ('20898', 'Niaga Madani', 'PT BPRS Niaga Madani');
INSERT INTO `tref_bank` VALUES ('20899', 'Daramandiri  Palopo', 'PT BPR Daramandiri  Palopo');
INSERT INTO `tref_bank` VALUES ('209', 'Labuhan Sumbawa (Merger ke NTB Sumbawa Tgl 6 Nov 2009)', '');
INSERT INTO `tref_bank` VALUES ('20900', 'Putra Niaga Mandiri', 'PT BPR Putra Niaga Mandiri');
INSERT INTO `tref_bank` VALUES ('20901', 'Agrimakmur Lestari', 'PT BPR Agrimakmur Lestari');
INSERT INTO `tref_bank` VALUES ('20902', 'Citra Mas', 'PT BPR Citra Mas');
INSERT INTO `tref_bank` VALUES ('20903', 'Nurul Ikhwan', 'PT BPRS Nurul Ikhwan');
INSERT INTO `tref_bank` VALUES ('20904', 'Yustima', 'PT BPR Yustima');
INSERT INTO `tref_bank` VALUES ('20905', 'Pesisir Tanadoang', 'PT BPR Pesisir Tanadoang');
INSERT INTO `tref_bank` VALUES ('20906', 'Gerbang Masa Depan', 'PT BPR Gerbang Masa Depan');
INSERT INTO `tref_bank` VALUES ('20907', 'Surya Sejati', 'PT BPRS Surya Sejati Palleko');
INSERT INTO `tref_bank` VALUES ('20908', 'Capta Mulia Abadi', 'PT BPR Capta Mulia Abadi');
INSERT INTO `tref_bank` VALUES ('20909', 'Tritama Abadi Mengkendek', 'PT BPR Tritama Abadi Mengkendek');
INSERT INTO `tref_bank` VALUES ('20910', 'Puangrimanggalatung', 'PT BPR Puangrimanggalatung');
INSERT INTO `tref_bank` VALUES ('20911', 'Artatama Sejahtera', 'PT BPR Artatama Sejahtera');
INSERT INTO `tref_bank` VALUES ('20912', 'Batu Artorejo', 'PT BPR Batu Artorejo');
INSERT INTO `tref_bank` VALUES ('20913', 'Delta Malang', 'PT BPR Delta Malang');
INSERT INTO `tref_bank` VALUES ('20914', 'Dwi Cahaya Nusaperkasa', 'PT BPR Dwi Cahaya Nusaperkasa');
INSERT INTO `tref_bank` VALUES ('20915', 'Krisman Mandala', 'PT BPR Krisman Mandala');
INSERT INTO `tref_bank` VALUES ('20916', 'Pancadana', 'Koperasi BPR Pancadana');
INSERT INTO `tref_bank` VALUES ('20917', 'Sumber Dhana Makmur', 'PT BPR Sumber Dhana Makmur');
INSERT INTO `tref_bank` VALUES ('20918', 'Tripakarti Dhanatama', 'PT BPR Tripakarti Dhanatama');
INSERT INTO `tref_bank` VALUES ('20919', 'Wahana Dhana Batu', 'PT BPR Wahana Dhana Batu');
INSERT INTO `tref_bank` VALUES ('20920', 'Bumi Rinjani - Syariah', 'PT BPRS Bumi Rinjani - Syariah');
INSERT INTO `tref_bank` VALUES ('20921', 'Bumi Rinjani Batu - Syariah', 'PT BPRS Bumi Rinjani Batu - Syariah');
INSERT INTO `tref_bank` VALUES ('20922', 'Bank Pasar Kab. Dati II Lumajang', 'PD BPR Bank Pasar Kabupaten Lumajang');
INSERT INTO `tref_bank` VALUES ('20923', 'Dharma Indra', 'PT BPR Dharma Indra');
INSERT INTO `tref_bank` VALUES ('20924', 'Sentral Arta Asia', 'PT BPR Sentral Arta Asia');
INSERT INTO `tref_bank` VALUES ('20925', 'Tanah Bandar', 'PT BPR Tanah Bandar');
INSERT INTO `tref_bank` VALUES ('20926', 'Tanggul Arto', 'PT BPR Tanggul Arto');
INSERT INTO `tref_bank` VALUES ('20927', 'Yuka Jaya', 'PT BPR Yuka Jaya');
INSERT INTO `tref_bank` VALUES ('20928', 'Adiartha Reksacitra', 'PT BPR Adiartha Reksacitra');
INSERT INTO `tref_bank` VALUES ('20929', 'Amanah', 'Koperasi BPR Amanah');
INSERT INTO `tref_bank` VALUES ('20930', 'Anugerah Kusuma Singosari', 'PT BPR Anugerah Kusuma Singosari');
INSERT INTO `tref_bank` VALUES ('20931', 'Armindo Kencana', 'PT BPR Armindo Kencana');
INSERT INTO `tref_bank` VALUES ('20932', 'Artha Kanjuruhan Pemkab Malang', 'PT BPR Artha Kanjuruhan Pemkab Malang');
INSERT INTO `tref_bank` VALUES ('20933', 'Artha Wiwaha Arjuna', 'PT BPR Artha Wiwaha Arjuna');
INSERT INTO `tref_bank` VALUES ('20934', 'Arthasari Kencana', 'PT BPR Arthasari Kencana');
INSERT INTO `tref_bank` VALUES ('20935', 'Bangil Adyatama', 'PT BPR Bangil Adyatama');
INSERT INTO `tref_bank` VALUES ('20936', 'Bhaskara Pakto', 'PT BPR Bhaskara Pakto');
INSERT INTO `tref_bank` VALUES ('20937', 'Centraldjaja Pratama', 'PT BPR Centraldjaja Pratama');
INSERT INTO `tref_bank` VALUES ('20938', 'Citra Halim Perdana', 'PT BPR Citra Halim Perdana');
INSERT INTO `tref_bank` VALUES ('20939', 'Dampit', 'PT BPR Dampit');
INSERT INTO `tref_bank` VALUES ('20940', 'Dau Anugerah', 'PT BPR Dau Anugerah');
INSERT INTO `tref_bank` VALUES ('20941', 'Dau Kusumadjaja', 'PT BPR Dau Kusumadjaja');
INSERT INTO `tref_bank` VALUES ('20942', 'Dau Lestari', 'PT BPR Dau Lestari');
INSERT INTO `tref_bank` VALUES ('20943', 'Delta Artha Kencana', 'PT BPR Delta Artha Kencana');
INSERT INTO `tref_bank` VALUES ('20944', 'Delta Singosari', 'PT BPR Delta Singosari');
INSERT INTO `tref_bank` VALUES ('20945', 'Dhana Lestari', 'PT BPR Dhana Lestari');
INSERT INTO `tref_bank` VALUES ('20946', 'Eka Dana Mandiri', 'PT BPR Eka Dana Mandiri');
INSERT INTO `tref_bank` VALUES ('20947', 'Eka Dana Utama', 'PT BPR Eka Dana Utama');
INSERT INTO `tref_bank` VALUES ('20948', 'Gunung Arjuna', 'PT BPR Gunung Arjuna');
INSERT INTO `tref_bank` VALUES ('20949', 'Gunung Ringgit', 'PT BPR Gunung Ringgit');
INSERT INTO `tref_bank` VALUES ('20950', 'Kerta Arthamandiri', 'PT BPR Kerta Arthamandiri');
INSERT INTO `tref_bank` VALUES ('20951', 'Kharisma Kusuma Lawang', 'PT BPR Kharisma Kusuma Lawang');
INSERT INTO `tref_bank` VALUES ('20952', 'Kimi Sanda', 'PT BPR Kimi Sanda');
INSERT INTO `tref_bank` VALUES ('20953', 'Kridadhana Citranusa', 'PT BPR Kridadhana Citranusa');
INSERT INTO `tref_bank` VALUES ('20954', 'Mandiri Adiyatra', 'PT BPR Mandiri Adiyatra');
INSERT INTO `tref_bank` VALUES ('20955', 'Mitra Catur Mandiri', 'PT BPR Mitra Catur Mandiri');
INSERT INTO `tref_bank` VALUES ('20956', 'Pujon Jayamakmur', 'PT BPR Pujon Jayamakmur');
INSERT INTO `tref_bank` VALUES ('20957', 'Putera Dana', 'PT BPR Putera Dana');
INSERT INTO `tref_bank` VALUES ('20958', 'Sadhya Muktiparama', 'PT BPR Sadhya Muktiparama');
INSERT INTO `tref_bank` VALUES ('20959', 'Sedayadhana Makmur', 'PT BPR Sedayadhana Makmur');
INSERT INTO `tref_bank` VALUES ('20960', 'Sumber Arto', 'PT BPR Sumber Arto');
INSERT INTO `tref_bank` VALUES ('20961', 'Surya Abadi Bersaudara', 'PT BPR Surya Abadi Bersaudara');
INSERT INTO `tref_bank` VALUES ('20962', 'Tri Dana Sakti', 'PT BPR Tri Dana Sakti');
INSERT INTO `tref_bank` VALUES ('20963', 'Trikarya Waranugraha', 'PT BPR Trikarya Waranugraha');
INSERT INTO `tref_bank` VALUES ('20964', 'Tugu Artha', 'PD BPR Tugu Artha');
INSERT INTO `tref_bank` VALUES ('20965', 'Tumpang Arthasarana', 'PT BPR Tumpang Arthasarana');
INSERT INTO `tref_bank` VALUES ('20966', 'Tumpang Prima Artorejo', 'PT BPR Tumpang Prima Artorejo');
INSERT INTO `tref_bank` VALUES ('20967', 'Bhakti Haji Malang', 'PT BPRS Bhakti Haji Malang');
INSERT INTO `tref_bank` VALUES ('20968', 'Bumi Rinjani Kepanjen', 'PT BPRS Bumi Rinjani Kepanjen');
INSERT INTO `tref_bank` VALUES ('20969', 'Bumi Rinjani Malang', 'PT BPRS Bumi Rinjani Malang');
INSERT INTO `tref_bank` VALUES ('20970', 'MItra Harmoni Kota Malang', 'PT BPRS MItra Harmoni Kota Malang');
INSERT INTO `tref_bank` VALUES ('20971', 'Adhi Purwo', 'PT BPR Adhi Purwo');
INSERT INTO `tref_bank` VALUES ('20972', 'Arta Seruni Surabaya', 'PT BPR Arta Seruni Surabaya');
INSERT INTO `tref_bank` VALUES ('20973', 'Arta Taman Dayu', 'PT BPR Arta Taman Dayu');
INSERT INTO `tref_bank` VALUES ('20974', 'Artha Senapati', 'PT BPR Artha Senapati');
INSERT INTO `tref_bank` VALUES ('20975', 'Bangil Idaman', 'PT BPR Bangil Idaman');
INSERT INTO `tref_bank` VALUES ('20976', 'Bromo Mandiri', 'PT BPR Bromo Mandiri');
INSERT INTO `tref_bank` VALUES ('20977', 'Citrahalim Dhanatama', 'PT BPR Citrahalim Dhanatama');
INSERT INTO `tref_bank` VALUES ('20978', 'Danaputra Sakti', 'PT BPR Danaputra Sakti');
INSERT INTO `tref_bank` VALUES ('20979', 'Gunung Adidana', 'PT BPR Gunung Adidana');
INSERT INTO `tref_bank` VALUES ('20980', 'Harta Swadiri', 'KB BPR Harta Swadiri');
INSERT INTO `tref_bank` VALUES ('20981', 'Kalimasada', 'KB BPR Kalimasada');
INSERT INTO `tref_bank` VALUES ('20982', 'Kota Pasuruan', 'PT BPR Kota Pasuruan');
INSERT INTO `tref_bank` VALUES ('20983', 'Kraton Surapati', 'PT BPR Kraton Surapati');
INSERT INTO `tref_bank` VALUES ('20984', 'Kratonprima Abadi', 'PT BPR Kratonprima Abadi');
INSERT INTO `tref_bank` VALUES ('20985', 'Mina Mandiri', 'PT BPR Mina Mandiri');
INSERT INTO `tref_bank` VALUES ('20986', 'Nusapanida Pandaan', 'PT BPR Nusapanida Pandaan');
INSERT INTO `tref_bank` VALUES ('20987', 'Pandaan Arta Jaya', 'PT BPR Pandaan Arta Jaya');
INSERT INTO `tref_bank` VALUES ('20988', 'Parlaungan', 'PT BPR Parlaungan');
INSERT INTO `tref_bank` VALUES ('20989', 'Purwosari Anugerah', 'PT BPR Purwosari Anugerah');
INSERT INTO `tref_bank` VALUES ('20990', 'Sedulur Artamakmur', 'PT BPR Sedulur Artamakmur');
INSERT INTO `tref_bank` VALUES ('20991', 'Sukorejo Makmur', 'PT BPR Sukorejo Makmur');
INSERT INTO `tref_bank` VALUES ('20992', 'Surasari Hutama', 'PT BPR Surasari Hutama');
INSERT INTO `tref_bank` VALUES ('20993', 'Surya Dana Karya', 'PT BPR Surya Dana Karya');
INSERT INTO `tref_bank` VALUES ('20994', 'Wisman Perkasa', 'PT BPR Wisman Perkasa');
INSERT INTO `tref_bank` VALUES ('20995', 'Al - Hidayah', 'PT BPRS Al - Hidayah');
INSERT INTO `tref_bank` VALUES ('20996', 'Daya Artha Mentari', 'PT BPRS Daya Artha Mentari');
INSERT INTO `tref_bank` VALUES ('20997', 'Jabal Tsur', 'PT BPRS Jabal Tsur');
INSERT INTO `tref_bank` VALUES ('20998', 'Untung Surapati', 'KB BPRS Untung Surapati');
INSERT INTO `tref_bank` VALUES ('20999', 'Semeru Swasti', 'PT BPR Semeru Swasti');
INSERT INTO `tref_bank` VALUES ('210', 'Bahteramas Bau-Bau', 'PD BPR Bahteramas Bau-Bau');
INSERT INTO `tref_bank` VALUES ('21000', 'Sentral Arta Jaya', 'PT BPR Sentral Arta Jaya');
INSERT INTO `tref_bank` VALUES ('21001', 'Angga Perkasa', 'PT BPR Angga Perkasa');
INSERT INTO `tref_bank` VALUES ('21002', 'Antar Parama', 'PT BPR Antar Parama');
INSERT INTO `tref_bank` VALUES ('21003', 'Benua Kraksaan', 'PT BPR Benua Kraksaan');
INSERT INTO `tref_bank` VALUES ('21004', 'Sentral Arta Sejahtera', 'PT BPR Sentral Arta Sejahtera');
INSERT INTO `tref_bank` VALUES ('21005', 'Bumi Rinjani Probolinggo', 'PT BPRS Bumi Rinjani Probolinggo');
INSERT INTO `tref_bank` VALUES ('21006', 'Maesa Waya', 'PT BPR Maesa Waya');
INSERT INTO `tref_bank` VALUES ('21007', 'Citra Dumoga', 'PT BPR Citra Dumoga');
INSERT INTO `tref_bank` VALUES ('21008', 'Asparaga Adiguna Bersama', 'PT BPR Asparaga Adiguna Bersama');
INSERT INTO `tref_bank` VALUES ('21009', 'Mega Zanur', 'PT BPR Mega Zanur');
INSERT INTO `tref_bank` VALUES ('21010', 'Paro Dana', 'PT BPR Paro Dana');
INSERT INTO `tref_bank` VALUES ('21011', 'Telaga Sinar Cahaya', 'PT BPR Telaga Sinar Cahaya');
INSERT INTO `tref_bank` VALUES ('21012', 'Nusa Utara', 'PT BPR Nusa Utara');
INSERT INTO `tref_bank` VALUES ('21013', 'Celebes Mitra Perdana', 'PT BPR Celebes Mitra Perdana');
INSERT INTO `tref_bank` VALUES ('21014', 'Cipta Cemerlang Indonesia', 'PT BPR Cipta Cemerlang Indonesia');
INSERT INTO `tref_bank` VALUES ('21015', 'Dana Raya', 'PT BPR Dana Raya');
INSERT INTO `tref_bank` VALUES ('21016', 'Millenia', 'PT BPR Millenia');
INSERT INTO `tref_bank` VALUES ('21017', 'Prisma Dana', 'PT BPR Prisma Dana');
INSERT INTO `tref_bank` VALUES ('21018', 'Paro Laba', 'PT BPR Paro Laba');
INSERT INTO `tref_bank` VALUES ('21019', 'Pinasungkulan', 'PT BPR Pinasungkulan');
INSERT INTO `tref_bank` VALUES ('21020', 'Pinasungkulan Indah', 'PT BPR Pinasungkulan Indah');
INSERT INTO `tref_bank` VALUES ('21021', 'Amurang Utama', 'PT BPR Amurang Utama');
INSERT INTO `tref_bank` VALUES ('21022', 'Mapalus Tumetenden', 'PT BPR Mapalus Tumetenden');
INSERT INTO `tref_bank` VALUES ('21023', 'Bank Pegawai Pensiunan Indonesia Tomohon', 'Koperasi BPR Bank Pegawai Pensiunan Indonesia (KBPPI) Sulawesi Utara');
INSERT INTO `tref_bank` VALUES ('21024', 'Kartika Matuari', 'PT BPR Kartika Matuari');
INSERT INTO `tref_bank` VALUES ('21025', 'Primaesa Sejahtera', 'PT BPR Primaesa Sejahtera');
INSERT INTO `tref_bank` VALUES ('21026', 'Bima Abdi Swadaya', 'PT BPR Bima Abdi Swadaya');
INSERT INTO `tref_bank` VALUES ('21027', 'Pesisir Akbar', 'PT BPR Pesisir Akbar');
INSERT INTO `tref_bank` VALUES ('21028', 'NTB Dompu', 'PD BPR NTB Dompu');
INSERT INTO `tref_bank` VALUES ('21029', 'Abdi Warga Mulia', 'PT BPR Abdi Warga Mulia');
INSERT INTO `tref_bank` VALUES ('21030', 'Dana Master Surya', 'PT BPR Dana Master Surya');
INSERT INTO `tref_bank` VALUES ('21031', 'Danayasa', 'PT BPR Danayasa');
INSERT INTO `tref_bank` VALUES ('21032', 'Narpada Nusa', 'PT BPR Narpada Nusa');
INSERT INTO `tref_bank` VALUES ('21033', 'NTB Lombok Barat', 'PD BPR NTB Lombok Barat');
INSERT INTO `tref_bank` VALUES ('21034', 'Pesisir Layar Berkembang', 'PT BPR Pesisir Layar Berkembang');
INSERT INTO `tref_bank` VALUES ('21035', 'Ramot Ganda', 'PT BPR Ramot Ganda');
INSERT INTO `tref_bank` VALUES ('21036', 'Tanjung Abdi Swadaya', 'PT BPR Tanjung Abdi Swadaya');
INSERT INTO `tref_bank` VALUES ('21037', 'Wiranadi', 'PT BPR Wiranadi');
INSERT INTO `tref_bank` VALUES ('21038', 'NTB Lombok Tengah', 'PD BPR NTB Lombok Tengah');
INSERT INTO `tref_bank` VALUES ('21039', 'Sowan Utama', 'PT BPR Sowan Utama');
INSERT INTO `tref_bank` VALUES ('21040', 'Tresna Niaga', 'PT BPR Tresna Niaga');
INSERT INTO `tref_bank` VALUES ('21041', 'NTB Lombok Timur', 'PD BPR NTB Lombok Timur');
INSERT INTO `tref_bank` VALUES ('21042', 'Samas', 'PT BPR Samas');
INSERT INTO `tref_bank` VALUES ('21043', 'Segara Anak Kencana', 'PT BPR Segara Anak Kencana');
INSERT INTO `tref_bank` VALUES ('21044', 'Tulen Amanah', 'PT BPRS Tulen Amanah');
INSERT INTO `tref_bank` VALUES ('21045', 'Mitra Harmoni Mataram', 'PT BPR Mitra Harmoni Mataram');
INSERT INTO `tref_bank` VALUES ('21046', 'NTB Mataram', 'PD BPR NTB Mataram');
INSERT INTO `tref_bank` VALUES ('21047', 'Pitih Gumarang', 'PT BPR Pitih Gumarang');
INSERT INTO `tref_bank` VALUES ('21048', 'Prima Nadi', 'PT BPR Prima Nadi');
INSERT INTO `tref_bank` VALUES ('21049', 'Dinar Ashri', 'PT BPRS Dinar Ashri');
INSERT INTO `tref_bank` VALUES ('21050', 'PNM Patuh Beramal', 'PT BPRS PNM Patuh Beramal');
INSERT INTO `tref_bank` VALUES ('21051', 'Kabalong Abdi Swadaya', 'PT BPR Kabalong Abdi Swadaya');
INSERT INTO `tref_bank` VALUES ('21052', 'LKP Seteluk Tengah', 'PD BPR LKP Seteluk Tengah');
INSERT INTO `tref_bank` VALUES ('21053', 'Lopok Ganda', 'PT BPR Lopok Ganda');
INSERT INTO `tref_bank` VALUES ('21054', 'NTB Sumbawa', 'PD BPR NTB Sumbawa');
INSERT INTO `tref_bank` VALUES ('21055', 'Samawa Kencana', 'PT BPR Samawa Kencana');
INSERT INTO `tref_bank` VALUES ('21056', 'LKP Dalam Taliwang', 'PD BPR Dalam Taliwang');
INSERT INTO `tref_bank` VALUES ('21057', 'NTB Bima', 'PD BPR NTB Bima');
INSERT INTO `tref_bank` VALUES ('21058', 'Rahmah Hijrah Agung', 'PT BPRS Rahmah Hijrah Agung');
INSERT INTO `tref_bank` VALUES ('21059', 'Diori Ganda', 'PT BPR Diori Ganda');
INSERT INTO `tref_bank` VALUES ('21060', 'Bumiasih NBP 4', 'PT BPR Bumiasih NBP 4');
INSERT INTO `tref_bank` VALUES ('21061', 'Bumiasih NBP 22', 'PT BPR Bumiasih NBP 22');
INSERT INTO `tref_bank` VALUES ('21062', 'Bumiasih NBP 8', 'PT BPR Bumiasih NBP 8');
INSERT INTO `tref_bank` VALUES ('21063', 'Bumiasih NBP 17', 'PT BPR Bumiasih NBP 17');
INSERT INTO `tref_bank` VALUES ('21064', 'Bumiasih NBP 20', 'PT BPR Bumiasih NBP 20');
INSERT INTO `tref_bank` VALUES ('21065', 'Bumiasih NBP 25', 'PT BPR Bumiasih NBP 25');
INSERT INTO `tref_bank` VALUES ('21066', 'Bumiasih NBP 33', 'PT BPR Bumiasih NBP 33');
INSERT INTO `tref_bank` VALUES ('21067', 'Dana Ganda', 'PT BPR Dana Ganda');
INSERT INTO `tref_bank` VALUES ('21068', 'Disky Suryajaya', 'PT BPR Disky Suryajaya');
INSERT INTO `tref_bank` VALUES ('21069', 'Duta Paramarta', 'PT BPR Duta Paramarta');
INSERT INTO `tref_bank` VALUES ('21070', 'Karyabhakti Ugahari', 'PT BPR Karyabhakti Ugahari');
INSERT INTO `tref_bank` VALUES ('21071', 'Laksana Abadi Sunggal', 'PT BPR Laksana Abadi Sunggal');
INSERT INTO `tref_bank` VALUES ('21072', 'Laksana Guna Percut', 'PT BPR Laksana Guna Percut');
INSERT INTO `tref_bank` VALUES ('21073', 'Mitradana Madani', 'PT BPR Mitradana Madani');
INSERT INTO `tref_bank` VALUES ('21074', 'Multi Tata Perkasa', 'PT BPR Multi Tata Perkasa');
INSERT INTO `tref_bank` VALUES ('21075', 'Nusa Galang Makmur', 'PT BPR Nusa Galang Makmur');
INSERT INTO `tref_bank` VALUES ('21076', 'Nusantara Sunggal', 'PT BPR Nusantara Sunggal');
INSERT INTO `tref_bank` VALUES ('21077', 'Perbaungan Hombar Makmur', 'PT BPR Perbaungan Hombar Makmur');
INSERT INTO `tref_bank` VALUES ('21078', 'Pijer Podi Kekelengen', 'PT BPR Pijer Podi Kekelengen');
INSERT INTO `tref_bank` VALUES ('21079', 'Solider', 'PT BPR Solider');
INSERT INTO `tref_bank` VALUES ('21080', 'Sumber Tiopan Raya', 'PT BPR Sumber Tiopan Raya');
INSERT INTO `tref_bank` VALUES ('21081', 'Talabumi Sunggal', 'PT BPR Talabumi Sunggal');
INSERT INTO `tref_bank` VALUES ('21082', 'Tridana Percut', 'PT BPR Tridana Percut');
INSERT INTO `tref_bank` VALUES ('21083', 'Amanah Insan Cita', 'PT BPRS Amanah Insan Cita');
INSERT INTO `tref_bank` VALUES ('21084', 'Kafalatul Ummah', 'PT BPRS Kafalatul Ummah');
INSERT INTO `tref_bank` VALUES ('21085', 'Puduarta Insani', 'PT BPRS Puduarta Insani');
INSERT INTO `tref_bank` VALUES ('21086', 'Guna Rakyat', 'PT BPR Guna Rakyat');
INSERT INTO `tref_bank` VALUES ('21087', 'Nusantara Bona Pasogit 10', 'PT BPR Nusantara Bona Pasogit 10');
INSERT INTO `tref_bank` VALUES ('21088', 'Bumiasih NBP 15', 'PT BPR Bumiasih NBP 15');
INSERT INTO `tref_bank` VALUES ('21089', 'Logo Karo Asri', 'PT BPR Logo Karo Asri');
INSERT INTO `tref_bank` VALUES ('21090', 'Bumiasih NBP 16', 'PT BPR Bumiasih NBP 16');
INSERT INTO `tref_bank` VALUES ('21091', 'Mangatur Ganda', 'PT BPR Mangatur Ganda');
INSERT INTO `tref_bank` VALUES ('21092', 'Bumiasih NBP 13', 'PT BPR Bumiasih NBP 13');
INSERT INTO `tref_bank` VALUES ('21093', 'Sabee Meusampee', 'PT BPR Sabee Meusampee');
INSERT INTO `tref_bank` VALUES ('21094', 'Bumiasih NBP 21', 'PT BPR Bumiasih NBP 21');
INSERT INTO `tref_bank` VALUES ('21095', 'Sindang Laya Kotanopan', 'PT BPRS Sindanglaya Kotanopan');
INSERT INTO `tref_bank` VALUES ('21096', 'Bank Pasar Medan', 'Koperasi BPR Bank Pasar Kotamadya Medan');
INSERT INTO `tref_bank` VALUES ('21097', 'Duta Adiarta', 'PT BPR Duta Adiarta');
INSERT INTO `tref_bank` VALUES ('21098', 'Eka Prasetya', 'PT BPR Eka Prasetya');
INSERT INTO `tref_bank` VALUES ('21099', 'Milala', 'PT BPR Milala');
INSERT INTO `tref_bank` VALUES ('211', 'Bahteramas Bombana', 'PD BPR Bahteramas Bombana');
INSERT INTO `tref_bank` VALUES ('21100', 'Prima Tata Patumbak', 'PT BPR Prima Tata Patumbak');
INSERT INTO `tref_bank` VALUES ('21101', 'Wahana Bersama KPUM', 'PT BPR Wahana Bersama KPUM');
INSERT INTO `tref_bank` VALUES ('21102', 'Al Washliyah', 'PT BPRS Al Washliyah');
INSERT INTO `tref_bank` VALUES ('21103', 'Gebu Prima', 'PT BPRS Gebu Prima');
INSERT INTO `tref_bank` VALUES ('21104', 'Bumiasih NBP 34', 'PT BPR Bumiasih NBP 34');
INSERT INTO `tref_bank` VALUES ('21105', 'Amanah Bangsa', 'PT BPRS Amanah Bangsa');
INSERT INTO `tref_bank` VALUES ('21106', 'Bumiasih NBP 9', 'PT BPR Bumiasih NBP 9');
INSERT INTO `tref_bank` VALUES ('21107', 'Bumiasih NBP 18', 'PT BPR Bumiasih NBP 18');
INSERT INTO `tref_bank` VALUES ('21108', 'Nusantara Bona Pasogit 3', 'PT BPR Nusantara Bona Pasogit 3');
INSERT INTO `tref_bank` VALUES ('21109', 'Buana Agribisnis', 'PT BPR Buana Agribisnis');
INSERT INTO `tref_bank` VALUES ('21110', 'Bumiasih NBP 6', 'PT BPR Bumiasih NBP 6');
INSERT INTO `tref_bank` VALUES ('21111', 'Bumiasih NBP 7', 'PT BPR Bumiasih NBP 7');
INSERT INTO `tref_bank` VALUES ('21112', 'Al - Yaqin', 'PT BPRS Al - Yaqin');
INSERT INTO `tref_bank` VALUES ('21113', 'Bandar Jaya', 'PT BPR Bandar Jaya');
INSERT INTO `tref_bank` VALUES ('21114', 'Bina Barumun', 'PT BPR Bina Barumun');
INSERT INTO `tref_bank` VALUES ('21115', 'Karya Parhuta', 'PT BPR Karya Parhuta');
INSERT INTO `tref_bank` VALUES ('21116', 'Bumiasih NBP 1', 'PT BPR Bumiasih NBP 1');
INSERT INTO `tref_bank` VALUES ('21117', 'Porsea Jaya', 'PT BPR Porsea Jaya');
INSERT INTO `tref_bank` VALUES ('21118', 'Bumiasih NBP 5', 'PT BPR Bumiasih NBP 5');
INSERT INTO `tref_bank` VALUES ('21119', 'Surungan Nauli', 'PT BPR Surungan Nauli');
INSERT INTO `tref_bank` VALUES ('21120', 'Dana Mandiri', 'PT BPR Dana Mandiri');
INSERT INTO `tref_bank` VALUES ('21121', 'Gebu Harapan', 'PT BPR Gebu Harapan');
INSERT INTO `tref_bank` VALUES ('21122', 'Gema Ampekkoto Sejahtera', 'PT BPR Gema Ampekkoto Sejahtera');
INSERT INTO `tref_bank` VALUES ('21123', 'LPN Magek', 'BP BPR LPN Magek');
INSERT INTO `tref_bank` VALUES ('21124', 'Mutiara Pesisir', 'BP BPR Mutiara Pesisir');
INSERT INTO `tref_bank` VALUES ('21125', 'Padang Tarab', 'PT BPR Padang Tarab');
INSERT INTO `tref_bank` VALUES ('21126', 'Panampung', 'BP BPR LPN Panampung');
INSERT INTO `tref_bank` VALUES ('21127', 'Pembangunan Nagari', 'PT BPR Pembangunan Nagari');
INSERT INTO `tref_bank` VALUES ('21128', 'Raga Dana Sejahtera', 'BP BPR Raga Dana Sejahtera');
INSERT INTO `tref_bank` VALUES ('21129', 'Sungai Puar', 'PT BPR Sungai Puar');
INSERT INTO `tref_bank` VALUES ('21130', 'Tilatang Kamang', 'PT BPR Tilatang Kamang');
INSERT INTO `tref_bank` VALUES ('21131', 'Carana Kiat Andalas', 'PT BPRS Carana Kiat Andalas');
INSERT INTO `tref_bank` VALUES ('21132', 'Rangkiang Aur', 'PT BPR Rangkiang Aur');
INSERT INTO `tref_bank` VALUES ('21133', 'Jam Gadang', 'PT BPR Jam Gadang');
INSERT INTO `tref_bank` VALUES ('21134', 'Ampek Angkek Candung', 'PT BPRS Ampek Angkek Candung');
INSERT INTO `tref_bank` VALUES ('21135', 'Dharma Nagari', 'PT BPR Dharma Nagari');
INSERT INTO `tref_bank` VALUES ('21136', 'LPN Sungai Rumbai', 'BP BPR LPN Sungai Rumbai');
INSERT INTO `tref_bank` VALUES ('21137', 'Pulau Punjung', 'PT BPR Pulau Punjung');
INSERT INTO `tref_bank` VALUES ('21138', 'Sungai Rumbai', 'PT BPR Sungai Rumbai');
INSERT INTO `tref_bank` VALUES ('21139', 'Tarantang', 'BP BPR LPN Tarantang');
INSERT INTO `tref_bank` VALUES ('21140', 'Pagai Utara Selatan', 'PT BPR Pagai Utara Selatan');
INSERT INTO `tref_bank` VALUES ('21141', 'Sipora', 'PT BPR Sipora');
INSERT INTO `tref_bank` VALUES ('21142', 'Artha Niaga Solok', 'BP BPR Artha Niaga Solok');
INSERT INTO `tref_bank` VALUES ('21143', 'Tambun Ijuk', 'PT BPR Tambun Ijuk');
INSERT INTO `tref_bank` VALUES ('21144', 'Dharma Pejuang Empatlima', 'PT BPR Dharma Pejuang Empatlima');
INSERT INTO `tref_bank` VALUES ('21145', 'Gonjong Limo', 'PD BPR Gonjong Limo');
INSERT INTO `tref_bank` VALUES ('21146', 'Guguk Mas Makmur', 'BP BPR Guguk Mas Makmur');
INSERT INTO `tref_bank` VALUES ('21147', 'Harau', 'PT BPR Harau');
INSERT INTO `tref_bank` VALUES ('21148', 'Labuh Gunung', 'BP BPR Labuh Gunung');
INSERT INTO `tref_bank` VALUES ('21149', 'LPN Kampung Baru', 'PT BPR LPN Kampung Baru Muara Paiti');
INSERT INTO `tref_bank` VALUES ('21150', 'LPN Taeh Baruh', 'BP BPR LPN Taeh Baruh');
INSERT INTO `tref_bank` VALUES ('21151', 'Mitra Usaha Muaro Paiti', 'BP BPR Mitra Usaha Muaro Paiti');
INSERT INTO `tref_bank` VALUES ('21152', 'Padang Kuning', 'BP BPR LPN Padang Kuning');
INSERT INTO `tref_bank` VALUES ('21153', 'Sago Luhak Limapuluh', 'PT BPR Sago Luhak Limapuluh');
INSERT INTO `tref_bank` VALUES ('21154', 'Suliki Gunung Mas', 'PT BPR Suliki Gunung Mas');
INSERT INTO `tref_bank` VALUES ('21155', 'Al Makmur', 'PT BPRS Al Makmur');
INSERT INTO `tref_bank` VALUES ('21156', 'Artha Nagari Madani', 'PT BPR Artha Nagari Madani');
INSERT INTO `tref_bank` VALUES ('21157', 'Berok Gunung Pangilun', 'PT BPR Berok Gunung Pangilun');
INSERT INTO `tref_bank` VALUES ('21158', 'Budisetia', 'PT BPR Budisetia');
INSERT INTO `tref_bank` VALUES ('21159', 'Cempaka Mitra Nagari Kephil', 'PT BPR Cempaka Mitra Nagari Kephil');
INSERT INTO `tref_bank` VALUES ('21160', 'Central Micro', 'BP BPR Central Micro');
INSERT INTO `tref_bank` VALUES ('21161', 'Dharma Bhakti Smadang', 'PT BPR Dharma Bhakti Smadang');
INSERT INTO `tref_bank` VALUES ('21162', 'Mitra Danagung', 'PT BPR Mitra Danagung');
INSERT INTO `tref_bank` VALUES ('21163', 'Stigma Andalas', 'PT BPR Stigma Andalas');
INSERT INTO `tref_bank` VALUES ('21164', 'Baringin Pdg. Panjang Sakato', 'PT BPR Baringin Pdg. Panjang Sakato');
INSERT INTO `tref_bank` VALUES ('21165', 'Kampung Manggis', 'BP BPR LPN Kampung Manggis');
INSERT INTO `tref_bank` VALUES ('21166', 'Cincin Permata Andalas', 'PT BPR Cincin Permata Andalas');
INSERT INTO `tref_bank` VALUES ('21167', 'Ganto Nagari 1954', 'PT BPR Ganto Nagari 1954');
INSERT INTO `tref_bank` VALUES ('21168', 'Koto Dalam', 'PT BPR Koto Dalam');
INSERT INTO `tref_bank` VALUES ('21169', 'Nagari Kasang', 'BP BPR LPN Kasang');
INSERT INTO `tref_bank` VALUES ('21170', 'Nurul Barokah', 'PT BPR Nurul Barokah');
INSERT INTO `tref_bank` VALUES ('21171', 'Pembangunan Kab. Padang Pariaman', 'PT BPR Pembangunan Kab. Padang Pariaman');
INSERT INTO `tref_bank` VALUES ('21172', 'Piala Makmur', 'PT BPR Piala Makmur');
INSERT INTO `tref_bank` VALUES ('21173', 'VII Koto', 'Koperasi BPR VII Koto Sungai Sariak');
INSERT INTO `tref_bank` VALUES ('21174', 'Jorong Kampung Tangah', 'BP BPR Jorong Kampung Tangah');
INSERT INTO `tref_bank` VALUES ('21175', 'La Mangau Sejahtera', 'BP BPR La Mangau Sejahtera');
INSERT INTO `tref_bank` VALUES ('21176', 'Khatulistiwa Bonjol', 'PT BPR Khatulistiwa Bonjol');
INSERT INTO `tref_bank` VALUES ('21177', 'Air Bangis', 'BP BPR Air Bangis');
INSERT INTO `tref_bank` VALUES ('21178', 'Mitra Dana', 'BP BPR Mitra Dana');
INSERT INTO `tref_bank` VALUES ('21179', 'Ophir Pasaman', 'Koperasi BPR Ophir');
INSERT INTO `tref_bank` VALUES ('21180', 'Swadaya Anak Nagari', 'BP BPR Swadaya Anak Nagari');
INSERT INTO `tref_bank` VALUES ('21181', 'Mentari Pasaman Saiyo', 'PT BPRS Mentari Pasaman Saiyo');
INSERT INTO `tref_bank` VALUES ('21182', 'Rangkiang Denai', 'PT BPR Rangkiang Denai');
INSERT INTO `tref_bank` VALUES ('21183', 'Batang Kapas', 'PT BPR Batang Kapas');
INSERT INTO `tref_bank` VALUES ('21184', 'Batang Tarusan', 'BP BPR Batang Tarusan');
INSERT INTO `tref_bank` VALUES ('21185', 'Gema Pesisir', 'PT BPR Gema Pesisir');
INSERT INTO `tref_bank` VALUES ('21186', 'Kotosebelas Tarusan', 'PT BPR Kotosebelas Tarusan');
INSERT INTO `tref_bank` VALUES ('21187', 'Lengayang', 'PT BPR Lengayang');
INSERT INTO `tref_bank` VALUES ('21188', 'LPN Tapan', 'BP BPR LPN Tapan');
INSERT INTO `tref_bank` VALUES ('21189', 'Samudera', 'PT BPR Samudera');
INSERT INTO `tref_bank` VALUES ('21190', 'Gajah Tongga Kotopiliang', 'PT BPR Gajah Tongga Kotopiliang');
INSERT INTO `tref_bank` VALUES ('21191', 'Kubang', 'BP BPR LPN Kubang');
INSERT INTO `tref_bank` VALUES ('21192', 'LPN Mudik Air', 'PD BPR LPN Mudik Air');
INSERT INTO `tref_bank` VALUES ('21193', 'Pasar Baru Durian', 'BP BPR LPN Pasar Baru Durian');
INSERT INTO `tref_bank` VALUES ('21194', 'Pondok Kapur', 'PT BPR Pondok Kapur');
INSERT INTO `tref_bank` VALUES ('21195', 'Batang Palangki', 'BP BPR Batang Palangki');
INSERT INTO `tref_bank` VALUES ('21196', 'Bukit Cati Pematang Panjang', 'PT BPR Bukit Cati Pematang Panjang');
INSERT INTO `tref_bank` VALUES ('21197', 'Kampung Dalam', 'BP BPR LPN Kampung Dalam');
INSERT INTO `tref_bank` VALUES ('21198', 'Mutiara Nagari', 'PT BPR Mutiara Nagari');
INSERT INTO `tref_bank` VALUES ('21199', 'LPN Talawi Sakato', 'BP BPR LPN Talawi Sakato');
INSERT INTO `tref_bank` VALUES ('212', 'LKP Belo', '');
INSERT INTO `tref_bank` VALUES ('21200', 'Muaro Bodi', 'BP BPR LPN Muaro Bodi');
INSERT INTO `tref_bank` VALUES ('21201', 'Sijunjung', 'BP BPR Sijunjung');
INSERT INTO `tref_bank` VALUES ('21202', 'Gunung Talang', 'PT BPR Gunung Talang');
INSERT INTO `tref_bank` VALUES ('21203', 'LPN Kinari', 'BP BPR LPN Kinari');
INSERT INTO `tref_bank` VALUES ('21204', 'LPN Bukit Tandang', 'BP BPR Bukit Tandang Mandiri');
INSERT INTO `tref_bank` VALUES ('21205', 'Mos Muara Panas', 'PT BPR Mos Muara Panas');
INSERT INTO `tref_bank` VALUES ('21206', 'Solok Sakato', 'BP BPR Solok Sakato');
INSERT INTO `tref_bank` VALUES ('21207', 'Surya Katialo', 'PT BPR Surya Katialo');
INSERT INTO `tref_bank` VALUES ('21208', 'X Koto Singkarak', 'PT BPR X Koto Singkarak');
INSERT INTO `tref_bank` VALUES ('21209', 'Barakah Nawaitul Ikhlas', 'PT BPRS Barakah Nawaitul Ikhlas');
INSERT INTO `tref_bank` VALUES ('21210', 'LPN Pakan Raba\'a', 'BP BPR LPN Pakan Rabaa');
INSERT INTO `tref_bank` VALUES ('21211', 'Sarantau Sasurambi', 'PT BPR Sarantau Sasurambi');
INSERT INTO `tref_bank` VALUES ('21212', 'Solok Selatan', 'PT BPR Solok Selatan');
INSERT INTO `tref_bank` VALUES ('21213', 'Batang Selo (Batu)', 'BP BPR Batang Selo (Batu)');
INSERT INTO `tref_bank` VALUES ('21214', 'Batipuh', 'PT BPR Batipuh');
INSERT INTO `tref_bank` VALUES ('21215', 'Carano Nagari', 'PT BPR Carano Nagari');
INSERT INTO `tref_bank` VALUES ('21216', 'Gudam Pagaruyung', 'BP BPR LPN Gudam Pagaruyung');
INSERT INTO `tref_bank` VALUES ('21217', 'LPN Andalas Baruh Bukit', 'BP BPR LPN Andalas Baruh Bukit');
INSERT INTO `tref_bank` VALUES ('21218', 'LPN Pandaisikek', 'BP BPR LPN Pandaisikek');
INSERT INTO `tref_bank` VALUES ('21219', 'LPN Tanjung Barulak', 'BP BPR LPN Tanjung Barulak');
INSERT INTO `tref_bank` VALUES ('21220', 'Luhak Nan Tuo', 'BP BPR Luhak Nan Tuo');
INSERT INTO `tref_bank` VALUES ('21221', 'Masyarakat Lintau Buo (Malibu)', 'PT BPR Masyarakat Lintau Buo (Malibu)');
INSERT INTO `tref_bank` VALUES ('21222', 'Padang Magek', 'BP BPR Padang Magek');
INSERT INTO `tref_bank` VALUES ('21223', 'Pagaruyung', 'BP BPR LPN Pagaruyung');
INSERT INTO `tref_bank` VALUES ('21224', 'Pariangan', 'PT BPR Pariangan');
INSERT INTO `tref_bank` VALUES ('21225', 'Rangkiang Nagari', 'PT BPR Rangkiang Nagari');
INSERT INTO `tref_bank` VALUES ('21227', 'Haji Miskin', 'PT BPRS Haji Miskin');
INSERT INTO `tref_bank` VALUES ('21228', 'Balerong Bunta', 'BP BPR LPN Balerong Bunta');
INSERT INTO `tref_bank` VALUES ('21229', 'Guguk Sarai', 'BP BPR Guguk Sarai');
INSERT INTO `tref_bank` VALUES ('21230', 'Marunting Sejahtera', 'PD BPR Marunting Sejahtera');
INSERT INTO `tref_bank` VALUES ('21231', 'Lingga Sejahtera', 'PT BPR Lingga Sejahtera');
INSERT INTO `tref_bank` VALUES ('21232', 'Bangka Belitung', 'PT BPRS Bangka Belitung');
INSERT INTO `tref_bank` VALUES ('21233', 'Rarat Ganda', 'PT BPR Rarat Ganda');
INSERT INTO `tref_bank` VALUES ('21234', 'Al-Falah', 'PT BPRS Al-Falah');
INSERT INTO `tref_bank` VALUES ('21235', 'Sindang Binaharta', 'PT BPR Sindang Binaharta');
INSERT INTO `tref_bank` VALUES ('21236', 'Tiur Ganda', 'PT BPR Tiur Ganda');
INSERT INTO `tref_bank` VALUES ('21237', 'Cinta Manis Agroloka', 'PT BPR Cinta Manis Agroloka');
INSERT INTO `tref_bank` VALUES ('21238', 'Agritrans Batumarta', 'PT BPR Agritrans Batumarta');
INSERT INTO `tref_bank` VALUES ('21239', 'Musi Arta Lestari', 'PT BPR Musi Arta Lestari');
INSERT INTO `tref_bank` VALUES ('21240', 'Mitra Central Dana', 'PT BPR Mitra Central Dana');
INSERT INTO `tref_bank` VALUES ('21241', 'Multidana Mandiri', 'PT BPR Multidana Mandiri');
INSERT INTO `tref_bank` VALUES ('21242', 'Musi Artha Surya', 'PT BPR Musi Artha Surya');
INSERT INTO `tref_bank` VALUES ('21243', 'Prabumegah Kencana', 'PT BPR Prabumegah Kencana');
INSERT INTO `tref_bank` VALUES ('21244', 'Prima Dana Abadi', 'PT BPR Prima Dana Abadi');
INSERT INTO `tref_bank` VALUES ('21245', 'Puskopat', 'PT BPR Puskopat');
INSERT INTO `tref_bank` VALUES ('21246', 'Sukasada', 'PT BPR Sukasada');
INSERT INTO `tref_bank` VALUES ('21247', 'Sumatera Selatan', 'PT BPR Sumatera Selatan');
INSERT INTO `tref_bank` VALUES ('21248', 'Tri Gunung Selatan', 'PT BPR Tri Gunung Selatan');
INSERT INTO `tref_bank` VALUES ('21249', 'Ukabima Grazia', 'PT BPR Ukabima Grazia');
INSERT INTO `tref_bank` VALUES ('21250', 'Ukabima Lestari', 'PT BPR Ukabima Lestari');
INSERT INTO `tref_bank` VALUES ('21251', 'Tahap Ganda', 'PT BPR Tahap Ganda');
INSERT INTO `tref_bank` VALUES ('21252', 'Cipta Dana Prima', 'PT BPR Cipta Dana Prima');
INSERT INTO `tref_bank` VALUES ('21253', 'Palu Anugerah', 'PT BPR Palu Anugerah');
INSERT INTO `tref_bank` VALUES ('21254', 'Palu Lokadana Utama', 'PT BPR Palu Lokadana Utama');
INSERT INTO `tref_bank` VALUES ('21255', 'Alimo Dana Prima', 'PT BPR Alimo Dana Prima');
INSERT INTO `tref_bank` VALUES ('21256', 'Nustria Mitra Abadi', 'PT BPR Nustria Mitra Abadi');
INSERT INTO `tref_bank` VALUES ('21257', 'Prima Artha Sejahtera', 'PT BPR Prima Artha Sejahtera');
INSERT INTO `tref_bank` VALUES ('21258', 'Akarumi', 'PT BPR Akarumi');
INSERT INTO `tref_bank` VALUES ('21259', 'Binarta Luhur', 'PT BPR Binarta Luhur');
INSERT INTO `tref_bank` VALUES ('21260', 'Yaspis Dana Prima', 'PT BPR Yaspis Dana Prima');
INSERT INTO `tref_bank` VALUES ('21261', 'Bumiasih NBP 24', 'PT BPR Bumiasih NBP 24');
INSERT INTO `tref_bank` VALUES ('21262', 'Mandar', 'PT BPR Mandar');
INSERT INTO `tref_bank` VALUES ('21263', 'Mitra Arta Mulia', 'PT BPR Mitra Arta Mulia');
INSERT INTO `tref_bank` VALUES ('21264', 'Terabina Seraya Mulia', 'PT BPR Terabina Seraya Mulia');
INSERT INTO `tref_bank` VALUES ('21265', 'Dumai Kapital Lestari', 'PT BPR Dumai Kapital Lestari');
INSERT INTO `tref_bank` VALUES ('21266', 'Gemilang', 'PD BPR Gemilang');
INSERT INTO `tref_bank` VALUES ('21267', 'Indra Arta', 'PD BPR Indra Arta');
INSERT INTO `tref_bank` VALUES ('21268', 'Bumi Riau Insani', 'PT BPR Bumi Riau Insani');
INSERT INTO `tref_bank` VALUES ('21269', 'Sarimadu', 'PD BPR Sarimadu');
INSERT INTO `tref_bank` VALUES ('21270', 'Unisritama', 'PT BPR Unisritama');
INSERT INTO `tref_bank` VALUES ('21271', 'Berkah Dana Fadhlillah', 'PT BPRS Berkah Dana Fadhlillah');
INSERT INTO `tref_bank` VALUES ('21272', 'Cempaka Mitra Nagori Kuansing', 'PT BPR Cempaka Mitra Nagori Kuansing');
INSERT INTO `tref_bank` VALUES ('21273', 'Dana Amanah', 'PD BPR Dana Amanah');
INSERT INTO `tref_bank` VALUES ('21274', 'Delta Dana Mandiri', 'PT BPR Delta Dana Mandiri');
INSERT INTO `tref_bank` VALUES ('21275', 'Artha Margahayu', 'PT BPR Artha Margahayu');
INSERT INTO `tref_bank` VALUES ('21276', 'Duta Perdana', 'PT BPR Duta Perdana');
INSERT INTO `tref_bank` VALUES ('21277', 'Faiza Pradani Andi', 'PT BPR Faiza Pradani Andi');
INSERT INTO `tref_bank` VALUES ('21278', 'Harta Mandiri', 'PT BPR Harta Mandiri');
INSERT INTO `tref_bank` VALUES ('21279', 'Indomitra Mega Kapital', 'PT BPR Indomitra Mega Kapital');
INSERT INTO `tref_bank` VALUES ('21280', 'Mandiri Jaya Perkasa', 'PT BPR Mandiri Jaya Perkasa');
INSERT INTO `tref_bank` VALUES ('21281', 'Mitra Rakyat Riau', 'PT BPR Mitra Rakyat Riau');
INSERT INTO `tref_bank` VALUES ('21282', 'Payung Negeri Bestari', 'PT BPR Payung Negeri Bestari');
INSERT INTO `tref_bank` VALUES ('21283', 'Pekanbaru', 'PT BPR Pekanbaru');
INSERT INTO `tref_bank` VALUES ('21284', 'Tuah Negeri Mandiri', 'PT BPR Tuah Negeri Mandiri');
INSERT INTO `tref_bank` VALUES ('21285', 'Tunas Mitra Mandiri', 'PT BPR Tunas Mitra Mandiri');
INSERT INTO `tref_bank` VALUES ('21286', 'Universal Karya Mandiri Riau', 'PT BPR Universal Karya Mandiri Riau');
INSERT INTO `tref_bank` VALUES ('21287', 'Cempaka Wadah Sejahtera', 'PT BPR Cempaka Wadah Sejahtera');
INSERT INTO `tref_bank` VALUES ('21288', 'Rokan Hilir', 'PD BPR Rokan Hilir');
INSERT INTO `tref_bank` VALUES ('21289', 'Rokan Hulu', 'PT BPR Rokan Hulu');
INSERT INTO `tref_bank` VALUES ('21290', 'Hasanah', 'PT BPRS Hasanah');
INSERT INTO `tref_bank` VALUES ('21291', 'Cahaya Wiraputra', 'PT BPR Cahaya Wiraputra');
INSERT INTO `tref_bank` VALUES ('21292', 'Pancur Banua Khatulistiwa', 'PT BPR Pancur Banua Khatulistiwa');
INSERT INTO `tref_bank` VALUES ('21293', 'Melawi Mandiri', 'PT BPR Melawi Mandiri');
INSERT INTO `tref_bank` VALUES ('21294', 'Bank Pasar Kota Pontianak', 'PD BPR Bank Pasar Kota Pontianak');
INSERT INTO `tref_bank` VALUES ('21295', 'Cemerlang Kapuas Makmur', 'PT BPR Cemerlang Kapuas Makmur');
INSERT INTO `tref_bank` VALUES ('21296', 'Centradana Kapuas', 'PT BPR Centradana Kapuas');
INSERT INTO `tref_bank` VALUES ('21297', 'Dana Tirtaraya', 'PT BPR Dana Tirtaraya');
INSERT INTO `tref_bank` VALUES ('21298', 'Dana Wira Buana', 'PT BPR Dana Wira Buana');
INSERT INTO `tref_bank` VALUES ('21299', 'Lokadana Sentosa', 'PT BPR Lokadana Sentosa');
INSERT INTO `tref_bank` VALUES ('213', 'Kopang Rembiga', '');
INSERT INTO `tref_bank` VALUES ('21300', 'Perdana Lintas Khatulistiwa', 'PT BPR Perdana Lintas Khatulistiwa');
INSERT INTO `tref_bank` VALUES ('21301', 'Prima Multi Makmur', 'PT BPR Prima Multi Makmur');
INSERT INTO `tref_bank` VALUES ('21302', 'Sukadana Prima', 'PT BPR Sukadana Prima');
INSERT INTO `tref_bank` VALUES ('21303', 'Universal Karya Mandiri Tangerang', 'PT BPR Universal Karya Mandiri Tangerang');
INSERT INTO `tref_bank` VALUES ('21304', 'Tebas Lokarizki', 'PT BPR Tebas Lokarizki');
INSERT INTO `tref_bank` VALUES ('21305', 'Dana Sanggau Mandiri', 'PT BPR Dana Sanggau Mandiri');
INSERT INTO `tref_bank` VALUES ('21306', 'Mitra Primalestari', 'PT BPR Mitra Primalestari');
INSERT INTO `tref_bank` VALUES ('21307', 'Panca Arta Graha', 'PT BPR Panca Arta Graha');
INSERT INTO `tref_bank` VALUES ('21308', 'Sambas Arta', 'PT BPR Sambas Arta');
INSERT INTO `tref_bank` VALUES ('21309', 'BKK Mandiraja', 'PD BPR BKK Mandiraja');
INSERT INTO `tref_bank` VALUES ('21310', 'Surya Yudhakencana', 'PT BPR Surya Yudhakencana');
INSERT INTO `tref_bank` VALUES ('21311', 'Artha Mekar Sokaraja', 'PT BPR Artha Mekar Sokaraja');
INSERT INTO `tref_bank` VALUES ('21312', 'BKK Purwokerto Utara', 'PD BPR BKK Purwokerto Utara');
INSERT INTO `tref_bank` VALUES ('21313', 'Danamitra Sokaraja', 'PT BPR Danamitra Sokaraja');
INSERT INTO `tref_bank` VALUES ('21314', 'Gunung Simping Artha', 'PT BPR Gunung Simping Artha');
INSERT INTO `tref_bank` VALUES ('21315', 'Mitra Gema Mandiri', 'PT BPR Mitra Gema Mandiri');
INSERT INTO `tref_bank` VALUES ('21316', 'Sahabat Purwokerto', 'PT BPR Sahabat Purwokerto');
INSERT INTO `tref_bank` VALUES ('21317', 'Soka Panca Artha', 'PT BPR Soka Panca Artha');
INSERT INTO `tref_bank` VALUES ('21318', 'Dana Mitra Sakti', 'PT BPR Dana Mitra Sakti');
INSERT INTO `tref_bank` VALUES ('21319', 'Arta Leksana', 'PT BPRS Arta Leksana');
INSERT INTO `tref_bank` VALUES ('21320', 'Bina Amanah Satria', 'PT BPRS Bina Amanah Satria');
INSERT INTO `tref_bank` VALUES ('21321', 'Khasanah Ummat', 'PT BPRS Khasanah Ummat');
INSERT INTO `tref_bank` VALUES ('21322', 'Artha Rahayu', 'PT BPR Artha Rahayu');
INSERT INTO `tref_bank` VALUES ('21323', 'Banyu Arthacitra', 'PT BPR Banyu Arthacitra');
INSERT INTO `tref_bank` VALUES ('21324', 'BKK Cilacap Tengah', 'PD BPR BKK Cilacap Tengah');
INSERT INTO `tref_bank` VALUES ('21325', 'Citanduy Artha', 'PT BPR Citanduy Artha');
INSERT INTO `tref_bank` VALUES ('21326', 'Gunung Slamet', 'PT BPR Gunung Slamet');
INSERT INTO `tref_bank` VALUES ('21327', 'Kroya Bangunartha', 'PT BPR Kroya Bangunartha');
INSERT INTO `tref_bank` VALUES ('21328', 'Ukabima Sejahtera', 'PT BPR Ukabima Sejahtera');
INSERT INTO `tref_bank` VALUES ('21329', 'Bumi Artha Sampang', 'PT BPRS Bumi Artha Sampang');
INSERT INTO `tref_bank` VALUES ('21330', 'Gunung Slamet Syariah', 'PT BPRS Syariah Gunung Slamet');
INSERT INTO `tref_bank` VALUES ('21331', 'Suriyah', 'PT BPRS Suriyah');
INSERT INTO `tref_bank` VALUES ('21332', 'Artha Perwira', 'PD BPR Artha Perwira Kab Purbalingga');
INSERT INTO `tref_bank` VALUES ('21333', 'BKK Purbalingga', 'PD BPR BKK Purbalingga');
INSERT INTO `tref_bank` VALUES ('21334', 'Buana Mitra Perwira', 'PT BPRS Buana Mitra Perwira');
INSERT INTO `tref_bank` VALUES ('21335', 'Bontang Sejahtera', 'PT BPR Bontang Sejahtera');
INSERT INTO `tref_bank` VALUES ('21336', 'Dhanarta Dwiprima', 'PT BPR Dhanarta Dwiprima');
INSERT INTO `tref_bank` VALUES ('21337', 'Paro Tua', 'PT BPR Paro Tua');
INSERT INTO `tref_bank` VALUES ('21338', 'Bepede Kutai Sejahtera', 'PT BPR Bepede Kutai Sejahtera');
INSERT INTO `tref_bank` VALUES ('21339', 'Ingertad Kota Bangun', 'PT BPR Ingertad Kota Bangun');
INSERT INTO `tref_bank` VALUES ('21340', 'Kutai Timur', 'PT BPR Kutai Timur');
INSERT INTO `tref_bank` VALUES ('21341', 'Artha Karya Perdana', 'PT BPR Artha Karya Perdana');
INSERT INTO `tref_bank` VALUES ('21342', 'Kota Samarinda', 'PD BPR Kota Samarinda');
INSERT INTO `tref_bank` VALUES ('21343', 'Permata Hati Jaya', 'PT BPR Permata Hati Jaya');
INSERT INTO `tref_bank` VALUES ('21344', 'Ronggolawe', 'PT BPR Ronggolawe Samarinda');
INSERT INTO `tref_bank` VALUES ('21345', 'Semoga Jaya Artha', 'PT BPR Semoga Jaya Artha');
INSERT INTO `tref_bank` VALUES ('21346', 'Zebra Surya Prima', 'PT BPR Zebra Surya Prima');
INSERT INTO `tref_bank` VALUES ('21347', 'BAPERA', 'PT BPR BAPERA');
INSERT INTO `tref_bank` VALUES ('21348', 'BKK TPI Klidang Lor', 'PD BKK TPI Klidang Lor');
INSERT INTO `tref_bank` VALUES ('21349', 'Limpungarta Utama', 'PT BPR Limpungarta Utama');
INSERT INTO `tref_bank` VALUES ('21350', 'Bank Pasar Kabupaten Dati II  Blora', 'PD BPR Bank Pasar Kabupaten Dati II  Blora');
INSERT INTO `tref_bank` VALUES ('21351', 'BKK Blora Kota', 'PD BPR BKK Blora Kota');
INSERT INTO `tref_bank` VALUES ('21352', 'Cepu Nasionalbank', 'PT BPR Cepu Nasionalbank');
INSERT INTO `tref_bank` VALUES ('21353', 'Dhana Mitratama', 'PT BPR Dhana Mitratama');
INSERT INTO `tref_bank` VALUES ('21354', 'Dutabhakti Insani', 'PT BPR Dutabhakti Insani');
INSERT INTO `tref_bank` VALUES ('21355', 'Arisma Mandiri', 'PT BPR Arisma Mandiri');
INSERT INTO `tref_bank` VALUES ('21356', 'BKK Banjarharjo', 'PD BPR BKK Banjarharjo');
INSERT INTO `tref_bank` VALUES ('21357', 'Bumiayu Bangun Citra', 'PT BPR Bumiayu Bangun Citra');
INSERT INTO `tref_bank` VALUES ('21358', 'Eleska Artha', 'PT BPR Eleska Artha');
INSERT INTO `tref_bank` VALUES ('21359', 'Jatibarang Sediaguna', 'PT BPR Jatibarang Sediaguna');
INSERT INTO `tref_bank` VALUES ('21360', 'Puspakencana Brebes', 'PD BPR Puspakencana Brebes');
INSERT INTO `tref_bank` VALUES ('21361', 'Artamas', 'PT BPR Artamas');
INSERT INTO `tref_bank` VALUES ('21362', 'Artha Mranggenjaya', 'PT BPR Artha Mranggenjaya');
INSERT INTO `tref_bank` VALUES ('21363', 'Arthanugraha Makmursejahtera', 'PT BPR Arthanugraha Makmursejahtera');
INSERT INTO `tref_bank` VALUES ('21364', 'BKK Demak Kota', 'PD BPR BKK Demak Kota');
INSERT INTO `tref_bank` VALUES ('21365', 'Karticentra Artha', 'PT BPR Karticentra Artha');
INSERT INTO `tref_bank` VALUES ('21366', 'Kusuma Langgeng', 'PT BPR Kusuma Langgeng');
INSERT INTO `tref_bank` VALUES ('21367', 'Mranggen Mitrapersada', 'PT BPR Mranggen Mitrapersada');
INSERT INTO `tref_bank` VALUES ('21368', 'Restu Mranggen Makmur', 'PT BPR Restu Mranggen Makmur');
INSERT INTO `tref_bank` VALUES ('21369', 'Sindhur Arta Mulia Kencana', 'PT BPR Sindhur Arta Mulia Kencana');
INSERT INTO `tref_bank` VALUES ('21370', 'Swadharma Mranggen', 'PT BPR Swadharma Mranggen');
INSERT INTO `tref_bank` VALUES ('21371', 'BKK Purwodadi', 'PD BPR BKK Purwodadi');
INSERT INTO `tref_bank` VALUES ('21372', 'Purwa Artha', 'PT BPR Purwa Artha');
INSERT INTO `tref_bank` VALUES ('21373', 'Wirosari  Ijo', 'PT BPR Wirosari  Ijo');
INSERT INTO `tref_bank` VALUES ('21374', 'Ben Salamah Abadi', 'PT BPRS Ben Salamah Abadi');
INSERT INTO `tref_bank` VALUES ('21375', 'BKK Jepara', 'PD BPR BKK Jepara');
INSERT INTO `tref_bank` VALUES ('21376', 'Jepara Artha', 'PD BPR Jepara Artha');
INSERT INTO `tref_bank` VALUES ('21377', 'Nusamba Pecangaan', 'PT BPR Nusamba Pecangaan');
INSERT INTO `tref_bank` VALUES ('21378', 'Artha Mitragombong', 'PT BPR Artha Mitragombong');
INSERT INTO `tref_bank` VALUES ('21379', 'Bank Pasar Kabupaten Kebumen', 'PD BPR Bank Pasar Kabupaten Kebumen');
INSERT INTO `tref_bank` VALUES ('21380', 'BKK Kebumen', 'PD BPR BKK Kebumen');
INSERT INTO `tref_bank` VALUES ('21381', 'Dana Mitra Sejahtera', 'PT BPR Dana Mitra Sejahtera');
INSERT INTO `tref_bank` VALUES ('21382', 'Gunung Merapi', 'PT BPR Gunung Merapi');
INSERT INTO `tref_bank` VALUES ('21383', 'Sinararta Sejahtera', 'PT BPR Sinararta Sejahtera');
INSERT INTO `tref_bank` VALUES ('21384', 'Ikhsanul Amal', 'PT BPRS Ikhsanul Amal');
INSERT INTO `tref_bank` VALUES ('21385', 'Agung Sejahtera', 'PT BPR Agung Sejahtera');
INSERT INTO `tref_bank` VALUES ('21386', 'Anugerah Harta Kaliwungu', 'PT BPR Anugerah Harta Kaliwungu');
INSERT INTO `tref_bank` VALUES ('21387', 'Artha Kaliwungu', 'PT BPR Artha Kaliwungu');
INSERT INTO `tref_bank` VALUES ('21388', 'Arthama Cerah', 'PT BPR Arthama Cerah');
INSERT INTO `tref_bank` VALUES ('21389', 'BKK Boja', 'PT BPR Pasar Boja');
INSERT INTO `tref_bank` VALUES ('21390', 'Citra Darian', 'PT BPR Citra Darian');
INSERT INTO `tref_bank` VALUES ('21391', 'Dhanatani Cepiring', 'PT BPR Dhanatani Cepiring');
INSERT INTO `tref_bank` VALUES ('21392', 'Enggal Makmur Adi Santoso', 'PT BPR Enggal Makmur Adi Santoso');
INSERT INTO `tref_bank` VALUES ('21393', 'Kendali Artha', 'PD BPR Kendali Artha');
INSERT INTO `tref_bank` VALUES ('21394', 'Kusuma Rejo', 'PT BPR Kusuma Rejo');
INSERT INTO `tref_bank` VALUES ('21395', 'Kusuma Sari', 'PT BPR Kusuma Sari');
INSERT INTO `tref_bank` VALUES ('21396', 'Nusamba Cepiring', 'PT BPR Nusamba Cepiring');
INSERT INTO `tref_bank` VALUES ('21397', 'Pasar Boja', 'PT BPR Pasar Boja');
INSERT INTO `tref_bank` VALUES ('21398', 'Sukorejo Menara Mulya', 'PT BPR Sukorejo Menara Mulya');
INSERT INTO `tref_bank` VALUES ('21399', 'Swadharma Makmur Artha Sembada', 'PT BPR Swadharma Makmur Artha Sembada');
INSERT INTO `tref_bank` VALUES ('214', 'Bahteramas Kolaka', 'PD BPR Bahteramas Kolaka');
INSERT INTO `tref_bank` VALUES ('21400', 'Weleri Jayapersada', 'PT BPR Weleri Jayapersada');
INSERT INTO `tref_bank` VALUES ('21401', 'Asad Alif', 'PT BPRS Syariah Asad Alif');
INSERT INTO `tref_bank` VALUES ('21402', 'Bank Pasar Kabupaten Kudus', 'PT BPR Hartha Muriatama');
INSERT INTO `tref_bank` VALUES ('21403', 'BKK Jati - Kudus', 'PD BPR BKK Jati - Kudus');
INSERT INTO `tref_bank` VALUES ('21404', 'Catur Artha Jaya', 'PT BPR Catur Artha Jaya');
INSERT INTO `tref_bank` VALUES ('21405', 'Dananta', 'PT BPR Dananta');
INSERT INTO `tref_bank` VALUES ('21406', 'Hartha Muriatama', 'PT BPR Hartha Muriatama');
INSERT INTO `tref_bank` VALUES ('21407', 'Mitra Budikusuma Mandiri', 'PT BPR Mitra Budikusuma Mandiri');
INSERT INTO `tref_bank` VALUES ('21408', 'Taruna Adidaya Santosa', 'PT BPR Taruna Adidaya Santosa');
INSERT INTO `tref_bank` VALUES ('21409', 'Artha Mertoyudan', 'PT BPR Artha Mertoyudan');
INSERT INTO `tref_bank` VALUES ('21410', 'Artha Sambhara', 'PT BPR Artha Sambhara');
INSERT INTO `tref_bank` VALUES ('21411', 'Bank Bapas 69', 'PD BPR Bank Bapas 70');
INSERT INTO `tref_bank` VALUES ('21412', 'Bank Pasar Kota Magelang', 'PD BPR Bank Magelang');
INSERT INTO `tref_bank` VALUES ('21413', 'BKK Magelang Utara', 'PD BPR BKK Magelang Utara');
INSERT INTO `tref_bank` VALUES ('21414', 'BKK Muntilan', 'PD BPR BKK Muntilan');
INSERT INTO `tref_bank` VALUES ('21415', 'Danarakyat Sentosa', 'PT BPR Danarakyat Sentosa');
INSERT INTO `tref_bank` VALUES ('21416', 'Dwiartha Sagriya', 'PT BPR Dwiartha Sagriya');
INSERT INTO `tref_bank` VALUES ('21417', 'Hidup Arthagraha', 'PT BPR Hidup Arthagraha');
INSERT INTO `tref_bank` VALUES ('21418', 'Kembang Parama', 'PT BPR Kembang Parama');
INSERT INTO `tref_bank` VALUES ('21419', 'Lumbung Artha Muntilanindo', 'PT BPR Lumbung Artha Muntilanindo');
INSERT INTO `tref_bank` VALUES ('21420', 'Mertoyudan Makmur', 'PT BPR Mertoyudan Makmur');
INSERT INTO `tref_bank` VALUES ('21421', 'Mitra', 'PT BPR Mitra');
INSERT INTO `tref_bank` VALUES ('21422', 'Mulyo Lumintu', 'PT BPR Mulyo Lumintu');
INSERT INTO `tref_bank` VALUES ('21423', 'Niji', 'PT BPR Niji');
INSERT INTO `tref_bank` VALUES ('21424', 'Prima Mertoyudan Sejahtera', 'PT BPR Prima Mertoyudan Sejahtera');
INSERT INTO `tref_bank` VALUES ('21425', 'Sinar Garuda Prima', 'PT BPR Sinar Garuda Prima');
INSERT INTO `tref_bank` VALUES ('21426', 'Meru Sankara', 'PT BPRS Meru Sankara');
INSERT INTO `tref_bank` VALUES ('21427', 'Bank Daerah Pati', 'PD BPR Bank Daerah Pati');
INSERT INTO `tref_bank` VALUES ('21428', 'Artaperdana Delta Sentosa', 'PT BPR Artaperdana Delta Sentosa');
INSERT INTO `tref_bank` VALUES ('21429', 'Artha Huda Abadi', 'PT BPR Artha Huda Abadi');
INSERT INTO `tref_bank` VALUES ('21430', 'Asabahana Sejahtera', 'PT BPR Asabahana Sejahtera');
INSERT INTO `tref_bank` VALUES ('21431', 'BKK Pati Kota', 'PD BPR BKK Pati Kota');
INSERT INTO `tref_bank` VALUES ('21432', 'Juwana Arthasurya', 'PT BPR Juwana Arthasurya');
INSERT INTO `tref_bank` VALUES ('21433', 'Kusuma Arta Rini', 'PT BPR Kusuma Arta Rini');
INSERT INTO `tref_bank` VALUES ('21434', 'Mitra Pati Mandiri', 'PT BPR Mitra Pati Mandiri');
INSERT INTO `tref_bank` VALUES ('21435', 'Sungkunandhana', 'PT BPR Sungkunandhana');
INSERT INTO `tref_bank` VALUES ('21436', 'Tayu Dutapersada', 'PT BPR Tayu Dutapersada');
INSERT INTO `tref_bank` VALUES ('21437', 'Wedarijaksa', 'Koperasi BPR Wedarijaksa');
INSERT INTO `tref_bank` VALUES ('21438', 'Artha Mas Abadi', 'PT BPRS Artha Mas Abadi');
INSERT INTO `tref_bank` VALUES ('21439', 'BKK Karanganyar - Pekalongan', 'PD BPR BKK Karanganyar Kab Pekalongan');
INSERT INTO `tref_bank` VALUES ('21440', 'BKK Pekalongan Barat', 'PD BPR BKK Pekalongan Barat');
INSERT INTO `tref_bank` VALUES ('21441', 'Sejahtera Artha Sembada', 'PT BPR Sejahtera Artha Sembada');
INSERT INTO `tref_bank` VALUES ('21442', 'Bank Pasar Kota Pekalongan', 'PD BPR Bank Pasar Kota Pekalongan');
INSERT INTO `tref_bank` VALUES ('21443', 'Bank Pasar Kabupaten Pemalang', 'PD BPR Bank Pasar Kabupaten Pemalang');
INSERT INTO `tref_bank` VALUES ('21444', 'BKK Taman', 'PD BPR BKK Taman');
INSERT INTO `tref_bank` VALUES ('21445', 'Hidup Artha Putra', 'PT BPR Hidup Artha Putra');
INSERT INTO `tref_bank` VALUES ('21446', 'Panasayu Arthalayan Sejahtera', 'PT BPR Panasayu Arthalayan Sejahtera');
INSERT INTO `tref_bank` VALUES ('21447', 'Semeru', 'PT BPR Semeru');
INSERT INTO `tref_bank` VALUES ('21448', 'Bank Pasar Kabupaten Purworejo', 'PD BPR Bank Pasar Kabupaten Purworejo');
INSERT INTO `tref_bank` VALUES ('21449', 'BKK Purworejo', 'PD BPR BKK Purworejo');
INSERT INTO `tref_bank` VALUES ('21450', 'Bank Pasar Kabupaten Rembang', 'PD BPR Bank Pasar Kabupaten Rembang');
INSERT INTO `tref_bank` VALUES ('21451', 'BKK Lasem', 'PD BPR BKK Lasem Kabupaten Rembang');
INSERT INTO `tref_bank` VALUES ('21452', 'Dinamika Bangun Arta', 'PT BPR Dinamika Bangun Arta');
INSERT INTO `tref_bank` VALUES ('21453', 'Kota Salatiga', 'PD BPR Bank Salatiga');
INSERT INTO `tref_bank` VALUES ('21454', 'Kridaharta Salatiga', 'PT BPR Kridaharta Salatiga');
INSERT INTO `tref_bank` VALUES ('21455', 'Adil Jaya Artha', 'PT BPR Adil Jaya Artha');
INSERT INTO `tref_bank` VALUES ('21456', 'Ambarawa Hartasarana', 'PT BPR Ambarawa Hartasarana');
INSERT INTO `tref_bank` VALUES ('21457', 'Ambarawa Persada', 'PT BPR Ambarawa Persada');
INSERT INTO `tref_bank` VALUES ('21458', 'Argo Dana Ungaran', 'PT BPR Argo Dana Ungaran');
INSERT INTO `tref_bank` VALUES ('21459', 'Artha Mukti Santosa', 'PT BPR Artha Mukti Santosa');
INSERT INTO `tref_bank` VALUES ('21460', 'Artha Mutiara', 'PT BPR Artha Mutiara');
INSERT INTO `tref_bank` VALUES ('21461', 'Artha Tanah Mas', 'PT BPR Artha Tanah Mas');
INSERT INTO `tref_bank` VALUES ('21462', 'Arto Moro', 'PT BPR Arto Moro');
INSERT INTO `tref_bank` VALUES ('21463', 'Bank Pasar Kota Semarang', 'PD BPR Bank Pasar Kota Semarang');
INSERT INTO `tref_bank` VALUES ('21464', 'BKK Semarang Tengah', 'PD BPR BKK Semarang Tengah');
INSERT INTO `tref_bank` VALUES ('21465', 'BKK Ungaran', 'PD BPR BKK Ungaran');
INSERT INTO `tref_bank` VALUES ('21466', 'BPR Jateng', 'PT BPR BPR Jateng');
INSERT INTO `tref_bank` VALUES ('21467', 'Dana Mitra Sentosa', 'PT BPR Dana Mitra Sentosa');
INSERT INTO `tref_bank` VALUES ('21468', 'Estetika Artha Guna', 'PT BPR Estetika Artha Guna');
INSERT INTO `tref_bank` VALUES ('21469', 'Gunung Kawi', 'PT BPR Gunung Kawi');
INSERT INTO `tref_bank` VALUES ('21470', 'Gunung Kinibalu', 'PT BPR Gunung Kinibalu');
INSERT INTO `tref_bank` VALUES ('21471', 'Gunung Merbabu', 'PT BPR Gunung Merbabu');
INSERT INTO `tref_bank` VALUES ('21472', 'Gunung Rizki Pusaka Utama', 'PT BPR Gunung Rizki Pusaka Utama');
INSERT INTO `tref_bank` VALUES ('21473', 'Inti Ambarawa Sejahtera', 'PT BPR Inti Ambarawa Sejahtera');
INSERT INTO `tref_bank` VALUES ('21474', 'Kedung Arto', 'PT BPR Kedung Arto');
INSERT INTO `tref_bank` VALUES ('21475', 'Klepu Mitra Kencana', 'PT BPR Klepu Mitra Kencana');
INSERT INTO `tref_bank` VALUES ('21476', 'Kusuma Makmur', 'PT BPR Kusuma Makmur');
INSERT INTO `tref_bank` VALUES ('21477', 'Kusuma Palagan Ambarawa', 'PT BPR Kusuma Palagan Ambarawa');
INSERT INTO `tref_bank` VALUES ('21478', 'Mandiri Artha Abadi', 'PT BPR Mandiri Artha Abadi');
INSERT INTO `tref_bank` VALUES ('21479', 'Mekar Nugraha Klepu', 'PT BPR Mekar Nugraha Klepu');
INSERT INTO `tref_bank` VALUES ('21480', 'Mitra Mulia Persada', 'PT BPR Mitra Mulia Persada');
INSERT INTO `tref_bank` VALUES ('21481', 'Persada Ganda', 'PT BPR Persada Ganda');
INSERT INTO `tref_bank` VALUES ('21482', 'Restu Artha Makmur', 'PT BPR Restu Artha Makmur');
INSERT INTO `tref_bank` VALUES ('21483', 'Restu Klepu Makmur', 'PT BPR Restu Klepu Makmur');
INSERT INTO `tref_bank` VALUES ('21484', 'Rudo Indobank', 'PT BPR Rudo Indobank');
INSERT INTO `tref_bank` VALUES ('21485', 'Satria Pertiwi Semarang', 'PT BPR Satria Pertiwi Semarang');
INSERT INTO `tref_bank` VALUES ('21486', 'Semarang Margatama Gunadana', 'PT BPR Semarang Margatama Gunadana');
INSERT INTO `tref_bank` VALUES ('21487', 'Setia Karib Abadi', 'PT BPR Setia Karib Abadi');
INSERT INTO `tref_bank` VALUES ('21488', 'Weleri Makmur', 'PT BPR Weleri Makmur');
INSERT INTO `tref_bank` VALUES ('21489', 'Artha Amanah Ummat', 'PT BPRS Artha Amanah Ummat');
INSERT INTO `tref_bank` VALUES ('21490', 'Artha Surya Barokah', 'PT BPRS Artha Surya Barokah');
INSERT INTO `tref_bank` VALUES ('21491', 'Mitra Harmoni Kota Semarang', 'PT BPRS Mitra Harmoni Kota Semarang');
INSERT INTO `tref_bank` VALUES ('21492', 'PNM Binama', 'PT BPRS PNM Binama');
INSERT INTO `tref_bank` VALUES ('21493', 'Arismentari Ayu', 'PT BPR Arismentari Ayu');
INSERT INTO `tref_bank` VALUES ('21494', 'Artha Kramat', 'PT BPR Artha Kramat');
INSERT INTO `tref_bank` VALUES ('21495', 'Arthapuspa Mega', 'PT BPR Arthapuspa Mega');
INSERT INTO `tref_bank` VALUES ('21496', 'Bank Pasar Kota Tegal', 'PD BPR Bank Pasar Kota Tegal');
INSERT INTO `tref_bank` VALUES ('21497', 'Bank Tegal Gotong Royong', 'PD BPR Bank Tegal Gotong Royong (TGR)');
INSERT INTO `tref_bank` VALUES ('21498', 'BKK Margadana', 'PD BPR BKK Margadana');
INSERT INTO `tref_bank` VALUES ('21499', 'BKK Talang', 'PD BPR BKK Talang');
INSERT INTO `tref_bank` VALUES ('215', 'Bahteramas Konawe', 'PD BPR Bahteramas Konawe');
INSERT INTO `tref_bank` VALUES ('21500', 'Bumi Sediaguna', 'PT BPR Bumi Sediaguna');
INSERT INTO `tref_bank` VALUES ('21501', 'Central Artha', 'PT BPR Central Artha');
INSERT INTO `tref_bank` VALUES ('21502', 'Dhana Adiwerna', 'PT BPR Dhana Adiwerna');
INSERT INTO `tref_bank` VALUES ('21503', 'Mega Artha Mustika', 'PT BPR Mega Artha Mustika');
INSERT INTO `tref_bank` VALUES ('21504', 'Nusamba Adiwerna', 'PT BPR Nusamba Adiwerna');
INSERT INTO `tref_bank` VALUES ('21505', 'Nusumma Jateng', 'PT BPR Nusumma Jateng');
INSERT INTO `tref_bank` VALUES ('21506', 'Sahabat Tata', 'PT BPR Sahabat Tata');
INSERT INTO `tref_bank` VALUES ('21507', 'Bank Pasar Kabupaten Temanggung', 'PD BPR Bank Pasar Kabupaten Temanggung');
INSERT INTO `tref_bank` VALUES ('21508', 'BKK Temanggung', 'PD BPR BKK Temanggung');
INSERT INTO `tref_bank` VALUES ('21509', 'Intan Surya', 'PT BPR Intan Surya');
INSERT INTO `tref_bank` VALUES ('21510', 'Kedu Arthasetia', 'PT BPR Kedu Arthasetia');
INSERT INTO `tref_bank` VALUES ('21511', 'Kusuma Sumbing', 'PT BPR Kusuma Sumbing');
INSERT INTO `tref_bank` VALUES ('21512', 'Multi Arthanusa', 'PT BPR Multi Arthanusa');
INSERT INTO `tref_bank` VALUES ('21513', 'Suryakusuma Kranggan', 'PT BPR Suryakusuma Kranggan');
INSERT INTO `tref_bank` VALUES ('21514', 'Artha Selomanik Putra', 'PT BPR Artha Selomanik Putra');
INSERT INTO `tref_bank` VALUES ('21515', 'Bank Wonosobo', 'PD BPR Bank Wonosobo');
INSERT INTO `tref_bank` VALUES ('21516', 'BKK Wonosobo', 'PD BPR BKK Wonosobo');
INSERT INTO `tref_bank` VALUES ('21517', 'Puspa Kencana', 'PT BPR Puspa Kencana');
INSERT INTO `tref_bank` VALUES ('21518', 'Surya Yudha', 'PT BPR Surya Yudha');
INSERT INTO `tref_bank` VALUES ('21519', 'Arthayasa Ageng', 'PT BPR Arthayasa Ageng');
INSERT INTO `tref_bank` VALUES ('21520', 'BKK Boyolali  Kota', 'PD BPR BKK Boyolali  Kota');
INSERT INTO `tref_bank` VALUES ('21521', 'Guna Daya', 'PT BPR Guna Daya');
INSERT INTO `tref_bank` VALUES ('21522', 'Bank Pasar Kabupaten Boyolali', 'PD BPR Bank Pasar Kabupaten Boyolali');
INSERT INTO `tref_bank` VALUES ('21523', 'Mitra Pandanaran Mandiri', 'PT BPR Mitra Pandanaran Mandiri');
INSERT INTO `tref_bank` VALUES ('21524', 'Nusamba Ampel', 'PT BPR Nusamba Ampel');
INSERT INTO `tref_bank` VALUES ('21525', 'Yekti Insan Sembada', 'PT BPR Yekti Insan Sembada');
INSERT INTO `tref_bank` VALUES ('21526', 'Antar Rumeksa Arta', 'PT BPR Antar Rumeksa Arta');
INSERT INTO `tref_bank` VALUES ('21527', 'Arta Mas Surakarta', 'PT BPR Arta Mas Surakarta');
INSERT INTO `tref_bank` VALUES ('21528', 'Bank Pasar Kabupaten Karanganyar', 'PD BPR Bank Daerah Karanganyar');
INSERT INTO `tref_bank` VALUES ('21529', 'Bina Sejahtera Insani', 'PT BPR Bina Sejahtera Insani');
INSERT INTO `tref_bank` VALUES ('21530', 'Bank Karanganyar', 'PD BPR Bank Karanganyar');
INSERT INTO `tref_bank` VALUES ('21531', 'BKK Tasikmadu', 'PD BPR BKK Tasikmadu');
INSERT INTO `tref_bank` VALUES ('21532', 'Buana Artha Lestari', 'PT BPR Buana Artha Lestari');
INSERT INTO `tref_bank` VALUES ('21533', 'Cita Dewi', 'PT BPR Cita Dewi');
INSERT INTO `tref_bank` VALUES ('21534', 'Gondangrejo', 'PT BPR Gondangrejo');
INSERT INTO `tref_bank` VALUES ('21535', 'Kandimadu Arta', 'PT BPR Kandimadu Arta');
INSERT INTO `tref_bank` VALUES ('21536', 'Lawu Artha', 'PT BPR Lawu Artha');
INSERT INTO `tref_bank` VALUES ('21537', 'Pura Artha Kencana Jatipuro', 'PT BPR Pura Artha Kencana Jatipuro');
INSERT INTO `tref_bank` VALUES ('21538', 'Tawangmangu Jaya', 'PT BPR Tawangmangu Jaya');
INSERT INTO `tref_bank` VALUES ('21539', 'Trihasta Prasodjo', 'PT BPR Trihasta Prasodjo');
INSERT INTO `tref_bank` VALUES ('21540', 'Artha Daya', 'PT BPR Artha Daya');
INSERT INTO `tref_bank` VALUES ('21541', 'Bhakti Riyadi', 'PT BPR Bhakti Riyadi');
INSERT INTO `tref_bank` VALUES ('21542', 'BKK Pedan', 'PD BPR BKK Pedan');
INSERT INTO `tref_bank` VALUES ('21543', 'BKK Tulung', 'PD BPR BKK Tulung');
INSERT INTO `tref_bank` VALUES ('21544', 'Ceper', 'Koperasi BPR Ceper');
INSERT INTO `tref_bank` VALUES ('21545', 'Danamas Pratama', 'PT BPR Danamas Pratama');
INSERT INTO `tref_bank` VALUES ('21546', 'Delanggu Raya', 'PT BPR Delanggu Raya');
INSERT INTO `tref_bank` VALUES ('21547', 'Gunung Lawu', 'PT BPR Gunung Lawu');
INSERT INTO `tref_bank` VALUES ('21548', 'Gunung Mas', 'PT BPR Gunung Mas');
INSERT INTO `tref_bank` VALUES ('21549', 'Hardi Mas Mandiri', 'PT BPR Hardi Mas Mandiri');
INSERT INTO `tref_bank` VALUES ('21550', 'Kab. Dati II  Klaten', 'PD BPR Bank Kalaten Kabupaten Klaten');
INSERT INTO `tref_bank` VALUES ('21551', 'Klaten Sejahtera', 'PT BPR Klaten Sejahtera');
INSERT INTO `tref_bank` VALUES ('21552', 'Kusuma Danaraja', 'PT BPR Kusuma Danaraja');
INSERT INTO `tref_bank` VALUES ('21553', 'Patma \"Klaten\"', 'Koperasi BPR Bank Pasar Patma');
INSERT INTO `tref_bank` VALUES ('21554', 'Restu Klaten Makmur', 'PT BPR Restu Klaten Makmur');
INSERT INTO `tref_bank` VALUES ('21555', 'Shinta Bhakti Wedi', 'PT BPR Shinta Bhakti Wedi');
INSERT INTO `tref_bank` VALUES ('21556', 'Sinarenam Permai Delanggu', 'PT BPR Sinarenam Permai Delanggu');
INSERT INTO `tref_bank` VALUES ('21557', 'Ukabima BMMS', 'PT BPR Ukabima BMMS');
INSERT INTO `tref_bank` VALUES ('21558', 'Wuni Artha Utama', 'PT BPR Wuni Artha Utama');
INSERT INTO `tref_bank` VALUES ('21559', 'Al Mabrur Klaten', 'PT BPRS Al Mabrur Klaten');
INSERT INTO `tref_bank` VALUES ('21560', 'Binalanggeng Mulia', 'PT BPR Binalanggeng Mulia');
INSERT INTO `tref_bank` VALUES ('21561', 'Central International', 'PT BPR Central International');
INSERT INTO `tref_bank` VALUES ('21562', 'Dana Utama', 'PT BPR Dana Utama');
INSERT INTO `tref_bank` VALUES ('21563', 'Nguter Surakarta', 'PT BPR Nguter Surakarta');
INSERT INTO `tref_bank` VALUES ('21564', 'Rejeki Insani', 'PT BPR Rejeki Insani');
INSERT INTO `tref_bank` VALUES ('21565', 'Sukadana', 'PT BPR Sukadana');
INSERT INTO `tref_bank` VALUES ('21566', 'Sukadyarindang', 'PT BPR Sukadyarindang');
INSERT INTO `tref_bank` VALUES ('21567', 'Bank Solo', 'PD BPR Bank Solo');
INSERT INTO `tref_bank` VALUES ('21568', 'Suryamas', 'PT BPR Suryamas');
INSERT INTO `tref_bank` VALUES ('21569', 'Central Syariah Utama', 'PT BPRS Central Syariah Utama');
INSERT INTO `tref_bank` VALUES ('21570', 'BKK Karangmalang', 'PD BPR BKK Karangmalang');
INSERT INTO `tref_bank` VALUES ('21571', 'Djoko Tingkir', 'PD BPR Djoko Tingkir');
INSERT INTO `tref_bank` VALUES ('21572', 'Gemolong Artha Mulyo', 'PT BPR Gemolong Artha Mulyo');
INSERT INTO `tref_bank` VALUES ('21573', 'Ghadira Danamulia', 'PT BPR Ghadira Danamulia');
INSERT INTO `tref_bank` VALUES ('21574', 'Mitra Banaran Mandiri', 'PT BPR Mitra Banaran Mandiri');
INSERT INTO `tref_bank` VALUES ('21575', 'Sukowati Jaya', 'PT BPR Sukowati Jaya');
INSERT INTO `tref_bank` VALUES ('21576', 'Sumber Arta', 'PT BPR Sumber Arta');
INSERT INTO `tref_bank` VALUES ('21577', 'Sragen', 'PD BPRS Sragen');
INSERT INTO `tref_bank` VALUES ('21578', 'Artha Sari Sentosa', 'PT BPR Artha Sari Sentosa');
INSERT INTO `tref_bank` VALUES ('21579', 'Bank Pasar Kabupaten Sukoharjo', 'PD BPR Bank Pasar Kabupaten Sukoharjo');
INSERT INTO `tref_bank` VALUES ('21580', 'Bekonang  Sukoharjo', 'PT BPR Bekonang  Sukoharjo');
INSERT INTO `tref_bank` VALUES ('21581', 'BKK Baki', 'PD BPR BKK Baki');
INSERT INTO `tref_bank` VALUES ('21582', 'BKK Bendosari', 'PD BPR BKK Bendosari');
INSERT INTO `tref_bank` VALUES ('21583', 'BKK Grogol', 'PD BPR BKK Grogol');
INSERT INTO `tref_bank` VALUES ('21584', 'BKK Mojolaban', 'PD BPR BKK Mojolaban');
INSERT INTO `tref_bank` VALUES ('21585', 'Grogol Joyo', 'PT BPR Grogol Joyo');
INSERT INTO `tref_bank` VALUES ('21586', 'Ihuthan  Ganda', 'PT BPR Ihuthan  Ganda');
INSERT INTO `tref_bank` VALUES ('21587', 'Restu Artha Abadi', 'PT BPR Restu Artha Abadi');
INSERT INTO `tref_bank` VALUES ('21588', 'Jadi Manunggal Abadi', 'PT BPR Jadi Manunggal Abadi');
INSERT INTO `tref_bank` VALUES ('21589', 'Kartadhani  Mulya', 'PT BPR Kartadhani  Mulya');
INSERT INTO `tref_bank` VALUES ('21590', 'Kartasura Makmur', 'PT BPR Kartasura Makmur');
INSERT INTO `tref_bank` VALUES ('21591', 'Kartasura Saribumi', 'PT BPR Kartasura Saribumi');
INSERT INTO `tref_bank` VALUES ('21592', 'Sami Makmur', 'PT BPR Sami Makmur');
INSERT INTO `tref_bank` VALUES ('21593', 'Sinarguna Sejahtera', 'PT BPR Sinarguna Sejahtera');
INSERT INTO `tref_bank` VALUES ('21594', 'Solobaru Permai', 'PT BPR Solobaru Permai');
INSERT INTO `tref_bank` VALUES ('21595', 'Surya Utama', 'PT BPR Surya Utama');
INSERT INTO `tref_bank` VALUES ('21596', 'Tugu Kencana', 'PT BPR Tugu Kencana');
INSERT INTO `tref_bank` VALUES ('21597', 'Wira Ardana Sejahtera', 'PT BPR Wira Ardana Sejahtera');
INSERT INTO `tref_bank` VALUES ('21598', 'Insan Madani', 'PT BPRS Insan Madani');
INSERT INTO `tref_bank` VALUES ('21599', 'Sabar Arthapalur', 'PT BPR Sabar Arthapalur');
INSERT INTO `tref_bank` VALUES ('216', 'Bahteramas Konawe Selatan', 'PD BPR Bahteramas Konawe Selatan');
INSERT INTO `tref_bank` VALUES ('21600', 'Usaha Madani Karya Mulia', 'PT BPR Usaha Madani Karya Mulia');
INSERT INTO `tref_bank` VALUES ('21601', 'Dana Amanah Syariah', 'PT BPRS Syariah Dana Amanah');
INSERT INTO `tref_bank` VALUES ('21602', 'Dana Mulia', 'PT BPRS Dana Mulia');
INSERT INTO `tref_bank` VALUES ('21603', 'BKK Wonogiri  Kota', 'PD BPR BKK Wonogiri  Kota');
INSERT INTO `tref_bank` VALUES ('21604', 'Gajah Mungkur', 'PT BPR Gajah Mungkur');
INSERT INTO `tref_bank` VALUES ('21605', 'Giri Suka Dana', 'PD BPR Giri Sukadana');
INSERT INTO `tref_bank` VALUES ('21606', 'Danakerja  Putra', 'PT BPR Danakerja  Putra');
INSERT INTO `tref_bank` VALUES ('21607', 'Kabupaten Dati II Bangkalan', 'PD BPR Bank Pasar Kabupaten Bangkalan');
INSERT INTO `tref_bank` VALUES ('21608', 'Delta Bojonegoro', 'PT BPR Delta Bojonegoro');
INSERT INTO `tref_bank` VALUES ('21609', 'Bank Daerah Bojonegoro', 'PD BPR Bank Daerah Bojonegoro');
INSERT INTO `tref_bank` VALUES ('21610', 'Rajekwesi', 'PT BPR Rajekwesi');
INSERT INTO `tref_bank` VALUES ('21611', 'Tanah Kondang', 'PT BPR Tanah Kondang');
INSERT INTO `tref_bank` VALUES ('21612', 'Aneka Dana Sejahtera', 'PT BPR Aneka Dana Sejahtera');
INSERT INTO `tref_bank` VALUES ('21613', 'Arindomegah Abadi', 'PT BPR Arindomegah Abadi');
INSERT INTO `tref_bank` VALUES ('21614', 'Balongpanggang Sentosa', 'PT BPR Balongpanggang Sentosa');
INSERT INTO `tref_bank` VALUES ('21615', 'Bumi Sanggabuana', 'PT BPR Bumi Sanggabuana');
INSERT INTO `tref_bank` VALUES ('21616', 'Dana Rajabally', 'PT BPR Dana Rajabally');
INSERT INTO `tref_bank` VALUES ('21617', 'Delta Gresik', 'PT BPR Delta Gresik');
INSERT INTO `tref_bank` VALUES ('21618', 'Intan Kita', 'PT BPR Intan Kita');
INSERT INTO `tref_bank` VALUES ('21619', 'Intan Nasional', 'PT BPR Intan Nasional');
INSERT INTO `tref_bank` VALUES ('21620', 'Kabupaten Dati II Gresik', 'PD BPR Kabupaten Dati II Gresik');
INSERT INTO `tref_bank` VALUES ('21621', 'Kebomas', 'PT BPR Kebomas');
INSERT INTO `tref_bank` VALUES ('21622', 'Mitra Cemawis Mandiri', 'PT BPR Mitra Cemawis Mandiri');
INSERT INTO `tref_bank` VALUES ('21623', 'Rajadana Menganti', 'PT BPR Rajadana Menganti');
INSERT INTO `tref_bank` VALUES ('21624', 'Amanah Sejahtera', 'PT BPRS Amanah Sejahtera');
INSERT INTO `tref_bank` VALUES ('21625', 'Mandiri Mitra Sukses', 'PT BPRS Mandiri Mitra Sukses');
INSERT INTO `tref_bank` VALUES ('21626', 'Arta Muktigraha', 'PT BPR Arta Muktigraha');
INSERT INTO `tref_bank` VALUES ('21627', 'Artha Anugrah Kencana', 'PT BPR Artha Anugrah Kencana');
INSERT INTO `tref_bank` VALUES ('21628', 'Bhapertim Persada', 'PT BPR Bhapertim Persada');
INSERT INTO `tref_bank` VALUES ('21629', 'Bumi Arta', 'Koperasi BPR Bumi Arta');
INSERT INTO `tref_bank` VALUES ('21630', 'Kabupaten Dati II Jombang', 'PD BPR Kabupaten Dati II Jombang');
INSERT INTO `tref_bank` VALUES ('21631', 'Mojoagung Pahalapakto', 'PT BPR Mojoagung Pahalapakto');
INSERT INTO `tref_bank` VALUES ('21632', 'Nusumma Tebuireng', 'PT BPR Nusumma Tebuireng');
INSERT INTO `tref_bank` VALUES ('21633', 'Panji Aronta', 'PT BPR Panji Aronta');
INSERT INTO `tref_bank` VALUES ('21634', 'Ploso Saranaartha', 'PT BPR Ploso Saranaartha');
INSERT INTO `tref_bank` VALUES ('21635', 'Surya Arthaguna  Abadi', 'PT BPR Surya Arthaguna  Abadi');
INSERT INTO `tref_bank` VALUES ('21636', 'Tjoekir Dasa Nusantara', 'PT BPR Tjoekir Dasa Nusantara');
INSERT INTO `tref_bank` VALUES ('21637', 'Wijaya Prima', 'PT BPR Wijaya Prima');
INSERT INTO `tref_bank` VALUES ('21638', 'Lantabur', 'PT BPRS Lantabur');
INSERT INTO `tref_bank` VALUES ('21639', 'Arta Swasembada Mojokerto', 'PT BPR Arta Swasembada Mojokerto');
INSERT INTO `tref_bank` VALUES ('21640', 'Babat Lestari', 'PT BPR Babat Lestari');
INSERT INTO `tref_bank` VALUES ('21641', 'Bank Daerah Lamongan', 'PD BPR Bank Daerah Lamongan');
INSERT INTO `tref_bank` VALUES ('21642', 'Damata Arthanugraha', 'PT BPR Damata Arthanugraha');
INSERT INTO `tref_bank` VALUES ('21643', 'Delta Lamongan', 'PT BPR Delta Lamongan');
INSERT INTO `tref_bank` VALUES ('21644', 'Mitra Dhanaceswara', 'PT BPR Mitra Dhanaceswara');
INSERT INTO `tref_bank` VALUES ('21645', 'Nusamba Brondong', 'PT BPR Nusamba Brondong');
INSERT INTO `tref_bank` VALUES ('21646', 'Rukun Karya Sari', 'Koperasi BPR Rukun Karya Sari');
INSERT INTO `tref_bank` VALUES ('21647', 'Ulintha Ganda', 'PT BPR Ulintha Ganda');
INSERT INTO `tref_bank` VALUES ('21648', 'Madinah', 'PT BPRS Madinah');
INSERT INTO `tref_bank` VALUES ('21649', 'Arta Bangsal Utama', 'PT BPR Arta Bangsal Utama');
INSERT INTO `tref_bank` VALUES ('21650', 'Arta Haksaprima', 'PT BPR Arta Haksaprima');
INSERT INTO `tref_bank` VALUES ('21651', 'Arta Swasembada Mojosari', 'PT BPR Arta Swasembada Mojosari');
INSERT INTO `tref_bank` VALUES ('21652', 'Bank Pasar Kabupaten Mojokerto', 'PD BPR Bank Pasar Kabupaten Mojokerto');
INSERT INTO `tref_bank` VALUES ('21653', 'Bumi Jaya', 'PT BPR Bumi Jaya');
INSERT INTO `tref_bank` VALUES ('21654', 'Delta Artha Panggung Mojokerto', 'PT BPR Delta Artha Panggung Mojokerto');
INSERT INTO `tref_bank` VALUES ('21655', 'Indoartha Bintang Mulia', 'PT BPR Indoartha Bintang Mulia');
INSERT INTO `tref_bank` VALUES ('21656', 'Kurnia Dadi Arta', 'PT BPR Kurnia Dadi Arta');
INSERT INTO `tref_bank` VALUES ('21657', 'Mojosari Pahalapakto', 'PT BPR Mojosari Pahalapakto');
INSERT INTO `tref_bank` VALUES ('21658', 'Puriseger Sentosa', 'PT BPR Puriseger Sentosa');
INSERT INTO `tref_bank` VALUES ('21659', 'Sejahtera', 'Koperasi BPR Sejahtera');
INSERT INTO `tref_bank` VALUES ('21660', 'Terusan Jaya', 'PT BPR Terusan Jaya');
INSERT INTO `tref_bank` VALUES ('21661', 'Pamekasan Purapersada', 'PT BPR Pamekasan Purapersada');
INSERT INTO `tref_bank` VALUES ('21662', 'Sarana Pamekasan Membangun', 'PT BPRS Sarana Pamekasan Membangun');
INSERT INTO `tref_bank` VALUES ('21663', 'Bakti Artha Sejahtera', 'PT BPR Bakti Artha Sejahtera');
INSERT INTO `tref_bank` VALUES ('21664', 'Abrin Centra Artha', 'PT BPR Abrin Centra Artha');
INSERT INTO `tref_bank` VALUES ('21665', 'Anglomas Indah', 'PT BPR Anglomas Indah');
INSERT INTO `tref_bank` VALUES ('21666', 'Aridha Artha Nugraha', 'PT BPR Aridha Artha Nugraha');
INSERT INTO `tref_bank` VALUES ('21667', 'Arta Mulya Bumi Mukti', 'PT BPR Arta Mulya Bumi Mukti');
INSERT INTO `tref_bank` VALUES ('21668', 'Arta Waru Surya', 'PT BPR Arta Waru Surya');
INSERT INTO `tref_bank` VALUES ('21669', 'Artha Buana', 'PT BPR Artha Buana');
INSERT INTO `tref_bank` VALUES ('21670', 'Bandataman', 'PT BPR Bandataman');
INSERT INTO `tref_bank` VALUES ('21671', 'Bank Pasar Bhakti', 'PT BPR Bank Pasar Bhakti');
INSERT INTO `tref_bank` VALUES ('21672', 'Benta Tesa', 'PT BPR Benta Tesa');
INSERT INTO `tref_bank` VALUES ('21673', 'Buana Dana Makmur', 'PT BPR Buana Dana Makmur');
INSERT INTO `tref_bank` VALUES ('21674', 'Buduran Delta Purnama', 'PT BPR Buduran Delta Purnama');
INSERT INTO `tref_bank` VALUES ('21675', 'Bumi Gora Jaya', 'PT BPR Bumi Gora Jaya');
INSERT INTO `tref_bank` VALUES ('21676', 'Candisaka Arta', 'PT BPR Candisaka Arta');
INSERT INTO `tref_bank` VALUES ('21677', 'Danamas Makmur', 'PT BPR Danamas Makmur');
INSERT INTO `tref_bank` VALUES ('21678', 'Danumas Binadhana', 'PT BPR Danumas Binadhana');
INSERT INTO `tref_bank` VALUES ('21679', 'Delta Artha', 'PT BPR Delta Artha');
INSERT INTO `tref_bank` VALUES ('21680', 'Delta Sidoarjo', 'PT BPR Delta Sidoarjo');
INSERT INTO `tref_bank` VALUES ('21681', 'Surabaya Lestari', 'PT BPR Surabaya Lestari');
INSERT INTO `tref_bank` VALUES ('21682', 'Dinar Pusaka', 'PT BPR Dinar Pusaka');
INSERT INTO `tref_bank` VALUES ('21683', 'Dirgadhana Arthamas', 'PT BPR Dirgadhana Arthamas');
INSERT INTO `tref_bank` VALUES ('21684', 'Djojo Mandiri Raya', 'PT BPR Djojo Mandiri Raya');
INSERT INTO `tref_bank` VALUES ('21685', 'Gema Nusa', 'PT BPR Gema Nusa');
INSERT INTO `tref_bank` VALUES ('21686', 'Handalniaga Bumindo', 'PT BPR Handalniaga Bumindo');
INSERT INTO `tref_bank` VALUES ('21687', 'Indodana Hargotama', 'PT BPR Indodana Hargotama');
INSERT INTO `tref_bank` VALUES ('21688', 'Inti Danita', 'PT BPR Inti Danita');
INSERT INTO `tref_bank` VALUES ('21689', 'Iswara Artha', 'PT BPR Iswara Artha');
INSERT INTO `tref_bank` VALUES ('21690', 'Jati Lestari', 'PT BPR Jati Lestari');
INSERT INTO `tref_bank` VALUES ('21691', 'Jenjen Wahana Niagamas', 'PT BPR Jenjen Wahana Niagamas');
INSERT INTO `tref_bank` VALUES ('21692', 'Karya Perdana Sejahtera', 'PT BPR Karya Perdana Sejahtera');
INSERT INTO `tref_bank` VALUES ('21693', 'Krian Nusantara', 'PT BPR Krian Nusantara');
INSERT INTO `tref_bank` VALUES ('21694', 'Krian Wijaya', 'PT BPR Krian Wijaya');
INSERT INTO `tref_bank` VALUES ('21695', 'Kudamas Sentosa', 'PT BPR Kudamas Sentosa');
INSERT INTO `tref_bank` VALUES ('21696', 'Masyarakat Mandiri', 'PT BPR Masyarakat Mandiri');
INSERT INTO `tref_bank` VALUES ('21697', 'Megakerta Swadiri', 'PT BPR Megakerta Swadiri');
INSERT INTO `tref_bank` VALUES ('21698', 'Mitra Maju Jaya Mandiri', 'PT BPR Mitra Maju Jaya Mandiri');
INSERT INTO `tref_bank` VALUES ('21699', 'Padat Ganda', 'PT BPR Padat Ganda');
INSERT INTO `tref_bank` VALUES ('217', 'Kec. Malangbong', '');
INSERT INTO `tref_bank` VALUES ('21700', 'Porong Idaman', 'PT BPR Porong Idaman');
INSERT INTO `tref_bank` VALUES ('21701', 'Porong Lestari', 'PT BPR Porong Lestari');
INSERT INTO `tref_bank` VALUES ('21702', 'Puridana Artamas', 'PT BPR Puridana Artamas');
INSERT INTO `tref_bank` VALUES ('21703', 'Rejeki Datang', 'PT BPR Rejeki Datang');
INSERT INTO `tref_bank` VALUES ('21704', 'Sahabat Sedati', 'PT BPR Sahabat Sedati');
INSERT INTO `tref_bank` VALUES ('21705', 'Sarana Sukses', 'PT BPR Sarana Sukses');
INSERT INTO `tref_bank` VALUES ('21706', 'Sekar Tarunamulia', 'PT BPR Sekar Tarunamulia');
INSERT INTO `tref_bank` VALUES ('21707', 'Sentra Dana Makmur', 'PT BPR Sentra Dana Makmur');
INSERT INTO `tref_bank` VALUES ('21708', 'Sepanjang Sumber Dharmaarta', 'PT BPR Sepanjang Sumber Dharmaarta');
INSERT INTO `tref_bank` VALUES ('21709', 'Sinardana Buana', 'PT BPR Sinardana Buana');
INSERT INTO `tref_bank` VALUES ('21710', 'Sriekaya', 'PT BPR Sriekaya');
INSERT INTO `tref_bank` VALUES ('21711', 'Sumber Artha Waru Agung', 'PT BPR Sumber Artha Waru Agung');
INSERT INTO `tref_bank` VALUES ('21712', 'Sumber Usahawan Bersama', 'PT BPR Sumber Usahawan Bersama');
INSERT INTO `tref_bank` VALUES ('21713', 'Taman Adimakmur', 'PT BPR Taman Adimakmur');
INSERT INTO `tref_bank` VALUES ('21714', 'Taman Artha Kencana', 'PT BPR Taman Artha Kencana');
INSERT INTO `tref_bank` VALUES ('21715', 'Taman Dhana', 'PT BPR Taman Dhana');
INSERT INTO `tref_bank` VALUES ('21716', 'Toelangan Dasa Nusantara', 'PT BPR Toelangan Dasa Nusantara');
INSERT INTO `tref_bank` VALUES ('21717', 'Tri Harta Indah', 'PT BPR Tri Harta Indah');
INSERT INTO `tref_bank` VALUES ('21718', 'Vita Jasaguna', 'PT BPR Vita Jasaguna');
INSERT INTO `tref_bank` VALUES ('21719', 'Waru Dhanasejahtera', 'PT BPR Waru Dhanasejahtera');
INSERT INTO `tref_bank` VALUES ('21720', 'Wiradhana Putramas', 'PT BPR Wiradhana Putramas');
INSERT INTO `tref_bank` VALUES ('21721', 'Annisa Mukti', 'PT BPRS Annisa Mukti');
INSERT INTO `tref_bank` VALUES ('21722', 'Baktimakmur Indah', 'PT BPRS Baktimakmur Indah');
INSERT INTO `tref_bank` VALUES ('21723', 'Unawi Barokah', 'PT BPRS Unawi Barokah');
INSERT INTO `tref_bank` VALUES ('21724', 'Bhakti Sumekar', 'PT BPRS Bhakti Sumekar');
INSERT INTO `tref_bank` VALUES ('21725', 'Bintang Mitra', 'PT BPR Bintang Mitra');
INSERT INTO `tref_bank` VALUES ('21726', 'Central Niaga', 'PT BPR Central Niaga');
INSERT INTO `tref_bank` VALUES ('21727', 'Danamas', 'PT BPR Danamas');
INSERT INTO `tref_bank` VALUES ('21728', 'Danamitra Surya', 'PT BPR Danamitra Surya');
INSERT INTO `tref_bank` VALUES ('21729', 'Guna Yatra', 'PT BPR Guna Yatra');
INSERT INTO `tref_bank` VALUES ('21730', 'Jawa Timur', 'PT BPR Jawa Timur');
INSERT INTO `tref_bank` VALUES ('21731', 'Kosanda', 'PT BPR Kosanda');
INSERT INTO `tref_bank` VALUES ('21732', 'Permata Artha Surya', 'PT BPR Permata Artha Surya');
INSERT INTO `tref_bank` VALUES ('21733', 'Prima Kredit Utama', 'PT BPR Prima Kredit Utama');
INSERT INTO `tref_bank` VALUES ('21734', 'Surya Artha Utama', 'PT BPR Surya Artha Utama');
INSERT INTO `tref_bank` VALUES ('21735', 'Jabal Nur', 'PT BPRS Jabal Nur');
INSERT INTO `tref_bank` VALUES ('21736', 'Karya Mugi Sentosa', 'PT BPRS Karya Mugi Sentosa');
INSERT INTO `tref_bank` VALUES ('21737', 'Charis Utama', 'PT BPR Charis Utama');
INSERT INTO `tref_bank` VALUES ('21738', 'Mentari Terang', 'PT BPR Mentari Terang');
INSERT INTO `tref_bank` VALUES ('21739', 'Semanding', 'Koperasi BPR Semanding');
INSERT INTO `tref_bank` VALUES ('21740', 'Banjar Arthasariguna', 'PT BPR Banjar Arthasariguna');
INSERT INTO `tref_bank` VALUES ('21741', 'BKPD Cijulang', 'PD BPR BKPD Cijulang');
INSERT INTO `tref_bank` VALUES ('21742', 'BKPD Lakbok', 'PD BPR BKPD Lakbok');
INSERT INTO `tref_bank` VALUES ('21743', 'BKPD Pangandaran', 'PD BPR BKPD Pangandaran');
INSERT INTO `tref_bank` VALUES ('21744', 'LPK Cimerak', 'PD BPR LPK Cimerak');
INSERT INTO `tref_bank` VALUES ('21745', 'Sehat Ekonomi', 'PT BPR Sehat Ekonomi');
INSERT INTO `tref_bank` VALUES ('21746', 'Nusantara Bona Pasogit 31', 'PT BPR Nusantara Bona Pasogit 31');
INSERT INTO `tref_bank` VALUES ('21747', 'LPK Bojonggambir', 'PD BPR LPK Bojonggambir');
INSERT INTO `tref_bank` VALUES ('21748', 'LPK Cipatujah', 'PD BPR LPK Cipatujah');
INSERT INTO `tref_bank` VALUES ('21749', 'Mitra Kopjaya Mandiri', 'PT BPR Mitra Kopjaya Mandiri');
INSERT INTO `tref_bank` VALUES ('21750', 'Nusamba Singaparna', 'PT BPR Nusamba Singaparna');
INSERT INTO `tref_bank` VALUES ('21751', 'Nusumma Singaparna', 'PT BPR Nusumma Singaparna');
INSERT INTO `tref_bank` VALUES ('21752', 'Sahat Sentosa', 'PT BPR Sahat Sentosa');
INSERT INTO `tref_bank` VALUES ('21754', 'Artha Jaya Mandiri', 'PT BPR Artha Jaya Mandiri');
INSERT INTO `tref_bank` VALUES ('21756', 'Pola Dana', 'PT BPR Pola Dana');
INSERT INTO `tref_bank` VALUES ('21757', 'Siliwangi', 'PT BPR Siliwangi');
INSERT INTO `tref_bank` VALUES ('21758', 'Al Wadi\'ah', 'PT BPRS Al Wadi\'ah');
INSERT INTO `tref_bank` VALUES ('21759', 'Al-Madinah Tasikmalaya', 'PT BPRS Al-Madinah Tasikmalaya');
INSERT INTO `tref_bank` VALUES ('21760', 'Ambarketawang Persada', 'PT BPR Ambarketawang Persada');
INSERT INTO `tref_bank` VALUES ('21761', 'Arga Tata', 'PT BPR Arga Tata');
INSERT INTO `tref_bank` VALUES ('21762', 'Arum Mandiri Kenanga', 'PT BPR Arum Mandiri Kenanga');
INSERT INTO `tref_bank` VALUES ('21763', 'Bank Pasar Bantul', 'PD BPR Bank Pasar Bantul');
INSERT INTO `tref_bank` VALUES ('21764', 'Bina Arta Swadaya Yogyakarta', 'PT BPR Bina Arta Swadaya Yogyakarta');
INSERT INTO `tref_bank` VALUES ('21765', 'Chandra Muktiartha', 'PT BPR Chandra Muktiartha');
INSERT INTO `tref_bank` VALUES ('21766', 'Kartikaartha Kencanajaya', 'PT BPR Kartikaartha Kencanajaya');
INSERT INTO `tref_bank` VALUES ('21767', 'Kurnia Sewon', 'PT BPR Kurnia Sewon');
INSERT INTO `tref_bank` VALUES ('21768', 'Nusamba Banguntapan', 'PT BPR Nusamba Banguntapan');
INSERT INTO `tref_bank` VALUES ('21769', 'Profidana Paramitra', 'PT BPR Profidana Paramitra');
INSERT INTO `tref_bank` VALUES ('21770', 'Swadharma Artha Nusa', 'PT BPR Swadharma Artha Nusa');
INSERT INTO `tref_bank` VALUES ('21771', 'Swadharma Bangun Artha', 'PT BPR Swadharma Bangun Artha');
INSERT INTO `tref_bank` VALUES ('21772', 'Tandu Artha', 'PT BPR Tandu Artha');
INSERT INTO `tref_bank` VALUES ('21773', 'Bangun Drajat Warga', 'PT BPRS Bangun Drajat Warga');
INSERT INTO `tref_bank` VALUES ('21774', 'Madina Mandiri Sejahtera', 'PT BPRS Madina Mandiri Sejahtera');
INSERT INTO `tref_bank` VALUES ('21775', 'Margirizki Bahagia', 'PT BPRS Margirizki Bahagia');
INSERT INTO `tref_bank` VALUES ('21776', 'Agra Arthaka Mulya', 'PT BPR Agra Arthaka Mulya');
INSERT INTO `tref_bank` VALUES ('21777', 'Arum Mandiri Melati', 'PT BPR Arum Mandiri Melati');
INSERT INTO `tref_bank` VALUES ('21778', 'Kabupaten Gunung Kidul', 'PD BPR Bank Daerah Gunung Kidul');
INSERT INTO `tref_bank` VALUES ('21779', 'Ukabima Nindya Raharja', 'PT BPR Ukabima Nindya Raharja');
INSERT INTO `tref_bank` VALUES ('21780', 'Kulon Progo', 'PD BPR Kulon Progo');
INSERT INTO `tref_bank` VALUES ('21781', 'Nusamba Temon', 'PT BPR Nusamba Temon');
INSERT INTO `tref_bank` VALUES ('21782', 'Shinta Putra Pengasih', 'PT BPR Shinta Putra Pengasih');
INSERT INTO `tref_bank` VALUES ('21783', 'Alto Makmur', 'PT BPR Alto Makmur');
INSERT INTO `tref_bank` VALUES ('21784', 'Arta Agung Yogyakarta', 'PT BPR Arta Agung Yogyakarta');
INSERT INTO `tref_bank` VALUES ('21785', 'Arta Yogyakarta', 'PT BPR Arta Yogyakarta');
INSERT INTO `tref_bank` VALUES ('21786', 'Artajaya Bhaktimulia', 'PT BPR Artajaya Bhaktimulia');
INSERT INTO `tref_bank` VALUES ('21787', 'Artha Mlatiindah', 'PT BPR Artha Mlatiindah');
INSERT INTO `tref_bank` VALUES ('21788', 'Artha Sumber Arum', 'PT BPR Artha Sumber Arum');
INSERT INTO `tref_bank` VALUES ('21789', 'Berlian Bumi Arta', 'PT BPR Berlian Bumi Arta');
INSERT INTO `tref_bank` VALUES ('21790', 'Bhakti Daya Ekonomi', 'PT BPR Bhakti Daya Ekonomi');
INSERT INTO `tref_bank` VALUES ('21791', 'Bhumikarya Pala', 'PT BPR Bhumikarya Pala');
INSERT INTO `tref_bank` VALUES ('21792', 'Danagung Abadi', 'PT BPR Danagung Abadi');
INSERT INTO `tref_bank` VALUES ('21793', 'Danagung Bakti', 'PT BPR Danagung Bakti');
INSERT INTO `tref_bank` VALUES ('21794', 'Danagung Ramulti', 'PT BPR Danagung Ramulti');
INSERT INTO `tref_bank` VALUES ('21795', 'Danamas Prima', 'PT BPR Danamas Prima');
INSERT INTO `tref_bank` VALUES ('21796', 'Dewa Arthaka Mulya', 'PT BPR Dewa Arthaka Mulya');
INSERT INTO `tref_bank` VALUES ('21797', 'Duta Gama', 'PT BPR Duta Gama');
INSERT INTO `tref_bank` VALUES ('21798', 'Gamping Artha Raya', 'PT BPR Gamping Artha Raya');
INSERT INTO `tref_bank` VALUES ('21799', 'Kabupaten Sleman', 'PD BPR Bank Pasar Kab Sleman');
INSERT INTO `tref_bank` VALUES ('218', 'BKK Gembong', '');
INSERT INTO `tref_bank` VALUES ('21800', 'Karangwaru Pratama', 'PT BPR Karangwaru Pratama');
INSERT INTO `tref_bank` VALUES ('21801', 'Mlati Pundi Artha', 'PT BPR Mlati Pundi Artha');
INSERT INTO `tref_bank` VALUES ('21802', 'Nusapanida Godean', 'PT BPR Nusapanida Godean');
INSERT INTO `tref_bank` VALUES ('21803', 'Nusumma Tempel', 'PT BPR Nusumma Tempel');
INSERT INTO `tref_bank` VALUES ('21804', 'Panca Arta Monjali', 'PT BPR Panca Arta Monjali');
INSERT INTO `tref_bank` VALUES ('21805', 'Redjo Bhawono', 'PT BPR Redjo Bhawono');
INSERT INTO `tref_bank` VALUES ('21806', 'Restu Mandiri Makmur', 'PT BPR Restu Mandiri Makmur');
INSERT INTO `tref_bank` VALUES ('21807', 'Shinta Daya', 'PT BPR Shinta Daya');
INSERT INTO `tref_bank` VALUES ('21808', 'Sindu Adi', 'PT BPR Sindu Adi');
INSERT INTO `tref_bank` VALUES ('21809', 'Wijayamulya Santosa', 'PT BPR Wijayamulya Santosa');
INSERT INTO `tref_bank` VALUES ('21810', 'Danagung Syari?ah', 'PT BPRS Danagung Syari?ah');
INSERT INTO `tref_bank` VALUES ('21811', 'Formes', 'PT BPRS Formes');
INSERT INTO `tref_bank` VALUES ('21812', 'Mitra Amal Mulia', 'PT BPRS Mitra Amal Mulia');
INSERT INTO `tref_bank` VALUES ('21813', 'Mitra Cahaya Indonesia', 'PT BPRS Mitra Cahaya Indonesia');
INSERT INTO `tref_bank` VALUES ('21814', 'Artha Berkah Cemerlang', 'PT BPR Artha Berkah Cemerlang');
INSERT INTO `tref_bank` VALUES ('21815', 'Artha Parama', 'PT BPR Artha Parama');
INSERT INTO `tref_bank` VALUES ('21816', 'Bank Jogja Kota Yogyakarta', 'PD BPR Bank Jogja Kota Yogyakarta');
INSERT INTO `tref_bank` VALUES ('21817', 'Lestari Darmo Mulyo', 'PT BPR Lestari Darmo Mulyo');
INSERT INTO `tref_bank` VALUES ('21818', 'Madani Sejahtera Abadi', 'PT BPR Madani Sejahtera Abadi');
INSERT INTO `tref_bank` VALUES ('21819', 'Mataram Mitra Manunggal', 'PT BPR Mataram Mitra Manunggal');
INSERT INTO `tref_bank` VALUES ('21820', 'Walet Jaya Abadi', 'PT BPR Walet Jaya Abadi');
INSERT INTO `tref_bank` VALUES ('21821', 'Barokah Dana Sejahtera', 'PT BPRS Barokah Dana Sejahtera');
INSERT INTO `tref_bank` VALUES ('21822', 'Dana Hidayatullah', 'PT BPRS Dana Hidayatullah');
INSERT INTO `tref_bank` VALUES ('21823', 'Mitra Harmoni Yogyakarta', 'PT BPRS Mitra Harmoni Yogyakarta');
INSERT INTO `tref_bank` VALUES ('219', 'BKK Gombong', '');
INSERT INTO `tref_bank` VALUES ('220', 'Bahteramas Kendari', 'PD BPR Bahteramas Kendari');
INSERT INTO `tref_bank` VALUES ('221', 'Bahteramas Wakatobi', 'PT BPR Bahteramas Wakatobi');
INSERT INTO `tref_bank` VALUES ('22100', '', 'Bank yy');
INSERT INTO `tref_bank` VALUES ('22106', 'Bank Test 2', 'PT. Bank Test 2');
INSERT INTO `tref_bank` VALUES ('222', 'LKP Lembuak', '');
INSERT INTO `tref_bank` VALUES ('223', 'Bank UOB Buana Tbk', '');
INSERT INTO `tref_bank` VALUES ('224', 'BKK Bulu', '');
INSERT INTO `tref_bank` VALUES ('225', 'Bank Windu Kentjana', '');
INSERT INTO `tref_bank` VALUES ('226', 'Bangun Randu Kencana', '');
INSERT INTO `tref_bank` VALUES ('227', 'Salaman Argakencana', '');
INSERT INTO `tref_bank` VALUES ('228', 'Ampel Guna Kencana', '');
INSERT INTO `tref_bank` VALUES ('229', 'Nusumma Cepu', '');
INSERT INTO `tref_bank` VALUES ('230', 'Karangpucung', '');
INSERT INTO `tref_bank` VALUES ('231', 'BKK Undaan', '');
INSERT INTO `tref_bank` VALUES ('232', 'Kecamatan Purwadadi', '');
INSERT INTO `tref_bank` VALUES ('233', 'Wanadadi', '');
INSERT INTO `tref_bank` VALUES ('23306', 'Bank DT', 'PT Bank DT');
INSERT INTO `tref_bank` VALUES ('234', 'BKK Purwodadi - Purworejo', '');
INSERT INTO `tref_bank` VALUES ('235', 'Cidahu', '');
INSERT INTO `tref_bank` VALUES ('236', 'Dana Mitra Utama', 'PT BPR Dana Mitra Utama');
INSERT INTO `tref_bank` VALUES ('237', 'Tripanca Setiadana', '');
INSERT INTO `tref_bank` VALUES ('238', 'Musajaya Arthadana', '');
INSERT INTO `tref_bank` VALUES ('239', 'Kallyana Adhikamandana', '');
INSERT INTO `tref_bank` VALUES ('240', 'Satya Adhi Perdana', '');
INSERT INTO `tref_bank` VALUES ('241', 'Kaligondang', '');
INSERT INTO `tref_bank` VALUES ('242', 'BKK Sadang', '');
INSERT INTO `tref_bank` VALUES ('243', 'BKK Gondang', '');
INSERT INTO `tref_bank` VALUES ('244', 'BKK Dawe', '');
INSERT INTO `tref_bank` VALUES ('245', 'Mataram Godean', '');
INSERT INTO `tref_bank` VALUES ('246', 'Swadharma Godean', '');
INSERT INTO `tref_bank` VALUES ('247', 'BKK Wiradesa', '');
INSERT INTO `tref_bank` VALUES ('248', 'LPK Cipeundeuy', '');
INSERT INTO `tref_bank` VALUES ('249', 'kec. Cipeundeuy (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', '');
INSERT INTO `tref_bank` VALUES ('250', 'Citraloka Danamandiri', '');
INSERT INTO `tref_bank` VALUES ('251', 'Kencana Artha Mandiri', '');
INSERT INTO `tref_bank` VALUES ('252', 'Indomitra Mandiri Ciputat', '');
INSERT INTO `tref_bank` VALUES ('253', 'Danaku Mapan Lestari', 'PT BPR Danaku Mapan Lestari');
INSERT INTO `tref_bank` VALUES ('254', 'Dharma Kuwera', 'PT BPRS Dharma Kuwera');
INSERT INTO `tref_bank` VALUES ('255', 'BKK Godong', '');
INSERT INTO `tref_bank` VALUES ('256', 'Andong', '');
INSERT INTO `tref_bank` VALUES ('257', 'BKK Sukodono', '');
INSERT INTO `tref_bank` VALUES ('258', 'Banyudono', '');
INSERT INTO `tref_bank` VALUES ('259', 'BKK Doro', '');
INSERT INTO `tref_bank` VALUES ('260', 'BKK Wedung', '');
INSERT INTO `tref_bank` VALUES ('261', 'Kec. Soreang (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', '');
INSERT INTO `tref_bank` VALUES ('262', 'BKK Reban', '');
INSERT INTO `tref_bank` VALUES ('263', 'Mrebet', '');
INSERT INTO `tref_bank` VALUES ('264', 'BKK Gebog', '');
INSERT INTO `tref_bank` VALUES ('265', 'BKK Patebon', '');
INSERT INTO `tref_bank` VALUES ('266', 'BKK Sedan', '');
INSERT INTO `tref_bank` VALUES ('267', 'Bank Ekspor Indonesia (Persero) (cabut ijin 1 September 2009)', '');
INSERT INTO `tref_bank` VALUES ('268', 'Punggelan', '');
INSERT INTO `tref_bank` VALUES ('269', 'BKK Bagelen', '');
INSERT INTO `tref_bank` VALUES ('270', 'BKK Gumelar', '');
INSERT INTO `tref_bank` VALUES ('271', 'Leles', '');
INSERT INTO `tref_bank` VALUES ('272', 'LKP Sambelia (Merger ke BPR NTB Lombok Timur Tgl31/8/2009)', '');
INSERT INTO `tref_bank` VALUES ('273', 'LPK Kasemen', '');
INSERT INTO `tref_bank` VALUES ('274', 'BKK Gemuh', '');
INSERT INTO `tref_bank` VALUES ('275', 'BKK Jakenan', '');
INSERT INTO `tref_bank` VALUES ('276', 'BKK Kradenan', '');
INSERT INTO `tref_bank` VALUES ('277', 'Nusumma Durenan (merger ke Nusumma Tebuireng Tgl. 20/1/2009)', '');
INSERT INTO `tref_bank` VALUES ('278', 'BKK Jenar', '');
INSERT INTO `tref_bank` VALUES ('279', 'BKK Bener', '');
INSERT INTO `tref_bank` VALUES ('280', 'LKP Tente Bima', '');
INSERT INTO `tref_bank` VALUES ('281', 'Nusumma Ceper', '');
INSERT INTO `tref_bank` VALUES ('282', 'Swadharma Depok', '');
INSERT INTO `tref_bank` VALUES ('283', 'Mapalus Keketeran (Merger Ke Mapalus Tumetenden Tgl 15/4/2009)', '');
INSERT INTO `tref_bank` VALUES ('284', 'Teras BKK', '');
INSERT INTO `tref_bank` VALUES ('285', 'Mustaqim Blangkejeren', '');
INSERT INTO `tref_bank` VALUES ('286', 'BKK Adiwerna', '');
INSERT INTO `tref_bank` VALUES ('287', 'Tanjung Teros (Merger ke BPR NTB Lombok Timur Tgl31/8/2009)', '');
INSERT INTO `tref_bank` VALUES ('288', 'Kec. Sindangkerta (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', '');
INSERT INTO `tref_bank` VALUES ('289', 'BKK Selomerto', '');
INSERT INTO `tref_bank` VALUES ('290', 'Kec. Cikeruh', '');
INSERT INTO `tref_bank` VALUES ('291', 'Matesih BKK', '');
INSERT INTO `tref_bank` VALUES ('292', 'Kec. Cikalong Wetan (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', '');
INSERT INTO `tref_bank` VALUES ('293', 'Baturetno BKK', '');
INSERT INTO `tref_bank` VALUES ('294', 'Montong Betok (Merger ke BPR NTB Lombok Timur Tgl31/8/2009)', '');
INSERT INTO `tref_bank` VALUES ('295', 'Pameungpeuk  -  Banjaran (merger ke BPR Kabupaten Bandung Tgl 15/12/200', '');
INSERT INTO `tref_bank` VALUES ('296', 'Pameungpeuk- Garut', '');
INSERT INTO `tref_bank` VALUES ('297', 'BKPD Pagerageung', '');
INSERT INTO `tref_bank` VALUES ('298', 'BKK Karanglewas', '');
INSERT INTO `tref_bank` VALUES ('299', 'Mataram Sewon', '');
INSERT INTO `tref_bank` VALUES ('300', 'BKK Geyer', '');
INSERT INTO `tref_bank` VALUES ('301', 'Nusumma Pecangaan', '');
INSERT INTO `tref_bank` VALUES ('302', 'Pusakanagara', '');
INSERT INTO `tref_bank` VALUES ('303', 'BKK Somagede', '');
INSERT INTO `tref_bank` VALUES ('304', 'Karanggede BKK', '');
INSERT INTO `tref_bank` VALUES ('305', 'Kec. Kadugede', '');
INSERT INTO `tref_bank` VALUES ('306', 'Kutoarjo Arthalanggeng', '');
INSERT INTO `tref_bank` VALUES ('307', 'BKK Wonotunggal', '');
INSERT INTO `tref_bank` VALUES ('308', 'BKPD Karangnunggal', '');
INSERT INTO `tref_bank` VALUES ('309', 'BKK Mranggen', '');
INSERT INTO `tref_bank` VALUES ('310', 'BKK Gunung Wungkal', '');
INSERT INTO `tref_bank` VALUES ('311', 'BKK Mungkid', '');
INSERT INTO `tref_bank` VALUES ('312', 'LKP Sengkol (Merger ke BPR NTB Lombok Tengah tgl 31/08/2009)', '');
INSERT INTO `tref_bank` VALUES ('313', 'Kemangkon', '');
INSERT INTO `tref_bank` VALUES ('314', 'Mataram Ngaglik', '');
INSERT INTO `tref_bank` VALUES ('315', 'BKK Pejagoan', '');
INSERT INTO `tref_bank` VALUES ('316', 'LPK Talegong', '');
INSERT INTO `tref_bank` VALUES ('317', 'Kadungora', '');
INSERT INTO `tref_bank` VALUES ('318', 'Purwonegoro', '');
INSERT INTO `tref_bank` VALUES ('319', 'Wonosegoro BKK', '');
INSERT INTO `tref_bank` VALUES ('320', 'Lenangguar (Merger ke NTB Sumbawa Tgl 6 Nov 2009)', '');
INSERT INTO `tref_bank` VALUES ('321', 'BKPD Ligung', '');
INSERT INTO `tref_bank` VALUES ('322', 'Bank Haga (Merger ke Rabobank)', '');
INSERT INTO `tref_bank` VALUES ('323', 'Bank Hagakita', '');
INSERT INTO `tref_bank` VALUES ('324', 'Kec. Gununghalu', '');
INSERT INTO `tref_bank` VALUES ('325', 'Samadhana', '');
INSERT INTO `tref_bank` VALUES ('326', 'Bank Harmoni Internasional (merger ke Bank Index Selindo)', '');
INSERT INTO `tref_bank` VALUES ('327', 'Handayani Cipta Sehati', '');
INSERT INTO `tref_bank` VALUES ('328', 'Binacitra Rahayu', '');
INSERT INTO `tref_bank` VALUES ('329', 'Kec. Buahdua', '');
INSERT INTO `tref_bank` VALUES ('330', 'Slogohimo BKK', '');
INSERT INTO `tref_bank` VALUES ('331', 'Mranggen Mitraniaga', '');
INSERT INTO `tref_bank` VALUES ('332', 'Anugrah Arta Niaga', '');
INSERT INTO `tref_bank` VALUES ('333', 'Bank Pasar Indihiang', '');
INSERT INTO `tref_bank` VALUES ('334', 'BKPD Indihiang', '');
INSERT INTO `tref_bank` VALUES ('335', 'Swadharma Leuwiliang', '');
INSERT INTO `tref_bank` VALUES ('336', 'BKPD Ciawi', '');
INSERT INTO `tref_bank` VALUES ('337', 'BKK Bumiayu', '');
INSERT INTO `tref_bank` VALUES ('338', 'Kec. Ciwidey (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', '');
INSERT INTO `tref_bank` VALUES ('339', 'Bank IFI  (cabut ijin 17 April 2009)', '');
INSERT INTO `tref_bank` VALUES ('340', 'BKK Mijen', '');
INSERT INTO `tref_bank` VALUES ('341', 'LPK Kragilan', '');
INSERT INTO `tref_bank` VALUES ('342', 'BKPD Sodonghilir', '');
INSERT INTO `tref_bank` VALUES ('343', 'Kota Liman', '');
INSERT INTO `tref_bank` VALUES ('344', 'BKK Purwokerto Timur', '');
INSERT INTO `tref_bank` VALUES ('345', 'Artha Nusa Guna', '');
INSERT INTO `tref_bank` VALUES ('346', 'BKK Mirit', '');
INSERT INTO `tref_bank` VALUES ('347', 'Tayu Argatirta', '');
INSERT INTO `tref_bank` VALUES ('348', 'BKK Tirto', '');
INSERT INTO `tref_bank` VALUES ('349', 'Karangpawitan', '');
INSERT INTO `tref_bank` VALUES ('350', 'Rejeki Anugerah Mitra', '');
INSERT INTO `tref_bank` VALUES ('351', 'Darbeni Mitra', '');
INSERT INTO `tref_bank` VALUES ('352', 'LKP Soriutu', '');
INSERT INTO `tref_bank` VALUES ('353', 'BKK Purwojati', '');
INSERT INTO `tref_bank` VALUES ('354', 'BKK Kedungjati', '');
INSERT INTO `tref_bank` VALUES ('355', 'BKPD Kertajati', '');
INSERT INTO `tref_bank` VALUES ('356', 'Kalijati', '');
INSERT INTO `tref_bank` VALUES ('357', 'Singajaya', '');
INSERT INTO `tref_bank` VALUES ('358', 'Bank Pasar Manonjaya', '');
INSERT INTO `tref_bank` VALUES ('359', 'BKPD Manonjaya', '');
INSERT INTO `tref_bank` VALUES ('360', 'Tripillar Arthajaya', '');
INSERT INTO `tref_bank` VALUES ('361', 'BKPD Cikijing', '');
INSERT INTO `tref_bank` VALUES ('362', 'BKK Mejobo', '');
INSERT INTO `tref_bank` VALUES ('363', 'BKK Bojong - Tegal', '');
INSERT INTO `tref_bank` VALUES ('364', 'BKK Bojong - Pekalongan', '');
INSERT INTO `tref_bank` VALUES ('365', 'BKK Jumo', '');
INSERT INTO `tref_bank` VALUES ('366', 'Madukara', '');
INSERT INTO `tref_bank` VALUES ('367', 'Asparaga Abadi Perkasa', '');
INSERT INTO `tref_bank` VALUES ('368', 'BKK Kedu', '');
INSERT INTO `tref_bank` VALUES ('369', 'BKK Rowokele', '');
INSERT INTO `tref_bank` VALUES ('370', 'LKP Aikmel (Merger ke BPR NTB Lombok Timur Tgl31/8/2009)', '');
INSERT INTO `tref_bank` VALUES ('371', 'Kota Mojokerto', 'PT BPRS Kota Mojokerto');
INSERT INTO `tref_bank` VALUES ('372', 'LKP Dasan Lekong (Merger ke BPR NTB Lombok Timur Tgl31/8/2009)', '');
INSERT INTO `tref_bank` VALUES ('373', 'BKK Rembang Kota', '');
INSERT INTO `tref_bank` VALUES ('374', 'BKK Kudus Kota', '');
INSERT INTO `tref_bank` VALUES ('375', 'BKK Batang Kota', '');
INSERT INTO `tref_bank` VALUES ('376', 'BKK Sragen Kota', '');
INSERT INTO `tref_bank` VALUES ('377', 'BKK Kaliangkrik', '');
INSERT INTO `tref_bank` VALUES ('378', 'BKK Jekulo', '');
INSERT INTO `tref_bank` VALUES ('379', 'Kec. Cimalaka', '');
INSERT INTO `tref_bank` VALUES ('380', 'BKK Watumalang', '');
INSERT INTO `tref_bank` VALUES ('381', 'BKK Sulang', '');
INSERT INTO `tref_bank` VALUES ('382', 'BKK Bantarbolang', '');
INSERT INTO `tref_bank` VALUES ('383', 'Sukadana Cemerlang (Self Liquidation ref srt BI tg 31 Juli 2009)', '');
INSERT INTO `tref_bank` VALUES ('384', 'Bungbulang', '');
INSERT INTO `tref_bank` VALUES ('385', 'Swadharma Mlati', '');
INSERT INTO `tref_bank` VALUES ('386', 'BKPD Salawu', '');
INSERT INTO `tref_bank` VALUES ('387', 'Kec. Majalaya (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', '');
INSERT INTO `tref_bank` VALUES ('388', 'I. Tasikmalaya', '');
INSERT INTO `tref_bank` VALUES ('389', 'Kota Tasikmalaya', '');
INSERT INTO `tref_bank` VALUES ('390', 'BKK Jeruklegi', '');
INSERT INTO `tref_bank` VALUES ('391', 'Nusumma Gondanglegi (merger ke Nusumma Tebuireng Tgl. 20/1/2009)', '');
INSERT INTO `tref_bank` VALUES ('392', 'Klego BKK', '');
INSERT INTO `tref_bank` VALUES ('393', 'BKK Alian', '');
INSERT INTO `tref_bank` VALUES ('394', 'BKK Sukolilo', '');
INSERT INTO `tref_bank` VALUES ('395', 'Bank Lippo Tbk.', '');
INSERT INTO `tref_bank` VALUES ('396', 'Rancakalong', '');
INSERT INTO `tref_bank` VALUES ('397', 'BKK Gemolong', '');
INSERT INTO `tref_bank` VALUES ('398', 'BKPD Bantarkalong', '');
INSERT INTO `tref_bank` VALUES ('399', 'BKPD Cibalong', '');
INSERT INTO `tref_bank` VALUES ('400', 'BKPD Cikalong', '');
INSERT INTO `tref_bank` VALUES ('401', 'BKPD Salopa', '');
INSERT INTO `tref_bank` VALUES ('402', 'BKK Sluke', '');
INSERT INTO `tref_bank` VALUES ('403', 'Nusumma Balung (merger ke Nusumma Tebuireng Tgl 20/1/2009)', '');
INSERT INTO `tref_bank` VALUES ('404', 'Primabasak Utama', '');
INSERT INTO `tref_bank` VALUES ('405', 'Argawa Utama', '');
INSERT INTO `tref_bank` VALUES ('406', 'Colomadu BKK', '');
INSERT INTO `tref_bank` VALUES ('407', 'Kec. Cimahi', '');
INSERT INTO `tref_bank` VALUES ('408', 'Maos', '');
INSERT INTO `tref_bank` VALUES ('409', 'BKK Tambak', '');
INSERT INTO `tref_bank` VALUES ('410', 'BKK Ambal', '');
INSERT INTO `tref_bank` VALUES ('411', 'BKK Lumbir', '');
INSERT INTO `tref_bank` VALUES ('412', 'LKP Labuhan Lombok (Merger ke BPR NTB Lombok Timur Tgl31/8/2009)', '');
INSERT INTO `tref_bank` VALUES ('413', 'BKK Ngombol', '');
INSERT INTO `tref_bank` VALUES ('414', 'BKK Prembun', '');
INSERT INTO `tref_bank` VALUES ('415', 'Prima Artha Sentana', '');
INSERT INTO `tref_bank` VALUES ('416', 'Mustaqim Seulimeum', '');
INSERT INTO `tref_bank` VALUES ('417', 'BKK Kemiri', '');
INSERT INTO `tref_bank` VALUES ('418', 'BKK Miri', '');
INSERT INTO `tref_bank` VALUES ('419', 'BKK Moga', '');
INSERT INTO `tref_bank` VALUES ('420', 'LKP Moyo (Merger ke NTB Sumbawa Tgl 6 Nov 2009)', '');
INSERT INTO `tref_bank` VALUES ('421', 'Tirtomoyo BKK', '');
INSERT INTO `tref_bank` VALUES ('422', 'Ampel BKK', '');
INSERT INTO `tref_bank` VALUES ('423', 'Purworejo Klampok', '');
INSERT INTO `tref_bank` VALUES ('424', 'BKK Sempor', '');
INSERT INTO `tref_bank` VALUES ('425', 'BKK Watukumpul', '');
INSERT INTO `tref_bank` VALUES ('426', 'Kemusu BKK', '');
INSERT INTO `tref_bank` VALUES ('427', 'BKK Majenang', '');
INSERT INTO `tref_bank` VALUES ('428', 'Angkinang', '');
INSERT INTO `tref_bank` VALUES ('429', 'LPK Carenang', '');
INSERT INTO `tref_bank` VALUES ('430', 'LKP Naru', '');
INSERT INTO `tref_bank` VALUES ('431', 'Jenawi BKK', '');
INSERT INTO `tref_bank` VALUES ('432', 'Mandirancan', '');
INSERT INTO `tref_bank` VALUES ('433', 'BKK Pekuncen', '');
INSERT INTO `tref_bank` VALUES ('434', 'BKK Pancur', '');
INSERT INTO `tref_bank` VALUES ('435', 'Japanan Indah', '');
INSERT INTO `tref_bank` VALUES ('436', 'Karangpandan BKK', '');
INSERT INTO `tref_bank` VALUES ('437', 'BKK Pegandon', '');
INSERT INTO `tref_bank` VALUES ('438', 'BKPD Cineam', '');
INSERT INTO `tref_bank` VALUES ('439', 'BKK Karangtengah', '');
INSERT INTO `tref_bank` VALUES ('440', 'Cimahi Tengah', '');
INSERT INTO `tref_bank` VALUES ('441', 'LKP Kayangan', '');
INSERT INTO `tref_bank` VALUES ('442', 'Kec. Pangalengan (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', '');
INSERT INTO `tref_bank` VALUES ('443', 'Gunung Rogojembangan', '');
INSERT INTO `tref_bank` VALUES ('444', 'BKK Sawangan', '');
INSERT INTO `tref_bank` VALUES ('445', 'BKK Plantungan', '');
INSERT INTO `tref_bank` VALUES ('446', 'BKK Penawangan', '');
INSERT INTO `tref_bank` VALUES ('447', 'BKK Batangan', '');
INSERT INTO `tref_bank` VALUES ('448', 'BKK Ngaringan', '');
INSERT INTO `tref_bank` VALUES ('449', 'BKK Limbangan', '');
INSERT INTO `tref_bank` VALUES ('450', 'BKK Kandangan', '');
INSERT INTO `tref_bank` VALUES ('451', 'Mustaqim Tangan-Tangan', '');
INSERT INTO `tref_bank` VALUES ('452', 'Balubur Limbangan', '');
INSERT INTO `tref_bank` VALUES ('453', 'Mapalus Kamangen (Merger Ke Mapalus Tumetenden Tgl 15/4/2009)', '');
INSERT INTO `tref_bank` VALUES ('454', 'BKK Tangen', '');
INSERT INTO `tref_bank` VALUES ('455', 'BKK Wonopringgo', '');
INSERT INTO `tref_bank` VALUES ('456', 'Cimanggu BKK', '');
INSERT INTO `tref_bank` VALUES ('457', 'LPK Cinangka', '');
INSERT INTO `tref_bank` VALUES ('458', 'kec. Cicalengka (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', '');
INSERT INTO `tref_bank` VALUES ('459', 'BKK Cilongok', '');
INSERT INTO `tref_bank` VALUES ('460', 'BKK Wangon', '');
INSERT INTO `tref_bank` VALUES ('461', 'BKK Binangun', '');
INSERT INTO `tref_bank` VALUES ('462', 'BKK Kutowinangun', '');
INSERT INTO `tref_bank` VALUES ('463', 'Kalibening', '');
INSERT INTO `tref_bank` VALUES ('464', 'Bank OCBC NISP Tbk.', '');
INSERT INTO `tref_bank` VALUES ('465', 'BKK Kemranjen', '');
INSERT INTO `tref_bank` VALUES ('466', 'BKK Winong', '');
INSERT INTO `tref_bank` VALUES ('467', 'Binong', '');
INSERT INTO `tref_bank` VALUES ('468', 'Pagentan', '');
INSERT INTO `tref_bank` VALUES ('469', 'Giritontro', '');
INSERT INTO `tref_bank` VALUES ('470', 'Karanganyar - Purbalingga', '');
INSERT INTO `tref_bank` VALUES ('471', 'BKK Karanganyar - Kebumen', '');
INSERT INTO `tref_bank` VALUES ('472', 'LPK Anyar', '');
INSERT INTO `tref_bank` VALUES ('473', 'BKK Loano', '');
INSERT INTO `tref_bank` VALUES ('474', 'Karangkobar BKK', '');
INSERT INTO `tref_bank` VALUES ('475', 'Bank OCBC Indonesia', '');
INSERT INTO `tref_bank` VALUES ('476', 'BKK Grobogan', '');
INSERT INTO `tref_bank` VALUES ('477', 'Bank Pasar Rajapolah', '');
INSERT INTO `tref_bank` VALUES ('478', 'BKPD Rajapolah', '');
INSERT INTO `tref_bank` VALUES ('479', 'BKPD Cikatomas', '');
INSERT INTO `tref_bank` VALUES ('480', 'Mustaqim Lhoong', '');
INSERT INTO `tref_bank` VALUES ('481', 'Lopok (Merger ke NTB Sumbawa Tgl 6 Nov 2009)', '');
INSERT INTO `tref_bank` VALUES ('482', 'BKK Toroh', '');
INSERT INTO `tref_bank` VALUES ('483', 'Mapalus Lo\'Orta (Merger Ke Mapalus Tumetenden Tgl 15/4/2009)', '');
INSERT INTO `tref_bank` VALUES ('484', 'BKK Pamotan', '');
INSERT INTO `tref_bank` VALUES ('485', 'BKK Adipala', '');
INSERT INTO `tref_bank` VALUES ('486', 'LKP Plampang (Merger ke NTB Sumbawa Tgl 6 Nov 2009)', '');
INSERT INTO `tref_bank` VALUES ('487', 'Salido Empati', '');
INSERT INTO `tref_bank` VALUES ('488', 'Mataram Gamping', '');
INSERT INTO `tref_bank` VALUES ('489', 'BKK Sumpiuh', '');
INSERT INTO `tref_bank` VALUES ('490', 'Ngemplak', '');
INSERT INTO `tref_bank` VALUES ('491', 'Cepogo BKK', '');
INSERT INTO `tref_bank` VALUES ('492', 'Jumapolo BKK', '');
INSERT INTO `tref_bank` VALUES ('493', 'BKK Sirampog', '');
INSERT INTO `tref_bank` VALUES ('494', 'LKP Janapria (Merger ke BPR NTB Lombok Tengah tgl 31/08/2009)', '');
INSERT INTO `tref_bank` VALUES ('495', 'LKP Perampuan', '');
INSERT INTO `tref_bank` VALUES ('496', 'BKK Limpung', '');
INSERT INTO `tref_bank` VALUES ('497', 'Putra Riau Mandiri', 'PT BPR Putra Riau Mandiri');
INSERT INTO `tref_bank` VALUES ('498', 'LKP Sarae', '');
INSERT INTO `tref_bank` VALUES ('499', 'Jagaraga', '');
INSERT INTO `tref_bank` VALUES ('500', 'BKK Sragi', '');
INSERT INTO `tref_bank` VALUES ('501', 'LKP Kotaraja (Merger ke BPR NTB Lombok Timur Tgl31/8/2009)', '');
INSERT INTO `tref_bank` VALUES ('502', 'BKK Sokaraja', '');
INSERT INTO `tref_bank` VALUES ('503', 'BKPD Sukaraja', '');
INSERT INTO `tref_bank` VALUES ('504', 'Darmaraja', '');
INSERT INTO `tref_bank` VALUES ('505', 'BKPD Taraju', '');
INSERT INTO `tref_bank` VALUES ('506', 'Kec. Padalarang (merger ke BPR Kabupaten Bandung Tgl 15/12/2009)', '');
INSERT INTO `tref_bank` VALUES ('507', 'Kec. Sagalaherang', '');
INSERT INTO `tref_bank` VALUES ('508', 'BKK Ajibarang', '');
INSERT INTO `tref_bank` VALUES ('509', 'BKK Kalorang', '');
INSERT INTO `tref_bank` VALUES ('510', 'LPK Samarang', '');
INSERT INTO `tref_bank` VALUES ('511', 'BKK Sarang', '');
INSERT INTO `tref_bank` VALUES ('512', 'BKK Lebakbarang', '');
INSERT INTO `tref_bank` VALUES ('513', 'LKP Pringgarata (Merger ke BPR NTB Lombok Tengah tgl 31/08/2009)', '');
INSERT INTO `tref_bank` VALUES ('514', 'BKK Brati', '');
INSERT INTO `tref_bank` VALUES ('515', 'LKP Rato Bolo', '');
INSERT INTO `tref_bank` VALUES ('516', 'Swadharma Ambarawa', '');
INSERT INTO `tref_bank` VALUES ('517', 'Mustaqim Meuraxa (korban tsunami)', '');
INSERT INTO `tref_bank` VALUES ('518', 'LKP Praya (Merger ke BPR NTB Lombok Tengah tgl 31/08/2009)', '');
INSERT INTO `tref_bank` VALUES ('519', 'BKK Kutoarjo', '');
INSERT INTO `tref_bank` VALUES ('520', 'Karangreja', '');
INSERT INTO `tref_bank` VALUES ('521', 'Wanareja', '');
INSERT INTO `tref_bank` VALUES ('522', 'Kedungreja', '');
INSERT INTO `tref_bank` VALUES ('523', 'Sidareja', '');
INSERT INTO `tref_bank` VALUES ('524', 'BKK Tegalrejo', '');
INSERT INTO `tref_bank` VALUES ('525', 'BKK Margorejo', '');
INSERT INTO `tref_bank` VALUES ('526', 'BKK Sukorejo', '');
INSERT INTO `tref_bank` VALUES ('527', 'BKK Ngadirejo - Temanggung', '');
INSERT INTO `tref_bank` VALUES ('528', 'BKK Sambirejo', '');
INSERT INTO `tref_bank` VALUES ('529', 'BKPD Cibeureum', '');
INSERT INTO `tref_bank` VALUES ('530', 'BKK Puring', '');
INSERT INTO `tref_bank` VALUES ('531', 'BKK Cepiring', '');
INSERT INTO `tref_bank` VALUES ('532', 'Mejayan Permai', '');
INSERT INTO `tref_bank` VALUES ('533', 'BKK Singorojo', '');
INSERT INTO `tref_bank` VALUES ('534', 'Ngadirojo (BKK) - Wonogiri', '');
INSERT INTO `tref_bank` VALUES ('535', 'BKK Tambakromo', '');
INSERT INTO `tref_bank` VALUES ('536', 'BKK Klirong', '');
INSERT INTO `tref_bank` VALUES ('537', 'BKK Candiroto', '');
INSERT INTO `tref_bank` VALUES ('538', 'Jatiroto BKK', '');
INSERT INTO `tref_bank` VALUES ('539', 'Kroya - Cilacap', '');
INSERT INTO `tref_bank` VALUES ('540', 'Manca Danarta', '');
INSERT INTO `tref_bank` VALUES ('541', 'Kawicentra Artha', '');
INSERT INTO `tref_bank` VALUES ('542', 'Adicentra Artha', '');
INSERT INTO `tref_bank` VALUES ('543', 'Wahyucakra Artha', '');
INSERT INTO `tref_bank` VALUES ('544', 'Swasad Artha', '');
INSERT INTO `tref_bank` VALUES ('545', 'Bekasi Istana Arta', '');
INSERT INTO `tref_bank` VALUES ('546', 'Ronatama Mandiri', 'PT BPR Ronatama Mandiri');
INSERT INTO `tref_bank` VALUES ('547', 'LKP Gerung', '');
INSERT INTO `tref_bank` VALUES ('548', 'BKK Garung', '');
INSERT INTO `tref_bank` VALUES ('549', 'BKK Bruno', '');
INSERT INTO `tref_bank` VALUES ('550', 'Bank Mandiri PT. Tbk.', 'PT Bank Mandiri');
INSERT INTO `tref_bank` VALUES ('5500', 'Naratama Bersada', '');
INSERT INTO `tref_bank` VALUES ('551', 'Kadiri Kartapersada', '');
INSERT INTO `tref_bank` VALUES ('552', 'Asparaga Mitra Usaha', '');
INSERT INTO `tref_bank` VALUES ('553', 'Prismadana Wirausaha', '');
INSERT INTO `tref_bank` VALUES ('554', 'BKK Sale', '');
INSERT INTO `tref_bank` VALUES ('555', 'LKP Gunung Sari', '');
INSERT INTO `tref_bank` VALUES ('556', 'Kec. Tanjungsari', '');
INSERT INTO `tref_bank` VALUES ('557', 'Bobotsari', '');
INSERT INTO `tref_bank` VALUES ('558', 'BKK Kutasari', '');
INSERT INTO `tref_bank` VALUES ('559', 'BKK Windusari', '');
INSERT INTO `tref_bank` VALUES ('560', 'BKK Wirosari', '');
INSERT INTO `tref_bank` VALUES ('561', 'Nogosari BKK', '');
INSERT INTO `tref_bank` VALUES ('562', 'BKPD Leuwisari', '');
INSERT INTO `tref_bank` VALUES ('563', 'Selo BKK', '');
INSERT INTO `tref_bank` VALUES ('564', 'BKK Kesesi', '');
INSERT INTO `tref_bank` VALUES ('565', 'BKK Dukuhseti', '');
INSERT INTO `tref_bank` VALUES ('566', 'Cisewu', '');
INSERT INTO `tref_bank` VALUES ('567', 'Pancasila', '');
INSERT INTO `tref_bank` VALUES ('568', 'Simo', '');
INSERT INTO `tref_bank` VALUES ('569', 'BKK Gringsing', '');
INSERT INTO `tref_bank` VALUES ('570', 'BKK Kaligesing', '');
INSERT INTO `tref_bank` VALUES ('571', 'BKK Brangsong', '');
INSERT INTO `tref_bank` VALUES ('572', 'BKK Leksono', '');
INSERT INTO `tref_bank` VALUES ('573', 'Artha Sembada', '');
INSERT INTO `tref_bank` VALUES ('574', 'Tegowanu Dieng Pratama', '');
INSERT INTO `tref_bank` VALUES ('575', 'Godong Merapi Pratama', '');
INSERT INTO `tref_bank` VALUES ('576', 'Dana Mitra Sejati  (Merger ke Dana Mitra Sentosa Tgl 28/4/2009)', '');
INSERT INTO `tref_bank` VALUES ('577', 'Juwangi Gajahmungkur Pratama', '');
INSERT INTO `tref_bank` VALUES ('578', 'Candimas Adipratama', '');
INSERT INTO `tref_bank` VALUES ('579', 'Sri Utama', '');
INSERT INTO `tref_bank` VALUES ('580', 'Margot Artha Utama', '');
INSERT INTO `tref_bank` VALUES ('581', 'LKP Mantang (Merger ke BPR NTB Lombok Tengah tgl 31/08/2009)', '');
INSERT INTO `tref_bank` VALUES ('582', 'BKK Wadaslintang', '');
INSERT INTO `tref_bank` VALUES ('583', 'BKPD Cigalontang', '');
INSERT INTO `tref_bank` VALUES ('584', 'LPK Pontang', '');
INSERT INTO `tref_bank` VALUES ('585', 'BKK Cilacap Utara', '');
INSERT INTO `tref_bank` VALUES ('586', 'Mustaqim Kluet Utara', '');
INSERT INTO `tref_bank` VALUES ('587', 'Asparaga Sejahtera Lestari', '');
INSERT INTO `tref_bank` VALUES ('588', 'BKK Patean', '');
INSERT INTO `tref_bank` VALUES ('589', 'Bukateja', '');
INSERT INTO `tref_bank` VALUES ('590', 'Seketeng (Merger ke NTB Sumbawa Tgl 6 Nov 2009)', '');
INSERT INTO `tref_bank` VALUES ('591', 'BKK Kedungbanteng', '');
INSERT INTO `tref_bank` VALUES ('592', 'Bangunkarsa Arthasejahtera', '');
INSERT INTO `tref_bank` VALUES ('593', 'Handayani Cipta Sejahtera', '');
INSERT INTO `tref_bank` VALUES ('594', 'Tomo', '');
INSERT INTO `tref_bank` VALUES ('595', 'LKP Paok Motong (Merger ke BPR NTB Lombok Timur Tgl31/8/2009)', '');
INSERT INTO `tref_bank` VALUES ('596', 'Jumantono BKK', '');
INSERT INTO `tref_bank` VALUES ('597', 'Purwantoro BKK', '');
INSERT INTO `tref_bank` VALUES ('598', 'Cakraputra Sentosa', '');
INSERT INTO `tref_bank` VALUES ('599', 'Harta Sentosa (Self liquidation surat BI 7 Nov 2008)', '');
INSERT INTO `tref_bank` VALUES ('600', 'Tumou Tou', '');
INSERT INTO `tref_bank` VALUES ('601', 'Swadharma Cibitung', '');
INSERT INTO `tref_bank` VALUES ('602', 'BKK Dukuh Turi', '');
INSERT INTO `tref_bank` VALUES ('603', 'Mustaqim Kuala', '');
INSERT INTO `tref_bank` VALUES ('604', 'BKK Gubug', '');
INSERT INTO `tref_bank` VALUES ('605', 'BKK Borobudur', '');
INSERT INTO `tref_bank` VALUES ('606', 'Bank UFJ Indonesia (cabut izin 5/10/06)', '');
INSERT INTO `tref_bank` VALUES ('607', 'Dayeuhluhur', '');
INSERT INTO `tref_bank` VALUES ('608', 'LKP Penujak (Merger ke BPR NTB Lombok Tengah tgl 31/08/2009)', '');
INSERT INTO `tref_bank` VALUES ('609', 'BKPD Bantarujeg', '');
INSERT INTO `tref_bank` VALUES ('610', 'BKPD Jatitujuh', '');
INSERT INTO `tref_bank` VALUES ('611', 'LKP Mujur (Merger ke BPR NTB Lombok Tengah tgl 31/08/2009)', '');
INSERT INTO `tref_bank` VALUES ('612', 'Susukan - Banjarnegara', '');
INSERT INTO `tref_bank` VALUES ('613', 'BKK Petarukan', '');
INSERT INTO `tref_bank` VALUES ('614', 'Pamanukan Kec', '');
INSERT INTO `tref_bank` VALUES ('615', 'BKK Dukun', '');
INSERT INTO `tref_bank` VALUES ('616', 'BKK Tulis', '');
INSERT INTO `tref_bank` VALUES ('617', 'BKK Pulokulon', '');
INSERT INTO `tref_bank` VALUES ('618', 'BKK Candimulyo', '');
INSERT INTO `tref_bank` VALUES ('619', 'BKK Adimulyo', '');
INSERT INTO `tref_bank` VALUES ('620', 'BKK Banyumas', '');
INSERT INTO `tref_bank` VALUES ('621', 'Utomo Manunggal Sejahtera Sumsel', 'PT BPR Utomo Manunggal Sejahtera Sumsel');
INSERT INTO `tref_bank` VALUES ('622', 'BKK Gunem', '');
INSERT INTO `tref_bank` VALUES ('623', 'Mapalus Wangunen (Merger Ke Mapalus Tumetenden Tgl 15/4/2009)', '');
INSERT INTO `tref_bank` VALUES ('624', 'Nusawungu', '');
INSERT INTO `tref_bank` VALUES ('625', 'BKK Kaliwungu - Kendal', '');
INSERT INTO `tref_bank` VALUES ('626', 'BKK Kaliwungu - Kudus', '');
INSERT INTO `tref_bank` VALUES ('627', 'BKK Tlogowungu', '');
INSERT INTO `tref_bank` VALUES ('628', 'Arthaguna Sembada', '');
INSERT INTO `tref_bank` VALUES ('629', 'Bank UOB Indonesia', '');
INSERT INTO `tref_bank` VALUES ('630', 'Kec. Cisurupan', '');
INSERT INTO `tref_bank` VALUES ('631', 'BKK Plupuh', '');
INSERT INTO `tref_bank` VALUES ('632', 'BKK Sapuran', '');
INSERT INTO `tref_bank` VALUES ('633', 'Cipta Artha Nusa', '');
INSERT INTO `tref_bank` VALUES ('634', 'BKK Banyuurip', '');
INSERT INTO `tref_bank` VALUES ('635', 'Jatipurno BKK', '');
INSERT INTO `tref_bank` VALUES ('636', 'BKK Pituruh', '');
INSERT INTO `tref_bank` VALUES ('637', 'Musuk', '');
INSERT INTO `tref_bank` VALUES ('638', 'LKP Motong Utan (Merger ke NTB Sumbawa Tgl 6 Nov 2009)', '');
INSERT INTO `tref_bank` VALUES ('639', 'BKK Cluwak', '');
INSERT INTO `tref_bank` VALUES ('640', 'BKK Ngluwar', '');
INSERT INTO `tref_bank` VALUES ('641', 'Ciawi BPR', '');
INSERT INTO `tref_bank` VALUES ('642', 'kec. Wado', '');
INSERT INTO `tref_bank` VALUES ('643', 'BKK Rawalo', '');
INSERT INTO `tref_bank` VALUES ('644', 'Kawalu', '');
INSERT INTO `tref_bank` VALUES ('645', 'BKK TPI Juwana', '');
INSERT INTO `tref_bank` VALUES ('646', 'BKK Juwana', '');
INSERT INTO `tref_bank` VALUES ('647', 'BKK Jatilawang', '');
INSERT INTO `tref_bank` VALUES ('648', 'BKK Bawang', '');
INSERT INTO `tref_bank` VALUES ('649', 'BKK Tegowanu', '');
INSERT INTO `tref_bank` VALUES ('650', 'BKK Kaliwiro', '');
INSERT INTO `tref_bank` VALUES ('651', 'Giriwoyo BKK', '');
INSERT INTO `tref_bank` VALUES ('652', 'BKK Kedawung', '');
INSERT INTO `tref_bank` VALUES ('653', 'BKK Kedungwuni', '');
INSERT INTO `tref_bank` VALUES ('654', 'Mustaqim Kaway XVI', '');
INSERT INTO `tref_bank` VALUES ('655', 'Wanayasa', '');
INSERT INTO `tref_bank` VALUES ('656', 'BKPD Cisayong', '');
INSERT INTO `tref_bank` VALUES ('657', 'BKK Margoyoso', '');
INSERT INTO `tref_bank` VALUES ('658', 'Ngargoyoso', '');
INSERT INTO `tref_bank` VALUES ('659', 'Jatiyoso BKK', '');
INSERT INTO `tref_bank` VALUES ('660', 'LKP Puyung (Merger ke BPR NTB Lombok Tengah tgl 31/08/2009)', '');
INSERT INTO `tref_bank` VALUES ('661', 'BKK Pageruyung', '');
INSERT INTO `tref_bank` VALUES ('662', 'BKK Karang Rayung', '');
INSERT INTO `tref_bank` VALUES ('663', 'BKK Sayung', '');
INSERT INTO `tref_bank` VALUES ('664', 'Era Aneka Rezeki', '');
INSERT INTO `tref_bank` VALUES ('665', 'Bank Sami\'un', 'Bank Thoyib');

-- ----------------------------
-- Table structure for `tref_bank_cabang`
-- ----------------------------
DROP TABLE IF EXISTS `tref_bank_cabang`;
CREATE TABLE `tref_bank_cabang` (
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
  KEY `cabangID` (`cabangID`),
  CONSTRAINT `tref_bank_cabang_ibfk_1` FOREIGN KEY (`bankID`) REFERENCES `tref_bank` (`bankID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tref_bank_cabang
-- ----------------------------
INSERT INTO `tref_bank_cabang` VALUES ('10002', '1', 'BNI KCK BDG', 'Kopooooo', '32', '1', '40225', 'dfd', '1234132', '2113', 'ddd', 'nope');
INSERT INTO `tref_bank_cabang` VALUES ('10002', '2', 'Mandiri KCP BDG', 'Asia Afrika', '32', '18', '123123', 'hjh', '123142', '2432', 'qwert@qwertz.com', '243refefgege');
INSERT INTO `tref_bank_cabang` VALUES ('10003', '3', 'BRI KCP BDG', 'Asia Afrika', '32', '18', '798788', 'dss', '876876', '22423422', '', 'asdasd');
INSERT INTO `tref_bank_cabang` VALUES ('550', '4', 'Persada Mandiri', 'Jalan Vetera', '32', '18', '123456', 'aksjd', '231321', '32a1sd3', 'asdjlkJ@laksjd.cocom', '321');
INSERT INTO `tref_bank_cabang` VALUES ('10011', '8', '123', '123', '31', '154', '123', '123', '123', '123', '123', null);
INSERT INTO `tref_bank_cabang` VALUES ('10018', '9', 'asdasd', 'qweqwe', '34', '223', '123', '123', '123', '123', '123', null);

-- ----------------------------
-- Table structure for `tref_city`
-- ----------------------------
DROP TABLE IF EXISTS `tref_city`;
CREATE TABLE `tref_city` (
  `kotaID` int(10) NOT NULL AUTO_INCREMENT,
  `propinsiID` varchar(4) NOT NULL DEFAULT '',
  `kotaNama` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`kotaID`,`propinsiID`)
) ENGINE=InnoDB AUTO_INCREMENT=502 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tref_city
-- ----------------------------
INSERT INTO `tref_city` VALUES ('1', '11', 'Kabupaten Aceh Barat');
INSERT INTO `tref_city` VALUES ('2', '11', 'Kabupaten Aceh Timur');
INSERT INTO `tref_city` VALUES ('3', '11', 'Kabupaten Aceh Utara');
INSERT INTO `tref_city` VALUES ('4', '11', 'Kabupaten Bener Meriah');
INSERT INTO `tref_city` VALUES ('5', '11', 'Kabupaten Bireuen');
INSERT INTO `tref_city` VALUES ('6', '11', 'Kabupaten Gayo Lues');
INSERT INTO `tref_city` VALUES ('7', '11', 'Kabupaten Nagan Raya');
INSERT INTO `tref_city` VALUES ('8', '11', 'Kabupaten Pidie');
INSERT INTO `tref_city` VALUES ('9', '11', 'Kabupaten Pidie Jaya');
INSERT INTO `tref_city` VALUES ('10', '11', 'Kabupaten Simeulue');
INSERT INTO `tref_city` VALUES ('11', '11', 'Kota Banda Aceh');
INSERT INTO `tref_city` VALUES ('12', '11', 'Kabupaten Aceh Barat Daya');
INSERT INTO `tref_city` VALUES ('13', '11', 'Kota Langsa');
INSERT INTO `tref_city` VALUES ('14', '11', 'Kota Lhokseumawe');
INSERT INTO `tref_city` VALUES ('15', '11', 'Kota Sabang');
INSERT INTO `tref_city` VALUES ('16', '11', 'Kota Subulussalam');
INSERT INTO `tref_city` VALUES ('17', '11', 'Kabupaten Aceh Barat');
INSERT INTO `tref_city` VALUES ('18', '11', 'Kabupaten Aceh Barat');
INSERT INTO `tref_city` VALUES ('19', '11', 'Kabupaten Aceh Besar');
INSERT INTO `tref_city` VALUES ('20', '11', 'Kabupaten Aceh Jaya');
INSERT INTO `tref_city` VALUES ('21', '11', 'Kabupaten Aceh Selatan');
INSERT INTO `tref_city` VALUES ('22', '11', 'Kabupaten Aceh Singkil');
INSERT INTO `tref_city` VALUES ('23', '11', 'Kabupaten Aceh Tamiang');
INSERT INTO `tref_city` VALUES ('24', '11', 'Kabupaten Aceh Tengah');
INSERT INTO `tref_city` VALUES ('25', '11', 'Kabupaten Aceh Tenggara');
INSERT INTO `tref_city` VALUES ('26', '12', 'Kabupaten Asahan');
INSERT INTO `tref_city` VALUES ('27', '12', 'Kabupaten Langkat');
INSERT INTO `tref_city` VALUES ('28', '12', 'Kabupaten Mandailing Natal');
INSERT INTO `tref_city` VALUES ('29', '12', 'Kabupaten Nias');
INSERT INTO `tref_city` VALUES ('30', '12', 'Kabupaten Nias Barat');
INSERT INTO `tref_city` VALUES ('31', '12', 'Kabupaten Nias Selatan');
INSERT INTO `tref_city` VALUES ('32', '12', 'Kabupaten Nias Utara');
INSERT INTO `tref_city` VALUES ('33', '12', 'Kabupaten Padang Lawas');
INSERT INTO `tref_city` VALUES ('34', '12', 'Kabupaten Padang Lawas Utara');
INSERT INTO `tref_city` VALUES ('35', '12', 'Kabupaten Pakpak Bharat');
INSERT INTO `tref_city` VALUES ('36', '12', 'Kabupaten Samosir');
INSERT INTO `tref_city` VALUES ('37', '12', 'Kabupaten Batubara');
INSERT INTO `tref_city` VALUES ('38', '12', 'Kabupaten Serdang Bedagai');
INSERT INTO `tref_city` VALUES ('39', '12', 'Kabupaten Simalungun');
INSERT INTO `tref_city` VALUES ('40', '12', 'Kabupaten Tapanuli Selatan');
INSERT INTO `tref_city` VALUES ('41', '12', 'Kabupaten Tapanuli Tengah');
INSERT INTO `tref_city` VALUES ('42', '12', 'Kabupaten Tapanuli Utara');
INSERT INTO `tref_city` VALUES ('43', '12', 'Kabupaten Toba Samosir');
INSERT INTO `tref_city` VALUES ('44', '12', 'Kota Binjai');
INSERT INTO `tref_city` VALUES ('45', '12', 'Kota Gunungsitoli');
INSERT INTO `tref_city` VALUES ('46', '12', 'Kota Medan');
INSERT INTO `tref_city` VALUES ('47', '12', 'Kota Padangsidempuan');
INSERT INTO `tref_city` VALUES ('48', '12', 'Kabupaten Dairi');
INSERT INTO `tref_city` VALUES ('49', '12', 'Kota Pematangsiantar');
INSERT INTO `tref_city` VALUES ('50', '12', 'Kota Sibolga');
INSERT INTO `tref_city` VALUES ('51', '12', 'Kota Tanjungbalai');
INSERT INTO `tref_city` VALUES ('52', '12', 'Kota Tebing Tinggi');
INSERT INTO `tref_city` VALUES ('53', '12', 'Kabupaten Deli Serdang');
INSERT INTO `tref_city` VALUES ('54', '12', 'Kabupaten Humbang Hasundutan');
INSERT INTO `tref_city` VALUES ('55', '12', 'Kabupaten Karo');
INSERT INTO `tref_city` VALUES ('56', '12', 'Kabupaten Labuhanbatu');
INSERT INTO `tref_city` VALUES ('57', '12', 'Kabupaten Labuhanbatu Selatan');
INSERT INTO `tref_city` VALUES ('58', '12', 'Kabupaten Labuhanbatu Utara');
INSERT INTO `tref_city` VALUES ('59', '13', 'Kabupaten Agam');
INSERT INTO `tref_city` VALUES ('60', '13', 'Kabupaten Solok');
INSERT INTO `tref_city` VALUES ('61', '13', 'Kabupaten Solok Selatan');
INSERT INTO `tref_city` VALUES ('62', '13', 'Kabupaten Tanah Datar');
INSERT INTO `tref_city` VALUES ('63', '13', 'Kota Bukittinggi');
INSERT INTO `tref_city` VALUES ('64', '13', 'Kota Padang');
INSERT INTO `tref_city` VALUES ('65', '13', 'Kota Padangpanjang');
INSERT INTO `tref_city` VALUES ('66', '13', 'Kota Pariaman');
INSERT INTO `tref_city` VALUES ('67', '13', 'Kota Payakumbuh');
INSERT INTO `tref_city` VALUES ('68', '13', 'Kota Sawahlunto');
INSERT INTO `tref_city` VALUES ('69', '13', 'Kota Solok');
INSERT INTO `tref_city` VALUES ('70', '13', 'Kabupaten Dharmasraya');
INSERT INTO `tref_city` VALUES ('71', '13', 'Kabupaten Kepulauan Mentawa');
INSERT INTO `tref_city` VALUES ('72', '13', 'Kabupaten Lima Puluh Kota');
INSERT INTO `tref_city` VALUES ('73', '13', 'Kabupaten Padang Pariaman');
INSERT INTO `tref_city` VALUES ('74', '13', 'Kabupaten Pasaman');
INSERT INTO `tref_city` VALUES ('75', '13', 'Kabupaten Pasaman Barat');
INSERT INTO `tref_city` VALUES ('76', '13', 'Kabupaten Pesisir Selatan');
INSERT INTO `tref_city` VALUES ('77', '13', 'Kabupaten Sijunjung');
INSERT INTO `tref_city` VALUES ('78', '14', 'Kabupaten Bengkalis');
INSERT INTO `tref_city` VALUES ('79', '14', 'Kabupaten Kepulauan Meranti');
INSERT INTO `tref_city` VALUES ('80', '14', 'Kota Dumai');
INSERT INTO `tref_city` VALUES ('81', '14', 'Kota Pekanbaru');
INSERT INTO `tref_city` VALUES ('82', '14', 'Kabupaten Indragiri Hilir');
INSERT INTO `tref_city` VALUES ('83', '14', 'Kabupaten Indragiri Hulu');
INSERT INTO `tref_city` VALUES ('84', '14', 'Kabupaten Kampar');
INSERT INTO `tref_city` VALUES ('85', '14', 'Kabupaten Kuantan Singingi');
INSERT INTO `tref_city` VALUES ('86', '14', 'Kabupaten Pelalawan');
INSERT INTO `tref_city` VALUES ('87', '14', 'Kabupaten Rokan Hilir');
INSERT INTO `tref_city` VALUES ('88', '14', 'Kabupaten Rokan Hulu');
INSERT INTO `tref_city` VALUES ('89', '14', 'Kabupaten Siak');
INSERT INTO `tref_city` VALUES ('90', '15', 'Kabupaten Batanghari');
INSERT INTO `tref_city` VALUES ('91', '15', 'Kota Jambi');
INSERT INTO `tref_city` VALUES ('92', '15', 'Kota Sungai Penuh');
INSERT INTO `tref_city` VALUES ('93', '15', 'Kabupaten Bungo');
INSERT INTO `tref_city` VALUES ('94', '15', 'Kabupaten Kerinci');
INSERT INTO `tref_city` VALUES ('95', '15', 'Kabupaten Merangin');
INSERT INTO `tref_city` VALUES ('96', '15', 'Kabupaten Muaro Jambi');
INSERT INTO `tref_city` VALUES ('97', '15', 'Kabupaten Sarolangun');
INSERT INTO `tref_city` VALUES ('98', '15', 'Kabupaten Tanjung Jabung Barat ');
INSERT INTO `tref_city` VALUES ('99', '15', 'Kabupaten Tanjung Jabung Timur ');
INSERT INTO `tref_city` VALUES ('100', '15', 'Kabupaten Tebo');
INSERT INTO `tref_city` VALUES ('101', '16', 'Kabupaten Banyuasin');
INSERT INTO `tref_city` VALUES ('102', '16', 'Kabupaten Ogan Komering Ulu Selatan');
INSERT INTO `tref_city` VALUES ('103', '16', 'Kabupaten Ogan Komering Ulu Timur');
INSERT INTO `tref_city` VALUES ('104', '16', 'Kota Lubuklinggau');
INSERT INTO `tref_city` VALUES ('105', '16', 'Kota Pagar Alam');
INSERT INTO `tref_city` VALUES ('106', '16', 'Kota Palembang');
INSERT INTO `tref_city` VALUES ('107', '16', 'Kota Prabumulih');
INSERT INTO `tref_city` VALUES ('108', '16', 'Kabupaten Empat Lawang');
INSERT INTO `tref_city` VALUES ('109', '16', 'Kabupaten Lahat');
INSERT INTO `tref_city` VALUES ('110', '16', 'Kabupaten Muara Enim');
INSERT INTO `tref_city` VALUES ('111', '16', 'Kabupaten Musi Banyuasin');
INSERT INTO `tref_city` VALUES ('112', '16', 'Kabupaten Musi Rawas');
INSERT INTO `tref_city` VALUES ('113', '16', 'Kabupaten Ogan Ilir');
INSERT INTO `tref_city` VALUES ('114', '16', 'Kabupaten Ogan Komering Ilir');
INSERT INTO `tref_city` VALUES ('115', '16', 'Kabupaten Ogan Komering Ulu');
INSERT INTO `tref_city` VALUES ('116', '17', 'Kabupaten Bengkulu Selatan');
INSERT INTO `tref_city` VALUES ('117', '17', 'Kota Bengkulu');
INSERT INTO `tref_city` VALUES ('118', '17', 'Kabupaten Bengkulu Tengah ');
INSERT INTO `tref_city` VALUES ('119', '17', 'Kabupaten Bengkulu Utara ');
INSERT INTO `tref_city` VALUES ('120', '17', 'Kabupaten Kaur');
INSERT INTO `tref_city` VALUES ('121', '17', 'Kabupaten Kepahiang');
INSERT INTO `tref_city` VALUES ('122', '17', 'Kabupaten Lebong');
INSERT INTO `tref_city` VALUES ('123', '17', 'Kabupaten Mukomuko');
INSERT INTO `tref_city` VALUES ('124', '17', 'Kabupaten Rejang Lebong');
INSERT INTO `tref_city` VALUES ('125', '17', 'Kabupaten Seluma');
INSERT INTO `tref_city` VALUES ('126', '18', 'Kabupaten Lampung Barat');
INSERT INTO `tref_city` VALUES ('127', '18', 'Kabupaten Tulang Bawang');
INSERT INTO `tref_city` VALUES ('128', '18', 'Kabupaten Tulang Bawang Barat ');
INSERT INTO `tref_city` VALUES ('129', '18', 'Kabupaten Way Kanan');
INSERT INTO `tref_city` VALUES ('130', '18', 'Kota Bandar Lampung');
INSERT INTO `tref_city` VALUES ('131', '18', 'Kota Metro');
INSERT INTO `tref_city` VALUES ('132', '18', 'Kabupaten Lampung Selatan');
INSERT INTO `tref_city` VALUES ('133', '18', 'Kabupaten Lampung Tengah');
INSERT INTO `tref_city` VALUES ('134', '18', 'Kabupaten Lampung Timur');
INSERT INTO `tref_city` VALUES ('135', '18', 'Kabupaten Lampung Utara');
INSERT INTO `tref_city` VALUES ('136', '18', 'Kabupaten Mesuji');
INSERT INTO `tref_city` VALUES ('137', '18', 'Kabupaten Pesawaran');
INSERT INTO `tref_city` VALUES ('138', '18', 'Kabupaten Pringsewu');
INSERT INTO `tref_city` VALUES ('139', '18', 'Kabupaten Tanggamus');
INSERT INTO `tref_city` VALUES ('140', '19', 'Kabupaten Bangka');
INSERT INTO `tref_city` VALUES ('141', '19', 'Kabupaten Bangka Barat');
INSERT INTO `tref_city` VALUES ('142', '19', 'Kabupaten Bangka Selatan');
INSERT INTO `tref_city` VALUES ('143', '19', 'Kabupaten Bangka Tengah');
INSERT INTO `tref_city` VALUES ('144', '19', 'Kabupaten Belitung');
INSERT INTO `tref_city` VALUES ('145', '19', 'Kabupaten Belitung Timur');
INSERT INTO `tref_city` VALUES ('146', '19', 'Kota Pangkal Pinang');
INSERT INTO `tref_city` VALUES ('147', '21', 'Kabupaten Bintan');
INSERT INTO `tref_city` VALUES ('148', '21', 'Kabupaten Karimun');
INSERT INTO `tref_city` VALUES ('149', '21', 'Kabupaten Kepulauan Anambas');
INSERT INTO `tref_city` VALUES ('150', '21', 'Kabupaten Lingga');
INSERT INTO `tref_city` VALUES ('151', '21', 'Kabupaten Natuna');
INSERT INTO `tref_city` VALUES ('152', '21', 'Kota Batam');
INSERT INTO `tref_city` VALUES ('153', '21', 'Kota Tanjung Pinang');
INSERT INTO `tref_city` VALUES ('154', '31', 'Kabupaten Administrasi Kepulauan Seribu');
INSERT INTO `tref_city` VALUES ('155', '31', 'Kota Administrasi Jakarta Barat');
INSERT INTO `tref_city` VALUES ('156', '31', 'Kota Administrasi Jakarta Pusat');
INSERT INTO `tref_city` VALUES ('157', '31', 'Kota Administrasi Jakarta Selatan');
INSERT INTO `tref_city` VALUES ('158', '31', 'Kota Administrasi Jakarta Timur');
INSERT INTO `tref_city` VALUES ('159', '31', 'Kota Administrasi Jakarta Utara');
INSERT INTO `tref_city` VALUES ('160', '32', 'Kabupaten Bandung');
INSERT INTO `tref_city` VALUES ('161', '32', 'Kabupaten Karawang');
INSERT INTO `tref_city` VALUES ('162', '32', 'Kabupaten Kuningan');
INSERT INTO `tref_city` VALUES ('163', '32', 'Kabupaten Majalengka');
INSERT INTO `tref_city` VALUES ('164', '32', 'Kabupaten Purwakarta');
INSERT INTO `tref_city` VALUES ('165', '32', 'Kabupaten Subang');
INSERT INTO `tref_city` VALUES ('166', '32', 'Kabupaten Sukabumi');
INSERT INTO `tref_city` VALUES ('167', '32', 'Kabupaten Sumedang');
INSERT INTO `tref_city` VALUES ('168', '32', 'Kabupaten Tasikmalaya');
INSERT INTO `tref_city` VALUES ('169', '32', 'Kota Bandung');
INSERT INTO `tref_city` VALUES ('170', '32', 'Kota Banjar');
INSERT INTO `tref_city` VALUES ('171', '32', 'Kabupaten Bandung Barat');
INSERT INTO `tref_city` VALUES ('172', '32', 'Kota Bekasi');
INSERT INTO `tref_city` VALUES ('173', '32', 'Kota Bogor');
INSERT INTO `tref_city` VALUES ('174', '32', 'Kota Cimahi');
INSERT INTO `tref_city` VALUES ('175', '32', 'Kota Cirebon');
INSERT INTO `tref_city` VALUES ('176', '32', 'Kota Depok');
INSERT INTO `tref_city` VALUES ('177', '32', 'Kota Sukabumi');
INSERT INTO `tref_city` VALUES ('178', '32', 'Kota Tasikmalaya');
INSERT INTO `tref_city` VALUES ('179', '32', 'Kabupaten Bekasi');
INSERT INTO `tref_city` VALUES ('180', '32', 'Kabupaten Bogor');
INSERT INTO `tref_city` VALUES ('181', '32', 'Kabupaten Ciamis');
INSERT INTO `tref_city` VALUES ('182', '32', 'Kabupaten Cianjur');
INSERT INTO `tref_city` VALUES ('183', '32', 'Kabupaten Cirebon');
INSERT INTO `tref_city` VALUES ('184', '32', 'Kabupaten Garut');
INSERT INTO `tref_city` VALUES ('185', '32', 'Kabupaten Indramayu');
INSERT INTO `tref_city` VALUES ('186', '33', 'Kabupaten Banjarnegara');
INSERT INTO `tref_city` VALUES ('187', '33', 'Kabupaten Jepara');
INSERT INTO `tref_city` VALUES ('188', '33', 'Kabupaten Karanganyar');
INSERT INTO `tref_city` VALUES ('189', '33', 'Kabupaten Kebumen');
INSERT INTO `tref_city` VALUES ('190', '33', 'Kabupaten Kendal');
INSERT INTO `tref_city` VALUES ('191', '33', 'Kabupaten Klaten');
INSERT INTO `tref_city` VALUES ('192', '33', 'Kabupaten Kudus');
INSERT INTO `tref_city` VALUES ('193', '33', 'Kabupaten Magelang');
INSERT INTO `tref_city` VALUES ('194', '33', 'Kabupaten Pati');
INSERT INTO `tref_city` VALUES ('195', '33', 'Kabupaten Pekalongan');
INSERT INTO `tref_city` VALUES ('196', '33', 'Kabupaten Pemalang');
INSERT INTO `tref_city` VALUES ('197', '33', 'Kabupaten Banyumas');
INSERT INTO `tref_city` VALUES ('198', '33', 'Kabupaten Purbalingga');
INSERT INTO `tref_city` VALUES ('199', '33', 'Kabupaten Purworejo');
INSERT INTO `tref_city` VALUES ('200', '33', 'Kabupaten Rembang');
INSERT INTO `tref_city` VALUES ('201', '33', 'Kabupaten Semarang');
INSERT INTO `tref_city` VALUES ('202', '33', 'Kabupaten Sragen');
INSERT INTO `tref_city` VALUES ('203', '33', 'Kabupaten Sukoharjo');
INSERT INTO `tref_city` VALUES ('204', '33', 'Kabupaten Tegal');
INSERT INTO `tref_city` VALUES ('205', '33', 'Kabupaten Temanggung');
INSERT INTO `tref_city` VALUES ('206', '33', 'Kabupaten Wonogiri');
INSERT INTO `tref_city` VALUES ('207', '33', 'Kabupaten Wonosobo');
INSERT INTO `tref_city` VALUES ('208', '33', 'Kabupaten Batang');
INSERT INTO `tref_city` VALUES ('209', '33', 'Kota Magelang');
INSERT INTO `tref_city` VALUES ('210', '33', 'Kota Pekalongan');
INSERT INTO `tref_city` VALUES ('211', '33', 'Kota Salatiga');
INSERT INTO `tref_city` VALUES ('212', '33', 'Kota Semarang');
INSERT INTO `tref_city` VALUES ('213', '33', 'Kota Surakarta');
INSERT INTO `tref_city` VALUES ('214', '33', 'Kota Tegal');
INSERT INTO `tref_city` VALUES ('215', '33', 'Kabupaten Blora');
INSERT INTO `tref_city` VALUES ('216', '33', 'Kabupaten Boyolali');
INSERT INTO `tref_city` VALUES ('217', '33', 'Kabupaten Brebes');
INSERT INTO `tref_city` VALUES ('218', '33', 'Kabupaten Cilacap');
INSERT INTO `tref_city` VALUES ('219', '33', 'Kabupaten Demak');
INSERT INTO `tref_city` VALUES ('220', '33', 'Kabupaten Grobogan');
INSERT INTO `tref_city` VALUES ('221', '34', 'Kabupaten Bantul');
INSERT INTO `tref_city` VALUES ('222', '34', 'Kabupaten Gunung Kidul');
INSERT INTO `tref_city` VALUES ('223', '34', 'Kabupaten Kulon Progo');
INSERT INTO `tref_city` VALUES ('224', '34', 'Kabupaten Sleman');
INSERT INTO `tref_city` VALUES ('225', '34', 'Kota Yogyakarta');
INSERT INTO `tref_city` VALUES ('226', '35', 'Kabupaten Bangkalan');
INSERT INTO `tref_city` VALUES ('227', '35', 'Kabupaten Lamongan');
INSERT INTO `tref_city` VALUES ('228', '35', 'Kabupaten Lumajang');
INSERT INTO `tref_city` VALUES ('229', '35', 'Kabupaten Madiun');
INSERT INTO `tref_city` VALUES ('230', '35', 'Kabupaten Magetan');
INSERT INTO `tref_city` VALUES ('231', '35', 'Kabupaten Malang');
INSERT INTO `tref_city` VALUES ('232', '35', 'Kabupaten Mojokerto');
INSERT INTO `tref_city` VALUES ('233', '35', 'Kabupaten Nganjuk');
INSERT INTO `tref_city` VALUES ('234', '35', 'Kabupaten Ngawi');
INSERT INTO `tref_city` VALUES ('235', '35', 'Kabupaten Pacitan');
INSERT INTO `tref_city` VALUES ('236', '35', 'Kabupaten Pamekasan');
INSERT INTO `tref_city` VALUES ('237', '35', 'Kabupaten Banyuwangi');
INSERT INTO `tref_city` VALUES ('238', '35', 'Kabupaten Pasuruan');
INSERT INTO `tref_city` VALUES ('239', '35', 'Kabupaten Ponorogo');
INSERT INTO `tref_city` VALUES ('240', '35', 'Kabupaten Probolinggo');
INSERT INTO `tref_city` VALUES ('241', '35', 'Kabupaten Sampang');
INSERT INTO `tref_city` VALUES ('242', '35', 'Kabupaten Sidoarjo');
INSERT INTO `tref_city` VALUES ('243', '35', 'Kabupaten Situbondo');
INSERT INTO `tref_city` VALUES ('244', '35', 'Kabupaten Sumenep');
INSERT INTO `tref_city` VALUES ('245', '35', 'Kabupaten Trenggalek');
INSERT INTO `tref_city` VALUES ('246', '35', 'Kabupaten Tuban');
INSERT INTO `tref_city` VALUES ('247', '35', 'Kabupaten Tulungagung');
INSERT INTO `tref_city` VALUES ('248', '35', 'Kabupaten Blitar');
INSERT INTO `tref_city` VALUES ('249', '35', 'Kota Batu');
INSERT INTO `tref_city` VALUES ('250', '35', 'Kota Blitar');
INSERT INTO `tref_city` VALUES ('251', '35', 'Kota Kediri');
INSERT INTO `tref_city` VALUES ('252', '35', 'Kota Madiun');
INSERT INTO `tref_city` VALUES ('253', '35', 'Kota Malang');
INSERT INTO `tref_city` VALUES ('254', '35', 'Kota Mojokerto');
INSERT INTO `tref_city` VALUES ('255', '35', 'Kota Pasuruan');
INSERT INTO `tref_city` VALUES ('256', '35', 'Kota Probolinggo');
INSERT INTO `tref_city` VALUES ('257', '35', 'Kota Surabaya');
INSERT INTO `tref_city` VALUES ('258', '35', 'Kabupaten Bojonegoro');
INSERT INTO `tref_city` VALUES ('259', '35', 'Kabupaten Bondowoso');
INSERT INTO `tref_city` VALUES ('260', '35', 'Kabupaten Gresik');
INSERT INTO `tref_city` VALUES ('261', '35', 'Kabupaten Jember');
INSERT INTO `tref_city` VALUES ('262', '35', 'Kabupaten Jombang');
INSERT INTO `tref_city` VALUES ('263', '35', 'Kabupaten Kediri');
INSERT INTO `tref_city` VALUES ('264', '36', 'Kabupaten Tangerang');
INSERT INTO `tref_city` VALUES ('265', '36', 'Kabupaten Serang');
INSERT INTO `tref_city` VALUES ('266', '36', 'Kabupaten Lebak');
INSERT INTO `tref_city` VALUES ('267', '36', 'Kabupaten Pandeglang');
INSERT INTO `tref_city` VALUES ('268', '36', 'Kota Tangerang');
INSERT INTO `tref_city` VALUES ('269', '36', 'Kota Serang');
INSERT INTO `tref_city` VALUES ('270', '36', 'Kota Cilegon');
INSERT INTO `tref_city` VALUES ('271', '36', 'Kota Tangerang Selatan');
INSERT INTO `tref_city` VALUES ('272', '51', 'Kabupaten Badung');
INSERT INTO `tref_city` VALUES ('273', '51', 'Kabupaten Bangli');
INSERT INTO `tref_city` VALUES ('274', '51', 'Kabupaten Buleleng');
INSERT INTO `tref_city` VALUES ('275', '51', 'Kabupaten Gianyar');
INSERT INTO `tref_city` VALUES ('276', '51', 'Kabupaten Jembrana');
INSERT INTO `tref_city` VALUES ('277', '51', 'Kabupaten Karangasem');
INSERT INTO `tref_city` VALUES ('278', '51', 'Kabupaten Klungkung');
INSERT INTO `tref_city` VALUES ('279', '51', 'Kabupaten Tabanan');
INSERT INTO `tref_city` VALUES ('280', '51', 'Kota Denpasar');
INSERT INTO `tref_city` VALUES ('281', '52', 'Kabupaten Bima');
INSERT INTO `tref_city` VALUES ('282', '52', 'Kota Mataram');
INSERT INTO `tref_city` VALUES ('283', '52', 'Kabupaten Dompu');
INSERT INTO `tref_city` VALUES ('284', '52', 'Kabupaten Lombok Barat');
INSERT INTO `tref_city` VALUES ('285', '52', 'Kabupaten Lombok Tengah');
INSERT INTO `tref_city` VALUES ('286', '52', 'Kabupaten Lombok Timur');
INSERT INTO `tref_city` VALUES ('287', '52', 'Kabupaten Lombok Utara');
INSERT INTO `tref_city` VALUES ('288', '52', 'Kabupaten Sumbawa');
INSERT INTO `tref_city` VALUES ('289', '52', 'Kabupaten Sumbawa Barat');
INSERT INTO `tref_city` VALUES ('290', '52', 'Kota Bima');
INSERT INTO `tref_city` VALUES ('291', '53', 'Kabupaten Alor');
INSERT INTO `tref_city` VALUES ('292', '53', 'Kabupaten Ngada');
INSERT INTO `tref_city` VALUES ('293', '53', 'Kabupaten Nagekeo');
INSERT INTO `tref_city` VALUES ('294', '53', 'Kabupaten Rote Ndao');
INSERT INTO `tref_city` VALUES ('295', '53', 'Kabupaten Sabu Raijua');
INSERT INTO `tref_city` VALUES ('296', '53', 'Kabupaten Sikka');
INSERT INTO `tref_city` VALUES ('297', '53', 'Kabupaten Sumba Barat');
INSERT INTO `tref_city` VALUES ('298', '53', 'Kabupaten Sumba Barat Daya');
INSERT INTO `tref_city` VALUES ('299', '53', 'Kabupaten Sumba Tengah');
INSERT INTO `tref_city` VALUES ('300', '53', 'Kabupaten Sumba Timur');
INSERT INTO `tref_city` VALUES ('301', '53', 'Kabupaten Timor Tengah Selatan');
INSERT INTO `tref_city` VALUES ('302', '53', 'Kabupaten Belu');
INSERT INTO `tref_city` VALUES ('303', '53', 'Kabupaten Timor Tengah Utara');
INSERT INTO `tref_city` VALUES ('304', '53', 'Kota Kupang');
INSERT INTO `tref_city` VALUES ('305', '53', 'Kabupaten Ende');
INSERT INTO `tref_city` VALUES ('306', '53', 'Kabupaten Flores Timur');
INSERT INTO `tref_city` VALUES ('307', '53', 'Kabupaten Kupang');
INSERT INTO `tref_city` VALUES ('308', '53', 'Kabupaten Lembata');
INSERT INTO `tref_city` VALUES ('309', '53', 'Kabupaten Manggarai');
INSERT INTO `tref_city` VALUES ('310', '53', 'Kabupaten Manggarai Barat');
INSERT INTO `tref_city` VALUES ('311', '53', 'Kabupaten Manggarai Timur');
INSERT INTO `tref_city` VALUES ('312', '61', 'Kabupaten Bengkayang');
INSERT INTO `tref_city` VALUES ('313', '61', 'Kabupaten Sanggau');
INSERT INTO `tref_city` VALUES ('314', '61', 'Kabupaten Sekadau');
INSERT INTO `tref_city` VALUES ('315', '61', 'Kabupaten Sintang');
INSERT INTO `tref_city` VALUES ('316', '61', 'Kota Pontianak');
INSERT INTO `tref_city` VALUES ('317', '61', 'Kota Singkawang');
INSERT INTO `tref_city` VALUES ('318', '61', 'Kabupaten Bengkayang');
INSERT INTO `tref_city` VALUES ('319', '61', 'Kabupaten Kayong Utara');
INSERT INTO `tref_city` VALUES ('320', '61', 'Kabupaten Ketapang');
INSERT INTO `tref_city` VALUES ('321', '61', 'Kabupaten Kubu Raya');
INSERT INTO `tref_city` VALUES ('322', '61', 'Kabupaten Landak');
INSERT INTO `tref_city` VALUES ('323', '61', 'Kabupaten Melawi');
INSERT INTO `tref_city` VALUES ('324', '61', 'Kabupaten Pontianak');
INSERT INTO `tref_city` VALUES ('325', '61', 'Kabupaten Sambas');
INSERT INTO `tref_city` VALUES ('326', '62', 'Kabupaten Barito Selatan');
INSERT INTO `tref_city` VALUES ('327', '62', 'Kabupaten Murung Raya');
INSERT INTO `tref_city` VALUES ('328', '62', 'Kabupaten Pulang Pisau');
INSERT INTO `tref_city` VALUES ('329', '62', 'Kabupaten Sukamara');
INSERT INTO `tref_city` VALUES ('330', '62', 'Kabupaten Seruyan');
INSERT INTO `tref_city` VALUES ('331', '62', 'Kota Palangka Raya');
INSERT INTO `tref_city` VALUES ('332', '62', 'Kabupaten Barito Timur');
INSERT INTO `tref_city` VALUES ('333', '62', 'Kabupaten Barito Utara');
INSERT INTO `tref_city` VALUES ('334', '62', 'Kabupaten Gunung Mas');
INSERT INTO `tref_city` VALUES ('335', '62', 'Kabupaten Kapuas');
INSERT INTO `tref_city` VALUES ('336', '62', 'Kabupaten Katingan');
INSERT INTO `tref_city` VALUES ('337', '62', 'Kabupaten Kotawaringin Barat');
INSERT INTO `tref_city` VALUES ('338', '62', 'Kabupaten Kotawaringin Timur');
INSERT INTO `tref_city` VALUES ('339', '62', 'Kabupaten Lamandau');
INSERT INTO `tref_city` VALUES ('340', '63', 'Kabupaten Balangan');
INSERT INTO `tref_city` VALUES ('341', '63', 'Kabupaten Tanah Laut');
INSERT INTO `tref_city` VALUES ('342', '63', 'Kabupaten Tapin');
INSERT INTO `tref_city` VALUES ('343', '63', 'Kota Banjarbaru');
INSERT INTO `tref_city` VALUES ('344', '63', 'Kota Banjarmasin');
INSERT INTO `tref_city` VALUES ('345', '63', 'Kabupaten Banjar');
INSERT INTO `tref_city` VALUES ('346', '63', 'Kabupaten Barito Kuala');
INSERT INTO `tref_city` VALUES ('347', '63', 'Kabupaten Hulu Sungai Selatan');
INSERT INTO `tref_city` VALUES ('348', '63', 'Kabupaten Hulu Sungai Tengah');
INSERT INTO `tref_city` VALUES ('349', '63', 'Kabupaten Hulu Sungai Utara');
INSERT INTO `tref_city` VALUES ('350', '63', 'Kabupaten Kotabaru');
INSERT INTO `tref_city` VALUES ('351', '63', 'Kabupaten Tabalong');
INSERT INTO `tref_city` VALUES ('352', '63', 'Kabupaten Tanah Bumbu');
INSERT INTO `tref_city` VALUES ('353', '64', 'Kabupaten Berau');
INSERT INTO `tref_city` VALUES ('354', '64', 'Kabupaten Tana Tidung');
INSERT INTO `tref_city` VALUES ('355', '64', 'Kota Balikpapan');
INSERT INTO `tref_city` VALUES ('356', '64', 'Kota Bontang');
INSERT INTO `tref_city` VALUES ('357', '64', 'Kota Samarinda');
INSERT INTO `tref_city` VALUES ('358', '64', 'Kota Tarakan');
INSERT INTO `tref_city` VALUES ('359', '64', 'Kabupaten Bulungan');
INSERT INTO `tref_city` VALUES ('360', '64', 'Kabupaten Kutai Barat');
INSERT INTO `tref_city` VALUES ('361', '64', 'Kabupaten Kutai Kartanegara');
INSERT INTO `tref_city` VALUES ('362', '64', 'Kabupaten Kutai Timur');
INSERT INTO `tref_city` VALUES ('363', '64', 'Kabupaten Malinau');
INSERT INTO `tref_city` VALUES ('364', '64', 'Kabupaten Nunukan');
INSERT INTO `tref_city` VALUES ('365', '64', 'Kabupaten Paser');
INSERT INTO `tref_city` VALUES ('366', '64', 'Kabupaten Penajam Paser Utara');
INSERT INTO `tref_city` VALUES ('367', '71', 'Kabupaten Bolaang Mongondow');
INSERT INTO `tref_city` VALUES ('368', '71', 'Kabupaten Minahasa Tenggara');
INSERT INTO `tref_city` VALUES ('369', '71', 'Kabupaten Minahasa Utara');
INSERT INTO `tref_city` VALUES ('370', '71', 'Kota Bitung');
INSERT INTO `tref_city` VALUES ('371', '71', 'Kota Kotamobagu');
INSERT INTO `tref_city` VALUES ('372', '71', 'Kota Manado');
INSERT INTO `tref_city` VALUES ('373', '71', 'Kota Tomohon');
INSERT INTO `tref_city` VALUES ('374', '71', 'Kabupaten Bolaang Mongondow Selatan');
INSERT INTO `tref_city` VALUES ('375', '71', 'Kabupaten Bolaang Mongondow Timur');
INSERT INTO `tref_city` VALUES ('376', '71', 'Kabupaten Bolaang Mongondow utara');
INSERT INTO `tref_city` VALUES ('377', '71', 'Kabupaten Kepulauan Sangihe');
INSERT INTO `tref_city` VALUES ('378', '71', 'Kabupaten Kepulauan Siau Tagulandang Biaro');
INSERT INTO `tref_city` VALUES ('379', '71', 'Kabupaten Kepulauan Talaud');
INSERT INTO `tref_city` VALUES ('380', '71', 'Kabupaten Minahasa');
INSERT INTO `tref_city` VALUES ('381', '71', 'Kabupaten Minahasa Selatan');
INSERT INTO `tref_city` VALUES ('382', '72', 'Kabupaten Banggai');
INSERT INTO `tref_city` VALUES ('383', '72', 'Kabupaten Sigi');
INSERT INTO `tref_city` VALUES ('384', '72', 'Kota Palu');
INSERT INTO `tref_city` VALUES ('385', '72', 'Kabupaten Banggai Kepulauan');
INSERT INTO `tref_city` VALUES ('386', '72', 'Kabupaten Buol');
INSERT INTO `tref_city` VALUES ('387', '72', 'Kabupaten Donggala');
INSERT INTO `tref_city` VALUES ('388', '72', 'Kabupaten Morowali');
INSERT INTO `tref_city` VALUES ('389', '72', 'Kabupaten Parigi Moutong');
INSERT INTO `tref_city` VALUES ('390', '72', 'Kabupaten Poso');
INSERT INTO `tref_city` VALUES ('391', '72', 'Kabupaten Tojo Una-Una');
INSERT INTO `tref_city` VALUES ('392', '72', 'Kabupaten Toli-Toli');
INSERT INTO `tref_city` VALUES ('393', '73', 'Kabupaten Bantaeng');
INSERT INTO `tref_city` VALUES ('394', '73', 'Kabupaten Luwu Timur');
INSERT INTO `tref_city` VALUES ('395', '73', 'Kabupaten Luwu Utara');
INSERT INTO `tref_city` VALUES ('396', '73', 'Kabupaten Maros');
INSERT INTO `tref_city` VALUES ('397', '73', 'Kabupaten Pangkajene dan Kepulauan');
INSERT INTO `tref_city` VALUES ('398', '73', 'Kabupaten Pinrang');
INSERT INTO `tref_city` VALUES ('399', '73', 'Kabupaten Sidenreng Rappang');
INSERT INTO `tref_city` VALUES ('400', '73', 'Kabupaten Sinjai');
INSERT INTO `tref_city` VALUES ('401', '73', 'Kabupaten Soppeng');
INSERT INTO `tref_city` VALUES ('402', '73', 'Kabupaten Takalar');
INSERT INTO `tref_city` VALUES ('403', '73', 'Kabupaten Tana Toraja');
INSERT INTO `tref_city` VALUES ('404', '73', 'Kabupaten Barru');
INSERT INTO `tref_city` VALUES ('405', '73', 'Kabupaten Toraja Utara');
INSERT INTO `tref_city` VALUES ('406', '73', 'Kabupaten Wajo');
INSERT INTO `tref_city` VALUES ('407', '73', 'Kota Makassar');
INSERT INTO `tref_city` VALUES ('408', '73', 'Kota Palopo');
INSERT INTO `tref_city` VALUES ('409', '73', 'Kota Parepare');
INSERT INTO `tref_city` VALUES ('410', '73', 'Kabupaten Bone');
INSERT INTO `tref_city` VALUES ('411', '73', 'Kabupaten Bulukumba');
INSERT INTO `tref_city` VALUES ('412', '73', 'Kabupaten Enrekang');
INSERT INTO `tref_city` VALUES ('413', '73', 'Kabupaten Gowa');
INSERT INTO `tref_city` VALUES ('414', '73', 'Kabupaten Jeneponto');
INSERT INTO `tref_city` VALUES ('415', '73', 'Kabupaten Kepulauan Selayar');
INSERT INTO `tref_city` VALUES ('416', '73', 'Kabupaten Luwu');
INSERT INTO `tref_city` VALUES ('417', '74', 'Kabupaten Bombana');
INSERT INTO `tref_city` VALUES ('418', '74', 'Kabupaten Wakatobi');
INSERT INTO `tref_city` VALUES ('419', '74', 'Kota Bau-Bau');
INSERT INTO `tref_city` VALUES ('420', '74', 'Kota Kendari');
INSERT INTO `tref_city` VALUES ('421', '74', 'Kabupaten Buton');
INSERT INTO `tref_city` VALUES ('422', '74', 'Kabupaten Buton Utara');
INSERT INTO `tref_city` VALUES ('423', '74', 'Kabupaten Kolaka');
INSERT INTO `tref_city` VALUES ('424', '74', 'Kabupaten Kolaka Utara');
INSERT INTO `tref_city` VALUES ('425', '74', 'Kabupaten Konawe');
INSERT INTO `tref_city` VALUES ('426', '74', 'Kabupaten Konawe Selatan');
INSERT INTO `tref_city` VALUES ('427', '74', 'Kabupaten Konawe Utar');
INSERT INTO `tref_city` VALUES ('428', '74', 'Kabupaten Muna');
INSERT INTO `tref_city` VALUES ('429', '75', 'Kabupaten Boalemo');
INSERT INTO `tref_city` VALUES ('430', '75', 'Kabupaten Bone Bolango');
INSERT INTO `tref_city` VALUES ('431', '75', 'Kabupaten Gorontalo');
INSERT INTO `tref_city` VALUES ('432', '75', 'Kabupaten Gorontalo Utara');
INSERT INTO `tref_city` VALUES ('433', '75', 'Kabupaten Pohuwato');
INSERT INTO `tref_city` VALUES ('434', '75', 'Kota Gorontalo');
INSERT INTO `tref_city` VALUES ('435', '76', 'Kabupaten Majene');
INSERT INTO `tref_city` VALUES ('436', '76', 'Kabupaten Mamasa');
INSERT INTO `tref_city` VALUES ('437', '76', 'Kabupaten Mamuju');
INSERT INTO `tref_city` VALUES ('438', '76', 'Kabupaten Mamuju Utara');
INSERT INTO `tref_city` VALUES ('439', '76', 'Kabupaten Polewali Mandar');
INSERT INTO `tref_city` VALUES ('440', '81', 'Kabupaten Buru');
INSERT INTO `tref_city` VALUES ('441', '81', 'Kota Ambon');
INSERT INTO `tref_city` VALUES ('442', '81', 'Kota Tual');
INSERT INTO `tref_city` VALUES ('443', '81', 'Kabupaten Buru Selatan');
INSERT INTO `tref_city` VALUES ('444', '81', 'Kabupaten Kepulauan Aru');
INSERT INTO `tref_city` VALUES ('445', '81', 'Kabupaten Maluku Barat Daya');
INSERT INTO `tref_city` VALUES ('446', '81', 'Kabupaten Maluku Tengah');
INSERT INTO `tref_city` VALUES ('447', '81', 'Kabupaten Maluku Tenggara');
INSERT INTO `tref_city` VALUES ('448', '81', 'Kabupaten Maluku Tenggara Barat');
INSERT INTO `tref_city` VALUES ('449', '81', 'Kabupaten Seram Bagian Barat');
INSERT INTO `tref_city` VALUES ('450', '81', 'Kabupaten Seram Bagian Timur');
INSERT INTO `tref_city` VALUES ('451', '82', 'Kabupaten Halmahera Barat');
INSERT INTO `tref_city` VALUES ('452', '82', 'Kabupaten Halmahera Tengah');
INSERT INTO `tref_city` VALUES ('453', '82', 'Kabupaten Halmahera Utara');
INSERT INTO `tref_city` VALUES ('454', '82', 'Kabupaten Halmahera Selatan');
INSERT INTO `tref_city` VALUES ('455', '82', 'Kabupaten Kepulauan Sula');
INSERT INTO `tref_city` VALUES ('456', '82', 'Kabupaten Halmahera Timur');
INSERT INTO `tref_city` VALUES ('457', '82', 'Kabupaten Pulau Morotai');
INSERT INTO `tref_city` VALUES ('458', '82', 'Kota Ternate');
INSERT INTO `tref_city` VALUES ('459', '82', 'Kota Tidore Kepulauan');
INSERT INTO `tref_city` VALUES ('460', '91', 'Kabupaten Fakfak');
INSERT INTO `tref_city` VALUES ('461', '91', 'Kabupaten Teluk Wondama');
INSERT INTO `tref_city` VALUES ('462', '91', 'Kota Sorong');
INSERT INTO `tref_city` VALUES ('463', '91', 'Kabupaten Kaimana');
INSERT INTO `tref_city` VALUES ('464', '91', 'Kabupaten Manokwari');
INSERT INTO `tref_city` VALUES ('465', '91', 'Kabupaten Maybrat');
INSERT INTO `tref_city` VALUES ('466', '91', 'Kabupaten Raja Ampat');
INSERT INTO `tref_city` VALUES ('467', '91', 'Kabupaten Sorong');
INSERT INTO `tref_city` VALUES ('468', '91', 'Kabupaten Sorong Selatan');
INSERT INTO `tref_city` VALUES ('469', '91', 'Kabupaten Tambrauw');
INSERT INTO `tref_city` VALUES ('470', '91', 'Kabupaten Teluk Bintuni');
INSERT INTO `tref_city` VALUES ('471', '94', 'Kabupaten Asmat');
INSERT INTO `tref_city` VALUES ('472', '94', 'Kabupaten Kepulauan Yapen');
INSERT INTO `tref_city` VALUES ('473', '94', 'Kabupaten Lanny Jaya');
INSERT INTO `tref_city` VALUES ('474', '94', 'Kabupaten Mamberamo Raya');
INSERT INTO `tref_city` VALUES ('475', '94', 'Kabupaten Mamberamo Tengah');
INSERT INTO `tref_city` VALUES ('476', '94', 'Kabupaten Mappi');
INSERT INTO `tref_city` VALUES ('477', '94', 'Kabupaten Merauke');
INSERT INTO `tref_city` VALUES ('478', '94', 'Kabupaten Mimika');
INSERT INTO `tref_city` VALUES ('479', '94', 'Kabupaten Nabire');
INSERT INTO `tref_city` VALUES ('480', '94', 'Kabupaten Nduga');
INSERT INTO `tref_city` VALUES ('481', '94', 'Kabupaten Paniai');
INSERT INTO `tref_city` VALUES ('482', '94', 'Kabupaten Biak Numfor');
INSERT INTO `tref_city` VALUES ('483', '94', 'Kabupaten Pegunungan Bintang');
INSERT INTO `tref_city` VALUES ('484', '94', 'Kabupaten Puncak');
INSERT INTO `tref_city` VALUES ('485', '94', 'Kabupaten Puncak Jaya');
INSERT INTO `tref_city` VALUES ('486', '94', 'Kabupaten Sarmi');
INSERT INTO `tref_city` VALUES ('487', '94', 'Kabupaten Supiori');
INSERT INTO `tref_city` VALUES ('488', '94', 'Kabupaten Tolikara');
INSERT INTO `tref_city` VALUES ('489', '94', 'Kabupaten Waropen');
INSERT INTO `tref_city` VALUES ('490', '94', 'Kabupaten Yahukimo');
INSERT INTO `tref_city` VALUES ('491', '94', 'Kabupaten Yalimo');
INSERT INTO `tref_city` VALUES ('492', '94', 'Kota Jayapura');
INSERT INTO `tref_city` VALUES ('493', '94', 'Kabupaten Boven Digoel');
INSERT INTO `tref_city` VALUES ('494', '94', 'Kabupaten Deiyai');
INSERT INTO `tref_city` VALUES ('495', '94', 'Kabupaten Dogiyai');
INSERT INTO `tref_city` VALUES ('496', '94', 'Kabupaten Intan Jaya');
INSERT INTO `tref_city` VALUES ('497', '94', 'Kabupaten Jayapura');
INSERT INTO `tref_city` VALUES ('498', '94', 'Kabupaten Jayawijaya');
INSERT INTO `tref_city` VALUES ('499', '94', 'Kabupaten Keerom');
INSERT INTO `tref_city` VALUES ('500', '11', 'asdasd');
INSERT INTO `tref_city` VALUES ('501', '11', 'AAA');

-- ----------------------------
-- Table structure for `tref_departemen`
-- ----------------------------
DROP TABLE IF EXISTS `tref_departemen`;
CREATE TABLE `tref_departemen` (
  `departemenID` varchar(5) NOT NULL,
  `departemenNama` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`departemenID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tref_departemen
-- ----------------------------
INSERT INTO `tref_departemen` VALUES ('1', 'Salesman');
INSERT INTO `tref_departemen` VALUES ('2', 'Informasi dan Teknologi');
INSERT INTO `tref_departemen` VALUES ('3', 'Bengkel');
INSERT INTO `tref_departemen` VALUES ('4', 'Finance');
INSERT INTO `tref_departemen` VALUES ('5', 'Accounting');
INSERT INTO `tref_departemen` VALUES ('6', 'Customer Service');
INSERT INTO `tref_departemen` VALUES ('D-001', 'Administrasi');

-- ----------------------------
-- Table structure for `tref_instansi`
-- ----------------------------
DROP TABLE IF EXISTS `tref_instansi`;
CREATE TABLE `tref_instansi` (
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
  KEY `FK_tref_konsumen_tref_kota` (`kotaID`),
  CONSTRAINT `FK_tref_instansi_tref_city` FOREIGN KEY (`kotaID`) REFERENCES `tref_city` (`kotaID`) ON UPDATE CASCADE,
  CONSTRAINT `tref_instansi_ibfk_1` FOREIGN KEY (`propinsiID`) REFERENCES `tref_propinsi` (`propinsiID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tref_instansi
-- ----------------------------
INSERT INTO `tref_instansi` VALUES ('I201209060001', 'CITSTUDIO', 'Jalan Rengasdengklok', '32', '160', '40291', '123456', 'Suhendra', 'CEO');

-- ----------------------------
-- Table structure for `tref_jabatan`
-- ----------------------------
DROP TABLE IF EXISTS `tref_jabatan`;
CREATE TABLE `tref_jabatan` (
  `jabatanID` varchar(5) NOT NULL,
  `jabatanNama` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`jabatanID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tref_jabatan
-- ----------------------------
INSERT INTO `tref_jabatan` VALUES ('1', 'Staff');
INSERT INTO `tref_jabatan` VALUES ('10', 'Admin Assistant & Technician 4');
INSERT INTO `tref_jabatan` VALUES ('100', 'SHE&S Safety Site 3');
INSERT INTO `tref_jabatan` VALUES ('101', 'SHE&S Safety Site EPC 5');
INSERT INTO `tref_jabatan` VALUES ('102', 'SHE&S Safety-Export System');
INSERT INTO `tref_jabatan` VALUES ('103', 'SHE&S Security  EPC 5');
INSERT INTO `tref_jabatan` VALUES ('104', 'SHE&S Security Site FF ');
INSERT INTO `tref_jabatan` VALUES ('105', 'Site Admin Support');
INSERT INTO `tref_jabatan` VALUES ('106', 'Site Material Coordinator 1');
INSERT INTO `tref_jabatan` VALUES ('107', 'Site Staff Admin ');
INSERT INTO `tref_jabatan` VALUES ('108', 'Site Staff Admin 2');
INSERT INTO `tref_jabatan` VALUES ('109', 'Site Staff Admin Export System');
INSERT INTO `tref_jabatan` VALUES ('11', 'Admin Assistant 3');
INSERT INTO `tref_jabatan` VALUES ('110', 'Sosioeconomic Monitoring & Reporting  Advisor');
INSERT INTO `tref_jabatan` VALUES ('111', 'Spread Supervisor 1 ');
INSERT INTO `tref_jabatan` VALUES ('112', 'Spread Supravisor 2 ');
INSERT INTO `tref_jabatan` VALUES ('113', 'Stewardship & Reporting Technician');
INSERT INTO `tref_jabatan` VALUES ('114', 'Translator');
INSERT INTO `tref_jabatan` VALUES ('115', 'Travel JMC');
INSERT INTO `tref_jabatan` VALUES ('116', 'Valve/Pipping Inspector');
INSERT INTO `tref_jabatan` VALUES ('117', 'Welding Inspector EPC 1');
INSERT INTO `tref_jabatan` VALUES ('12', 'Admin Assistant 4');
INSERT INTO `tref_jabatan` VALUES ('13', 'Admin Asst');
INSERT INTO `tref_jabatan` VALUES ('14', 'Admin Support - Development');
INSERT INTO `tref_jabatan` VALUES ('15', 'Admin Support FSO');
INSERT INTO `tref_jabatan` VALUES ('16', 'Admin Support HR');
INSERT INTO `tref_jabatan` VALUES ('17', 'Admin Support-Export System');
INSERT INTO `tref_jabatan` VALUES ('18', 'Administrative Assistant');
INSERT INTO `tref_jabatan` VALUES ('19', 'Admint Assisstant 1');
INSERT INTO `tref_jabatan` VALUES ('2', 'Koordinator');
INSERT INTO `tref_jabatan` VALUES ('20', 'Admint Assisstant SHE&S');
INSERT INTO `tref_jabatan` VALUES ('21', 'Amdal Monitoring Report Advisor POS ID 96 CN');
INSERT INTO `tref_jabatan` VALUES ('22', 'AMDAL Monitoring Reporting Advisor ');
INSERT INTO `tref_jabatan` VALUES ('23', 'Civil Inspector');
INSERT INTO `tref_jabatan` VALUES ('24', 'Civil Inspector 3 Export System');
INSERT INTO `tref_jabatan` VALUES ('25', 'Civil Inspector Export System');
INSERT INTO `tref_jabatan` VALUES ('26', 'Civil Structural Inspector 2 Pos ID 1253 CB');
INSERT INTO `tref_jabatan` VALUES ('27', 'Coating Inspector');
INSERT INTO `tref_jabatan` VALUES ('28', 'Coating Inspector Export System EPC2');
INSERT INTO `tref_jabatan` VALUES ('29', 'Construction Advisor');
INSERT INTO `tref_jabatan` VALUES ('3', 'Supervisor');
INSERT INTO `tref_jabatan` VALUES ('30', 'Contract Assistant');
INSERT INTO `tref_jabatan` VALUES ('31', 'Contract Specialist');
INSERT INTO `tref_jabatan` VALUES ('32', 'Contract Support Staff 1 Pos. ID 92 CN.');
INSERT INTO `tref_jabatan` VALUES ('33', 'Controls Reporting Specialist');
INSERT INTO `tref_jabatan` VALUES ('34', 'Cost Engineer');
INSERT INTO `tref_jabatan` VALUES ('35', 'Cost Technician');
INSERT INTO `tref_jabatan` VALUES ('36', 'Data Assistant');
INSERT INTO `tref_jabatan` VALUES ('37', 'Doct Cont');
INSERT INTO `tref_jabatan` VALUES ('38', 'Document Control');
INSERT INTO `tref_jabatan` VALUES ('39', 'Document Controller');
INSERT INTO `tref_jabatan` VALUES ('4', 'Manager');
INSERT INTO `tref_jabatan` VALUES ('40', 'Document Controller - DFO');
INSERT INTO `tref_jabatan` VALUES ('41', 'Document Controller 1 - Export System');
INSERT INTO `tref_jabatan` VALUES ('42', 'Document Controller 3 - Export System ');
INSERT INTO `tref_jabatan` VALUES ('43', 'Document Controller FSO 1');
INSERT INTO `tref_jabatan` VALUES ('44', 'Domestic Content Coordinator');
INSERT INTO `tref_jabatan` VALUES ('45', 'E&I  Inspector 1 -Export System-');
INSERT INTO `tref_jabatan` VALUES ('46', 'Envinronmental Project Spcecialist');
INSERT INTO `tref_jabatan` VALUES ('47', 'Enviromental ,Regulatory & Permit Eng');
INSERT INTO `tref_jabatan` VALUES ('48', 'Environmental Special Project Officer');
INSERT INTO `tref_jabatan` VALUES ('49', 'EPC 1 - Regulatory & Permit Site Support');
INSERT INTO `tref_jabatan` VALUES ('5', 'Direktur');
INSERT INTO `tref_jabatan` VALUES ('50', 'EPC 5 Civil/Structural Inspecto');
INSERT INTO `tref_jabatan` VALUES ('51', 'EPC 5 Material Coordinator');
INSERT INTO `tref_jabatan` VALUES ('52', 'EPC-1 Contract Assistant ');
INSERT INTO `tref_jabatan` VALUES ('53', 'EPC2 - Environmental & Socioeconomic - Exp Sys ');
INSERT INTO `tref_jabatan` VALUES ('54', 'EPC2 Spread Supervisor 3 ');
INSERT INTO `tref_jabatan` VALUES ('55', 'GIS Coordinator');
INSERT INTO `tref_jabatan` VALUES ('56', 'Inspection Lead 2 Export Syteme ');
INSERT INTO `tref_jabatan` VALUES ('57', 'Inspection Lead 3 Export System');
INSERT INTO `tref_jabatan` VALUES ('58', 'Inspection Lead 4 Export System');
INSERT INTO `tref_jabatan` VALUES ('59', 'Interface Technician');
INSERT INTO `tref_jabatan` VALUES ('6', 'Adm Asst');
INSERT INTO `tref_jabatan` VALUES ('60', 'Lead Negotiator Team Coordinator');
INSERT INTO `tref_jabatan` VALUES ('61', 'Material Coordinator');
INSERT INTO `tref_jabatan` VALUES ('62', 'Mechanical/Piping Inspector EPC 5');
INSERT INTO `tref_jabatan` VALUES ('63', 'OIMS Coordinator');
INSERT INTO `tref_jabatan` VALUES ('64', 'OIMS Technician ');
INSERT INTO `tref_jabatan` VALUES ('65', 'Pipeline Designer-EPC3');
INSERT INTO `tref_jabatan` VALUES ('66', 'Pipeline Engineer - Export System');
INSERT INTO `tref_jabatan` VALUES ('67', 'Planning  and Schedule Engineer');
INSERT INTO `tref_jabatan` VALUES ('68', 'Procurement Interface Coordinator');
INSERT INTO `tref_jabatan` VALUES ('69', 'Procurement Staff');
INSERT INTO `tref_jabatan` VALUES ('7', 'Adm Asst');
INSERT INTO `tref_jabatan` VALUES ('70', 'Project Accountant');
INSERT INTO `tref_jabatan` VALUES ('71', 'Project Control Engineer 1');
INSERT INTO `tref_jabatan` VALUES ('72', 'Project Control Engineer 2');
INSERT INTO `tref_jabatan` VALUES ('73', 'Project Training Coordinator ');
INSERT INTO `tref_jabatan` VALUES ('74', 'Quality Inspection Coordinator');
INSERT INTO `tref_jabatan` VALUES ('75', 'Regulatory & Permit Site ');
INSERT INTO `tref_jabatan` VALUES ('76', 'Regulatory & Permitting Support');
INSERT INTO `tref_jabatan` VALUES ('77', 'Regulatory Document Coordinator');
INSERT INTO `tref_jabatan` VALUES ('78', 'Regulatory Staff 1');
INSERT INTO `tref_jabatan` VALUES ('79', 'Regulatory Staff 3');
INSERT INTO `tref_jabatan` VALUES ('8', 'Admin Assistant');
INSERT INTO `tref_jabatan` VALUES ('80', 'Regulatory Staff 5');
INSERT INTO `tref_jabatan` VALUES ('81', 'Regulatory Staff 7');
INSERT INTO `tref_jabatan` VALUES ('82', 'Regulatory Staff 8');
INSERT INTO `tref_jabatan` VALUES ('83', 'Safety Advisor');
INSERT INTO `tref_jabatan` VALUES ('84', 'Safety Site 2 EPC 5');
INSERT INTO `tref_jabatan` VALUES ('85', 'Sec Field Adm Asst');
INSERT INTO `tref_jabatan` VALUES ('86', 'Security - Field ');
INSERT INTO `tref_jabatan` VALUES ('87', 'Security Field Coord');
INSERT INTO `tref_jabatan` VALUES ('88', 'Security Field Coord');
INSERT INTO `tref_jabatan` VALUES ('89', 'Security Support Technician Pos ID 448 CN');
INSERT INTO `tref_jabatan` VALUES ('9', 'Admin Assistant - Quality');
INSERT INTO `tref_jabatan` VALUES ('90', 'SHE & S Safety Advisor-Export System ');
INSERT INTO `tref_jabatan` VALUES ('91', 'SHE & S Safety Coordinator-Export System ');
INSERT INTO `tref_jabatan` VALUES ('92', 'SHE & S Security Coordinator');
INSERT INTO `tref_jabatan` VALUES ('93', 'SHE & Safety Advisor Export System');
INSERT INTO `tref_jabatan` VALUES ('94', 'SHE & Safety Site');
INSERT INTO `tref_jabatan` VALUES ('95', 'SHE & Safety Site 4');
INSERT INTO `tref_jabatan` VALUES ('96', 'SHE&S Safety Coordinator');
INSERT INTO `tref_jabatan` VALUES ('97', 'SHE&S Safety EPC 1');
INSERT INTO `tref_jabatan` VALUES ('98', 'SHE&S Safety Lead');
INSERT INTO `tref_jabatan` VALUES ('99', 'SHE&S Safety Site 2');
INSERT INTO `tref_jabatan` VALUES ('M01', 'Office Boy');

-- ----------------------------
-- Table structure for `tref_karyawan`
-- ----------------------------
DROP TABLE IF EXISTS `tref_karyawan`;
CREATE TABLE `tref_karyawan` (
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
  `NoPKWT` varchar(150) DEFAULT NULL,
  `noKontrak` varchar(50) DEFAULT NULL,
  `noregistrasikaryawan` varchar(32) NOT NULL DEFAULT '',
  `tanggalmasuk` date DEFAULT NULL,
  `bankID` varchar(5) DEFAULT NULL,
  `cabangID` bigint(20) DEFAULT NULL,
  `noRekening` varchar(100) DEFAULT NULL,
  `accRekening` varchar(150) DEFAULT NULL,
  `status` enum('N','Y') DEFAULT 'N',
  PRIMARY KEY (`nip`,`noregistrasikaryawan`),
  UNIQUE KEY `accRekening` (`accRekening`),
  KEY `propinsiID` (`propinsiID`),
  KEY `FK_tref_karyawan_tref_kota` (`kotaID`),
  KEY `FK_tref_karyawan_tref_kota_2` (`tempatLahir`),
  KEY `nip` (`nip`),
  KEY `cabangID` (`cabangID`),
  KEY `FK_tref_karyawan_tref_bank` (`bankID`),
  CONSTRAINT `FK_tref_karyawan_tref_bank` FOREIGN KEY (`bankID`) REFERENCES `tref_bank` (`bankID`) ON UPDATE CASCADE,
  CONSTRAINT `FK_tref_karyawan_tref_city` FOREIGN KEY (`kotaID`) REFERENCES `tref_city` (`kotaID`) ON UPDATE CASCADE,
  CONSTRAINT `FK_tref_karyawan_tref_city_2` FOREIGN KEY (`tempatLahir`) REFERENCES `tref_city` (`kotaID`) ON UPDATE CASCADE,
  CONSTRAINT `tref_karyawan_ibfk_1` FOREIGN KEY (`propinsiID`) REFERENCES `tref_propinsi` (`propinsiID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `tref_karyawan_ibfk_2` FOREIGN KEY (`cabangID`) REFERENCES `tref_bank_cabang` (`cabangID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tref_karyawan
-- ----------------------------
INSERT INTO `tref_karyawan` VALUES ('6304194', 'L', null, null, 'Suhendra', 'hendra', '2012-09-05', '6', 'L', 'islam', 'Jalan Rengasdengklok 3 No 17 Bandung', '11', '13', null, '0123', null, null, null, 'REG2407976304194', '2012-01-01', null, null, null, null, 'N');
INSERT INTO `tref_karyawan` VALUES ('aqqq', 'aaa', 'aaa', 'aaa', 'aaaa', 'aa', '2012-09-05', '3', 'L', 'islam', null, null, null, null, null, null, null, null, 'REG120907002', null, null, null, null, null, 'N');
INSERT INTO `tref_karyawan` VALUES ('NIP120909', 'qwe', 'qwe', 'qwe', 'qwe', 'qwe', '2012-09-19', '2', 'P', 'protestan', 'qweqwe', '51', '275', '132', '123123', '12312312', null, null, 'REG120909001', null, '10003', '3', null, 'Suhendra', 'N');

-- ----------------------------
-- Table structure for `tref_leveluser`
-- ----------------------------
DROP TABLE IF EXISTS `tref_leveluser`;
CREATE TABLE `tref_leveluser` (
  `levelID` int(8) NOT NULL AUTO_INCREMENT COMMENT 'ID Level dari User',
  `levelName` varchar(25) NOT NULL DEFAULT 'Administrator' COMMENT 'Nama Level dari User',
  `levelSlug` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`levelID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tref_leveluser
-- ----------------------------
INSERT INTO `tref_leveluser` VALUES ('1', 'Super Administrator', 'sa');
INSERT INTO `tref_leveluser` VALUES ('2', 'Administrator', 'admin');
INSERT INTO `tref_leveluser` VALUES ('3', 'Manager', 'mgr');
INSERT INTO `tref_leveluser` VALUES ('4', 'Operator', 'opr');

-- ----------------------------
-- Table structure for `tref_propinsi`
-- ----------------------------
DROP TABLE IF EXISTS `tref_propinsi`;
CREATE TABLE `tref_propinsi` (
  `propinsiID` varchar(4) NOT NULL,
  `propinsiNama` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`propinsiID`),
  UNIQUE KEY `propinsiNama` (`propinsiNama`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tref_propinsi
-- ----------------------------
INSERT INTO `tref_propinsi` VALUES ('11', 'Aceh');
INSERT INTO `tref_propinsi` VALUES ('51', 'Bali');
INSERT INTO `tref_propinsi` VALUES ('36', 'Banten');
INSERT INTO `tref_propinsi` VALUES ('17', 'Bengkulu');
INSERT INTO `tref_propinsi` VALUES ('34', 'Daerah Istimewa Yogyakarta');
INSERT INTO `tref_propinsi` VALUES ('31', 'Daerah Khusus Ibukota Jakarta');
INSERT INTO `tref_propinsi` VALUES ('75', 'Gorontalo');
INSERT INTO `tref_propinsi` VALUES ('15', 'Jambi');
INSERT INTO `tref_propinsi` VALUES ('32', 'Jawa Barat');
INSERT INTO `tref_propinsi` VALUES ('33', 'Jawa Tengah');
INSERT INTO `tref_propinsi` VALUES ('35', 'Jawa Timur');
INSERT INTO `tref_propinsi` VALUES ('61', 'Kalimantan Barat');
INSERT INTO `tref_propinsi` VALUES ('63', 'Kalimantan Selatan');
INSERT INTO `tref_propinsi` VALUES ('62', 'Kalimantan Tengah');
INSERT INTO `tref_propinsi` VALUES ('64', 'Kalimantan Timur');
INSERT INTO `tref_propinsi` VALUES ('19', 'Kepulauan Bangka Belitung');
INSERT INTO `tref_propinsi` VALUES ('21', 'Kepulauan Riau');
INSERT INTO `tref_propinsi` VALUES ('18', 'Lampung');
INSERT INTO `tref_propinsi` VALUES ('81', 'Maluku');
INSERT INTO `tref_propinsi` VALUES ('82', 'Maluku Utara');
INSERT INTO `tref_propinsi` VALUES ('52', 'Nusa Tenggara Barat');
INSERT INTO `tref_propinsi` VALUES ('53', 'Nusa Tenggara Timur');
INSERT INTO `tref_propinsi` VALUES ('94', 'Papua');
INSERT INTO `tref_propinsi` VALUES ('91', 'Papua Barat');
INSERT INTO `tref_propinsi` VALUES ('14', 'Riau');
INSERT INTO `tref_propinsi` VALUES ('76', 'Sulawesi Barat');
INSERT INTO `tref_propinsi` VALUES ('73', 'Sulawesi Selatan');
INSERT INTO `tref_propinsi` VALUES ('72', 'Sulawesi Tengah');
INSERT INTO `tref_propinsi` VALUES ('74', 'Sulawesi Tenggara');
INSERT INTO `tref_propinsi` VALUES ('71', 'Sulawesi Utara');
INSERT INTO `tref_propinsi` VALUES ('13', 'Sumatera Barat');
INSERT INTO `tref_propinsi` VALUES ('12', 'Sumatera Utara');
INSERT INTO `tref_propinsi` VALUES ('16', 'Sumatra Selatan');

-- ----------------------------
-- Table structure for `tref_user`
-- ----------------------------
DROP TABLE IF EXISTS `tref_user`;
CREATE TABLE `tref_user` (
  `userID` varchar(8) NOT NULL,
  `levelID` int(8) NOT NULL DEFAULT '0',
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `nip` varchar(9) NOT NULL,
  PRIMARY KEY (`userID`,`levelID`,`nip`),
  UNIQUE KEY `nip` (`nip`),
  UNIQUE KEY `username` (`username`),
  KEY `FK_tref_user_tref_leveluser` (`levelID`),
  CONSTRAINT `FK_tref_user_tref_leveluser` FOREIGN KEY (`levelID`) REFERENCES `tref_leveluser` (`levelID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tref_user_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `tref_karyawan` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tref_user
-- ----------------------------
INSERT INTO `tref_user` VALUES ('UID00001', '1', 'sa01', 'sa01', '6304194');

-- ----------------------------
-- Table structure for `t_hakakses`
-- ----------------------------
DROP TABLE IF EXISTS `t_hakakses`;
CREATE TABLE `t_hakakses` (
  `username` varchar(50) NOT NULL,
  `modulID` varchar(10) NOT NULL,
  `is_grant` enum('N','Y') DEFAULT 'Y',
  PRIMARY KEY (`username`,`modulID`),
  KEY `modulID` (`modulID`),
  CONSTRAINT `FK_t_hakakses_tref_user` FOREIGN KEY (`username`) REFERENCES `tref_user` (`username`) ON UPDATE CASCADE,
  CONSTRAINT `t_hakakses_ibfk_1` FOREIGN KEY (`modulID`) REFERENCES `conf_modul` (`modulID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_hakakses
-- ----------------------------
INSERT INTO `t_hakakses` VALUES ('sa01', '1', 'Y');
INSERT INTO `t_hakakses` VALUES ('sa01', '2', 'Y');
INSERT INTO `t_hakakses` VALUES ('sa01', '3', 'Y');

-- ----------------------------
-- Table structure for `t_log`
-- ----------------------------
DROP TABLE IF EXISTS `t_log`;
CREATE TABLE `t_log` (
  `logID` varchar(64) NOT NULL DEFAULT '',
  `logAktivitas` enum('INSERT','UPDATE','DELETE') NOT NULL DEFAULT 'INSERT',
  `logTable` varchar(50) DEFAULT NULL,
  `logPenjelasan` text,
  `logKomputer` varchar(64) DEFAULT NULL,
  `logTerakhir` datetime DEFAULT NULL,
  `logUser` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`logID`,`logAktivitas`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_log
-- ----------------------------
INSERT INTO `t_log` VALUES ('02a391ec-f59a-11e1-aa1b-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=aaa', '127.0.0.1', '2012-09-03 14:36:01', 'sa01');
INSERT INTO `t_log` VALUES ('041b007d-d98c-11e1-bf13-5442495fad6a', 'UPDATE', 'TREF_MANUFAKTUR', 'manufakturID=M02|manufakturNama=Toyota XX', '127.0.0.1', '2012-07-29 21:45:18', 'sa01');
INSERT INTO `t_log` VALUES ('0608e803-f59a-11e1-aa1b-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=96|propinsiNama=abc', '127.0.0.1', '2012-09-03 14:36:07', 'sa01');
INSERT INTO `t_log` VALUES ('0b6468e8-f59a-11e1-aa1b-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 14:36:16', 'sa01');
INSERT INTO `t_log` VALUES ('0b6ba7f7-f59a-11e1-aa1b-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=96|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 14:36:16', 'sa01');
INSERT INTO `t_log` VALUES ('168552f6-f52b-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', null, '127.0.0.1', '2012-09-03 01:22:03', 'sa01');
INSERT INTO `t_log` VALUES ('16c089b3-f52b-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', null, '127.0.0.1', '2012-09-03 01:22:03', 'sa01');
INSERT INTO `t_log` VALUES ('16f7c8ee-f52b-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', null, '127.0.0.1', '2012-09-03 01:22:03', 'sa01');
INSERT INTO `t_log` VALUES ('1aead571-f55e-11e1-86a1-f07bcbe0bf28', 'UPDATE', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=Aceh Darussalam', '127.0.0.1', '2012-09-03 07:27:15', 'sa01');
INSERT INTO `t_log` VALUES ('20bc6ded-f528-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=123', '127.0.0.1', '2012-09-03 01:00:51', 'sa01');
INSERT INTO `t_log` VALUES ('226653cc-f57d-11e1-a0e7-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 11:09:19', 'sa01');
INSERT INTO `t_log` VALUES ('298b405b-f554-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=96|propinsiNama=aa', '127.0.0.1', '2012-09-03 06:16:04', 'sa01');
INSERT INTO `t_log` VALUES ('2e3b32b9-f83f-11e1-9460-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', null, '127.0.0.1', '2012-09-06 23:23:24', 'sa01');
INSERT INTO `t_log` VALUES ('310fe2b4-f527-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_DEPARTEMEN', 'departemenID=|departemenNama=asd', '127.0.0.1', '2012-09-03 00:54:09', '');
INSERT INTO `t_log` VALUES ('336e2fe8-f562-11e1-86a1-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=0|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 07:56:34', 'sa01');
INSERT INTO `t_log` VALUES ('39051a30-f554-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=97|propinsiNama=abcd', '127.0.0.1', '2012-09-03 06:16:30', 'sa01');
INSERT INTO `t_log` VALUES ('3c948e84-f57d-11e1-a0e7-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 11:10:03', 'sa01');
INSERT INTO `t_log` VALUES ('4490db7a-f527-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=231321', '127.0.0.1', '2012-09-03 00:54:42', 'admin');
INSERT INTO `t_log` VALUES ('57ae097f-f59c-11e1-aa1b-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=aaa', '127.0.0.1', '2012-09-03 14:52:43', 'sa01');
INSERT INTO `t_log` VALUES ('5c51788f-f59c-11e1-aa1b-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 14:52:51', 'sa01');
INSERT INTO `t_log` VALUES ('638c3281-d81e-11e1-9bee-5442495fad6a', 'INSERT', 'TREF_KATEGORI', 'kategoriID=K01|kategoriNama=Sedan', '127.0.0.1', '2012-07-28 02:08:02', 'sa01');
INSERT INTO `t_log` VALUES ('74eace12-f62f-11e1-9920-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', null, '127.0.0.1', '2012-09-04 08:25:48', 'sa01');
INSERT INTO `t_log` VALUES ('7982d653-f62f-11e1-9920-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-04 08:25:56', 'sa01');
INSERT INTO `t_log` VALUES ('79dbed2b-f59c-11e1-aa1b-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=aaaa', '127.0.0.1', '2012-09-03 14:53:40', 'sa01');
INSERT INTO `t_log` VALUES ('7de2d2b1-f59c-11e1-aa1b-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 14:53:47', 'sa01');
INSERT INTO `t_log` VALUES ('8692e80b-f52b-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=qwe', '127.0.0.1', '2012-09-03 01:25:11', 'sa01');
INSERT INTO `t_log` VALUES ('8afafb62-f555-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=98|propinsiNama=asd', '127.0.0.1', '2012-09-03 06:25:57', 'sa01');
INSERT INTO `t_log` VALUES ('9342061e-d824-11e1-9bee-5442495fad6a', 'INSERT', 'TREF_PROPINSI', 'propinsiID=K01|propinsiNama=Bali', '127.0.0.1', '2012-07-28 02:52:19', 'sa01');
INSERT INTO `t_log` VALUES ('9452be20-d8ae-11e1-99a8-5442495fad6a', 'INSERT', 'TREF_JABATAN', 'jabatanID=M01|jabatanNama=Office Boy', '127.0.0.1', '2012-07-28 19:20:12', 'sa01');
INSERT INTO `t_log` VALUES ('980d81a2-f527-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_DEPARTEMEN', 'departemenID=X|departemenNama=123', '127.0.0.1', '2012-09-03 00:57:02', 'sa01');
INSERT INTO `t_log` VALUES ('98c48277-d827-11e1-9bee-5442495fad6a', 'UPDATE', 'TREF_DEPARTEMEN', 'departemenID=2|departemenNama=Informasi dan Teknologi', '127.0.0.1', '2012-07-28 03:13:57', 'sa01');
INSERT INTO `t_log` VALUES ('99539e7f-d81d-11e1-9bee-5442495fad6a', 'INSERT', 'TREF_KATEGORI', 'kategoriID=K01|kategoriNama=Truk', '127.0.0.1', '2012-07-28 02:02:23', 'sa01');
INSERT INTO `t_log` VALUES ('9b63248d-f52d-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=100|propinsiNama=qweqwe', '127.0.0.1', '2012-09-03 01:40:04', 'sa01');
INSERT INTO `t_log` VALUES ('9edba2f1-d824-11e1-9bee-5442495fad6a', 'UPDATE', 'TREF_PROPINSI', 'propinsiID=P001|propinsiNama=Jakarta', '127.0.0.1', '2012-07-28 02:52:39', 'sa01');
INSERT INTO `t_log` VALUES ('a1062034-d81e-11e1-9bee-5442495fad6a', 'INSERT', 'TREF_KATEGORI', 'kategoriID=K03|kategoriNama=Mobil Box', '127.0.0.1', '2012-07-28 02:09:46', 'sa01');
INSERT INTO `t_log` VALUES ('a2f8c08f-f52a-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=ert', '127.0.0.1', '2012-09-03 01:18:49', 'sa01');
INSERT INTO `t_log` VALUES ('a32a260d-d824-11e1-9bee-5442495fad6a', 'DELETE', 'TREF_KATEGORI', 'propinsiID=K01|propinsiNama=Bali', '127.0.0.1', '2012-07-28 02:52:46', 'sa01');
INSERT INTO `t_log` VALUES ('a44bf1b5-f596-11e1-aa1b-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 14:11:54', 'sa01');
INSERT INTO `t_log` VALUES ('a455551e-f596-11e1-aa1b-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', null, '127.0.0.1', '2012-09-03 14:11:54', 'sa01');
INSERT INTO `t_log` VALUES ('a909c3e4-f595-11e1-aa1b-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 14:04:53', 'sa01');
INSERT INTO `t_log` VALUES ('a90e0b2a-f595-11e1-aa1b-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', null, '127.0.0.1', '2012-09-03 14:04:53', 'sa01');
INSERT INTO `t_log` VALUES ('abd28a7c-d756-11e1-b4f0-5442495fad6a', 'INSERT', 'TREF_MANUFAKTUR', 'manufakturID=M01|manufakturNama=Toyota', '127.0.0.1', '2012-07-27 02:18:25', 'sa01');
INSERT INTO `t_log` VALUES ('b05177f3-d756-11e1-b4f0-5442495fad6a', 'DELETE', 'TREF_MANUFAKTUR', 'manufakturID=M01|manufakturNama=Toyota', '127.0.0.1', '2012-07-27 02:18:32', 'sa01');
INSERT INTO `t_log` VALUES ('b5d78df3-d756-11e1-b4f0-5442495fad6a', 'INSERT', 'TREF_MANUFAKTUR', 'manufakturID=M01|manufakturNama=Toyota', '127.0.0.1', '2012-07-27 02:18:41', 'sa01');
INSERT INTO `t_log` VALUES ('b6591700-f596-11e1-aa1b-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 14:12:25', 'sa01');
INSERT INTO `t_log` VALUES ('b65d58dc-f596-11e1-aa1b-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', null, '127.0.0.1', '2012-09-03 14:12:25', 'sa01');
INSERT INTO `t_log` VALUES ('b84cdadd-d756-11e1-b4f0-5442495fad6a', 'DELETE', 'TREF_MANUFAKTUR', 'manufakturID=M01|manufakturNama=Toyota', '127.0.0.1', '2012-07-27 02:18:45', 'sa01');
INSERT INTO `t_log` VALUES ('c051b90b-f52a-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=96|propinsiNama=xcv', '127.0.0.1', '2012-09-03 01:19:38', 'sa01');
INSERT INTO `t_log` VALUES ('c0b840d9-f7a8-11e1-a394-f07bcbe0bf28', 'UPDATE', 'TREF_PROPINSI', null, '127.0.0.1', '2012-09-06 05:26:35', 'sa01');
INSERT INTO `t_log` VALUES ('c469acb0-f7a8-11e1-a394-f07bcbe0bf28', 'UPDATE', 'TREF_PROPINSI', null, '127.0.0.1', '2012-09-06 05:26:42', 'sa01');
INSERT INTO `t_log` VALUES ('c4ec09ae-d99e-11e1-bf13-5442495fad6a', 'INSERT', 'TREF_MANUFAKTUR', 'manufakturID=M04|manufakturNama=Mobil', '127.0.0.1', '2012-07-29 23:59:33', 'sa01');
INSERT INTO `t_log` VALUES ('c8c8e528-d827-11e1-9bee-5442495fad6a', 'INSERT', 'TREF_DEPARTEMEN', 'departemenID=M01|departemenNama=RnD', '127.0.0.1', '2012-07-28 03:15:18', 'sa01');
INSERT INTO `t_log` VALUES ('c9596993-d820-11e1-9bee-5442495fad6a', 'INSERT', 'TREF_MANUFAKTUR', 'manufakturID=M01|manufakturNama=Honda', '127.0.0.1', '2012-07-28 02:25:12', 'sa01');
INSERT INTO `t_log` VALUES ('ca2e3b75-f596-11e1-aa1b-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 14:12:58', 'sa01');
INSERT INTO `t_log` VALUES ('d10027e6-f52b-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=96|propinsiNama=asdasd', '127.0.0.1', '2012-09-03 01:27:15', 'sa01');
INSERT INTO `t_log` VALUES ('d94b00f3-f55f-11e1-86a1-f07bcbe0bf28', 'UPDATE', 'TREF_PROPINSI', 'propinsiID=|propinsiNama=', '127.0.0.1', '2012-09-03 07:39:44', 'sa01');
INSERT INTO `t_log` VALUES ('e01cefd6-f52c-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=97|propinsiNama=zzzz', '127.0.0.1', '2012-09-03 01:34:50', 'sa01');
INSERT INTO `t_log` VALUES ('e91ffbd8-f553-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=Aduh', '127.0.0.1', '2012-09-03 06:14:16', 'sa01');
INSERT INTO `t_log` VALUES ('e9a658d5-f870-11e1-9460-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-07 05:19:24', 'sa01');
INSERT INTO `t_log` VALUES ('eb8cf8b9-f52a-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=97|propinsiNama=cvb', '127.0.0.1', '2012-09-03 01:20:50', 'sa01');
INSERT INTO `t_log` VALUES ('ec95dbb3-f599-11e1-aa1b-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=aaaa', '127.0.0.1', '2012-09-03 14:35:24', 'sa01');
INSERT INTO `t_log` VALUES ('f0034690-f52c-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=98|propinsiNama=ccc', '127.0.0.1', '2012-09-03 01:35:17', 'sa01');
INSERT INTO `t_log` VALUES ('f0782fe0-f557-11e1-86a1-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=96|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 06:43:07', 'sa01');
INSERT INTO `t_log` VALUES ('f19e1e7a-f527-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_DEPARTEMEN', 'departemenID=ID|departemenNama=123', '127.0.0.1', '2012-09-03 00:59:32', 'sa01');
INSERT INTO `t_log` VALUES ('f1fba016-f599-11e1-aa1b-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=95|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 14:35:33', 'sa01');
INSERT INTO `t_log` VALUES ('f3a36db9-f557-11e1-86a1-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=97|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 06:43:12', 'sa01');
INSERT INTO `t_log` VALUES ('f47f3b66-d820-11e1-9bee-5442495fad6a', 'INSERT', 'TREF_MANUFAKTUR', 'manufakturID=M02|manufakturNama=Toyota', '127.0.0.1', '2012-07-28 02:26:25', 'sa01');
INSERT INTO `t_log` VALUES ('f7b62656-f52c-11e1-86a1-f07bcbe0bf28', 'INSERT', 'TREF_PROPINSI', 'propinsiID=99|propinsiNama=sss', '127.0.0.1', '2012-09-03 01:35:30', 'sa01');
INSERT INTO `t_log` VALUES ('fd57a0e8-f557-11e1-86a1-f07bcbe0bf28', 'DELETE', 'TREF_PROPINSI', 'propinsiID=98|propinsiNama=Nama Propinsi', '127.0.0.1', '2012-09-03 06:43:28', 'sa01');
INSERT INTO `t_log` VALUES ('fe549894-d820-11e1-9bee-5442495fad6a', 'INSERT', 'TREF_MANUFAKTUR', 'manufakturID=M03|manufakturNama=Nissan', '127.0.0.1', '2012-07-28 02:26:41', 'sa01');

-- ----------------------------
-- Table structure for `t_menjabat`
-- ----------------------------
DROP TABLE IF EXISTS `t_menjabat`;
CREATE TABLE `t_menjabat` (
  `menjabatID` varchar(9) NOT NULL DEFAULT '',
  `periodeAwal` date DEFAULT NULL,
  `periodeAkhir` date DEFAULT NULL,
  `nip` varchar(9) NOT NULL DEFAULT '',
  `departemenID` varchar(5) DEFAULT NULL,
  `jabatanID` varchar(5) DEFAULT NULL,
  `periodeTahunAwal` varchar(5) DEFAULT NULL,
  `periodeTahunAkhir` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`menjabatID`,`nip`),
  KEY `FK_t_menjabat_tref_karyawan` (`nip`),
  KEY `FK_t_menjabat_tref_departemen` (`departemenID`),
  KEY `FK_t_menjabat_tref_jabatan` (`jabatanID`),
  CONSTRAINT `FK_t_menjabat_tref_departemen` FOREIGN KEY (`departemenID`) REFERENCES `tref_departemen` (`departemenID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_t_menjabat_tref_jabatan` FOREIGN KEY (`jabatanID`) REFERENCES `tref_jabatan` (`jabatanID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_t_menjabat_tref_karyawan` FOREIGN KEY (`nip`) REFERENCES `tref_karyawan` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_menjabat
-- ----------------------------
INSERT INTO `t_menjabat` VALUES ('JB0000107', '2012-07-28', '2015-07-28', '6304194', '2', '4', '2012', '2015');

-- ----------------------------
-- View structure for `view_instansi`
-- ----------------------------
DROP VIEW IF EXISTS `view_instansi`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_instansi` AS select `tref_instansi`.`instansiID` AS `instansiID`,`tref_instansi`.`instansiNama` AS `instansiNama`,`tref_instansi`.`alamat` AS `alamat`,`tref_instansi`.`propinsiID` AS `propinsiID`,`fnPropinsiByID`(`tref_instansi`.`propinsiID`) AS `propinsi`,`tref_instansi`.`kotaID` AS `kotaID`,`fnKotaByID`(`tref_instansi`.`kotaID`,`tref_instansi`.`propinsiID`) AS `kota`,`tref_instansi`.`kodePos` AS `kodePos`,`tref_instansi`.`nomorTelepon` AS `nomorTelepon`,`tref_instansi`.`namaKontak` AS `namaKontak`,`tref_instansi`.`jabatanKontak` AS `jabatanKontak` from `tref_instansi` ;

-- ----------------------------
-- View structure for `view_karyawan`
-- ----------------------------
DROP VIEW IF EXISTS `view_karyawan`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_karyawan` AS select `tref_karyawan`.`nip` AS `nip`,`tref_karyawan`.`npwp` AS `npwp`,`tref_karyawan`.`noKTPSIM` AS `noKTPSIM`,`tref_karyawan`.`noJamsostek` AS `noJamsostek`,`tref_karyawan`.`namaLengkap` AS `namaLengkap`,`tref_karyawan`.`namaPanggilan` AS `namaPanggilan`,`tref_karyawan`.`tanggalLahir` AS `tanggalLahir`,`tref_karyawan`.`tempatLahir` AS `tempatLahir`,`fnCityByID`(`tref_karyawan`.`tempatLahir`) AS `kotaLahir`,`tref_karyawan`.`gender` AS `gender`,`tref_karyawan`.`agama` AS `agama`,`tref_karyawan`.`alamat` AS `alamat`,`tref_karyawan`.`propinsiID` AS `propinsiID`,`tref_karyawan`.`kotaID` AS `kotaID`,`fnPropinsiByID`(`tref_karyawan`.`propinsiID`) AS `propinsi`,`fnKotaByID`(`tref_karyawan`.`kotaID`,`tref_karyawan`.`propinsiID`) AS `kota`,`tref_karyawan`.`kodePos` AS `kodePos`,`tref_karyawan`.`nomortelepon` AS `nomortelepon`,`tref_karyawan`.`email` AS `email`,`tref_karyawan`.`NoPKWT` AS `NoPKWT`,`tref_karyawan`.`noKontrak` AS `noKontrak`,`tref_karyawan`.`noregistrasikaryawan` AS `noregistrasikaryawan`,`tref_karyawan`.`tanggalmasuk` AS `tanggalmasuk`,`tref_karyawan`.`bankID` AS `bankID`,`fnBankByID`(`tref_karyawan`.`bankID`) AS `namaBank`,`tref_karyawan`.`cabangID` AS `cabangID`,`fnCabangByIDBankIDCabang`(`tref_karyawan`.`bankID`,`tref_karyawan`.`cabangID`) AS `namaCabang`,`tref_karyawan`.`noRekening` AS `noRekening`,`tref_karyawan`.`accRekening` AS `accRekening`,`tref_karyawan`.`status` AS `status` from `tref_karyawan` ;

-- ----------------------------
-- View structure for `view_kota`
-- ----------------------------
DROP VIEW IF EXISTS `view_kota`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_kota` AS select `tref_city`.`kotaID` AS `kotaID`,`tref_city`.`kotaNama` AS `kotaNama`,`tref_propinsi`.`propinsiNama` AS `propinsiNama`,`tref_propinsi`.`propinsiID` AS `propinsiID` from (`tref_city` join `tref_propinsi` on((`tref_city`.`propinsiID` = `tref_propinsi`.`propinsiID`))) ;

-- ----------------------------
-- Procedure structure for `sp_departemen_delete`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_departemen_delete`;
DELIMITER ;;
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

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `sp_departemen_insert`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_departemen_insert`;
DELIMITER ;;
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

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `sp_departemen_update`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_departemen_update`;
DELIMITER ;;
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

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `sp_GetModuleAuthenticationByUsername`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_GetModuleAuthenticationByUsername`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `sp_GetUserByNIP`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_GetUserByNIP`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `sp_GetUserByUserNameAndPassword`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_GetUserByUserNameAndPassword`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `sp_jabatan_delete`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_jabatan_delete`;
DELIMITER ;;
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

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `sp_jabatan_insert`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_jabatan_insert`;
DELIMITER ;;
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

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `sp_jabatan_update`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_jabatan_update`;
DELIMITER ;;
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

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `sp_karyawan_insert_update`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_karyawan_insert_update`;
DELIMITER ;;
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

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `sp_propinsi_delete`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_propinsi_delete`;
DELIMITER ;;
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

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `sp_propinsi_insert`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_propinsi_insert`;
DELIMITER ;;
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

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `sp_propinsi_update`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_propinsi_update`;
DELIMITER ;;
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

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `sp_tlog_insert`
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_tlog_insert`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tlog_insert`(IN `i_aktivitas` varchar(15), IN `i_table` varchar(50), IN `i_penjelasan` text, IN `i_alamatIP` varchar(150), IN `i_user` varchar(50))
BEGIN
	#Routine body goes here...
	DECLARE logid VARCHAR(150);
	SET logid = UUID();

	INSERT INTO t_log
	(logID, logAktivitas, logTable, logPenjelasan, logKomputer, logTerakhir, logUser)
	VALUES
	(logid, i_aktivitas, i_table,i_penjelasan,i_alamatIP,SYSDATE(),i_user);

END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `fnBankByID`
-- ----------------------------
DROP FUNCTION IF EXISTS `fnBankByID`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fnBankByID`(`ibankID` int) RETURNS varchar(150) CHARSET latin1
BEGIN
	#Routine body goes here...
	SET @namaBank = '';
SELECT tref_bank.bankName AS bank INTO @namaBank FROM tref_bank WHERE tref_bank.bankID = ibankID LIMIT 1;
  RETURN @namaBank;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `fnCabangByIDBankIDCabang`
-- ----------------------------
DROP FUNCTION IF EXISTS `fnCabangByIDBankIDCabang`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fnCabangByIDBankIDCabang`(`iBankID` varchar(5), `iCabangID` INT) RETURNS varchar(150) CHARSET latin1
BEGIN
	#Routine body goes here...
	SET @namaCabang = '';
SELECT tref_bank_cabang.cabangNama AS bankCabang INTO @namaCabang FROM tref_bank_cabang WHERE tref_bank_cabang.bankID = iBankID AND tref_bank_cabang.cabangID=iCabangID LIMIT 1;
  RETURN @namaCabang;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `fnCityByID`
-- ----------------------------
DROP FUNCTION IF EXISTS `fnCityByID`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fnCityByID`(`kotaID` int) RETURNS varchar(150) CHARSET latin1
BEGIN
	#Routine body goes here...
	SET @namaKota = '';
SELECT kotaNama AS kota INTO @namaKota FROM tref_city WHERE kotaID = kotaID LIMIT 1;
  RETURN @namaKota;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `fnKotaByID`
-- ----------------------------
DROP FUNCTION IF EXISTS `fnKotaByID`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fnKotaByID`(`kotaID` int, `ipropinsiID` INT) RETURNS varchar(50) CHARSET latin1
BEGIN
	#Routine body goes here...
	SET @namaKota = '';
SELECT kotaNama AS kota INTO @namaKota FROM tref_city WHERE kotaID = kotaID AND tref_city.propinsiID=ipropinsiID LIMIT 1;
  RETURN @namaKota;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `fnPropinsiByID`
-- ----------------------------
DROP FUNCTION IF EXISTS `fnPropinsiByID`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fnPropinsiByID`(`ipropinsiID` INT) RETURNS varchar(50) CHARSET latin1
BEGIN
	#Routine body goes here...
	SET @namaPropinsi = '';
SELECT tref_propinsi.propinsiNama AS propinsi INTO @namaPropinsi FROM tref_propinsi WHERE tref_propinsi.propinsiID=ipropinsiID LIMIT 1;
  RETURN @namaPropinsi;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `fn_trefdepartemen_delete`
-- ----------------------------
DROP FUNCTION IF EXISTS `fn_trefdepartemen_delete`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `fn_trefdepartemen_insert`
-- ----------------------------
DROP FUNCTION IF EXISTS `fn_trefdepartemen_insert`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `fn_trefdepartemen_update`
-- ----------------------------
DROP FUNCTION IF EXISTS `fn_trefdepartemen_update`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `fn_trefjabatan_delete`
-- ----------------------------
DROP FUNCTION IF EXISTS `fn_trefjabatan_delete`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `fn_trefjabatan_insert`
-- ----------------------------
DROP FUNCTION IF EXISTS `fn_trefjabatan_insert`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `fn_trefjabatan_update`
-- ----------------------------
DROP FUNCTION IF EXISTS `fn_trefjabatan_update`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `fn_trefkaryawan_insert_update`
-- ----------------------------
DROP FUNCTION IF EXISTS `fn_trefkaryawan_insert_update`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `fn_trefpropinsi_delete`
-- ----------------------------
DROP FUNCTION IF EXISTS `fn_trefpropinsi_delete`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `fn_trefpropinsi_insert`
-- ----------------------------
DROP FUNCTION IF EXISTS `fn_trefpropinsi_insert`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for `fn_trefpropinsi_update`
-- ----------------------------
DROP FUNCTION IF EXISTS `fn_trefpropinsi_update`;
DELIMITER ;;
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
END
;;
DELIMITER ;
