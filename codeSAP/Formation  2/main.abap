*&---------------------------------------------------------------------*
*& Report ZODE_FORMATION2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZODE_FORMATION2.

*------------Révision de toutes les notions abordées------------
*1/ L'Utilisateur final souhaite disposer d'un report lui permettant
* d'afficher les informations des commandes d'achats
* Ci-dessous, la liste des champs à afficher :
* EBELN  Document achat
* EBELP  Poste
* BUKRS  Société
* BSTYP  Catégorie doc.
* BSART  Type document
* Fournisseur
* Organis. achats
* MATNR
* MENGE
* MEINS
* VOLUM
* VOLEH
*2/ L'utilisateur souhaite pouvoir "filtrer" cette sélection de données
* en fonction du n° commande d'achat / de l'article / de la société
* Il indique que le critère "société" doit être un critère obligatoire
* et que sa valeur par défaut sera "0001'.
*3/ L'utilisateur souhaite également disposer d'une case à cocher lui
* permettant d'afficher ou non le volume de l'article
*4/ L'utilisateur précise enfin qu'il a besoin de messages d'information
* dans l'éventualité où il renseignerait une société qui n'existe pas.
* et dans l'éventualité où aucune information ne serait récupérée.


TABLES : EKKO,
        EKPO.


SELECTION-SCREEN : BEGIN OF BLOCK b01 WITH FRAME TITLE text-003.

SELECT-OPTIONS : p_EBELN FOR EKKO-EBELN ,
                 p_MATNR FOR EKPO-MATNR.


PARAMETERS : p_BUKRS TYPE EKPO-BUKRS OBLIGATORY DEFAULT '1710'.
*PARAMETERS : p_BUKRS TYPE EKPO-BUKRS.

PARAMETERS : P_TRAIT AS CHECKBOX DEFAULT 'x'.

PARAMETERS : p_prog1 RADIOBUTTON GROUP b1,
             p_prog2 RADIOBUTTON GROUP b1.


SELECTION-SCREEN : END OF BLOCK b01.





***VERIF SOCIETE***


SELECT BUKRS
FROM EKPO
INTO TABLE @DATA(LT_SOCIETE)
  WHERE BUKRS = @p_BUKRS.


  IF SY-SUBRC = 0.
    MESSAGE TEXT-001 TYPE 'S'.   "J'ai trouvé une société"
  ELSE.
    MESSAGE TEXT-002 TYPE 'E'.   "Je n'ai pas trouvé de société"
  ENDIF.

*************************************
*Volume d'article & Livraison
*************************************
IF P_TRAIT IS NOT INITIAL AND p_prog1 IS NOT INITIAL.
SELECT
  EKPO~EBELN, "EKPO"
  EKPO~EBELP, "EKPO"
  EKPO~BUKRS, "EKPO"
  EKPO~BSTYP, "EKPO"

  EKKO~BSART, "EKKO"
  EKKO~LIFNR, "EKKO"
  EKKO~EKORG,  "EKKO"

  EKPO~MATNR, "EKPO"
  EKPO~MENGE, "EKPO"
  EKPO~MEINS, "EKPO"
  EKPO~VOLUM, "EKPO"
  EKPO~VOLEH, "EKPO"
  EKES~VBELN

 FROM EKKO
 INNER JOIN EKPO ON EKKO~EBELN = EKPO~EBELN
 INNER JOIN EKES ON EKES~EBELN = EKPO~EBELN
AND EKES~EBELP = EKPO~EBELP
  INTO TABLE @DATA(LT_EKKO)
WHERE EKKO~EBELN IN @p_EBELN
AND EKPO~MATNR IN @p_MATNR
AND EKPO~BUKRS = @p_BUKRS.
ENDIF.

*************************************
*Volume d'article & Pas Livraison
*************************************
IF P_TRAIT IS NOT INITIAL AND p_prog1 IS INITIAL.
SELECT
  EKPO~EBELN, "EKPO"
  EKPO~EBELP, "EKPO"
  EKPO~BUKRS, "EKPO"
  EKPO~BSTYP, "EKPO"

  EKKO~BSART, "EKKO"
  EKKO~LIFNR, "EKKO"
  EKKO~EKORG,  "EKKO"

  EKPO~MATNR, "EKPO"
  EKPO~MENGE, "EKPO"
  EKPO~MEINS, "EKPO"
  EKPO~VOLUM, "EKPO"
  EKPO~VOLEH "EKPO"


 FROM EKKO
 INNER JOIN EKPO ON EKKO~EBELN = EKPO~EBELN
  INTO TABLE @DATA(LT_EKKO2)
WHERE EKKO~EBELN IN @p_EBELN
AND EKPO~MATNR IN @p_MATNR
AND EKPO~BUKRS = @p_BUKRS.
ENDIF.




*************************************
*Pas Volume d'article &  Livraison
*************************************

