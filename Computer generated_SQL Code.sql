/* BINDU SAI SRI YERRA - 02084144 */
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema HealthInsuranceDatabase
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema HealthInsuranceDatabase
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS HealthInsuranceDatabase;
CREATE SCHEMA IF NOT EXISTS `HealthInsuranceDatabase` DEFAULT CHARACTER SET utf8mb4 ;
USE `HealthInsuranceDatabase` ;

-- -----------------------------------------------------
-- Table `HealthInsuranceDatabase`.`POLICY_HOLDERS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HealthInsuranceDatabase`.`POLICY_HOLDERS` (
  `PolicyHolder_ID` INT NOT NULL,
  `Holder_Name` VARCHAR(40) NOT NULL,
  `Gender` VARCHAR(10) NOT NULL,
  `DateOfBirth` DATE NOT NULL,
  `Contact_Number` VARCHAR(15) NOT NULL,
  `Holder_Email` VARCHAR(30) NOT NULL,
  `Address` VARCHAR(30) NOT NULL,
  `City` VARCHAR(15) NOT NULL,
  `State` VARCHAR(15) NOT NULL,
  `Zipcode` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`PolicyHolder_ID`),
  UNIQUE INDEX `PolicyHolder_ID_UNIQUE` (`PolicyHolder_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthInsuranceDatabase`.`INSURANCE_PLANS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HealthInsuranceDatabase`.`INSURANCE_PLANS` (
  `Plan_ID` INT NOT NULL,
  `Plan_Name` VARCHAR(30) NOT NULL,
  `Plan_Description` VARCHAR(300) NOT NULL,
  `Coverage_Details` VARCHAR(300) NOT NULL,
  `Plan_Cost` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`Plan_ID`),
  UNIQUE INDEX `Plan_ID_UNIQUE` (`Plan_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthInsuranceDatabase`.`HEALTHCARE_PROVIDERS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HealthInsuranceDatabase`.`HEALTHCARE_PROVIDERS` (
  `Provider_ID` INT NOT NULL,
  `Provider_Name` VARCHAR(40) NOT NULL,
  `Speciality` VARCHAR(25) NOT NULL,
  `Provider_Contact` VARCHAR(15) NOT NULL,
  `Provider_Email` VARCHAR(30) NOT NULL,
  `Provider_Address` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Provider_ID`),
  UNIQUE INDEX `Provider_ID_UNIQUE` (`Provider_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthInsuranceDatabase`.`CLAIMS_DETAILS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HealthInsuranceDatabase`.`CLAIMS_DETAILS` (
  `Claim_ID` INT NOT NULL,
  `Service_Date` DATE NOT NULL,
  `Billing_Amount` DECIMAL(10,2) NOT NULL,
  `HEALTHCARE_PROVIDERS_Provider_ID` INT NOT NULL,
  PRIMARY KEY (`Claim_ID`),
  UNIQUE INDEX `Claim_ID_UNIQUE` (`Claim_ID` ASC) VISIBLE,
  INDEX `fk_CLAIMS_DETAILS_HEALTHCARE_PROVIDERS1_idx` (`HEALTHCARE_PROVIDERS_Provider_ID` ASC) VISIBLE,
  CONSTRAINT `fk_CLAIMS_DETAILS_HEALTHCARE_PROVIDERS1`
    FOREIGN KEY (`HEALTHCARE_PROVIDERS_Provider_ID`)
    REFERENCES `HealthInsuranceDatabase`.`HEALTHCARE_PROVIDERS` (`Provider_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthInsuranceDatabase`.`ENROLLMENT_DETAILS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HealthInsuranceDatabase`.`ENROLLMENT_DETAILS` (
  `Enrollment_ID` INT NOT NULL,
  `Start_Date` DATE NOT NULL,
  `End_Date` DATE NOT NULL,
  `POLICY_HOLDERS_PolicyHolder_ID` INT NOT NULL,
  `Insurance_Plans_Plan_ID` INT NOT NULL,
  PRIMARY KEY (`Enrollment_ID`),
  UNIQUE INDEX `Enrollment_ID_UNIQUE` (`Enrollment_ID` ASC) VISIBLE,
  INDEX `fk_ENROLLMENT_DETAILS_POLICY_HOLDERS1_idx` (`POLICY_HOLDERS_PolicyHolder_ID` ASC) VISIBLE,
  INDEX `fk_ENROLLMENT_DETAILS_Insurance_Plans1_idx` (`Insurance_Plans_Plan_ID` ASC) VISIBLE,
  CONSTRAINT `fk_ENROLLMENT_DETAILS_POLICY_HOLDERS1`
    FOREIGN KEY (`POLICY_HOLDERS_PolicyHolder_ID`)
    REFERENCES `HealthInsuranceDatabase`.`POLICY_HOLDERS` (`PolicyHolder_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ENROLLMENT_DETAILS_Insurance_Plans1`
    FOREIGN KEY (`Insurance_Plans_Plan_ID`)
    REFERENCES `HealthInsuranceDatabase`.`INSURANCE_PLANS` (`Plan_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthInsuranceDatabase`.`POLICY_DETAILS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HealthInsuranceDatabase`.`POLICY_DETAILS` (
  `PolicyDetail_ID` INT NOT NULL,
  `Deductible` DECIMAL(10,2) NOT NULL,
  `CoPay` DECIMAL(10,2) NOT NULL,
  `OutofPocketMax` DECIMAL(10,2) NOT NULL,
  `Insurance_Plans_Plan_ID` INT NOT NULL,
  UNIQUE INDEX `PolicyDetail_ID_UNIQUE` (`PolicyDetail_ID` ASC) VISIBLE,
  PRIMARY KEY (`PolicyDetail_ID`),
  INDEX `fk_POLICY_DETAILS_Insurance_Plans1_idx` (`Insurance_Plans_Plan_ID` ASC) VISIBLE,
  CONSTRAINT `fk_POLICY_DETAILS_Insurance_Plans1`
    FOREIGN KEY (`Insurance_Plans_Plan_ID`)
    REFERENCES `HealthInsuranceDatabase`.`INSURANCE_PLANS` (`Plan_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthInsuranceDatabase`.`PAYMENT_DETAILS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HealthInsuranceDatabase`.`PAYMENT_DETAILS` (
  `Payment_ID` INT NOT NULL,
  `Payment_Date` DATE NOT NULL,
  `Amount_Paid` DECIMAL(10,2) NOT NULL,
  `CLAIMS_DETAILS_Claim_ID` INT NOT NULL,
  PRIMARY KEY (`Payment_ID`),
  UNIQUE INDEX `Payment_ID_UNIQUE` (`Payment_ID` ASC) VISIBLE,
  INDEX `fk_PAYMENT_DETAILS_CLAIMS_DETAILS1_idx` (`CLAIMS_DETAILS_Claim_ID` ASC) VISIBLE,
  CONSTRAINT `fk_PAYMENT_DETAILS_CLAIMS_DETAILS1`
    FOREIGN KEY (`CLAIMS_DETAILS_Claim_ID`)
    REFERENCES `HealthInsuranceDatabase`.`CLAIMS_DETAILS` (`Claim_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthInsuranceDatabase`.`Diagnosis_Details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HealthInsuranceDatabase`.`Diagnosis_Details` (
  `Diagnosis_Code` VARCHAR(15) NOT NULL,
  `Diagnosis_Description` VARCHAR(45) NOT NULL,
  `CLAIMS_DETAILS_Claim_ID` INT NOT NULL,
  PRIMARY KEY (`Diagnosis_Code`),
  UNIQUE INDEX `Diagnosis_Code_UNIQUE` (`Diagnosis_Code` ASC) VISIBLE,
  INDEX `fk_Diagnosis_Details_CLAIMS_DETAILS1_idx` (`CLAIMS_DETAILS_Claim_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Diagnosis_Details_CLAIMS_DETAILS1`
    FOREIGN KEY (`CLAIMS_DETAILS_Claim_ID`)
    REFERENCES `HealthInsuranceDatabase`.`CLAIMS_DETAILS` (`Claim_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthInsuranceDatabase`.`Insurance_Plans_has_POLICY_HOLDERS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HealthInsuranceDatabase`.`Insurance_Plans_has_POLICY_HOLDERS` (
  `Insurance_Plans_Plan_ID` INT NOT NULL,
  `POLICY_HOLDERS_PolicyHolder_ID` INT NOT NULL,
  PRIMARY KEY (`Insurance_Plans_Plan_ID`, `POLICY_HOLDERS_PolicyHolder_ID`),
  INDEX `fk_Insurance_Plans_has_POLICY_HOLDERS_POLICY_HOLDERS1_idx` (`POLICY_HOLDERS_PolicyHolder_ID` ASC) VISIBLE,
  INDEX `fk_Insurance_Plans_has_POLICY_HOLDERS_Insurance_Plans_idx` (`Insurance_Plans_Plan_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Insurance_Plans_has_POLICY_HOLDERS_Insurance_Plans`
    FOREIGN KEY (`Insurance_Plans_Plan_ID`)
    REFERENCES `HealthInsuranceDatabase`.`INSURANCE_PLANS` (`Plan_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Insurance_Plans_has_POLICY_HOLDERS_POLICY_HOLDERS1`
    FOREIGN KEY (`POLICY_HOLDERS_PolicyHolder_ID`)
    REFERENCES `HealthInsuranceDatabase`.`POLICY_HOLDERS` (`PolicyHolder_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HealthInsuranceDatabase`.`HEALTHCARE_PROVIDERS_has_POLICY_HOLDERS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HealthInsuranceDatabase`.`HEALTHCARE_PROVIDERS_has_POLICY_HOLDERS` (
  `HEALTHCARE_PROVIDERS_Provider_ID` INT NOT NULL,
  `POLICY_HOLDERS_PolicyHolder_ID` INT NOT NULL,
  PRIMARY KEY (`HEALTHCARE_PROVIDERS_Provider_ID`, `POLICY_HOLDERS_PolicyHolder_ID`),
  INDEX `fk_HEALTHCARE_PROVIDERS_has_POLICY_HOLDERS_POLICY_HOLDERS1_idx` (`POLICY_HOLDERS_PolicyHolder_ID` ASC) VISIBLE,
  INDEX `fk_HEALTHCARE_PROVIDERS_has_POLICY_HOLDERS_HEALTHCARE_PROVI_idx` (`HEALTHCARE_PROVIDERS_Provider_ID` ASC) VISIBLE,
  CONSTRAINT `fk_HEALTHCARE_PROVIDERS_has_POLICY_HOLDERS_HEALTHCARE_PROVIDE1`
    FOREIGN KEY (`HEALTHCARE_PROVIDERS_Provider_ID`)
    REFERENCES `HealthInsuranceDatabase`.`HEALTHCARE_PROVIDERS` (`Provider_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_HEALTHCARE_PROVIDERS_has_POLICY_HOLDERS_POLICY_HOLDERS1`
    FOREIGN KEY (`POLICY_HOLDERS_PolicyHolder_ID`)
    REFERENCES `HealthInsuranceDatabase`.`POLICY_HOLDERS` (`PolicyHolder_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO POLICY_HOLDERS (PolicyHolder_ID, Holder_Name, Gender, DateOfBirth, Contact_Number, Holder_Email, Address, City, State, Zipcode)
VALUES
(1, 'Katy Pery', 'Female', '1986-1-19', '76548935462', 'katy.pery@happy.com', '765 Part St', 'Boston', 'BO', '15647'),
(2, 'The Weekend', 'Male', '1995-7-25', '5325787497', 'weekend.the@happy.com', '369 South St', 'New York', 'NY', '78564'),
(3, 'Selena Goamez', 'Female', '1988-12-12', '98645432567', 'selena.gomez3@happy.com', '876 Haymarket', 'California', 'CL', '14563'),
(4, 'Taylor Swift', 'Female', '1990-03-18', '9876342981', 'taylor.swift@happy.com', '654 Fenway', 'Houston', 'TX', '01234'),
(5, 'Charlie Puth', 'Male', '1983-08-26', '89765436728', 'charlie.puth@happy.com', '134 Indiana St', 'Florida', 'FL', '76584');

INSERT INTO INSURANCE_PLANS (Plan_ID, Plan_Name, Plan_Description, Coverage_Details, Plan_Cost)
VALUES
(1, 'Basic Plan', 'Provides essential coverage for common medical services', 'Hospitalization, doctor visits, prescription drugs', 100.00),
(2, 'Silver Plan', 'Offers moderate coverage with additional benefits', 'Hospitalization, doctor visits, prescription drugs, specialist consultations', 150.00),
(3, 'Gold Plan', 'Comprehensive coverage with higher limits and more benefits', 'Hospitalization, doctor visits, prescription drugs, specialist consultations, preventive care, dental and vision', 200.00),
(4, 'Platinum Plan', 'Top-tier plan with extensive coverage and additional perks', 'Hospitalization, doctor visits, prescription drugs, specialist consultations, preventive care, dental and vision, alternative therapies, gym membership', 250.00),
(5, 'Family Plan', 'Designed for families with coverage for multiple members', 'Hospitalization, doctor visits, prescription drugs, specialist consultations, preventive care, dental and vision, maternity care', 300.00);

INSERT INTO HEALTHCARE_PROVIDERS (Provider_ID, Provider_Name, Speciality, Provider_Contact, Provider_Email, Provider_Address)
VALUES
(1, 'Sanjeevini Hospital', 'General Medicine', '7532648643', 'sanjeevini@hospital.com', '345 Main Street'),
(2, 'Apolo Clinic', 'Dermatology', '5468837267', 'apolo@clinic.com', '987 sandy Avenue'),
(3, 'John Dental Care', 'Dentistry', '7654378973', 'john@dentalcare.com', '876 Oak king'),
(4, 'David Specialist Center', 'Cardiology', '8765356498', 'davidspecialist@center.com', '132 Maple St'),
(5, 'Sandra Family Physicians', 'Family Medicine', '8764673894', 'sandrafamily@physicians.com', '675 Pinky Street');

INSERT INTO CLAIMS_DETAILS (Claim_ID, Service_Date, Billing_Amount, HEALTHCARE_PROVIDERS_Provider_ID)
VALUES
(1, '2023-05-01', 250.00, 1),
(2, '2023-04-15', 150.00, 2),
(3, '2023-05-10', 300.00, 3),
(4, '2023-04-22', 200.00, 1),
(5, '2023-05-05', 180.00, 4);

INSERT INTO ENROLLMENT_DETAILS (Enrollment_ID, Start_Date, End_Date, POLICY_HOLDERS_PolicyHolder_ID, Insurance_Plans_Plan_ID)
VALUES
(1, '2023-01-01', '2023-12-31', 1, 1),
(2, '2023-02-15', '2023-11-30', 2, 1),
(3, '2023-03-01', '2023-10-31', 3, 2),
(4, '2023-04-01', '2023-09-30', 4, 2),
(5, '2023-05-01', '2023-08-31', 5, 3);

INSERT INTO POLICY_DETAILS (PolicyDetail_ID, Deductible, CoPay, OutofPocketMax, Insurance_Plans_Plan_ID)
VALUES
(1, 5000.00, 20.00, 10000.00, 1),
(2, 3000.00, 30.00, 8000.00, 1),
(3, 2000.00, 25.00, 5000.00, 2),
(4, 4000.00, 15.00, 9000.00, 2),
(5, 2500.00, 35.00, 7000.00, 3);

INSERT INTO PAYMENT_DETAILS (Payment_ID, Payment_Date, Amount_Paid, CLAIMS_DETAILS_Claim_ID)
VALUES
(1, '2023-01-15', 150.00, 1),
(2, '2023-02-20', 250.00, 2),
(3, '2023-03-10', 180.00, 3),
(4, '2023-04-05', 200.00, 4),
(5, '2023-05-12', 300.00, 5);

INSERT INTO Diagnosis_Details (Diagnosis_Code, Diagnosis_Description, CLAIMS_DETAILS_Claim_ID)
VALUES
('D001', 'Common Cold', 1),
('D002', 'Bronchitis', 2),
('D003', 'Hypertension', 3),
('D004', 'Diabetes', 4),
('D005', 'Allergic Rhinitis', 5);

INSERT INTO Insurance_Plans_has_POLICY_HOLDERS (Insurance_Plans_Plan_ID, POLICY_HOLDERS_PolicyHolder_ID)
VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5);

INSERT INTO HEALTHCARE_PROVIDERS_has_POLICY_HOLDERS (HEALTHCARE_PROVIDERS_Provider_ID, POLICY_HOLDERS_PolicyHolder_ID)
VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 5);

/* Queries *
/* Query: 1 - Count of Policy Holders Enrolled in Each Insurance Plan - We can assess the popularity and demand of various plans and use the information to decide which plans to offer and how to modify them. */
SELECT IP.Plan_ID, IP.Plan_Name, COUNT(ED.POLICY_HOLDERS_PolicyHolder_ID) AS PolicyHolderCount
FROM INSURANCE_PLANS IP
LEFT JOIN ENROLLMENT_DETAILS ED ON IP.Plan_ID = ED.Insurance_Plans_Plan_ID
GROUP BY IP.Plan_ID, IP.Plan_Name;

/*Query 2: Average Billing amount for each healthcare provider - Analysis of the performance of various healthcare providers is possible by computing the average billing amount for each provider. Higher average billing amounts from providers may be a sign that they are providingmore expensive services or handling more complicated situations. */
SELECT hp.Provider_ID, hp.Provider_Name, AVG(cd.Billing_Amount) AS AverageBillingAmount
FROM HEALTHCARE_PROVIDERS hp
JOIN CLAIMS_DETAILS cd ON hp.Provider_ID = cd.HEALTHCARE_PROVIDERS_Provider_ID
GROUP BY hp.Provider_ID, hp.Provider_Name;

/* Query 3: Retrieve the policy details of all policyholders along with their enrollment start and end dates -
 You can get a thorough understanding of the policyholders and the facts of their individual policies. 
 The coverage, expenses, and advantages of various insurance policies can be analyzed and understood using this data.*/
SELECT ph.Holder_Name, pd.Deductible, pd.CoPay, pd.OutofPocketMax, ed.Start_Date, ed.End_Date
FROM POLICY_HOLDERS ph
JOIN ENROLLMENT_DETAILS ed ON ph.PolicyHolder_ID = ed.POLICY_HOLDERS_PolicyHolder_ID
JOIN POLICY_DETAILS pd ON ed.Insurance_Plans_Plan_ID = pd.Insurance_Plans_Plan_ID;

/*Query - 4: Retrieve the policyholder names who have made payments exceeding the average billing amount - 
This data can be used by insurance companies or healthcare organizations to examine how their policyholders' payment patterns. It can reveal information about a policyholder's profitability, reveal high-paying clients, or signal potential irregularities in payment patterns. T */
SELECT ph.Holder_Name
FROM POLICY_HOLDERS ph
JOIN ENROLLMENT_DETAILS ed ON ph.PolicyHolder_ID = ed.POLICY_HOLDERS_PolicyHolder_ID
JOIN CLAIMS_DETAILS cd ON ed.POLICY_HOLDERS_PolicyHolder_ID = cd.HEALTHCARE_PROVIDERS_Provider_ID
JOIN PAYMENT_DETAILS pd ON cd.Claim_ID = pd.CLAIMS_DETAILS_Claim_ID
GROUP BY ph.Holder_Name
HAVING SUM(pd.Amount_Paid) > (SELECT AVG(cd.Billing_Amount) FROM CLAIMS_DETAILS cd);

/*Query 5 - the total billing amount for each policyholder's claims - 
Insurance companies or healthcare providers can learn more about the expenses related to specific policyholders by obtaining the total billing amount for each policyholder. */
SELECT ph.Holder_Name, SUM(cd.Billing_Amount) AS Total_Billing_Amount
FROM POLICY_HOLDERS ph
JOIN ENROLLMENT_DETAILS ed ON ph.PolicyHolder_ID = ed.POLICY_HOLDERS_PolicyHolder_ID
JOIN CLAIMS_DETAILS cd ON ed.POLICY_HOLDERS_PolicyHolder_ID = cd.HEALTHCARE_PROVIDERS_Provider_ID
GROUP BY ph.Holder_Name;

/* Query 6 - Retrieve the provider names and their corresponding policyholders' names for each claim - 
Insurance firms can manage and improve their provider networks by looking at the connections between providers and policyholders. They can spot coverage gaps, spots where there are many or few providers, and decide with knowledge whether to add or remove providers from the network. */
SELECT hp.Provider_Name, ph.Holder_Name
FROM HEALTHCARE_PROVIDERS hp
JOIN CLAIMS_DETAILS cd ON hp.Provider_ID = cd.HEALTHCARE_PROVIDERS_Provider_ID
JOIN ENROLLMENT_DETAILS ed ON cd.HEALTHCARE_PROVIDERS_Provider_ID = ed.POLICY_HOLDERS_PolicyHolder_ID
JOIN POLICY_HOLDERS ph ON ed.POLICY_HOLDERS_PolicyHolder_ID = ph.PolicyHolder_ID;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
