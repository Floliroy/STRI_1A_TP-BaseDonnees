--Crée table Chercheur
CREATE TABLE Chercheur(
	codeCh integer PRIMARY KEY,
	nomCh text,
  	codeEq integer
);

--Crée table Laboratoire
CREATE TABLE Laboratoire(
    codeLabo integer PRIMARY KEY, 
    type text,
    nomLabo text,
    URL text,
    codeDir integer
);

--Crée table Equipe
CREATE TABLE Equipe(
    codeEq integer PRIMARY KEY, 
    nomEq text, 
    codeResp integer, 
    codeLabo integer
);

--Crée table Theme
CREATE TABLE Theme(
    codeTh integer PRIMARY KEY, 
    libelle text
);

--Crée table Definir
CREATE TABLE Definir(
    codeEq integer, 
    codeTh integer,
    PRIMARY KEY(codeEq, codeTh)
);

--Crée table Travailler
CREATE TABLE Travailler(
    codeCh integer,
    codeTh integer,
    PRIMARY KEY(codeCh, codeTh)
);

--Alter Table pour les foreign key
ALTER TABLE Chercheur 
ADD CONSTRAINT fk_equipe 
FOREIGN KEY (codeEq) REFERENCES Equipe(codeEq);

ALTER TABLE Laboratoire 
ADD CONSTRAINT fk_directeur
FOREIGN KEY (codeDir) REFERENCES Chercheur(codeCh);

ALTER TABLE Equipe 
ADD CONSTRAINT fk_responsable
FOREIGN KEY (codeResp) REFERENCES Chercheur(codeCh);

ALTER TABLE Equipe 
ADD CONSTRAINT fk_laboratoire
FOREIGN KEY (codeLabo) REFERENCES Laboratoire(codeLabo);

ALTER TABLE Definir 
ADD CONSTRAINT fkdef_equipe
FOREIGN KEY (codeEq) REFERENCES Equipe(codeEq);

ALTER TABLE Definir 
ADD CONSTRAINT fkdef_theme
FOREIGN KEY (codeTh) REFERENCES Theme(codeTh);

ALTER TABLE Travailler 
ADD CONSTRAINT fktra_chercher
FOREIGN KEY (codeCh) REFERENCES Chercheur(codeCh);

ALTER TABLE Travailler 
ADD CONSTRAINT fktra_theme
FOREIGN KEY (codeTh) REFERENCES Theme(codeTh);