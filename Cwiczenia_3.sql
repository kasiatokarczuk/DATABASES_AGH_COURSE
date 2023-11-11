--1)
CREATE DATABASE firma;

--2)
CREATE SCHEMA rozliczenia;

--3)
CREATE TABLE rozliczenia.pracownicy 
(
	id_pracownika INT PRIMARY KEY,
	imie VARCHAR(20) NOT NULL,
	nazwisko VARCHAR(20) NOT NULL,
	adres VARCHAR(100) NOT NULL,
	telefon VARCHAR(15) 
);

CREATE TABLE rozliczenia.godziny 
(
	id_godziny INT PRIMARY KEY,
	data DATE NOT NULL,
	liczba_godzin DECIMAL(5, 2) NOT NULL,
	id_pracownika INT NOT NULL
);


CREATE TABLE rozliczenia.pensje 
(
	id_pensji INT PRIMARY KEY,
	stanowisko VARCHAR(30) NOT NULL,
	kwota DECIMAL(10, 2) NOT NULL,
	id_premii INT
);

CREATE TABLE rozliczenia.premie 
(
	id_premii INT PRIMARY KEY,
	rodzaj VARCHAR(30) NOT NULL,
	kwota DECIMAL(10, 2) NOT NULL
);

ALTER TABLE rozliczenia.pensje 
ADD FOREIGN KEY (id_premii)
REFERENCES rozliczenia.premie(id_premii);

ALTER TABLE rozliczenia.godziny 
ADD FOREIGN KEY (id_pracownika)
REFERENCES rozliczenia.pracownicy(id_pracownika);





--4)
INSERT INTO rozliczenia.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
VALUES
(1, 'Bella', 'Ćwir', 'ul.Wolska 69, Kraków', '889 420 113'),
(2, 'Agata', 'Zadecka', 'ul. Podzamcze 134, Zamość', '420 655 798'),
(3, 'Alicja', 'Martin', 'ul. Narutowicza 98, Kraków', '977 908 409'),
(4, 'Antoni', 'Wróbel', 'ul.Kilińskiego 2, Wrocław', '223 445 667'),
(5, 'Borys', 'Naleśnik', 'ul.Kolejowa 56, Kraków', '168 936 746'),
(6, 'Eliza', 'Cegła', 'ul.Polna 3, Kraków', '446 746 938'),
(7, 'Ireneusz', 'Belina', 'ul.Przemysłowa 7, Warszawa', '988 762 220'),
(8, 'Julia', 'Landgrab', 'ul. Górna 807, Kraków', '969 702 654'),
(9, 'Pelagia', 'Kowal', 'ul.Wodna 66a, Siedlce', '390 236 380'),
(10, 'Wiktor', 'Feng', 'ul.Piłsudkiego 24, Łódź', '213 721 150');


INSERT INTO rozliczenia.godziny (id_godziny, data, liczba_godzin, id_pracownika)
VALUES
(1, '2022-10-12', 160, 1),
(2, '2022-10-13', 80, 2),
(3, '2022-10-14', 90, 3),
(4, '2022-10-15', 190, 4),
(5, '2022-10-16', 130, 5),
(6, '2022-10-17', 95, 6),
(7, '2022-10-18', 90, 7),
(8, '2022-10-19', 150, 8),
(9, '2022-10-20', 80, 9),
(10, '2022-10-21', 100, 10);


INSERT INTO rozliczenia.premie (id_premii, rodzaj, kwota)
VALUES
(1, 'motywacyjna', 500),
(2, 'frekwencja', 700),
(3, 'motywacyjna', 400),
(4, 'uznaniowa', 1000),
(5, 'regulaminowa', 450),
(6, 'regulaminowa', 600),
(7, 'regulaminowa', 300),
(8, 'za frekwencje', 600),
(9, 'motywacyjna', 800),
(10, 'regulaminowa', 950);


INSERT INTO rozliczenia.pensje( id_pensji, stanowisko, kwota, id_premii)
VALUES 
(11,'kierownik', 9000, 1),
(8, 'monter', 4900, 2),
(55, 'księgowa', 5500, 3),
(5, 'konserwator', 5200, 4),
(9, 'kierowca', 6900, 5),
(17, 'dyrektor', 13000, 6),
(2, 'manager', 9900, 7),
(6, 'specjalista', 7800, 8),
(12, 'inżynier', 9200, 9),
(7, 'technik', 6900, 10);



--5)
SELECT nazwisko, adres FROM rozliczenia.pracownicy;

--6)
SELECT
    id_godziny,
    EXTRACT(DAY FROM data) AS dzien_tygodnia,
    EXTRACT(MONTH FROM data) AS miesiac
FROM rozliczenia.godziny;

--7)
ALTER TABLE rozliczenia.pensje
    RENAME COLUMN kwota TO kwota_brutto;

ALTER TABLE rozliczenia.pensje
    ADD COLUMN kwota_netto DECIMAL(10, 2);

UPDATE rozliczenia.pensje
SET kwota_netto = kwota_brutto / 1.23;
