--1)
CREATE DATABASE firma;


--2)
CREATE SCHEMA ksiegowosc;


--3)
CREATE TABLE ksiegowosc.pracownicy 
(
	id_pracownika INT PRIMARY KEY,
	imie VARCHAR(20) NOT NULL,
	nazwisko VARCHAR(20) NOT NULL,
	adres VARCHAR(100) NOT NULL,
	telefon VARCHAR(15)  
);
COMMENT ON TABLE ksiegowosc.pracownicy IS 'Tabela przechowująca informacje o pracownikach';


CREATE TABLE ksiegowosc.godziny 
(
	id_godziny INT PRIMARY KEY,
	data DATE NOT NULL,
	liczba_godzin DECIMAL(5, 2) NOT NULL,
	id_pracownika INT NOT NULL
);
COMMENT ON TABLE ksiegowosc.godziny IS 'Tabela przechowująca informacje o godzinach przepracowanych przez pracowników';


CREATE TABLE ksiegowosc.pensja 
(
	id_pensji INT PRIMARY KEY,
	stanowisko VARCHAR(30) NOT NULL,
	kwota DECIMAL(10, 2) NOT NULL
);
COMMENT ON TABLE ksiegowosc.pensja IS 'Tabela przechowująca informacje o pensjach pracowników';


CREATE TABLE ksiegowosc.premia 
(
	id_premii INT PRIMARY KEY,
	rodzaj VARCHAR(30) NOT NULL,
	kwota DECIMAL(10, 2) NOT NULL
);
COMMENT ON TABLE ksiegowosc.premia IS 'Tabela przechowująca informacje o premiach';


CREATE TABLE ksiegowosc.wynagrodzenie
(
    id_wynagrodzenia INT PRIMARY KEY,
    data DATE NOT NULL, 
    id_pracownika INT NOT NULL,  
    id_pensji INT NOT NULL, 
    id_premii INT
);
COMMENT ON TABLE ksiegowosc.wynagrodzenie IS 'Tabela przechowująca informacje o wynagrodzeniach pracowników';



--FOREIGN KEYS
ALTER TABLE ksiegowosc.godziny 
ADD FOREIGN KEY (id_pracownika)
REFERENCES ksiegowosc.pracownicy(id_pracownika);

ALTER TABLE ksiegowosc.wynagrodzenie 
ADD FOREIGN KEY (id_pracownika)
REFERENCES ksiegowosc.pracownicy(id_pracownika);

ALTER TABLE ksiegowosc.wynagrodzenie 
ADD FOREIGN KEY (id_pensji)
REFERENCES ksiegowosc.pensja(id_pensji);

ALTER TABLE ksiegowosc.wynagrodzenie 
ADD FOREIGN KEY (id_premii)
REFERENCES ksiegowosc.premia(id_premii);



--4)
INSERT INTO ksiegowosc.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
VALUES
(1, 'Bella', 'Ćwir', 'ul.Wolska 69, Kraków', '889 420 113'),
(2, 'Agata', 'Zadecka', 'ul. Podzamcze 134, Zamość', '420 655 798'),
(3, 'Alicja', 'Martin', 'ul. Narutowicza 98, Kraków', '977 908 409'),
(4, 'Jan', 'Wróbel', 'ul.Kilińskiego 2, Wrocław', '223 445 667'),
(5, 'Borys', 'Naleśnik', 'ul.Kolejowa 56, Kraków', '168 936 746'),
(6, 'Eliza', 'Nowa', 'ul.Polna 3, Kraków', '446 746 938'),
(7, 'Ireneusz', 'Belina', 'ul.Przemysłowa 7, Warszawa', '988 762 220'),
(8, 'Julia', 'Landgrab', 'ul. Górna 807, Kraków', '969 702 654'),
(9, 'Pelagia', 'Kowal', 'ul.Wodna 66a, Siedlce', '390 236 380'),
(10, 'Wiktor', 'Feng', 'ul.Piłsudkiego 24, Łódź', '213 721 150');


INSERT INTO ksiegowosc.godziny (id_godziny, data, liczba_godzin, id_pracownika)
VALUES
(1, '2022-10-12', 170, 1),
(2, '2022-10-13', 150, 2),
(3, '2022-10-14', 100, 3),
(4, '2022-10-15', 190, 4),
(5, '2022-10-16', 130, 5),
(6, '2022-10-17', 200, 6),
(7, '2022-10-18', 180, 7),
(8, '2022-10-19', 150, 8),
(9, '2022-10-20', 170, 9),
(10, '2022-10-21', 100, 10);


INSERT INTO ksiegowosc.premia (id_premii, rodzaj, kwota)
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


INSERT INTO ksiegowosc.pensja ( id_pensji, stanowisko, kwota)
VALUES 
(11,'kierownik', 9000),
(8, 'monter', 1900),
(55, 'księgowa', 2200),
(5, 'konserwator', 1000),
(9, 'kierowca', 6900),
(17, 'dyrektor', 13000),
(2, 'manager', 9900),
(6, 'kierownik', 7800),
(12, 'inżynier', 9200),
(7, 'technik', 6900);

