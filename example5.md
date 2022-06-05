---
title: "Βάσεις Δεδομένων - Εξαμηνιαία
  Εργασία[\\[fig\\]](#fig){reference-type=\"ref\" reference=\"fig\"}"
---

::: center
![image](NTUA_Logo.jpg){#fig}[\[fig\]]{#fig label="fig"}
:::

::: center
  -------------- ---------------------------- ---------------------------- ----------------------------
  Όνομα          Χαράλαμπος                   Γεώργιος-Λουκάς              Γεώργιος

  Επίθετο        Μπεκιάρης                    Υγρόπουλος                   Μπελιώτης

  Σχολή          ΕΜΦΕ                         ΕΜΦΕ                         ΗΜΜΥ

  Αριθμός        $ge$`<!-- -->`{=html}18088   $ge$`<!-- -->`{=html}18801   $el$`<!-- -->`{=html}19139
  Μητρώου                                                                  

  $email$        $ge18088@mail.ntua.gr$       $ge18801@mail.ntua.gr$       $georgebel@hotmail.gr$

  Εξάμηνο        $^{\text{ο}}$                $^{\text{ο}}$                $^{\text{ο}}$
  -------------- ---------------------------- ---------------------------- ----------------------------
:::

# Προαπαιτούμενα της εφαρμογής

Για να τρέξετε την εφαρμογή, θα χρειαστείτε να έχετε εγκατεστημένα στο
σύστημά σας:

-   Μία βάση δεδομένων [Mariadb]{lang="en-"}.

-   Έναν [dbms]{lang="en-"} [client]{lang="en-"}, εμείς επιλέξαμε το
    [phpmyadmin]{lang="en-"}.

Για το [server-side]{lang="en-"} της εφαρμογής, επιλέξαμε να
χρησιμοποιήσουμε το πακέτο [flask]{lang="en-"} της [python]{lang="en-"},
ενώ για την σύνδεση της βάσης με την [python]{lang="en-"}, το πακέτο
[flask-mysqldb]{lang="en-"}.

Εάν δεν έχετε κάποιο από τα παραπάνω υπάρχουν σχετικές οδηγίες παρακάτω.

## Εγκατάσταση της βάσης σε περιβάλλον [linux]{lang="en-"} μέσω [docker]{lang="en-"}

Αρχικά πρέπει να εγκατασταθεί το [docker]{lang="en-"} στο σύστημά σας,
επομένως ανάλογα την διανομή ακολουθείτε τις οδηγίες που βρίσκονται στην
επίσημη ιστοσελίδα του [docker]{lang="en-"}, κάνοντας κλικ
[εδώ](https://docs.docker.com/engine/install/). Εν συνεχεία, αν δεν
τρέχει ήδη το [docker]{lang="en-"}, πληκτρολογήστε την εντολή:

``` {.bash breaklines="true"}
> sudo systemctl start docker
```

Για να εγκαταστήσετε την τελευταία διαθέσιμη έκδοση του
[Mariadb]{lang="en-"} στο [docker]{lang="en-"}, θα πρέπει να τρέξετε την
ακόλουθη εντολή:

``` {.bash breaklines="true"}
> sudo docker run --name ntua-mariadb -d -e  MYSQL_ROOT_PASSWORD=examplepass mariadb
```

Η παραπάνω εντολή θα εγκαταστήσει το ζητούμενο σε ένα
[container]{lang="en-"} με το όνομα [ntua-mariadb]{lang="en-"}, και ως
κωδικό της βάσης [examplepass]{lang="en-"}. Φυσικά μπορείτε να
χρησιμοποιήσετε ότι κωδικό θέλετε ή να ονομάσετε όπως αλλιώς θέλετε το
[container]{lang="en-"}. Κατά σύμβαση από εδώ και στο εξής οτιδήποτε
σχετικό με το [Mariadb]{lang="en-"}, όπως ο κωδικός, και το όνομα του εν
λόγω [container]{lang="en-"} θα γίνονται οι αναφορές όπως είναι στην
παραπάνω εντολή.

Ακολούθως, πρέπει να εγκατασταθεί το [phpmyadmin]{lang="en-"}:

``` {.bash breaklines="true"}
> sudo docker run --name ntua-phpmyadmin -d -p 8080:80  -e PMA_HOST=ntua-mariadb phpmyadmin
```

Στην παραπάνω εντολή το [phpmyadmin]{lang="en-"} θα εγκατασταθεί σε ένα
[container]{lang="en-"} ονόματι []{lang="en-"}
[ntua-phpmyadmin]{lang="en-"}. Δίνουμε ως [argument]{lang="en-"} στην
παραπάνω εντολή το όνομα του [container]{lang="en-"} στο οποίο τρέχει
το[ Mariadb]{lang="en-"}.

Τέλος, προκειμένου να επικοινωνούν σωστά τα παραπάνω
[container]{lang="en-"}, και να μπορεί ο χρήστης να αλληλεπιδράσει με
αυτά θα πρέπει να δημιουργηθεί στο [docker]{lang="en-"} ένα
[network]{lang="en-"} στο οποία θα συνδεθούν τα
[containers]{lang="en-"}:

``` {.bash numbers="right" fontsize="\\small" breaklines="true"}
> sudo docker network create ntua-network
> sudo docker network connect ntua-network ntua-mariadb
> sudo docker network connect ntua-network ntua-phpmyadmin
```

Το δίκτυο που δημιουργείται με τις παραπάνω εντολές έχει όνομα
[ntua-network]{lang="en-"}.

Για να δείτε εάν τρέχουν τα [container]{lang="en-"} τρέξτε την παρακάτω
εντολή:

``` {.bash breaklines="true"}
> sudo docker ps -a
```

Εάν δεν τρέχουν τότε μπορείτε να τα εκκινήσετε τρέχοντας την παρακάτω
εντολή:

``` {.bash breaklines="true"}
> sudo docker start ntua-mariadb
> sudo docker start ntua-phpmyadmin
```

To [phpmyadmin]{lang="en-"} είναι προσβάσιμο από την διεύθυνση
[localhost]{lang="en-"}:8080 και θα σας ζητηθούν τα στοιχεία για την
σύνδεση στην βάση:

``` {.bash breaklines="true"}
username: root
password: examplepass
```

## Εγκατάσταση των πακέτων της [python]{lang="en-"}

Η εφαρμογή μας και τα πακέτα που χρειάζεται, τρέχουν στην
[python3]{lang="en-"}, η οποία βρίσκεται προεγκατεστημένη στις
περισσότερες σύγχρονες διανομές του [linux]{lang="en-"}, όπως το
[Fedora]{lang="en-"}. Tα πακέτα της [Python]{lang="en-"} που θα
χρειαστείτε μπορείτε να τα αποκτήσετε μέσω [pip]{lang="en-"}:

``` {.bash breaklines="true"}
> pip install flask flask_mysqldb
```

Αν δεν έχετε το [pip]{lang="en-"} διαθέσιμο στον υπολογιστή σας
συμβουλευτείτε τις οδηγίες της διανομής σας για να αποκτήσετε την έκδοση
που είναι συμβατή με την [python3]{lang="en-"}.

# Εγκατάσταση της εφαρμογής

Ανοίξτε το [phpmyadmin]{lang="en-"} και κατεβάστε από το
[github]{lang="en-"} [repo]{lang="en-"}
([<https://github.com/J0K3RAS/project92_db_2022>]{lang="en-"}) τα αρχεία
[ddl]{lang="en-"} και [dml]{lang="en-"}. Σιγουρευτείτε ότι βρίσκεστε
στην αρχική σελίδα του [phpmyadmin]{lang="en-"} ([home]{lang="en-"} )
και πως δεν υπάρχει άλλη βάση με το όνομα [project92]{lang="en-"}.

## Εισαγωγή του [ddl]{lang="en-"} αρχείου

Το αρχείο [ddl]{lang="en-"} θα δημιουργήσει μια νέα βάση με το όνομα
[project92]{lang="en-"}, και θα ορίσει όλους τους πίνακες
([entities]{lang="en-"} & [relations]{lang="en-"}) της βάσης, καθώς και
τα [views]{lang="en-"}. Ακολουθώντας τα παρακάτω βήματα μπορείτε να
εισάγεται το εν λόγω αρχείο στην βάση:

::: enumerate
Από την αρχική σελίδα του [phpmyadmin]{lang="en-"} επιλέξτε το κουμπί
[**Import**]{lang="en-"} στο πάνω [menu]{lang="en-"}.

![image](\string"screenshots/dml ddl/screeen1\string".png)

Στην σελίδα που μας ανοίγει, πρέπει να επιλέξετε για
[import]{lang="en-"} κάποιο από τα διαθέσιμα στον υπολογιστή σας.
Πατήστε [Choose Files]{lang="en-"} και επιλέξτε το [ddl]{lang="en-"}
αρχείο μας, [project92_ddl.sql]{lang="en-"}. Οι υπόλοιπες επιλογές
μπορούν να μείνουν ως έχουν, δηλαδή:

::: list

[Allow the interruption of an import in case the script detects it is
close to the PHP timeout limit.]{lang="en-"}

[Enable foreign key checks]{lang="en-"}

[Do not use AUTO_INCREMENT for zero values]{lang="en-"}

[Skip this number of queries (for SQL) starting from the first one:
0]{lang="en-"}

[Format: SQL]{lang="en-"}

[SQL Compatibility mode: NONE]{lang="en-"}
:::

![image](\string"screenshots/dml ddl/screeen2\string".png)

Τέλος πατήστε το κουμπί [**Go**]{lang="en-"} στο κάτω δεξιά μέρος της
σελίδας. Αν όλα πάνε καλά ευχάριστα μηνύματα επιτυχίας θα γεμίσουν την
οθόνη σας και θα μπορείτε να δείτε την βάση μας στο αριστερό
[menu]{lang="en-"} του [phpmyadmin]{lang="en-"}.

  Σε περίπτωση που αποτύχει η παραπάνω διαδικασία λόγω των [foreign]{lang="en-"} [key]{lang="en-"} [checks]{lang="en-"}, κάντε [drop]{lang="en-"} την βάση και δοκιμάστε πάλι χωρίς να επιλέξετε το κουτάκι [Enable foreign key checks]{lang="en-"}.
  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:::

## Εισαγωγή του [dml]{lang="en-"} αρχείου

Στην συνέχεια, θα πρέπει να εισάγετε δεδομένα στην βάση, μέσω του
[dml]{lang="en-"} [script]{lang="en-"}. Επαναλάβετε τα ίδια βήματα που
ακολουθήσατε στην προηγούμενη ενότητα για το [ddl]{lang="en-"}
[script]{lang="en-"}, όμως αυτή την φορά επιλέξτε το αρχείο
[project92_dml.sql]{lang="en-"}.

## Τρέχοντας τον [web]{lang="en-"} [server]{lang="en-"}

Στο [github]{lang="en-"} [repo]{lang="en-"} της ομάδας μας, θα βρείτε
τον φάκελο [web]{lang="en-"}\_[server]{lang="en-"} μέσα στον οποίο
υπάρχει το αρχείο [app.py]{lang="en-"} και μπορείτε να το τρέξετε
ανοίγοντας ένα τερματικό στον εν λόγω φάκελο και πληκτρολογώντας την
εντολή:

``` {.bash breaklines="true"}
> flask run
```

Απαραίτητη προϋπόθεση για να συνδεθεί σωστά το [flask]{lang="en-"} με
την βάση, είναι στις πρώτες γραμμές του αρχείου [app.py]{lang="en-"} να
ορίσετε σωστά την διεύθυνση και την θύρα στην οποία τρέχει η βάση, το
[username]{lang="en-"}, τον κωδικό και το όνομα της βάσης. Ενδεικτικά,
με βάση όσα αναφέρθηκαν στις προηγούμενες ενότητες το σωστό
[configuration]{lang="en-"} θα ήταν:

``` {.python breaklines="true"}
app.config['MYSQL_HOST'] = '172.18.0.2' 
app.config['MYSQL_PORT'] = 3306 
app.config["MYSQL_USER"] = "root" 
app.config["MYSQL_PASSWORD"] = "examplepass" 
app.config["MYSQL_DB"] = "project92"
```

Σε ένα σύστημα που τρέχει [windows]{lang="en-"} και η
[Mariadb]{lang="en-"} είναι εγκατεστημένη μέσω [XAMPP]{lang="en-"}, τότε
το επιθυμητό [configuration]{lang="en-"} είναι:

``` {.python breaklines="true"}
app.config['MYSQL_HOST'] = 'localhost' 
app.config['MYSQL_PORT'] = 3306 
app.config["MYSQL_USER"] = "root" 
app.config["MYSQL_PASSWORD"] = "" 
app.config["MYSQL_DB"] = "project92"
```

Αν όλα πάνε καλά, ανοίγωντας στον [browser]{lang="en-"} διεύθυνση
[127.0.0.1:5000](http://127.0.0.1:5000) θα δείτε την αρχική σελίδα της
εφαρμογής μας, και επιλέγοντας από το αριστερό μενού το ερώτημα που
θέλετε, θα ανακτήσετε τις πληροφορίες που θέλετε από την βάση με ένα
φιλικό προς τον χρήστη τρόπο.

# Επισκόπηση της βάσης

## Τελικό [ER]{lang="en-"} [diagram]{lang="en-"}

Προκειμένου η βάση μας να είναι λειτουργική και να ικανοποιεί όλα τα
ζητήματα, θα πρέπει σε [conceptual]{lang="en-"} επίπεδο να φτιαχτεί ένα
διάγραμμα που να περιγράφει τις βασικές οντότητες της βάσης μας, τα
[attributes]{lang="en-"} των οντοτήτων, και τις σχέσεις που περιγράφουν
τις μεταξύ τους αλληλεπιδράσεις. Το διάγραμμα αυτό καλέιται
[Entity]{lang="en-"} [Relationship]{lang="en-"} [diagram]{lang="en-"}
και για την βάση μας μπορείτε να το δείτε παρακάτω. Υπάρχουν κάποιες
διαφοροποιήσεις σε σχέση με το αρχικό που είχαμε υποβάλλει, καθώς,
εμπλουτίσαμε το δικό μας σε κάποια σημεία με το προτεινόμενο
[ER]{lang="en-"} που είχε αναρτηθεί.

![image](\string"screenshots/ΕΡ ΝΟΙΣΕ\string".png)

## Σχεσιακό Διάγραμμα

Στο σχεσιακό διάγραμμα μπορείτε να δείτε πως υλοποιήσαμε το
[ER]{lang="en-"} στην βάση μας. Το εν λόγω διάγραμμα περιέχει τους
πίνακες που ορίσαμε με τις αντίστοιχες κολώνες τους, καθώς και τις
σχέσεις μεταξύ των πινάκων.

![image](screenshots/RelationSchema.png)

Όπως μπορείτε να δείτε οι πίνακες είναι παραπάνω από τα
[Entities]{lang="en-"} στο [ER]{lang="en-"} [diagram]{lang="en-"}. Αυτο
οφείλεται στο γεγονός ότι τα [Many-to-Many]{lang="en-"}
[relationships]{lang="en-"} για την υλοποίηση τους χρειάζονται ένα
ξεχωριστό [entity]{lang="en-"}, επομένως ήταν αναγκαία η δημιουργία των
πινάκων [WorksForOrganization]{lang="en-"}, [WorksForErgo]{lang="en-"}
και [PedioRelation]{lang="en-"}. Επίσης, καθώς η [mariadb]{lang="en-"}
δεν υποστηρίζει [multivalued]{lang="en-"} [attributes]{lang="en-"} ένας
νέος πίνακας για τα τηλέφωνα των οργανισμών έπρεπε να κατασκευαστεί.
Τέλος, η σχέση της αξιολόγησης, καθώς έχει [attributes]{lang="en-"} τον
βαθμό και την ημερομηνία, επίσης έγινε ένας ξεχωριστός πίνακας.

## Πίνακες

Εν συνεχεία, παραθέτουμε του κώδικες με τους οποίους κατασκευάστηκαν οι
παραπάνω πίνακες:

-   Στέλεχος ΕΛΛΙΔΕΚ

    ``` {.sql breaklines="true"}
    CREATE TABLE Stelexos(
        ID int NOT NULL AUTO_INCREMENT,
        FirstName varchar(255),
        LastName varchar(255),
        Gender ENUM('Male', 'Female'),
        DoBirth DATE,
        PRIMARY KEY (ID)
    );
    ```

-   Ερευνητής

    ``` {.sql breaklines="true"}
    CREATE TABLE Researcher(
        ID int NOT NULL AUTO_INCREMENT,
        FirstName varchar(255),
        LastName varchar(255),
        Gender ENUM('Male', 'Female'),
        DoBirth DATE,
        PRIMARY KEY (ID)
    );
    ```

-   Πεδίο

    ``` {.sql breaklines="true"}
    CREATE TABLE Pedio (
         Name varchar(255),
         PRIMARY KEY (Name)
    );
    ```

-   Σχέση πεδίων με τα έργα

    ``` {.sql breaklines="true"}
    CREATE TABLE PedioRelation(
        Pedio varchar(255) NOT NULL,
        Ergo int NOT NULL,
        FOREIGN KEY (Pedio) REFERENCES Pedio(Name) ON UPDATE CASCADE ON DELETE CASCADE,
        FOREIGN KEY (Ergo) REFERENCES Ergo(ID) ON DELETE CASCADE,
        PRIMARY KEY (Pedio,Ergo)
    );
    ```

-   Πρόγραμμα του ΕΛΛΙΔΕΚ

    ``` {.sql breaklines="true"}
    CREATE TABLE Programma(
        ID int NOT NULL AUTO_INCREMENT,
         Name varchar(255),
        Address varchar(255),
        PRIMARY KEY (ID)
    );
    ```

-   Έργο

    ``` {.sql breaklines="true"}
    CREATE TABLE Ergo(
        ID INT NOT NULL AUTO_INCREMENT,
        Title varchar(255),
        Brief varchar(255),
        StartDate DATE NOT NULL,
        EndDate DATE NOT NULL,
        Duration int AS (YEAR(EndDate)-YEAR(StartDate)) CHECK (Duration<=4 AND Duration>=1),
        Budget DECIMAL(65,2) CHECK (Budget>=0),
        Programma int NOT NULL,     
        MasterStelexos int NOT NULL,
        MasterOrganization int NOT NULL,
        Responsible int NOT NULL,
        FOREIGN KEY (Programma) REFERENCES Programma(ID),
        FOREIGN KEY (MasterStelexos) REFERENCES Stelexos(ID),
        FOREIGN KEY (MasterOrganization) REFERENCES Organization(ID),
        FOREIGN KEY (Responsible) REFERENCES Researcher(ID),
        PRIMARY KEY (ID)
    );
    ```

-   Παραδοτέο

    ``` {.sql breaklines="true"}
    CREATE TABLE Paradoteo(
        Title varchar(255) NOT NULL,
        Ergo int NOT NULL,
        Summary varchar(255),
        Deadline DATE,
        FOREIGN KEY (Ergo) REFERENCES Ergo(ID) ON DELETE CASCADE,
        PRIMARY KEY (Title,Ergo)
    ); 
    ```

-   Αξιολόγηση

    ``` {.sql breaklines="true"}
    CREATE TABLE Review(
        Researcher INT NOT NULL,
        Ergo INT NOT NULL,
        Grade int NOT NULL,
        Date DATE NOT NULL,
        FOREIGN KEY (Researcher) REFERENCES Researcher(ID) ON DELETE NO ACTION,
        FOREIGN KEY (Ergo) REFERENCES Ergo(ID) ON DELETE CASCADE,
        PRIMARY KEY (Ergo)
    );
    ```

-   Ερενευτής εργάζεται σε έργο

    ``` {.sql breaklines="true"}
    CREATE TABLE WorksForErgo(
        Ergo int,
        Researcher int,
        FOREIGN KEY (Ergo) REFERENCES Ergo(ID) ON DELETE CASCADE,
        FOREIGN KEY (Researcher) REFERENCES Researcher(ID) ON DELETE CASCADE,
        PRIMARY KEY (Ergo,Researcher)
    );
    ```

-   Ερευνητής εργάζεται σε οργανισμό

    ``` {.sql breaklines="true"}
    CREATE TABLE WorksForOrganization(
        Organization int NOT NULL,
        Researcher int NOT NULL,
        SINCE DATE NOT NULL,
        FOREIGN KEY (Organization) REFERENCES Organization(ID) ON DELETE CASCADE,
        FOREIGN KEY (Researcher) REFERENCES Researcher(ID) ON DELETE CASCADE,
        PRIMARY KEY (Researcher)
    );
    ```

-   Οργανισμός

    ``` {.sql breaklines="true"}
    CREATE TABLE Organization(
        ID INT NOT NULL AUTO_INCREMENT,
        Name varchar(255),
        Abbreviation varchar(255),
        Street varchar(255),
        StreetNo varchar(255),
        City varchar(255),
        PostalCode varchar(255),
        UnivID int,
        CompID int,
        ResID int,
        CONSTRAINT chk
          CHECK( (UnivID IS NULL AND CompID IS NULL AND ResID IS NOT NULL) OR
                 (UnivID IS NULL AND CompID IS NOT NULL AND ResID IS NULL) OR
                 (UnivID IS NOT NULL AND CompID IS NULL AND ResID IS NULL)),
        PRIMARY KEY (ID),
        FOREIGN KEY (UnivID) REFERENCES University(ID),
        FOREIGN KEY (CompID) REFERENCES Company(ID),
        FOREIGN KEY (ResID) REFERENCES Research_Center(ID)
    );
    ```

-   Τηλέφωνο

    ``` {.sql breaklines="true"}
    CREATE TABLE Telephone(
        Number varchar(15) NOT NULL,
        Organization int NOT NULL,
        FOREIGN KEY (Organization) REFERENCES Organization(ID) ON DELETE CASCADE,
        PRIMARY KEY (Organization,Number)
    );
    ```

-   Εταιρία

    ``` {.sql breaklines="true"}
    CREATE TABLE Company(
        ID int NOT NULL AUTO_INCREMENT,
        Budget DECIMAL(65,2) CHECK (Budget>=0),
        PRIMARY KEY (ID)
    );
    ```

-   Πανεπιστήμιο

    ``` {.sql breaklines="true"}
    CREATE TABLE University(
        ID int NOT NULL AUTO_INCREMENT,
        Budget DECIMAL(65,2) CHECK (Budget>=0),
        PRIMARY KEY (ID)
    );
    ```

-   Ερευνητικό κέντρο

    ``` {.sql breaklines="true"}
    CREATE TABLE Research_Center(
        ID int NOT NULL AUTO_INCREMENT,
        Ministry_Budget DECIMAL(65,2) CHECK (Ministry_Budget>=0),
        Private_Budget DECIMAL(65,2) CHECK (Private_Budget>=0),
        PRIMARY KEY (ID)
    );
    ```

## Παραδοχές

Όπου χρειάζεται υπολογισμός χρονικής διάρκειας σε κλίμακα ετών,
αφαιρούμε απλώς τα έτη από τις δύο ημερομηνίες. Για παράδειγμα, η
διάρκεια ενός έργου υπολογίζεται ως έτος_λήξης - έτος_εκκίνησης.

-   Οργανισμοί:

    -   Οι οργανισμού αρχικά δημιουργούνται χωρίς να έχουν τηλέφωνα. Αν
        το [insert]{lang="en-"} γινόταν μέσω του [UI]{lang="en-"} θα
        είχαμε στην ίδια φόρμα ένα πεδίο για το τηλέφωνο το οποίο θα
        ήταν υποχρεωτικό να συμπληρωθεί.

    -   Διαγράφοντας έναν οργανισμό, διαγράφονται επίσης τα τηλέφωνά του
        και οι αντίστοιχες γραμμές του πίνακα
        [WorksForOrganization]{lang="en-"} που αφορούν τον αντίστοιχο
        οργανισμό. Ο οργανισμός δεν μπορεί να διαγραφτεί στην περίπτωση
        που διαχειρίζεται κάποιο έργο.

-   Ερευνητές:

    -   Διαγράφοντας τον ερευνητή, διαγράφονται επίσης οι αντίστοιχες
        γραμμές του [WorksForErgo]{lang="en-"} και του
        [WorksForOrganization]{lang="en-"}. Ο ερευνητής δεν επιτρέπεται
        να διαγραφτεί την περίπτωση που έχει γράψει αξιολόγηση για
        κάποιο έργο, είτε είναι υπεύθυνος σε κάποιο έργο.

-   Στελέχη:

    -   Τα στελέχη, όμοια με τους ερευνητές, δεν μπορούν να διαγραφτούν
        σε περίπτωση που διαχειρίζονται κάποιο έργο.

-   Έργα:

    -   Τα έργα αρχικά δημιουργούνται χωρίς να έχουν αξιολόγηση, ενώ το
        κάθε έργο πρέπει να έχει μία αξιολόγηση. Επομένως αν έπρεπε να
        γίνουν οι εισαγωγές των έργων μέσω του [UI]{lang="en-"}, τότε
        στην ίδια φόρμα με τα έργα θα έπρεπε ταυτόχρονα ο χρήστης να
        συμπληρώνει τα στοιχεία της αξιολόγησης για να δημιουργηθεί το
        έργο.

    -   Διαγράφοντας τα έργα, διαγράφονται επίσης τα παραδοτέα τους, οι
        σχέσεις με τα πεδία [pediorelation]{lang="en-"} και τους
        ερευνητές [WorksForErgo]{lang="en-"}, και η αντίστοιχη
        αξιολόγηση.

## Ευρετήρια

Από μόνη της η [Mariadb]{lang="en-"} όταν δημιουργούμε ένα νέο πίνακα,
φτιάχνει [indexes]{lang="en-"} πάνω στο [primary]{lang="en-"}
[key]{lang="en-"} και επίσης υπάρχουν ήδη ευρετήρια στα τυχόν
[foreign]{lang="en-"} [key]{lang="en-"} τα οποία κάνουν
[reference]{lang="en-"} το [primary]{lang="en-"} [key]{lang="en-"}
κάποιου άλλου πίνακα. Έτσι όπως είναι φτιαγμένα τα [primary]{lang="en-"}
[keys]{lang="en-"}, για τα ερωτήματα που πρέπει να απαντηθούν στο 3ο
σκέλος της εκφώνησης, είναι αρκετά τα εν λόγω ευρετήρια. Παρόλα αυτά,
επειδή σε κάποια ερωτήματα θέλουμε μόνο τα ενεργά έργα, παραθέτουμε
ενδεικτικά ένα ευρετήριο το οποίο κατασκευάσαμε πάνω στην κολώνα
[EndDate]{lang="en-"} του πίνακα [Ergo]{lang="en-"}.

``` {.sql breaklines="true"}
CREATE INDEX end_date ON Ergo (EndDate);
```

## Triggers

Γνωρίζουμε πως δεν γίνεται ο αξιολογητής του έργου να εργάζεται στον
οργανισμό που το διαχειρίζεται. Γι' αυτό δημιουργήσαμε ένα
[trigger]{lang="en-"} πριν γίνει [insert]{lang="en-"} η αξιολόγηση, ώστε
σε περίπτωση που ο αξιολογητής εργάζεται στον οργανισμό που επιβλέπει το
έργο, τότε δεν γίνεται το [insert]{lang="en-"} και η βάση μας πετάει
[exception]{lang="en-"} με σχετικό μήνυμα.

``` {.sql breaklines="true"}
DELIMITER //
CREATE TRIGGER
    test
BEFORE INSERT ON Review FOR EACH ROW
BEGIN
  IF( 
    (SELECT e.MasterOrganization AS `Organization` FROM Ergo e WHERE e.ID=NEW.Ergo) =
    (SELECT w.Organization FROM WorksForOrganization w WHERE w.Researcher=NEW.Researcher)
 ) 
THEN
    signal sqlstate '45000' set message_text = "Reviewer works for organization that manages `Ergo`";
  END IF;
END; //
DELIMITER ;
```

## Όψεις του σχεσιακού μοντέλου

Ως δεύτερη όψη του σχεσιακού μοντέλου επιλέξαμε να εμφανίζεται το πλήθος
των έργων που λαμβάνει ο κάθε οργανισμός ανά έτος.

``` {.sql breaklines="true"}
CREATE VIEW view2 AS SELECT
    o.ID as `org_id`,
    o.Name as `org_name`,
    YEAR(e.StartDate) as `year`,
    COUNT(CONCAT(o.ID,",",e.StartDate)) as `count`
FROM
    Ergo e
    JOIN Organization o ON e.MasterOrganization=o.ID 
GROUP BY
    `org_id`,`year`;
```

# Παράρτημα {#παράρτημα .unnumbered}

## Δημιουργία [ddl]{lang="en-"} αρχείου {#δημιουργία-ddl-αρχείου .unnumbered}

Με την βοήθεια της εντολής [mysqldump]{lang="en-"} μπορούμε να πάρουμε
το [ddl]{lang="en-"} αρχείο της βάσης, ανοίγοντας ένα τερματικό και
πληκτρολογώντας την ακόλουθη εντολή:

``` {.bash breaklines="true"}
> mysqldump --databases project92 -u root -h 172.18.0.2 --port=3306 -p  --no-data > project92_ddl.sql 
```

Φυσικά, στην παραπάνω εντολή χρειάζεται να δώσουμε το όνομα της βάσης
[project92]{lang="en-"}, το όνομα χρήστη [root]{lang="en-"}, την
διεύθυνση που τρέχει η βάση .0.2, και την θύρα . Θα δημιουργηθεί ένα νέο
αρχείο [project92_ddl.sql]{lang="en-"} στο [working]{lang="en-"}
[directory]{lang="en-"} που ανοίξατε το τερματικό.

Εάν έχετε κωδικό στην βάση σας, τότε θα σας ζητηθεί να τον
πληκτρολογήσετε.

## Δημιουργία [dml]{lang="en-"} αρχείου {#δημιουργία-dml-αρχείου .unnumbered}

Όμοια με το [ddl]{lang="en-"}, πληκτρολογούμε στο τερματικό:

``` {.bash breaklines="true"}
> mysqldump --databases project92 -u root -h 172.18.0.2 --port=3306 -p  --no-create-db --no-create-info --skip-triggers > project92_dml.sql
```

Θα δημιουργηθεί ένα νέο αρχείο με το όνομα
[project92_dml.sql]{lang="en-"}.

## Εισάγετε τυχαία δεδομένα με το [script]{lang="en-"} μας {#εισάγετε-τυχαία-δεδομένα-με-το-script-μας .unnumbered}

Μπορείτε αντί του [dml]{lang="en-"} [script]{lang="en-"} να δοκιμάσετε
να εισάγετε στην βάση τυχαία δεδομένα, με το [script]{lang="en-"} το
οποίο φτιάξαμε για γεμίσουμε τους πίνακες με δεδομένα και να ορίσουμε
(σχεδόν) τυχαία σχέσεις μεταξύ των αντικειμένων, λαμβάνοντας υπόψιν
φυσικά τους περιορισμούς που προαναφέρονται παραπάνω. Θα βρείτε στον
φάκελο [fake_data]{lang="en-"} στο [repo]{lang="en-"} μας, το αρχείο
[main.py]{lang="en-"}.

-   Ανοίξτε το και ρυθμίστε το ώστε να συνδεθεί με την βάση σας
    αλλάζοντας τις πρώτες γραμμές (16-20). Ενδεικτικά οι ρυθμίσεις με
    βάση την ενότητα 1, είναι:

``` {.python numbers="left" breaklines="true" startFrom="16"}
        user="root",
        password="2223041042",
        host="172.18.0.2",
        port=3306,
        database="project92"
```

-   Σιγουρευτείτε πως η βάση σας είναι πλήρως κενή πριν το τρέξετε. Θα
    πρέπει να έχετε εγκατεστημένα στο σύστημά σας τις βιβλιοθήκες της
    python pandas, numpy, faker & mariadb.
