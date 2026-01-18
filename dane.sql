-- Updated dane.sql for consistent naming and sample data

DROP TABLE IF EXISTS lokalizacja_urzadzen;
DROP TABLE IF EXISTS urzadzenia;
DROP TABLE IF EXISTS szpitale;

CREATE TABLE szpitale (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nazwa TEXT NOT NULL UNIQUE,
    lokalizacja TEXT NOT NULL,
    opis TEXT
);

CREATE TABLE urzadzenia (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nazwa TEXT NOT NULL UNIQUE,
    kategoria TEXT NOT NULL,
    opis TEXT
);

CREATE TABLE lokalizacja_urzadzen (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    szpital_id INTEGER NOT NULL,
    urzadzenie_id INTEGER NOT NULL,
    FOREIGN KEY (szpital_id) REFERENCES szpitale(id),
    FOREIGN KEY (urzadzenie_id) REFERENCES urzadzenia(id)
);

INSERT INTO szpitale (nazwa, lokalizacja, opis) VALUES
('GUMed', 'Gdańsk', 'Centrum Kliniczne Gdańskiego Uniwersytetu Medycznego'),
('WUM', 'Warszawa', 'Centralny Szpital Kliniczny Warszawskiego Uniwersytetu Medycznego'),
('Matka Polka', 'Łódź', 'Szpital Matki Polki w Łodzi'),
('Copernicus', 'Gdańsk', 'Szpital Copernicus w Gdańsku');

INSERT INTO urzadzenia (nazwa, kategoria, opis) VALUES
('Akcelerator', 'Radioterapia', 'Nowoczesny akcelerator liniowy do radioterapii'),
('Da Vinci', 'Chirurgia', 'Robot chirurgiczny Da Vinci'),
('EKG', 'Kardiologia', 'Elektrokardiograf'),
('EUS', 'Diagnostyka', 'Endosonograf'),
('MRI', 'Diagnostyka', 'Rezonans magnetyczny'),
('RTG', 'Diagnostyka', 'Aparat rentgenowski');

INSERT INTO lokalizacja_urzadzen (szpital_id, urzadzenie_id) VALUES
(1, 1),
(1, 3),
(2, 2),
(2, 5),
(3, 4),
(4, 6);
