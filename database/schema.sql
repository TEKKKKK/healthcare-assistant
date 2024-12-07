CREATE DATABASE IF NOT EXISTS healthcare_db;
USE healthcare_db;

CREATE TABLE IF NOT EXISTS patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    medical_history TEXT,
    current_medications TEXT,
    allergies TEXT,
    last_visit DATE
);

CREATE TABLE IF NOT EXISTS medical_records (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    record_date DATE,
    diagnosis TEXT,
    treatment TEXT,
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);

CREATE TABLE IF NOT EXISTS user_profiles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    password_hash VARCHAR(255),
    role ENUM('doctor', 'nurse', 'admin'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO patients (id, first_name, last_name, date_of_birth, medical_history, current_medications, allergies, last_visit)
VALUES (1, 'John', 'Smith', '1980-05-15', 'Type 2 Diabetes, Hypertension', 'Metformin 500mg, Lisinopril 10mg', 'Penicillin', '2024-01-15');

INSERT INTO medical_records (patient_id, record_date, diagnosis, treatment, notes)
VALUES (1, '2024-01-15', 'Uncontrolled Type 2 Diabetes', 'Increased Metformin dosage to 1000mg', 'Blood sugar levels consistently high');

INSERT INTO patients (id, first_name, last_name, date_of_birth, medical_history, current_medications, allergies, last_visit)
VALUES (2, 'Sarah', 'Johnson', '1975-08-22', 'Asthma, Seasonal Allergies', 'Albuterol inhaler, Fluticasone nasal spray', 'Sulfa drugs, Pollen', '2024-02-10');

INSERT INTO medical_records (patient_id, record_date, diagnosis, treatment, notes)
VALUES (2, '2024-02-10', 'Acute Asthma Exacerbation', 'Prescribed oral corticosteroids, Continue current inhaler', 'Patient reports increased wheezing due to seasonal changes');

INSERT INTO patients (id, first_name, last_name, date_of_birth, medical_history, current_medications, allergies, last_visit)
VALUES (3, 'Michael', 'Williams', '1992-03-30', 'Migraine, Anxiety', 'Sumatriptan 50mg, Sertraline 100mg', 'None', '2024-01-28');

INSERT INTO medical_records (patient_id, record_date, diagnosis, treatment, notes)
VALUES (3, '2024-01-28', 'Chronic Migraine', 'Adjusted Sumatriptan dosage, Started preventive therapy', 'Frequency of migraines increased to 3x/week');

INSERT INTO patients (id, first_name, last_name, date_of_birth, medical_history, current_medications, allergies, last_visit)
VALUES (4, 'Emily', 'Brown', '1988-11-15', 'Hypothyroidism, Iron Deficiency', 'Levothyroxine 75mcg, Iron supplements', 'Iodine contrast', '2024-02-05');

INSERT INTO medical_records (patient_id, record_date, diagnosis, treatment, notes)
VALUES (4, '2024-02-05', 'Controlled Hypothyroidism', 'Continue current medication regimen', 'TSH levels within normal range');

INSERT INTO patients (id, first_name, last_name, date_of_birth, medical_history, current_medications, allergies, last_visit)
VALUES (5, 'David', 'Garcia', '1965-07-19', 'Coronary Artery Disease, High Cholesterol', 'Atorvastatin 40mg, Aspirin 81mg', 'Shellfish', '2024-01-20');

INSERT INTO medical_records (patient_id, record_date, diagnosis, treatment, notes)
VALUES (5, '2024-01-20', 'Stable Coronary Artery Disease', 'Continue current medications, Lifestyle modifications', 'Regular exercise program showing positive results');

INSERT INTO patients (id, first_name, last_name, date_of_birth, medical_history, current_medications, allergies, last_visit)
VALUES (6, 'Lisa', 'Martinez', '1990-09-25', 'Rheumatoid Arthritis', 'Methotrexate 15mg weekly, Folic acid', 'Latex', '2024-02-15');

INSERT INTO medical_records (patient_id, record_date, diagnosis, treatment, notes)
VALUES (6, '2024-02-15', 'Rheumatoid Arthritis Flare', 'Added prednisone taper, Continue methotrexate', 'Joint pain and swelling in hands worsened');

INSERT INTO patients (id, first_name, last_name, date_of_birth, medical_history, current_medications, allergies, last_visit)
VALUES (7, 'Robert', 'Anderson', '1972-12-08', 'GERD, Sleep Apnea', 'Omeprazole 40mg, CPAP therapy', 'Codeine', '2024-01-30');

INSERT INTO medical_records (patient_id, record_date, diagnosis, treatment, notes)
VALUES (7, '2024-01-30', 'Well-controlled GERD', 'Maintain current treatment plan', 'Significant improvement in nighttime symptoms');

INSERT INTO patients (id, first_name, last_name, date_of_birth, medical_history, current_medications, allergies, last_visit)
VALUES (8, 'Jennifer', 'Taylor', '1983-04-11', 'Depression, Chronic Back Pain', 'Duloxetine 60mg, Cyclobenzaprine 10mg', 'NSAIDs', '2024-02-08');

INSERT INTO medical_records (patient_id, record_date, diagnosis, treatment, notes)
VALUES (8, '2024-02-08', 'Improving Depression', 'Continue current medications, Physical therapy', 'Patient reports better mood and pain management');

INSERT INTO patients (id, first_name, last_name, date_of_birth, medical_history, current_medications, allergies, last_visit)
VALUES (9, 'William', 'Lee', '1970-06-03', 'Type 1 Diabetes, Hypertension', 'Insulin pump, Lisinopril 20mg', 'Adhesive tape', '2024-02-12');

INSERT INTO medical_records (patient_id, record_date, diagnosis, treatment, notes)
VALUES (9, '2024-02-12', 'Well-controlled Type 1 Diabetes', 'Adjusted insulin pump settings', 'A1C improved to 6.8%');

INSERT INTO patients (id, first_name, last_name, date_of_birth, medical_history, current_medications, allergies, last_visit)
VALUES (10, 'Maria', 'Rodriguez', '1995-01-27', 'Epilepsy, Vitamin D Deficiency', 'Levetiracetam 1000mg BID, Vitamin D3', 'None', '2024-02-01');

INSERT INTO medical_records (patient_id, record_date, diagnosis, treatment, notes)
VALUES (10, '2024-02-01', 'Controlled Epilepsy', 'Continue current anticonvulsant therapy', 'No seizures in past 6 months');

INSERT INTO patients (id, first_name, last_name, date_of_birth, medical_history, current_medications, allergies, last_visit)
VALUES (11, 'James', 'Wilson', '1968-10-14', 'Osteoarthritis, Benign Prostatic Hyperplasia', 'Acetaminophen PRN, Tamsulosin 0.4mg', 'Contrast dye', '2024-02-18');

INSERT INTO medical_records (patient_id, record_date, diagnosis, treatment, notes)
VALUES (11, '2024-02-18', 'Progressive Osteoarthritis', 'Started physical therapy, Continue current medications', 'Increased knee pain with activity');