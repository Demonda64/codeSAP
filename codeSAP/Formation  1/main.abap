*&---------------------------------------------------------------------*
*& Report ZODE_FORMATION
*&---------------------------------------------------------------------*
*&Date Création / Auteur / Motif
*&21/02/2023 / ODE / Création premier programme
*&---------------------------------------------------------------------*
REPORT ZODE_FORMATION.

*DATA : LV_NAME  TYPE ZDRIVER_CAR_KDE-NAME,
*       LV_NAME2 TYPE CHAR25,
*       LV_NAME3 TYPE SRMFNAME.
*
**-------------------------------
** Selectionner 1 champ
**-------------------------------
*SELECT SINGLE NAME
*FROM ZDRIVER_CAR_KDE
*INTO LV_NAME
*WHERE ID_DRIVER = 'JPP' .
*
**WRITE : LV_NAME.
*
*
**-------------------------------
**Selectioner 1 lignes dans une structure
**-------------------------------
*DATA : LS_CONDUCTEUR TYPE ZDRIVER_CAR_KDE .
*
*SELECT SINGLE *
*FROM ZDRIVER_CAR_KDE
*INTO LS_CONDUCTEUR
*WHERE ID_DRIVER = 'JPP'  .
*
**WRITE : LS_CONDUCTEUR.
*
*
*
**-------------------------------
**Selectioner & Afficher une table
**-------------------------------
*DATA : LT_CONDUCTEUR TYPE TABLE OF ZDRIVER_CAR_KDE .
**DATA : LS_CONDUCTEUR2 TYPE ZDRIVER_CAR_KDE .
*
*SELECT  *
*FROM ZDRIVER_CAR_KDE
*INTO TABLE LT_CONDUCTEUR.
*
*SORT LT_CONDUCTEUR BY NAME ASCENDING.
*
**LOOP AT LT_CONDUCTEUR INTO LS_CONDUCTEUR.
**  WRITE LS_CONDUCTEUR.
**ENDLOOP.
*
*
**-------------------------------
**Selectioner & Afficher une table avec des conditions &
**-------------------------------
*
**LOOP AT LT_CONDUCTEUR INTO LS_CONDUCTEUR.
**  IF LS_CONDUCTEUR-NAME = 'MAGALI'.
***   CONTINUE
**    WRITE : 'MAGALI FOUND'.
***    EXIT.
**  ELSEIF LS_CONDUCTEUR-NAME = 'OSCAR'.
**    WRITE : 'OSCAR FOUND'.
**  ELSE .
**     WRITE : 'Nope'.
**  ENDIF.
**ENDLOOP.
*
*
*
**-------------------------------
**Selectioner & Afficher une table avec un CHECK
**-------------------------------
*
*
**LOOP AT LT_CONDUCTEUR INTO LS_CONDUCTEUR.
**
**    CHECK LS_CONDUCTEUR-NAME <> 'OSCAR'.
**    WRITE LS_CONDUCTEUR-NAME.
**
**ENDLOOP.
*
*
**LOOP AT LT_CONDUCTEUR INTO LS_CONDUCTEUR.
**
*** WRITE : LS_CONDUCTEUR-NAME.
**  CASE LS_CONDUCTEUR-NAME.
**    WHEN 'OSCAR'.
**      WRITE : 'OSCAR'.
**    WHEN 'MAGALI'.
**      WRITE : 'MAGALI'.
**    WHEN OTHERS.
**      WRITE : 'OTHERS'.
**  ENDCASE.
**
**ENDLOOP.
*
*
**-------------------------------
**Fusion/Concat des prénoms des gens ayant une peugeot
**-------------------------------
*DATA : LV_FUSION  TYPE String.
*
*
**LOOP AT LT_CONDUCTEUR INTO LS_CONDUCTEUR WHERE CAR_BRAND = 'Peugeot'.
**
**  CONCATENATE LV_FUSION LS_CONDUCTEUR-NAME INTO LV_FUSION SEPARATED BY SPACE.
**
**ENDLOOP.
*
*
*LOOP AT LT_CONDUCTEUR INTO LS_CONDUCTEUR WHERE CAR_BRAND = 'Peugeot'.
*
*  LV_FUSION = |{ LV_FUSION }{ LS_CONDUCTEUR-NAME }|.
*
*ENDLOOP.
*WRITE LV_FUSION.



*TYPES : BEGIN OF TY_ZDRIVER,
*          ID_DRIVER  TYPE ZDRIVER_CAR_KDE-ID_DRIVER,
*          SURNAME    TYPE ZDRIVER_CAR_KDE-SURNAME,
*          NAME       TYPE ZDRIVER_CAR_KDE-NAME,
*          DATE_BIRTH TYPE ZDRIVER_CAR_KDE-DATE_BIRTH,
*        END OF TY_ZDRIVER.
*
*DATA : LT_DRIVER TYPE TABLE OF TY_ZDRIVER.
*
*
*SELECT ID_DRIVER SURNAME NAME DATE_BIRTH
*FROM ZDRIVER_CAR_KDE
*INTO TABLE LT_DRIVER.
*


