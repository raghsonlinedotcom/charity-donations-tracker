use itsraghz;

DROP TABLE IF EXISTS `tblexpenses11jul19`;

CREATE TABLE IF NOT EXISTS `tblexpenses11jul19` (
  `TxId` int(11) NOT NULL AUTO_INCREMENT,
  `DateOfTx` date DEFAULT NULL COMMENT 'YYYY-MM-DD format',
  `TimeOfTx` time DEFAULT '10:00:00' COMMENT 'HH:mm:SS format in 24 hours',
  `DayOfTx` varchar(10) DEFAULT NULL COMMENT 'MON, TUE, WED, THU, FRI, SAT, SUN',
  `TxType` varchar(10) NOT NULL DEFAULT 'DR' COMMENT 'DR for Debit, CR for Credit',
  `Country` varchar(10) NOT NULL DEFAULT 'India' COMMENT 'Country at which the expense is made',
  `Currency` varchar(5) NOT NULL DEFAULT 'INR' COMMENT 'Currency at which the expense is made',
  `City` varchar(40) DEFAULT 'Chennai',
  `Place` varchar(40) DEFAULT 'Home',
  `ShopName` varchar(40) DEFAULT 'Flat 3A, Sudharsan Apartments',
  `Area` varchar(40) DEFAULT 'Indra Nagar, Adyar',
  `Landmark` varchar(40) DEFAULT 'Near Adyar Hero Showroom',
  `Category` varchar(20) NOT NULL DEFAULT 'Day-Day',
  `SubCategory` varchar(20) NOT NULL DEFAULT 'Groceries' COMMENT 'Groceries, Food, Beverages, Snacks, Flowers, Water etc.,',
  `Beneficiary` varchar(100) NOT NULL DEFAULT 'Raghavan, Manikanta',
  `Source` varchar(40) DEFAULT 'Cash' COMMENT 'Cash, GooglePay, PhonePe etc,.',
  `Amount` double(10,2) DEFAULT '0.0',
  `Description` varchar(1000) DEFAULT NULL COMMENT 'Description of the expenses',
  `Remarks` varchar(1000) DEFAULT NULL COMMENT 'Any additional remarks for the expenses',
  `Tags` varchar(255) DEFAULT 'Day-Day, Groceries' COMMENT 'set of tags separated by comma for quick filtering and logical grouping of expense',
  `YetTo` int(1) DEFAULT 1 COMMENT 'a flag to mark the expense which is loaned. 1 means Yes, 0 means no',
  `Balance` double(10,2) DEFAULT '0.0' COMMENT 'Balance amount in the respective Bank Acct',
  `MODIFIED_ON` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `MODIFIED_BY` varchar(20) DEFAULT 'SYSTEM',
  `CREATED_ON` timestamp NOT NULL DEFAULT current_timestamp(),
  `CREATED_BY` varchar(20) DEFAULT 'Manikanta',
  PRIMARY KEY (`TxId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;