IF P_TRAIT IS INITIAL AND p_prog1 IS NOT INITIAL.
SELECT
  EKPO~EBELN, "EKPO"
  EKPO~EBELP, "EKPO"
  EKPO~BUKRS, "EKPO"
  EKPO~BSTYP, "EKPO"

  EKKO~BSART, "EKKO"
  EKKO~LIFNR, "EKKO"
  EKKO~EKORG,  "EKKO"

  EKPO~MATNR, "EKPO"
  EKPO~MENGE, "EKPO"
  EKPO~MEINS, "EKPO"
  EKES~VBELN


 FROM EKKO
 INNER JOIN EKPO ON EKKO~EBELN = EKPO~EBELN
 INNER JOIN EKES ON EKES~EBELN = EKPO~EBELN AND
EKES~EBELP = EKPO~EBELP
  INTO TABLE @DATA(LT_EKKO3)
WHERE EKKO~EBELN IN @p_EBELN
AND EKPO~MATNR IN @p_MATNR
AND EKPO~BUKRS = @p_BUKRS.
ENDIF.




*************************************
*Pas Volume d'article &  Pas Livraison
*************************************
IF P_TRAIT IS INITIAL AND p_prog1 IS INITIAL.
 SELECT
  EKPO~EBELN, "EKPO"
  EKPO~EBELP, "EKPO"
  EKPO~BUKRS, "EKPO"
  EKPO~BSTYP, "EKPO"

  EKKO~BSART, "EKKO"
  EKKO~LIFNR, "EKKO"
  EKKO~EKORG,  "EKKO"

  EKPO~MATNR, "EKPO"
  EKPO~MENGE, "EKPO"
  EKPO~MEINS "EKPO"

 FROM EKKO
 INNER JOIN EKPO ON EKKO~EBELN = EKPO~EBELN
  INTO TABLE @DATA(LT_EKKO4)
  WHERE EKKO~EBELN IN @p_EBELN AND EKPO~MATNR IN @p_MATNR AND EKPO~BUKRS = @p_BUKRS.
ENDIF.


  IF SY-SUBRC = 0.
    "J'ai trouvé des articles"
    MESSAGE TEXT-003 TYPE 'S'.   "J'ai trouvé des Commandes"
  ELSE.
    MESSAGE TEXT-004 TYPE 'E'.   "Je n'ai pas trouvé de Commandes"
  ENDIF.


DATA : ls_commande LIKE LINE OF LT_EKKO.
ls_commande-ebeln = ' 45666666'.
ls_commande-ebelp = '10'.
ls_commande-BUKRS = ' '.
ls_commande-BSTYP = ' '.
ls_commande-BSART = ' '.
ls_commande-LIFNR = ' '.
ls_commande-EKORG = ' '.
ls_commande-MATNR = ' '.
ls_commande-MENGE = ' '.
*APPEND LS_COMMANDE TO LT_EKKO.


ls_commande-ebelp = '20'.
*INSERT LS_COMMANDE INTO TABLE LT_EKKO.
ls_commande-ebelp = '30'.
*INSERT LS_COMMANDE INTO TABLE LT_EKKO.
ls_commande-ebelp = '40'.
*INSERT LS_COMMANDE INTO TABLE LT_EKKO.
ls_commande-ebelp = '50'.
*INSERT LS_COMMANDE INTO TABLE LT_EKKO.


CLEAR ls_commande.
ls_commande-ebeln = '5500000013'.


*LOOP AT LT_EKKO INTO LS_COMMANDE.
*  LS_COMMANDE-LIFNR = 'MODIF'.
*  MODIFY LT_EKKO FROM LS_COMMANDE.
*ENDLOOP.
*
*DELETE LT_EKKO WHERE ebelp = '40'.
*DELETE.









 DATA : LO_ALV TYPE REF TO CL_SALV_TABLE.






IF P_TRAIT IS NOT INITIAL AND p_prog1 IS NOT INITIAL.

     CALL METHOD CL_SALV_TABLE=>FACTORY
    IMPORTING
      R_SALV_TABLE = LO_ALV
    CHANGING
      T_TABLE      = LT_EKKO.

ENDIF.


IF P_TRAIT IS NOT INITIAL AND p_prog1 IS INITIAL.
       CALL METHOD CL_SALV_TABLE=>FACTORY
    IMPORTING
      R_SALV_TABLE = LO_ALV
    CHANGING
      T_TABLE      = LT_EKKO2.
ENDIF.




IF P_TRAIT IS INITIAL AND p_prog1 IS NOT INITIAL.
     CALL METHOD CL_SALV_TABLE=>FACTORY
    IMPORTING
      R_SALV_TABLE = LO_ALV
    CHANGING
      T_TABLE      = LT_EKKO3.
ENDIF.



IF P_TRAIT IS INITIAL AND p_prog1 IS INITIAL.
     CALL METHOD CL_SALV_TABLE=>FACTORY
    IMPORTING
      R_SALV_TABLE = LO_ALV
    CHANGING
      T_TABLE      = LT_EKKO4.
ENDIF.




 CALL METHOD LO_ALV->DISPLAY.