***INTO CORRESPONDING FIELDS OF TABLE LT_DRIVER.


*TABLES : zdriver_car_kde.
*PARAMETERS : p_id TYPE z_driver_id_kde.
*SELECT-OPTIONS : s_id FOR zdriver_car_kde-id_driver.
*
*
*SELECT ID_DRIVER, SURNAME, NAME, DATE_BIRTH
*FROM ZDRIVER_CAR_KDE
*INTO TABLE @data(lt_driver)
*WHERE ID_DRIVER IN @s_id.
*
*
*IF 1 = 1.
*ENDIF.
*
*DATA : lo_alv type REF TO cl_salv_table.
*
*CALL METHOD cl_salv_table=>factory
*  IMPORTING
*    r_salv_table = lo_alv
*   CHANGING
*     t_table = lt_driver.
*
*CALL METHOD lo_alv->display.


*& Le client sohaite disposer d'un document de report lui permettant d'afficher certaines informations concernant les articles.
*& 1/ Liste des informations à afficher:
*& - le numéro d'article
*& - la description
*& - le type d'article
*& - son poids net
*& - unité de poids
*& 2/ L'utilisateur souhaite pouvoir afficher ces informations en fonction du type d'article et du numéro d'article.

TABLES : MARA,
         MAKT.


****PARAMETERS : p_MTART TYPE MTART,
****             p_MATNR TYPE MATNR.


**SELECT-OPTIONS : p_MTART FOR MARA-MTART,
**                   p_MATNR FOR MARA-MATNR.
**
**
**
**SELECT MATNR , MTART , NTGEW , GEWEI
**FROM MARA
**INTO TABLE @data(lt_mara)
**WHERE MTART IN @p_MTART AND MATNR IN @p_MATNR .
**
**
**DATA : lo_alv type REF TO cl_salv_table.
**
**CALL METHOD cl_salv_table=>factory
**  IMPORTING
**    r_salv_table = lo_alv
**   CHANGING
**     t_table = lt_mara.
**
**CALL METHOD lo_alv->display.


MESSAGE TEXT-003 TYPE 'I'.

SELECT-OPTIONS : p_MTART FOR MARA-MTART OBLIGATORY,
                   p_MATNR FOR MARA-MATNR.

**----------------------------------------------------------------------------------------------------------------------------
**--------------------------------------------------------------PREMIERE FACON****-------------------------------
**--------------------------------------------------------------FACON PERSO****-------------------------------
**----------------------------------------------------------------------------------------------------------------------------

*TYPES : BEGIN OF TY_MARA_MAKT,
*          MATNR TYPE MARA-MATNR,
*          MAKTX TYPE MAKT-MAKTX,
*          MTART TYPE MARA-MTART,
*          NTGEW TYPE MARA-NTGEW,
*          GEWEI TYPE MARA-GEWEI,
*        END OF TY_MARA_MAKT.
*
*DATA : LT_MARA_MAKT TYPE TABLE OF TY_MARA_MAKT.
*
*
*SELECT MARA~MATNR ,
*  MAKT~MAKTX,
*  MARA~MTART ,
*  MARA~NTGEW ,
*  MARA~GEWEI
*FROM MARA
*INNER JOIN MAKT ON MARA~MATNR = MAKT~MATNR
*  WHERE MARA~MTART IN @p_MTART AND MARA~MATNR IN @p_MATNR
*  INTO CORRESPONDING FIELDS OF TABLE @LT_MARA_MAKT.
**
*
*
*DATA : LO_ALV TYPE REF TO CL_SALV_TABLE.
*
*CALL METHOD CL_SALV_TABLE=>FACTORY
*  IMPORTING
*    R_SALV_TABLE = LO_ALV
*  CHANGING
*    T_TABLE      = LT_MARA_MAKT.
*
*CALL METHOD LO_ALV->DISPLAY.
*
*SELECT MATNR,MAKTX
*  FROM MAKT
*  INTO TABLE @DATA(lt_makt)
*  FOR ALL ENTRIES IN LT_MARA
*  WHERE matnr = lt_mara_matnr

**--------------------------------------------------------------------------------------------------------------------------------
**--------------------------------------------------------------DEUXIEME FACON****------------------------------------------------
**--------------------------------------------------------------FACON DU PROF****------------------------------------------------
**--------------------------------------------------------------------------------------------------------------------------------

