--Question 1
SELECT *
FROM Chercheur;

--Question 2
SELECT nomCh, codeCh
FROM Chercheur;

--Question 3
SELECT c.nomCh, e.nomEq 
FROM Chercheur c, Equipe e
WHERE c.codeEq = e.codeEq;

--Question 4
SELECT c.nomCh
FROM Chercheur c, Equipe e
WHERE c.codeEq = e.codeEq
AND e.nomEq = 'Elipse';

--Ajout Colone
ALTER TABLE Equipe 
ADD COLUMN budget integer;
UPDATE Equipe SET budget = 5000 WHERE codeEq = 1;
UPDATE Equipe SET budget = 8000 WHERE codeEq = 2;
UPDATE Equipe SET budget = 10000 WHERE codeEq = 3;
UPDATE Equipe SET budget = 15000 WHERE codeEq = 4;
UPDATE Equipe SET budget = 25000 WHERE codeEq = 5;
UPDATE Equipe SET budget = 500 WHERE codeEq = 6;
UPDATE Equipe SET budget = 17000 WHERE codeEq = 7;

--Question 5
SELECT nomEq
FROM Equipe
WHERE budget BETWEEN 10000 AND 20000;

--Question 6
SELECT nomEq
FROM Equipe
WHERE budget > (SELECT budget
                FROM Equipe
                WHERE nomEq = 'Elipse');

--Question 7
SELECT COUNT(*)
FROM Chercheur c, Equipe e
WHERE c.codeEq = e.codeEq 
AND e.nomEq = 'Elipse';

--Question 8
SELECT c.nomCh, (SELECT COUNT(tr.codeTh)
				FROM Chercheur c0, Travailler tr
				WHERE c0.codeCh = tr.codeCh
			  	AND c0.nomCh = c.nomCh)
FROM Chercheur c;

--Question 9
SELECT COUNT(*)
FROM (	SELECT COUNT(DISTINCT codeEq)
	  	FROM Chercheur
		GROUP BY codeEq
		HAVING COUNT(codeCh) > 5) dual;

--Question 10
SELECT c.nomCh, e.nomEq, t.libelle
FROM Chercheur c, Equipe e, Theme t, Definir d
WHERE e.codeResp = c.codeCh
AND d.codeTh = t.codeTh
AND d.codeEq = e.codeEq;

--Question 11
SELECT DISTINCT c.nomCh
FROM Chercheur c, Travailler tr, Theme th
WHERE c.codeCh = tr.codeCh
AND th.codeTh = tr.codeTh
AND th.libelle IN ('Bases de Données', 'Langage Naturel');

--Question 12
SELECT c.nomCh
FROM Chercheur c, Travailler tr, Theme th
WHERE c.codeCh = tr.codeCh
AND th.codeTh = tr.codeTh
AND th.libelle = 'Bases de Données'
EXCEPT
SELECT c.nomCh
FROM Chercheur c, Travailler tr, Theme th
WHERE c.codeCh = tr.codeCh
AND th.codeTh = tr.codeTh
AND th.libelle = 'Langage Naturel';

--Question 13
SELECT c.nomCh
FROM Chercheur c, Travailler tr, Theme th
WHERE c.codeCh = tr.codeCh
AND th.codeTh = tr.codeTh
AND th.libelle = 'Bases de Données'
INTERSECT
SELECT c.nomCh
FROM Chercheur c, Travailler tr, Theme th
WHERE c.codeCh = tr.codeCh
AND th.codeTh = tr.codeTh
AND th.libelle = 'Langage Naturel';

--Question 14
SELECT nomCh
FROM Chercheur 
WHERE codeEq = (SELECT codeEq
                FROM Chercheur
                WHERE nomCh = 'Hedi')
AND nomCh <> 'Hedi';