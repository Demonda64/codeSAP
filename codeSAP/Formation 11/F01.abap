FORM CREATE_PERSONNE .


  DATA : LO_PERSONNE  TYPE REF TO ZCL_PERSONNE_JPP,
         LO_PERSONNE2 TYPE REF TO ZCL_PERSONNE_JPP,
         LV_IDENTITE  TYPE STRING.

  CREATE OBJECT LO_PERSONNE
    EXPORTING
      IV_NOM    = 'WATATATATA'
      IV_PRENOM = 'WOTOTOTOTO'.

*CREATE OBJECT lo_personne.
*lo_personne->nom = 'WATATATATA'.
*lo_personne->prenom = 'WOTOTOTOTO'.

*lv_identite = lo_personne->nom && || && lo_personne->prenom.
*CALL METHOD LO_PERSONNE->GET_IDENTITE
*  RECEIVING
*    EV_IDENTITE = lv_identite
*    .


*CREATE OBJECT lo_personne2.
*lo_personne2->nom = 'Hacker'.
*lo_personne2->prenom = 'Man'.
*lo_personne2->NUM_CIN = '065810'.

  LV_IDENTITE = LO_PERSONNE->GET_IDENTITE( ).

  WRITE : / LV_IDENTITE.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form CREATE_EMPLOYE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM CREATE_EMPLOYE .


  DATA : LO_PERSONNE   TYPE REF TO ZCL_PERSONNE_JPP,
         LO_CONSULTANT TYPE REF TO ZCL_EMPLOYE_CONSULTANT_JPP,
         LO_MANAGER    TYPE REF TO ZCL_EMPLOYE_MANAGER_JPP,
         LV_IDENTITE   TYPE STRING.

  CREATE OBJECT LO_PERSONNE
    EXPORTING
      IV_NOM    = 'Frites'
      IV_PRENOM = 'Moules'.


  CREATE OBJECT LO_CONSULTANT
    EXPORTING
      IV_NOM    = 'Couscous'
      IV_PRENOM = 'Tajine'.

*lv_identite = lo_consultant->get_identite( ) && ':' && lo_consultant->GET_NOM_METIER( ).

  WRITE : / LO_CONSULTANT->GET_INTITULE( ).


  CREATE OBJECT LO_MANAGER
    EXPORTING
      IV_NOM    = 'Jason'
      IV_PRENOM = 'Statham'.
*lo_consultant->metier = 'Kebabier'.

  LV_IDENTITE = LO_MANAGER->GET_IDENTITE( ) && ':' && LO_MANAGER->GET_NOM_METIER( ).

  WRITE : / LO_MANAGER->GET_INTITULE( ).


ENDFORM.
*&---------------------------------------------------------------------*
*& Form CREATE_EMPLOYE_2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM CREATE_EMPLOYE_2 .

  DATA : LO_PERSONNE   TYPE REF TO ZCL_EMPLOYE_JPP,
         LO_CONSULTANT TYPE REF TO ZCL_EMPLOYE_JPP,
         LO_MANAGER    TYPE REF TO ZCL_EMPLOYE_JPP,
         LV_IDENTITE   TYPE STRING.



  CREATE OBJECT LO_CONSULTANT TYPE ('ZCL_EMPLOYE_CONSULTANT_JPP')
    EXPORTING
      IV_NOM    = 'Couscous'
      IV_PRENOM = 'Tajine'.

*lv_identite = lo_consultant->get_identite( ) && ':' && lo_consultant->GET_NOM_METIER( ).

  WRITE : / LO_CONSULTANT->GET_INTITULE( ).


  CREATE OBJECT LO_MANAGER TYPE ('ZCL_EMPLOYE_MANAGER_JPP')
    EXPORTING
      IV_NOM    = 'Jason'
      IV_PRENOM = 'Statham'.
*lo_consultant->metier = 'Kebabier'.

  LV_IDENTITE = LO_MANAGER->GET_IDENTITE( ) && ':' && LO_MANAGER->GET_NOM_METIER( ).

  WRITE : / LO_MANAGER->GET_INTITULE( ).


ENDFORM.
*&---------------------------------------------------------------------*
*& Form CREATE_EMPLOYE_3
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM CREATE_EMPLOYE_3 .

DATA : LO_PERSONNE   TYPE REF TO ZCL_PERSONNE_JPP,
       LO_CONSULTANT TYPE REF TO ZCL_EMPLOYE_CONSULTANT_JPP,
       LO_MANAGER    TYPE REF TO ZCL_EMPLOYE_MANAGER_JPP,
       LV_IDENTITE   TYPE STRING.

CREATE OBJECT LO_PERSONNE
    EXPORTING
      IV_NOM    = 'Frites'
      IV_PRENOM = 'Moules'.


CREATE OBJECT LO_CONSULTANT
    EXPORTING
      IV_NOM    = 'Couscous'
      IV_PRENOM = 'Tajine'.

SET HANDLER LO_CONSULTANT->handle_employee_hired FOR LO_CONSULTANT.

LV_IDENTITE = LO_CONSULTANT->GET_INTITULE( ).

    WRITE : / LO_CONSULTANT->GET_INTITULE( ).

ENDFORM.