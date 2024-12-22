DELIMITER $$

CREATE PROCEDURE DODAJ_PROIZVOD(
    IN p_sifra CHAR(6),
    IN p_naziv VARCHAR(100),
    IN p_cena DECIMAL(18, 4),
    IN p_JM VARCHAR(3)  -- promenjeno na VARCHAR(3)
)
BEGIN
    INSERT INTO PROIZVOD (sifra, naziv, cena, JM)
    VALUES (p_sifra, p_naziv, p_cena, p_JM);
END $$

DELIMITER ;
