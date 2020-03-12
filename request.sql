--Question 1
SELECT * 
--SELECT * permet de sélectionner toutes les colonnes disponibles
FROM Chercheur;

--Question 2
SELECT nomCh, codeCh
--Ici on ne sélectionne que le nom et le code
FROM Chercheur;

--Question 3
SELECT c.nomCh, e.nomEq 
--On souhaite sélectionner le nom des Chercheurs et celui de leurs Equipes
FROM Chercheur c, Equipe e
WHERE c.codeEq = e.codeEq;
--On lie les tables à l'aide du code de l'équipe

--Question 4
SELECT c.nomCh
--On cherche seulement le nom des chercheurs présent dans l'équipe Elipse
FROM Chercheur c, Equipe e
WHERE c.codeEq = e.codeEq
--On lie les tables à l'aide du code de l'équipe
AND e.nomEq = 'Elipse';

--Question 5
ALTER TABLE Equipe 
ADD COLUMN budget integer;
--On ajoute la colonne budget et on donne des budgets aux équipes
UPDATE Equipe SET budget = 5000 WHERE codeEq = 1;
UPDATE Equipe SET budget = 8000 WHERE codeEq = 2;
UPDATE Equipe SET budget = 10000 WHERE codeEq = 3;
UPDATE Equipe SET budget = 15000 WHERE codeEq = 4;
UPDATE Equipe SET budget = 25000 WHERE codeEq = 5;
UPDATE Equipe SET budget = 500 WHERE codeEq = 6;
UPDATE Equipe SET budget = 17000 WHERE codeEq = 7;

SELECT nomEq
--On sélectionne seulement le nom des équipes
FROM Equipe
--Avec un budget entre 10.000 et 20.000
WHERE budget BETWEEN 10000 AND 20000;

--Question 6
SELECT nomEq
--On sélection le nom des équipes
FROM Equipe
--Ayant un budget supérieur
WHERE budget > (SELECT budget
                FROM Equipe
				--A celui de l'équipe Elipse
                WHERE nomEq = 'Elipse');

--Question 7
SELECT COUNT(*)
--On compte le nombre de chercheur
FROM Chercheur c, Equipe e
WHERE c.codeEq = e.codeEq
--Dans l'équipe Elipse
AND e.nomEq = 'Elipse';

--Question 8
SELECT c.nomCh, (SELECT COUNT(tr.codeTh)
				--On compte le nombre de theme
				FROM Chercheur c0, Travailler tr
				WHERE c0.codeCh = tr.codeCh
				--Pour un chercheur donné
			  	AND c0.nomCh = c.nomCh)
--On donne le nom des chercheurs et le nombre de themes sur lequel il travail
FROM Chercheur c;

--Question 9
SELECT COUNT(*)
--On compte le nombre de retour de notre deuxieme select
FROM (	SELECT COUNT(DISTINCT codeEq)
		--On sélectionne les équipes
	  	FROM Chercheur
		GROUP BY codeEq
		--Ayant au moins 5 chercheurs
		HAVING COUNT(codeCh) >= 5) dual;

--Question 10
SELECT c.nomCh, e.nomEq, t.libelle
--On sélectionne le nom du chef d'équipe, le nom de son équipe, et les themes associés
FROM Chercheur c, Equipe e, Theme t, Definir d
--On lie Equipe et Chercheur avec le code du chercheur
WHERE e.codeResp = c.codeCh
--On lie Definir et Theme avec le code du theme
AND d.codeTh = t.codeTh
--On lie Definir et Equipe avec le code Equipe
AND d.codeEq = e.codeEq;

--Question 11
SELECT DISTINCT c.nomCh
--On selectionne les noms des chercheurs
FROM Chercheur c, Travailler tr, Theme th
WHERE c.codeCh = tr.codeCh
AND th.codeTh = tr.codeTh
--Travaillant sur les themes BDD ou Langage Naturel
AND th.libelle IN ('Bases de Données', 'Langage Naturel');

--Question 12
SELECT c.nomCh
--On selectionne les noms des chercheurs
FROM Chercheur c, Travailler tr, Theme th
WHERE c.codeCh = tr.codeCh
AND th.codeTh = tr.codeTh
--Travaillant sur le theme BDD
AND th.libelle = 'Bases de Données'
EXCEPT
SELECT c.nomCh
FROM Chercheur c, Travailler tr, Theme th
WHERE c.codeCh = tr.codeCh
AND th.codeTh = tr.codeTh
--Mais pas sur le theme Langage Naturel
AND th.libelle = 'Langage Naturel';

--Question 13
SELECT c.nomCh
--On selectionne les noms des chercheurs
FROM Chercheur c, Travailler tr, Theme th
WHERE c.codeCh = tr.codeCh
AND th.codeTh = tr.codeTh
--Travaillant sur le theme BDD
AND th.libelle = 'Bases de Données'
INTERSECT
SELECT c.nomCh
FROM Chercheur c, Travailler tr, Theme th
WHERE c.codeCh = tr.codeCh
AND th.codeTh = tr.codeTh
--ET sur le theme Langage Naturel
AND th.libelle = 'Langage Naturel';

