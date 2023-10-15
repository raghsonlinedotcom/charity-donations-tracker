CREATE DATABASE IF NOT EXISTS charity_donation_tracker;

USE charity_donation_tracker;

CREATE TABLE IF NOT EXISTS charity_donation (
    id INT AUTO_INCREMENT PRIMARY KEY,
    financialYear VARCHAR(10) NOT NULL,
    date DATE NOT NULL,
    receipt VARCHAR(255),
    amount DECIMAL(10, 2) NOT NULL,
    institution VARCHAR(255),
    address VARCHAR(255) NOT NULL,
    pan VARCHAR(10),
    receipts VARCHAR(3),
    remarks TEXT
);