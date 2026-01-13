CREATE TABLE szpitale (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    location TEXT NOT NULL
);

CREATE TABLE urzadzenia (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    category TEXT NOT NULL
);

CREATE TABLE lokalizacja_urzadzen (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    hospital_id INTEGER NOT NULL,
    equipment_id INTEGER NOT NULL,
    FOREIGN KEY (szpitale_id) REFERENCES szpitale(id),
    FOREIGN KEY (urzadzenia_id) REFERENCES urzadzenia(id)
);


INSERT INTO hospitals (name, location) VALUES 
('GUMed', 'Gdańsk'),
('WUM', 'Warszawa'),
('Matka Polka', 'Łódź'),
('St. Mary''s Hospital', 'Los Angeles, CA'),
('Healthcare Clinic', 'Seattle, WA');

-- 3. Insert Sample Data into Medical Equipment Table
INSERT INTO medical_equipment (name, category) VALUES 
('MRI Scanner', 'Imaging'),
('CT Scan Machine', 'Imaging'),
('Laparoscopic System', 'Surgical/Operating Room'),
('Surgical Robot', 'Surgical/Operating Room'),
('Cardiac Catheterization Lab', 'Cardiology'),
('Automated Chemistry Analyzer', 'Laboratory'),
('Digital X-ray Machine', 'Imaging'),
('Ultrasound Device', 'Imaging'),
('Interventional Radiology Suite', 'Radiology'),
('Electrocardiogram (ECG) Machine', 'Cardiology');

-- 4. Insert Sample Data into Equipment Locations Table
INSERT INTO equipment_locations (hospital_id,