--Question 14
SELECT nomCh
--On sélectionne les noms des chercherus
FROM Chercheur 
--Qui ont le meme code d'équipe
WHERE codeEq = (SELECT codeEq
                FROM Chercheur
				--Que celui d'Hedi
                WHERE nomCh = 'Hedi')
--Mais pas Hedi lui-même
AND nomCh <> 'Hedi';

--Question 15
SELECT c.nomCh
--On selectionne les noms des chercheurs
FROM Chercheur c
--Qui travaille au moins sur les memes themes qu'Hedi
WHERE NOT EXISTS (
(SELECT t0.codeTh FROM Chercheur c0, Travailler t0 WHERE c0.codeCh = t0.codeCh AND c0.nomCh = 'Hedi'
	EXCEPT SELECT t1.codeTh FROM Chercheur c1, Travailler t1 WHERE c1.codeCh = t1.codeCh AND c1.nomCh = c.nomCh))
--Mais pas Hedi lui-même
AND c.nomCh  <> 'Hedi';

--Question 16
SELECT c.nomCh
--On selectionne les noms des chercheurs
FROM Chercheur c
--Qui travail exactement sur les memes themes qu'Hedi
WHERE NOT EXISTS (
(SELECT t0.codeTh FROM Chercheur c0, Travailler t0 WHERE c0.codeCh = t0.codeCh AND c0.nomCh = c.nomCh
	EXCEPT SELECT t1.codeTh FROM Chercheur c1, Travailler t1 WHERE c1.codeCh = t1.codeCh AND c1.nomCh = 'Hedi')
UNION ALL
(SELECT t2.codeTh FROM Chercheur c2, Travailler t2 WHERE c2.codeCh = t2.codeCh AND c2.nomCh = 'Hedi'
	EXCEPT SELECT t3.codeTh FROM Chercheur c3, Travailler t3 WHERE c3.codeCh = t3.codeCh AND c3.nomCh = c.nomCh))
--Mais pas Hedi lui-même
AND c.nomCh  <> 'Hedi';

--Question 17
SELECT c.nomCh
--On selectionne les noms des chercheurs
FROM Chercheur c
--Qui travail au plus sur les themes qu'Hedi
WHERE NOT EXISTS (
(SELECT t0.codeTh FROM Chercheur c0, Travailler t0 WHERE c0.codeCh = t0.codeCh AND c0.nomCh = 'Hedi' 
	EXCEPT SELECT t1.codeTh FROM Chercheur c1, Travailler t1 WHERE c1.codeCh = t1.codeCh AND c1.nomCh = c.nomCh)
UNION ALL
(SELECT t2.codeTh FROM Chercheur c2, Travailler t2 WHERE c2.codeCh = t2.codeCh AND c2.nomCh = c.nomCh)
	EXCEPT SELECT t3.codeTh FROM Chercheur c3, Travailler t3 WHERE c3.codeCh = t3.codeCh AND c3.nomCh = 'Hedi')
--Mais pas Hedi lui-même
AND c.nomCh  <> 'Hedi';


--Question 18
SELECT nomEq 
--On sélectionne les noms des équipes
FROM Equipe e
WHERE NOT EXISTS (
	--Qui ont comme themes
    SELECT * FROM Theme t WHERE NOT EXISTS (
		--Tous les themes existant
    	SELECT * FROM Definir d
    	WHERE d.codeEq = e.codeEq
    	AND d.codeTh = t.codeTh
	)
);

--Question 19
CREATE TABLE Publication(
	codePub integer PRIMARY KEY,
	nomPub text,
	typePub text,
  	codeAut integer
);
--On ajoute la table Publication, chaque publication a un seul auteur
ALTER TABLE Publication 
ADD CONSTRAINT fk_publication
FOREIGN KEY (codeAut) REFERENCES Chercheur(codeCh);
--On y ajoute les publications demandées
INSERT INTO Publication(codePub, nomPub, typePub, codeAut) VALUES
	(1, 'Formes Normales dans les BD objets', 'thèse', 5),
	(2, 'Vers un nouveau langage pour les non voyants', 'article', 5),
	(3, 'Alimenter des ontologies par les textes', 'thèse', 20);

SELECT nomCh
--On sélectionne les noms des Chercheurs
FROM Chercheur
--N'ayant aucune publication
WHERE codeCh NOT IN (
	SELECT codeAut
	FROM Publication 
);

--Question 20
SELECT DISTINCT c.nomCh,
--On sélectionne les noms des chercheurs
--Et leur nombre d'articles publiés
	(SELECT COUNT(*)
	--On sélectionne le nombre d'article pour un chercheur donné
	FROM Publication
	WHERE codeAut = c.codeCh)
FROM Chercheur c, Publication p
--On ne sélectionne que les chercheurs ayant deja publié
WHERE c.codeCh = p.codeAut;