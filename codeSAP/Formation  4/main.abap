*&---------------------------------------------------------------------*
*& Report ZJPP_FORMATION4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZJPP_FORMATION4.

* Révision 1ère semaine de formation :
*1/ Déclarez une variable capable de stocker chacune des données ci-dessous :
* - un nombre entier
* - un nombre avec décimale
* - un nom de famille
* - un numéro d'article
* - une date
* - un texte d'une longueur non connue / illimitée


DATA : lv_entier TYPE INT8.
DATA : lv_decimal TYPE DECFLOAT16.
DATA : lv_nom TYPE CHAR25.
DATA : lv_article TYPE INT8.
DATA : lv_date TYPE DATS.
DATA : lv_texte TYPE STRING.

*2/ Déclarez une structure capable de stocker les données de la table VBRK

DATA : LS_VBRK TYPE VBRK.


*3/ Déclarez un modèle avec lequel on pourra créer une structure
*   capable de stocker les valeurs contenues dans les champs ci-dessous :
* - Numéro de commande d'achat
* - Numéro de poste
*-  Date de création de la commande
* - numéro d'article
* - Désignation article


TYPES : BEGIN OF TY_EKPO,
          EBELN  TYPE EKPO-EBELN,
          EBELP    TYPE EKPO-EBELP,
          AEDAT       TYPE EKKO-AEDAT,
          MATNR TYPE EKPO-MATNR,
          MAKTX       TYPE MAKT-MAKTX,
        END OF TY_EKPO.

*MAKT-MAKTX


*4/ Déclarez la structure basée sur le modèle créé précédemment
*5/ Déclarez une table capable de stocker plusieurs lignes identiques à la structure précédemment créé
DATA : LT_EKPO TYPE TABLE OF TY_EKPO.
DATA : LS_EKPO TYPE TY_EKPO.



*6/ Déclarez les critères de sélection pour l'écran de sélection
*   - un critère permettant de saisir une valeur unique pour la date de création de la commande d'achat

TABLES : EKPO, EKKO.

PARAMETERS : p_AEDAT TYPE EKKO-AEDAT.
*   - un critère permettant de saisir plusieurs numéros de commande d'achat
SELECT-OPTIONS : s_EBELN FOR EKPO-EBELN.
*   - un critère obligatoire permettant de saisir un type de document d'achat (champ BSART) avec 'NB' comme valeur par défaut
PARAMETERS : p_BSART TYPE EKKO-BSART OBLIGATORY DEFAULT 'NB'.
*   - une case à cocher permettant à l'utilisateur de ne sélectionner QUE les commandes créés pendant l'année en cours
  PARAMETERS : P_TRAIT AS CHECKBOX DEFAULT ''.
*   - un radiobouton permettant à l'utilisateur de choisir la langue de la désignation article
  PARAMETERS : p_prog1 RADIOBUTTON GROUP b1,
             p_prog2 RADIOBUTTON GROUP b1.


*7/ Effectuer une requête SQL permettant de récupérer les champs de la question 3 dans la table créé pour la question 5
*   et intégréz les critères de sélection de votre écran dans cette requête SQL.
*   (Attention, une jointure devra être effectuée pour récupérer l'ensemble des champs avec UNE SEULE requête SQL)
*
*

IF P_TRAIT IS INITIAL.
select
      EKPO~EBELN,
      EKPO~EBELP,
      EKKO~AEDAT,
      EKPO~MATNR,
      MAKT~MAKTX
FROM EKKO
INNER JOIN EKPO ON EKPO~EBELN = EKKO~EBELN
INNER JOIN MAKT ON EKPO~MATNR = MAKT~MATNR
INTO CORRESPONDING FIELDS OF TABLE @LT_EKPO
  WHERE  EKKO~EBELN  IN @s_EBELN
  AND EKKO~BSART = @p_BSART .
ENDIF.




IF P_TRAIT IS NOT INITIAL.
select
      EKPO~EBELN,
      EKPO~EBELP,
      EKKO~AEDAT,
      EKPO~MATNR,
      MAKT~MAKTX
FROM EKKO
INNER JOIN EKPO ON EKPO~EBELN = EKKO~EBELN
INNER JOIN MAKT ON EKPO~MATNR = MAKT~MATNR
INTO CORRESPONDING FIELDS OF TABLE @LT_EKPO
  WHERE EKKO~AEDAT = @p_AEDAT
        AND EKKO~EBELN  IN @s_EBELN
  AND EKKO~BSART = @p_BSART .
ENDIF.




*8/ Appelez les méthodes "Factory" et "display" de la classe CL_SALV_TABLE
*  Pour afficher votre table interne

 DATA : LO_ALV TYPE REF TO CL_SALV_TABLE.


      CALL METHOD CL_SALV_TABLE=>FACTORY
    IMPORTING
      R_SALV_TABLE = LO_ALV
    CHANGING
      T_TABLE      = LT_EKPO.

  CALL METHOD LO_ALV->DISPLAY.