INSERT INTO ksiegowosc.wynagrodzenie (id_wynagrodzenia, data, id_pracownika, id_pensji, id_premii)
VALUES
(1,'2022-11-01',1,11,1),
(2,'2022-11-02',2,8,1),
(3,'2022-11-03',3,55,10),
(4,'2022-11-04',4,12,NULL),
(5,'2022-11-05',5,7,6),
(6,'2022-11-06',6,7,NULL),
(7,'2022-11-07',7,6,9),
(8,'2022-11-10',8,17,4),
(9,'2022-11-06',9,2,5),
(10,'2022-11-20',10,9,10);


--5)

--a) Wyświetl tylko id pracownika oraz jego nazwisko
SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;

--b) Wyświetl id pracowników, których płaca jest większa niż 1000
SELECT ksiegowosc.pracownicy.id_pracownika
FROM ksiegowosc.pracownicy 
JOIN ksiegowosc.wynagrodzenie ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
WHERE ksiegowosc.pensja.kwota > 1000;

--c) Wyświetl id pracowników nieposiadających premii, których płaca jest większa niż 2000
SELECT ksiegowosc.pracownicy.id_pracownika
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
JOIN ksiegowosc.pensja ON ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
WHERE ksiegowosc.pensja.kwota >2000 AND ksiegowosc.wynagrodzenie.id_premii IS NULL;

--d) Wyświetl pracowników, których pierwsza litera imienia zaczyna się na literę ‘J’
SELECT * FROM ksiegowosc.pracownicy WHERE imie LIKE 'J%';

--e) Wyświetl pracowników, których nazwisko zawiera literę ‘n’ oraz imię kończy się na literę ‘a’.
SELECT * FROM ksiegowosc.pracownicy WHERE nazwisko LIKE '%n%' AND imie LIKE '%a';

--f) Wyświetl imię i nazwisko pracowników oraz liczbę ich nadgodzin, przyjmując,standardowy czas pracy to 160 h miesięcznie
SELECT p.imie, p.nazwisko, (SUM(g.liczba_godzin) - 160) AS nadgodziny
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.godziny g ON p.id_pracownika = g.id_pracownika
GROUP BY p.imie, p.nazwisko;


--g) Wyświetl imię i nazwisko pracowników, których pensja zawiera się w przedziale 1500 – 3000 PLN
SELECT ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko 
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
WHERE ksiegowosc.pensja.kwota BETWEEN 1500 AND 3000


--h) Wyświetl imię i nazwisko pracowników, którzy pracowali w nadgodzinach i nie otrzymali premii. 
SELECT ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko 
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
--LEFT JOIN ksiegowosc.premia ON ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premia.id_premii  --LEFT zeby wyswietlalo NULL
JOIN ksiegowosc.godziny ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.godziny.id_pracownika
WHERE ksiegowosc.wynagrodzenie.id_premii IS NULL AND ksiegowosc.godziny.liczba_godzin > 160;

--i) Uszereguj pracowników według pensji.
SELECT ksiegowosc.pracownicy.*
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
ORDER BY ksiegowosc.pensja.kwota ASC;

--j) Uszereguj pracowników według pensji i premii malejąco
SELECT ksiegowosc.pracownicy.*
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
LEFT JOIN ksiegowosc.premia ON ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premia.id_premii
ORDER BY ksiegowosc.pensja.kwota DESC AND ksiegowosc.premia.kwota DESC;

--k) Zlicz i pogrupuj pracowników według pola ‘stanowisko’. 
SELECT stanowisko, COUNT(*) AS liczba_pracownikow
FROM ksiegowosc.pensja
GROUP BY stanowisko;

--l) Policz średnią, minimalną i maksymalną płacę dla stanowiska ‘kierownik’ (jeżeli takiego nie masz, to przyjmij dowolne inne). 
SELECT
    AVG(kwota) AS srednia_pensja,
    MIN(kwota) AS minimalna_pensja,
    MAX(kwota) AS maksymalna_pensja
FROM ksiegowosc.pensja
WHERE stanowisko = 'kierownik';

--m) Policz sumę wszystkich wynagrodzeń
SELECT SUM (ksiegowosc.pensja.kwota + ksiegowosc.premia.kwota) AS suma_wynagrodzen
FROM ksiegowosc.pensja, ksiegowosc.premia

--n) Policz sumę wynagrodzeń w ramach danego stanowiska.
SELECT stanowisko, SUM(ksiegowosc.pensja.kwota + ksiegowosc.premia.kwota) AS suma_wynagrodzen_stanowisko
FROM ksiegowosc.pensja, ksiegowosc.premia
GROUP BY stanowisko;
 
--o) Wyznacz liczbę premii przyznanych dla pracowników danego stanowiska.
SELECT stanowisko, COUNT(ksiegowosc.wynagrodzenie.id_premii) AS liczba_premii
FROM ksiegowosc.wynagrodzenie 
JOIN ksiegowosc.pensja  ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
GROUP BY stanowisko;

--p) Usuń wszystkich pracowników mających pensję mniejszą niż 1200 zł
DELETE FROM ksiegowosc.pracownicy
WHERE id_pracownika IN (
    SELECT p.id_pracownika
    FROM ksiegowosc.pracownicy p
    JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
    JOIN ksiegowosc.pensja pe ON w.id_pensji = pe.id_pensji
    WHERE pe.kwota < 1200
);
