REPORT ZJPP_FORMATION5.




INCLUDE ZJPP_FORMATION5_TOP.
INCLUDE ZJPP_FORMATION5_SCR.
INCLUDE ZJPP_FORMATION5_F01.

*START-OF-SELECTION.

*PERFORM SELECT_DATA_LIVRAISON.
*PERFORM AFFICHER_DATA_LIVRAISON.


*PERFORM SELECT_MODIF_DATE.
*PERFORM AFFICHER_MODIF_DATE.


* 6/ Commentez tout votre code et déclarez un modèle permettant de récupérer dans la même table interne
*    la date
*    la date de création de la facture
*    + la totalité des champs de la VBRP


TYPES: BEGIN OF TY_VBRK,  "Déclaration de ty_data
         FKART TYPE VBRK-FKART,  "avec le type de facture de VBRK
         FKDAT TYPE VBRK-FKDAT.  "avec la Date de la facture de VBRK
         INCLUDE STRUCTURE VBRP. "En incluant toutes les données de la table VBRP
TYPES: END OF TY_VBRK.



* 7/ Récupérez les données évoquées à la question 6 à l'aide d'UN SEUL SELECT en ne prenant QUE
*    les factures de type F2 (Un champ de la VBRK vous donnera cette information)
*     FKART = 'F2'

DATA : LT_VBRK TYPE TABLE OF TY_VBRK.

*SELECT VBRK~FKART,
*  VBRK~FKDAT
*,VBRP~*
*FROM VBRK
*INNER JOIN VBRP ON VBRP~VBELN = VBRK~VBELN
*  INTO TABLE @LT_VBRK
*  WHERE FKART = 'F2' .



* 8/ Effectuez un deuxième select en ne prenant cette fois que les factures de type S1
*    Et stockez les dans la même table que celle utilisée pour le 1er select
*    Débuggez le résultat de votre sélection.  Que constatez-vous?


*  SELECT VBRK~FKART,
*    VBRK~FKDAT
*  ,VBRP~*
*  FROM VBRK
*  INNER JOIN VBRP ON VBRP~VBELN = VBRK~VBELN
*    INTO TABLE @LT_VBRK
*    WHERE FKART = 'S1' .


* 9/ Répetez les opérations 7 et 8 en prenant soin cette fois de ne pas effacer les données
*    résultant du 1er select

DATA : LT_VBRK2 TYPE TABLE OF TY_VBRK.
DATA : LS_VBRK2 LIKE LINE OF LT_VBRK2 .

*SELECT VBRK~FKART,
*  VBRK~FKDAT
*,VBRP~*
*FROM VBRK
*INNER JOIN VBRP ON VBRP~VBELN = VBRK~VBELN
**  INTO TABLE @LT_VBRK2
*  APPENDING TABLE @LT_VBRK
*  WHERE FKART = 'S1' .




* 9.h/ Afficher le montant le plus cher
TYPES: BEGIN OF TY_NETWR,  "Déclaration de ty_data
         NETWR TYPE VBRK-NETWR.  "avec le type de facture de VBRK
TYPES: END OF TY_NETWR.
DATA : LT_NETWR TYPE TABLE OF TY_NETWR.

DATA : LV_PRIXMAX TYPE INT8.

*SELECT MAX( NETWR )
*FROM VBRK
**INTO TABLE @LT_NETWR.
*INTO LV_PRIXMAX.
*
*
*SELECT MIN( NETWR )
*FROM VBRK
*INTO @DATA(LV_PRIXMIN).
*
*
*SELECT AVG( NETWR )
*FROM VBRK
*INTO @DATA(LV_PRIXAVG).


*  WRITE : / 'Montant min ' , LV_PRIXMIN.
*  WRITE : / 'Montant max ' ,LV_PRIXMAX.
*  WRITE : / 'Montant avg ' ,LV_PRIXAVG.



*LOOP AT LT_VBRK2 INTO LS_VBRK2.
*  APPEND LS_VBRK2 TO LT_VBRK .
*ENDLOOP.



* 10/ Créer une table de type RANGE correspondant au type de facture et ajoutez y les valeurs F2 et S1
*    afin de constistuer une liste de valeurs
*    Utilisez ce range pour refaire le même select qu'à l'étape 7


TYPES: BEGIN OF TY_RANGE,  "Déclaration de ty_data
         FKART TYPE VBRK-FKART.  "avec le type de facture de VBRK
TYPES: END OF TY_RANGE.

DATA : LT_RANGE TYPE TABLE OF TY_RANGE.
DATA : LS_RANGE LIKE LINE OF LT_RANGE.

DATA : LT_VBRK3 TYPE TABLE OF TY_VBRK.

*LS_RANGE-FKART = 'F2'.
*APPEND LS_RANGE TO LT_RANGE .

*LS_RANGE-FKART = 'S1'.
*APPEND LS_RANGE TO LT_RANGE .


TABLES : TVARVC.

DATA : LR_RANGE TYPE RANGE OF FKART.
*DATA : LR_RANGE TYPE RANGE OF TVARV_val.
*DATA : LR_RANGE TYPE RANGE OF TVARVC.
*select opti LOW from tvarvc INTO TABLE LR_RANGE where name = 'ZTYPE_FACTURE'.
*SELECt  *
*  FROM TVARVC
*  WHERE NAME = 'ZTYPE_FACTURE'
**  INTO TABLE @LT_RANGE.
**  INTO @DATA(LR_RANGE).
*  INTO TABLE @LR_RANGE.


*select VBRK~FKART,
*  VBRK~FKDAT
*,VBRP~*
*FROM VBRK
*INNER JOIN VBRP ON VBRP~VBELN = VBRK~VBELN
*  FOR ALL ENTRIES IN @LR_RANGE WHERE VBRK~FKART IN @LR_RANGE
* INTO TABLE @LT_VBRK.


*FOR ALL ENTRIES IN LR_RANGE WHERE VBRK~FKART IN LR_RANGE-FKART.



*SELECT VBRK~FKART,
*  VBRK~FKDAT
*,VBRP~*
*FROM VBRK
*INNER JOIN VBRP ON VBRP~VBELN = VBRK~VBELN
**INNER JOIN @LT_RANGE AS LT_RANGE ON VBRK~FKART = LT_RANGE~FKART.
*FOR ALL ENTRIES IN @LT_RANGE WHERE VBRK~FKART IN @LT_RANGE-FKART.


* 11/ Rajouter une autre colonne dans votre table finale nommée "Montant de la facture la plus élevéé"
*    et utilisez le sélect adéquat pour récupérer le montant de la facture la plus élevée dans la VBRK


* 12/ TVARVC : Créer une variable dans la table TVARVC en utilisant la transaction TVARVC
*              Alimentez cette variable avec les types de facture évoqués précédemment


* 13/ Notion de rupture (At NEW, At first,...exemple : at first vbeln, on alimente la date de création)
* car pas besoin de remplir à nouveau ce champ si la ligne suivante correspondant au même numéro de facture







*DATA : LO_ALV TYPE REF TO CL_SALV_TABLE.
*
*CL_SALV_TABLE=>FACTORY(
*IMPORTING
*  R_SALV_TABLE = LO_ALV
*CHANGING
*  T_TABLE      = LT_VBRK ).
*
*LO_ALV->DISPLAY( ).




*END-OF-SELECTION.