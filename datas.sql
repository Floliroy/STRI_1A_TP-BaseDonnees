ALTER TABLE Chercheur DISABLE TRIGGER ALL;
ALTER TABLE Laboratoire DISABLE TRIGGER ALL;
ALTER TABLE Equipe DISABLE TRIGGER ALL;
ALTER TABLE Theme DISABLE TRIGGER ALL;
ALTER TABLE Definir DISABLE TRIGGER ALL;
ALTER TABLE Travailler DISABLE TRIGGER ALL;

INSERT INTO Chercheur(codeCh, nomCh, codeEq) VALUES
    (1, 'Terrier', 1),
    (2, 'Issalis', 1),
    (3, 'Gallo', 1),
    (4, 'Hedi', 2),
    (5, 'Eddy', 2),
    (6, 'Broise', 2),
    (7, 'Palma', 2),
    (8, 'Lourdel', 3),
    (9, 'Achibane', 3),
    (10, 'Val', 4),
    (11, 'Cambon', 4),
    (12, 'Acila', 4),
    (13, 'Aoun', 1),
    (14, 'Galy', 1),
    (15, 'Tartarin', 1),
    (16, 'Marty-Dessus', 5),
    (17, 'Einstein', 5),
    (18, 'Rousseau', 6),
    (19, 'Heimer', 7),
    (20, 'Gnar', 7);

INSERT INTO Laboratoire(codeLabo, type, nomLabo, URL, codeDir) VALUES
    (1, 'INRIA', 'Atomic', '', 2),
    (2, 'Universitaire', 'IRIT', '', 13),
    (3, 'CNRS', 'LAAS', '', 1);

INSERT INTO Equipe(codeEq, nomEq, codeResp, codeLabo) VALUES
    (1, 'Bacterie', 3, 1),
    (2, 'Virus', 6, 1),
    (3, 'Elipse', 8, 1),
    (4, 'Onde', 12, 3),
    (5, 'Satellite', 16, 2),
    (6, 'Genetique', 18, 3),
    (7, 'Laser', 20, 2);

INSERT INTO Theme(codeTh, libelle) VALUES
    (1, 'Radioactif'),
    (2, 'Onde Progressive'),
    (3, 'Effusion'),
    (4, 'Reaction'),
    (5, 'Développement Durable'),
    (6, 'Enseignement'),
    (7, 'Langage Naturel'),
    (8, 'Bases de Données');

INSERT INTO Definir(codeEq, codeTh) VALUES
    (1,4),
    (2,3),
    (3,1),
    (3,5),
    (4,2),
    (5,7),
    (5,8),
    (6,6),
    (7,8);

INSERT INTO Travailler(codeCh, codeTh) VALUES
    (1,4),
    (2,4),
    (3,4),
    (4,3),
    (5,3),
    (6,3),
    (7,3),
    (8,1),
    (8,5),
    (9,1),
    (9,5),
    (10,2),
    (11,2),
    (12,2),
    (13,4),
    (14,4),
    (15,4),
    (16,7),
    (16,8),
    (17,7),
    (17,8),
    (18,6),
    (19,8),
    (20,8);

ALTER TABLE Chercheur ENABLE TRIGGER ALL;
ALTER TABLE Laboratoire ENABLE TRIGGER ALL;
ALTER TABLE Equipe ENABLE TRIGGER ALL;
ALTER TABLE Theme ENABLE TRIGGER ALL;
ALTER TABLE Definir ENABLE TRIGGER ALL;
ALTER TABLE Travailler ENABLE TRIGGER ALL;