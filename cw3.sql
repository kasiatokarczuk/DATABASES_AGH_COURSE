CREATE DATABASE firma;

CREATE SCHEMA rozliczenia;


CREATE TABLE rozliczenia.pracownicy 
(
	id_pracownika INT PRIMARY KEY,
	imie VARCHAR(20) NOT NULL,
	nazwisko VARCHAR(20) NOT NULL,
	adres VARCHAR(150) NOT NULL,
	telefon VARCHAR(15) NOT NULL
);

CREATE TABLE rozliczenia.godziny 
(
	id_godziny INT PRIMARY KEY,
	data DATE,
	liczba_godzin DECIMAL(10, 2) NOT NULL,
	id_pracownika INT,
	FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika)
);


CREATE TABLE rozliczenia.pensje 
(
	id_pensje INT PRIMARY KEY,
	stanowisko VARCHAR(30) NOT NULL,
	kwota DECIMAL(10, 2),
	id_premii INT,
	FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie (id_premii)
);

CREATE TABLE rozliczenia.premie 
(
	id_premii INT PRIMARY KEY,
	rodzaj VARCHAR(30) NOT NULL,
	kwota DECIMAL(100, 2) NOT NULL
);




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
(1, '2022-10-12', 160, 3),
(2, '2022-10-13', 80, 4),
(3, '2022-10-14', 90, 5),
(4, '2022-10-15', 190, 6),
(5, '2022-10-16', 130, 7),
(6, '2022-10-17', 95, 8),
(7, '2022-10-18', 90, 9),
(8, '2022-10-19', 150, 10),
(9, '2022-10-20', 80, 1),
(10, '2022-10-21', 100, 2);


INSERT INTO rozliczenia.pensje(
	id_pensje, stanowisko, kwota, id_premii)
	VALUES 
	(11,'kierownik', 9000, 20),
	(8, 'monter', 4900, 9),
	(55, 'księgowa', 5500, 11),
	(5, 'konserwator', 5200, 4),
	(9, 'kierowca', 6900, 81),
	(17, 'dyrektor', 13000, 3),
	(2, 'manager', 9900, 14),
	(6, 'specjalista', 7800, 17),
	(12, 'inżynier', 9200, 8),
	(7, 'technik', 6900, 22);



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


SELECT nazwisko, adres FROM rozliczenia.pracownicy;

SELECT
    id_godziny,
    EXTRACT(DAY FROM data) AS dzien_tygodnia,
    EXTRACT(MONTH FROM data) AS miesiac
FROM rozliczenia.godziny;

ALTER TABLE rozliczenia.pensje
    RENAME COLUMN kwota TO kwota_brutto;

ALTER TABLE rozliczenia.pensje
    ADD COLUMN kwota_netto DECIMAL(10, 2);

UPDATE rozliczenia.pensje
SET kwota_netto = kwota_brutto * 0.8;
SELECT * FROM rozliczenia.pensje