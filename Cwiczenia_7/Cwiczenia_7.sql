--ZADANIE 1

--procedura wypisująca do konsoli ciąg Fibonnaciego
CREATE OR REPLACE FUNCTION generate_fibonacci(n INT)
RETURNS BIGINT AS $$
BEGIN
    IF n<=0 THEN
        RETURN 0;
    ELSIF n=1 THEN
        RETURN 1;
    ELSE 
        RETURN generate_fibonacci(n-1) + generate_fibonacci(n-2);
    END IF;
END;
$$ LANGUAGE plpgsql;

--generowanie ciągu
CREATE OR REPLACE FUNCTION print_fibonacci(n INT)
AS $$
DECLARE
    counter INT :=1
    fib_numer BIGINT;
BEGIN
    WHILE counter <= n LOOP
        fib_number := generate_fibonacci(counter);
        RAISE NOTICE 'Fibonacci number %: %',counter, fib_number;
        counter := counter + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

--wywolanie procedury
CALL print_fibonacci(10);



--ZADANIE 2
--trigger DML (po wprowadzeniu danych do tabeli Persons zmodyfikuje nazwisko tak, aby było napisane dużymi literami)
--2 trigger -abstrakcja, automatyzuje pewne rzeczy pozwala na wykonanie operacji pod jakimis warunkami

CREATE OR REPLACE FUNCTION uppercase_lastname()
RETURNS TRIGGER AS $$ --funckja zwraca trigger, bez triggera tej funkcji nie wykonamy
BEGIN
    NEW.lastname := UPPER(NEW.lastname); --z duzej litery zeby bylo. NEW. jako referancja
    RETURN NEW; --NEW jest tutaj triggerem
END;
$$ LANGUAGE plpgsql;

--tworzenie triggera
CREATE TRIGGER trigger_uppercase_lastname
BEFORE INSERT OR UPDATE ON person.person
FOR EACH ROW
EXECUTE FUNCTION uppercase_lastname();




--ZADANIE 3
--trigger ‘taxRateMonitoring’, który wyświetli komunikat o błędzie, jeżeli nastąpi zmiana wartości w polu ‘TaxRate’ o więcej niż 30%

CREATE OR REPLACE FUNCTION CheckTaxChange () RETURNS TRIGGER AS $$
DECLARE 
    --nowe zmienne
    oldTaxRate DECIMAL (18,2);
    newTaxRage DECIMAL (18,2);
    percenttageChange DECIMAL(5,2);
BEGIN
    oldTaxRate :=  OLD.TaxRate; --stara wartosc TaxRate
    newTaxRate := NEW.TaxRate; --nowa wartość

    --zmianna na procenty
    percentageChange := ABS((newTaxrate - oldTaxRate)/oldTaxRate) *100;

    --komunikt o bledxie >30%
    IF percentageChange > 30 THEN
    RAISE EXCEPTION 'Zmiana wartości pola TaxRate przekracze 30%%'; --dajemy %% bo sam % traktuje jak znak specjalny
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--przypisanie funkcji do triggera
CREATE TRIGGER taxRateMonitoring
BEFORE UPDATE ON sales.salestaxrate
FOR EACH ROW 
EXECUTE FUNCTION CheckTaxChange();