*IF 1 = 1.
*ENDIF.
*
*SELECT MATNR,
*          MTART ,
*          NTGEW ,
*          GEWEI
*FROM MARA
*INTO TABLE @DATA(lt_mara)
*  WHERE MTART IN @p_MTART AND MATNR IN @p_MATNR.
*
*
*SELECT MATNR,MAKTX
*  FROM MAKT
*  INTO TABLE @DATA(lt_makt)
*  FOR ALL ENTRIES IN @LT_MARA
*  WHERE matnr = @lt_mara-matnr.
*
*
*DATA : LO_ALV TYPE REF TO CL_SALV_TABLE.
*
*CALL METHOD CL_SALV_TABLE=>FACTORY
*  IMPORTING
*    R_SALV_TABLE = LO_ALV
*  CHANGING
*    T_TABLE      = LT_MARA.
*
*CALL METHOD LO_ALV->DISPLAY.




**----------------------------------------------------------------------------------------------------------------------------
**--------------------------------------------------------------TROISIEME FACON****-------------------------------
**--------------------------------------------------------------COMME MOI MAIS V.PROF***-------------------------------
**----------------------------------------------------------------------------------------------------------------------------

*SELECT MATNR,
*          MTART ,
*          NTGEW ,
*          GEWEI
*FROM MARA
*INTO TABLE @DATA(lt_mara)
*  WHERE MTART IN @p_MTART AND MATNR IN @p_MATNR.
*
*
*SELECT MATNR,MAKTX
*  FROM MAKT
*  INTO TABLE @DATA(lt_makt)
*  FOR ALL ENTRIES IN @LT_MARA
*  WHERE matnr = @lt_mara-matnr.
*
*TYPES : BEGIN OF ty_modele,
*          MATNR TYPE MARA-MATNR,
*          MAKTX TYPE MAKT-MAKTX,
*          MTART TYPE MARA-MTART,
*          NTGEW TYPE MARA-NTGEW,
*          GEWEI TYPE MARA-GEWEI,
*        END OF ty_modele.
*
*
*DATA : LT_FINAL TYPE TABLE OF ty_modele,
*      LS_FINAL LIKE LINE OF LT_FINAL,
*      LS_MARA LIKE LINE OF lt_mara,
*      LS_MAKT like line of lt_makt.
*
*LOOP AT lt_mara INTO LS_MARA.
*  CLEAR LS_FINAL.
*  ls_final-matnr = ls_mara-matnr.
*  ls_final-MTART = ls_mara-MTART.
*  ls_final-NTGEW = ls_mara-NTGEW.
*  ls_final-GEWEI = ls_mara-GEWEI.
*  READ TABLE lt_makt INTO ls_makt WITH KEY matnr = ls_mara-matnr.
*    IF sy-subrc = 0.
*      ls_final-MAKTX = ls_makt-MAKTX.
*    ENDIF.
*  APPEND ls_final TO lt_final.
*ENDLOOP.


**----------------------------------------------------------------------------------------------------------------------------
**--------------------------------------------------------------QUATRIEME FACON****-------------------------------
**--------------------------------------------------------------La meilleure------------
**----------------------------------------------------------------------------------------------------------------------------

PARAMETERS : P_TRAIT AS CHECKBOX DEFAULT 'x'.

IF P_TRAIT IS NOT INITIAL.
  SELECT MARA~MATNR ,
    MARA~MTART ,
    MARA~NTGEW ,
    MARA~GEWEI,
    MAKT~MAKTX
  FROM MARA
  LEFT OUTER JOIN MAKT ON MAKT~MATNR = MARA~MATNR AND MAKT~SPRAS ='F'
  INTO TABLE @DATA(LT_FINAL)
    WHERE MARA~MTART IN @p_MTART AND MARA~MATNR IN @p_MATNR .

  IF SY-SUBRC = 0.
    "J'ai trouvé des articles"
    MESSAGE TEXT-002 TYPE 'S'.   "J'ai trouvé"
  ELSE.
    MESSAGE TEXT-001 TYPE 'E'.   "Je n'ai rien trouvé"
  ENDIF.

ELSE.
  SELECT MARA~MATNR ,
    MARA~MTART ,
    MARA~NTGEW ,
    MARA~GEWEI
  FROM MARA
  INTO TABLE @DATA(LT_FINAL2)
    WHERE MARA~MTART IN @p_MTART AND MARA~MATNR IN @p_MATNR .
ENDIF.


DATA : LO_ALV TYPE REF TO CL_SALV_TABLE.


IF P_TRAIT IS NOT INITIAL.

  CALL METHOD CL_SALV_TABLE=>FACTORY
    IMPORTING
      R_SALV_TABLE = LO_ALV
    CHANGING
      T_TABLE      = LT_FINAL.

ELSE.

  CALL METHOD CL_SALV_TABLE=>FACTORY
    IMPORTING
      R_SALV_TABLE = LO_ALV
    CHANGING
      T_TABLE      = LT_FINAL2.

ENDIF.

CALL METHOD LO_ALV->DISPLAY.
