*&---------------------------------------------------------------------*
*& Include          ZJPP_FORMATION3_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form select_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
*FORM SELECT_DATA .


*&---------------------------------------------------------------------*
*& Form select_data_Client
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM select_data_Client .


  ***********VBAK************
  *VBAK-VBELN  Le numéro de la commande de vente (document de vente)
  *VBAK-ERDAT  La date de création de la commande
  *VBAK-VKORG  L’organisation commerciale rattachée à cette commande
  *VBAK-VTWEG  Le canal de distribution rattachée à cette commande
  *VBAK-SPART  Le secteur d’activité rattachée à cette commande
  *VBAK-NETWR  La valeur nette de la commande (a calculer ou récuperer dans la table)
  *VBAK-WAERK  Sa devise
  
  
  
    DATA : LT_VBAK  TYPE TABLE OF TY_VBAK.
  
    SELECT
      VBELN
      ERDAT
      VKORG
      VTWEG
      SPART
      NETWR
      WAERK
      FROM VBAK
      INTO TABLE LT_VBAK
      WHERE VBELN IN S_vbeln.
  
  ***********VBAP************
  *VBAP-POSNR  Le poste de la commande de vente
  *VBAP-MATNR  L’article de chacun des postes
  *VBAP-CHARG Le lot
  *VBAP-KUNNR_ANA Le donneur d’ordre (client)
  *VBAP-NETWR La valeur nette du poste
  *VBAP-WAERK Sa devise
  
  
  
    DATA : LT_VBAP  TYPE TABLE OF TY_VBAP.
  
    SELECT
      VBELN
      POSNR
      MATNR
      CHARG
      KUNNR_ANA
      NETWR
      WAERK
      FROM VBAP
      INTO TABLE LT_VBAP
      FOR ALL ENTRIES IN LT_VBAK
      WHERE VBELN = LT_VBAK-VBELN
       AND CHARG IN S_CHARG .
  
  
  ***********MAKT************
  *MAKT-MAKTX La désignation de l’article
  
  
    DATA : LT_MAKT  TYPE TABLE OF TY_MAKT.
  
    SELECT
      MATNR
      MAKTX
      FROM MAKT
      INTO TABLE LT_MAKT
      FOR ALL ENTRIES IN LT_VBAP
     WHERE MATNR = LT_VBAP-MATNR
      AND MATNR IN S_MATNR.
  
  
  ***********KNA1************
  *KNA1-NAME1 Son nom
  *KNA1- La concaténation de son adresse (rue + code postal + ville + pays)
  *ZJPP_ADRESSE -> STRAS + PSTLZ + ORT01 + LAND1
  *STRING_AGG(KNA1~STRAS,KNA1~PSTLZ,KNA1~ORT01,KNA1~LAND1) AS 'ZJPP_ADRESSE'
  
  
  
    DATA : LT_KNA1  TYPE TABLE OF TY_KNA1.
  
    SELECT
      KUNNR
      NAME1
      STRAS
      PSTLZ
      ORT01
      LAND1
  *CONCAT(CONCAT( KNA1~STRAS , KNA1~PSTLZ ) CONCAT( KNA1~ORT01 , KNA1~LAND1 ))
  *CONCAT_WITH_SPACE(KNA1~STRAS,KNA1~PSTLZ,KNA1~ORT01,KNA1~LAND1) AS "ZJPP_ADRESSE"
      FROM KNA1
      INTO TABLE LT_KNA1
      FOR ALL ENTRIES IN LT_VBAP
      WHERE KUNNR = LT_VBAP-KUNNR_ANA
      AND KUNNR IN S_KUNNR.
  
  
  
    PERFORM: merge_data_Client USING LT_VBAK LT_VBAP LT_MAKT LT_KNA1.
  
  ENDFORM.
  
  
  
  
  
  
  
  *&---------------------------------------------------------------------*
  *& Form merge_data_Client
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  **&---------------------------------------------------------------------*
  *FORM merge_data_Client USING LT_VBAK LT_VBAP LT_MAKT LT_KNA1 .
  *
  *
  *
  *
  *
  **  LOOP AT gt_mara ASSIGNING FIELD-SYMBOL(<fs_mara>).
  **    CLEAR ls_final.
  **    READ TABLE ut_makt ASSIGNING FIELD-SYMBOL(<fs_makt>) WITH KEY matnr = <fs_mara>-matnr.
  **    IF sy-subrc = 0.
  **      ls_final-matnr = <fs_mara>-matnr.
  **      ls_final-mtart = <fs_mara>-mtart.
  **      ls_final-ntgew = <fs_mara>-ntgew.
  **      ls_final-gewei = <fs_mara>-gewei.
  **      ls_final-maktx = <fs_makt>-maktx.
  **      APPEND ls_final TO gt_final.
  **    ENDIF.
  **
  **  ENDLOOP.
  *
  *DATA : ls_finalclient LIKE LINE OF GT_ZJPP_FINAL .
  *
  *LOOP AT LT_VBAK ASSIGNING FIELD-SYMBOL(<fs_VBAK>).
  *    CLEAR ls_finalclient.
  *    READ TABLE LT_VBAP ASSIGNING FIELD-SYMBOL(<fs_VBAP>) WITH KEY VBELN = <fs_BAK>-vbeln.
  *
  *    IF sy-subrc = 0.
  *      ls_finalcient-vbeln = <fs_vbap>-vbeln.
  *      ls_finalcient-vbelp = <fs_BAP>-vbelp.
  *      APPEND ls_finalcient TO GT_ZJPP_FINAL.
  *    ENDIF.
  *
  *ENDLOOP.
  *
  *
  *
  *
  *
  *
  *ENDFORM.
  
  
  
  
  
  
  
  
  
  *&---------------------------------------------------------------------*
  *& Form merge_data_Client
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *&      --> LT_VBAK
  *&      --> LT_VBAP
  *&      --> LT_MAKT
  *&      --> LT_KNA1
  *&---------------------------------------------------------------------*
  FORM merge_data_Client  USING    UT_VBAK TYPE TY_T_VBAK
                                   UT_VBAP TYPE TY_T_VBAP
                                   UT_MAKT TYPE TY_T_MAKT
                                   UT_KNA1 TYPE TY_T_KNA1.
  
  
  
  
  
  
    DATA : LS_FINALCLIENT LIKE LINE OF GT_ZJPP_FINAL .
  *VBAK_VBELN
  *VBAK_ERDAT
  *VBAK_VKORG
  *VBAK_VTWEG
  *VBAK_SPART
  *VBAK_NETWR
  *VBAK_WAERK
  
  *VBAP_POSNR
  *VBAP_MATNR
  
  *MAKT_MAKTX
  
  *VBAP_CHARG
  *VBAP_KUNNR_ANA
  
  *KNA1_NAME1
  *ZJPP_ADRESSE
  
  *VBAP_NETWR
  *VBAP_WAERK
  
    LOOP AT UT_VBAK ASSIGNING FIELD-SYMBOL(<FS_VBAK>).
  
      CLEAR LS_FINALCLIENT.
      LS_FINALCLIENT-VBAK_VBELN = <FS_VBAK>-VBELN.
      LS_FINALCLIENT-VBAK_ERDAT = <FS_VBAK>-VBELN.
      LS_FINALCLIENT-VBAK_VKORG = <FS_VBAK>-VKORG.
      LS_FINALCLIENT-VBAK_VTWEG = <FS_VBAK>-VTWEG.
      LS_FINALCLIENT-VBAK_SPART = <FS_VBAK>-SPART.
      LS_FINALCLIENT-VBAK_NETWR = <FS_VBAK>-NETWR.
      LS_FINALCLIENT-VBAK_WAERK = <FS_VBAK>-WAERK.
  
      LOOP AT UT_VBAP ASSIGNING FIELD-SYMBOL(<fs_VBAP>) WHERE VBELN = <fs_VBAK>-VBELN.
  *    READ TABLE UT_VBAP ASSIGNING FIELD-SYMBOL(<fs_VBAP>) WITH KEY VBELN = <fs_VBAK>-vbeln.
        IF SY-SUBRC = 0.
          LS_FINALCLIENT-VBAP_POSNR = <fs_VBAP>-POSNR.
          LS_FINALCLIENT-VBAP_MATNR = <fs_VBAP>-MATNR.
          LS_FINALCLIENT-VBAP_CHARG = <fs_VBAP>-CHARG.
          LS_FINALCLIENT-VBAP_KUNNR_ANA = <fs_VBAP>-KUNNR_ANA.
          LS_FINALCLIENT-VBAP_NETWR = <fs_VBAP>-NETWR.
          LS_FINALCLIENT-VBAP_WAERK = <fs_VBAP>-WAERK.
        ENDIF.
  
        READ TABLE UT_MAKT ASSIGNING FIELD-SYMBOL(<fs_MAKT>) WITH KEY MATNR = <fs_VBAP>-MATNR.
        IF SY-SUBRC = 0.
          LS_FINALCLIENT-MAKT_MAKTX = <fs_MAKT>-MAKTX.
        ENDIF.
  
        READ TABLE UT_KNA1 ASSIGNING FIELD-SYMBOL(<fs_KNA1>) WITH KEY KUNNR = <fs_VBAP>-KUNNR_ANA.
        IF SY-SUBRC = 0.
          LS_FINALCLIENT-KNA1_NAME1 = <fs_KNA1>-NAME1.
  *         ls_finalclient-ZJPP_ADRESSE = 'JESAIPACONCAT'.
  *         ls_finalclient-ZJPP_ADRESSE = CONCATENATE( <fs_KNA1>-STRAS , <fs_KNA1>-PSTLZ  ).
          CONCATENATE <fs_KNA1>-STRAS <fs_KNA1>-PSTLZ  <fs_KNA1>-ORT01 <fs_KNA1>-LAND1 INTO LS_FINALCLIENT-ZJPP_ADRESSE SEPARATED BY ','.
        ENDIF.
  
        APPEND LS_FINALCLIENT TO GT_ZJPP_FINAL.
  
      ENDLOOP.
  
  **          ZJPP_ADRESSE TYPE ZJPP_ADRESSE,
  *          STRAS TYPE KNA1-STRAS,
  *          PSTLZ TYPE KNA1-PSTLZ,
  *          ORT01 TYPE KNA1-ORT01,
  *          LAND1 TYPE KNA1-LAND1,
  
  
  
    ENDLOOP.
  
  
  
  ENDFORM.
  
  
  
  
  *&---------------------------------------------------------------------*
  *& Form display_data_Cient
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  FORM display_data_Cient .
  
    DATA : LO_ALV TYPE REF TO CL_SALV_TABLE.
  
    CL_SALV_TABLE=>FACTORY(
    IMPORTING
      R_SALV_TABLE = LO_ALV
    CHANGING
      T_TABLE      = GT_ZJPP_FINAL ).
  
    LO_ALV->DISPLAY( ).
  
  ENDFORM.