DELIMITER $$

CREATE PROCEDURE dodaj_firmu(
    IN p_pib CHAR(9),       
    IN p_naziv VARCHAR(100),    
    IN p_adresa VARCHAR(100),    
    IN p_telefon VARCHAR(20),   
    IN p_mail VARCHAR(50)
)
BEGIN

    INSERT INTO FIRMA (pib, naziv, adresa, telefon,mail)
    VALUES (p_pib, p_naziv, p_adresa, p_telefon,p_mail);
END $$

DELIMITER ;
