*&---------------------------------------------------------------------*
*& Include          ZJPP_FORMATION5_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form select_data_livraison
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

FORM SELECT_DATA_LIVRAISON.


  *LIKP-VBELN V  Le numéro de livraison
  *LIKP-ABLAD V  Le point d’expédition
  *LIKP-VKORG V  L’organisation commerciale
  *LIKP-ERDAT V  La date de création de la livraison
  *
  *  DATA : LT_LIKP  TYPE TABLE OF TY_LIKP.
  *
  *  SELECT
  *    VBELN
  *    ABLAD
  *    VKORG
  *    ERDAT
  *    FROM LIKP
  *    INTO TABLE LT_LIKP
  *    WHERE VBELN IN S_vbeln.
  *
  ********LIPS Via VBELN*********
  **LIPS-POSNR-J  Le numéro de poste
  **LIPS-MATNR J  L’article livré
  **LIPS-WERKS J  La division
  **LIPS-LFIMG J  La quantité livrée
  **LIPS-MEINS J  L’Unité de quantité
  *
  *  DATA : LT_LIPS  TYPE TABLE OF TY_LIPS.
  *
  *  SELECT
  *    VBELN
  *    POSNR
  *    MATNR
  *    WERKS
  *    LFIMG
  *    MEINS
  *    FROM LIPS
  *    INTO TABLE LT_LIPS
  *    FOR ALL ENTRIES IN LT_LIKP
  *    WHERE VBELN = LT_LIKP-VBELN
  *    AND MATNR IN S_MATNR
  *    AND WERKS IN S_WERKS.
  *
  *
  *********MARC Via MATNR & WERKS*********
  **MARC-EKGRP B  Grpe acheteurs
  *
  *  DATA : LT_MARC  TYPE TABLE OF TY_MARC.
  *
  *  IF P_FOR IS NOT INITIAL.
  *
  *    SELECT
  *    MARC~MATNR
  *    WERKS
  *    EKGRP
  *    FROM MARC
  *    INNER JOIN MARA ON MARC~MATNR = MARA~MATNR
  *    INTO TABLE LT_MARC
  *      FOR ALL ENTRIES IN LT_LIPS
  *    WHERE MARC~MATNR = LT_LIPS-MATNR
  *      AND MARC~MATNR IN S_MATNR
  *      AND MARA~LVORM = 'x' .
  *
  *  ELSE.
  *
  *    SELECT
  *      MATNR
  *      WERKS
  *      EKGRP
  *      FROM MARC
  *      INTO TABLE LT_MARC
  *      FOR ALL ENTRIES IN LT_LIPS
  *      WHERE MARC~MATNR = LT_LIPS-MATNR
  *      AND MARC~WERKS = LT_LIPS-WERKS
  *      AND MATNR IN S_MATNR.
  *  ENDIF.
  *
  *
  *
  *
  *
  *********VBRP Via VBELN*********
  **VBRP-POSNR M  Le poste de la facture
  **VBRP-FKIMG M  Qté facturée
  **VBRP-MEINS M  L’unité de cette quantité (unité de vente)
  **VBRP-NTGEW M  Poids net
  **VBRP-GEWEI M  Unité de poids
  **VBRP-NETWR M  Valeur nette
  *
  *  DATA : LT_VBRP  TYPE TABLE OF TY_VBRP.
  *
  *  SELECT
  *    VBELN
  *    POSNR
  *    FKIMG
  *    MEINS
  *    NTGEW
  *    GEWEI
  *    NETWR
  *    VGBEL
  *    VGPOS
  *    FROM VBRP
  *    INTO TABLE LT_VBRP
  *    FOR ALL ENTRIES IN LT_LIPS
  *    WHERE VGBEL = LT_LIPS-VBELN
  *    AND VGPOS = LT_LIPS-POSNR.
  *
  *
  ****LIPS-VBELN <--> VBRP-VGBEL
  ****LIPS-POSNR <--> VBRP-VGPOS
  *
  *********VBRK Via VBELN*********
  **VBRK-VBELN G  Le numéro de facture
  **VBRK-FKART G  Le type de facture
  **VBRK-FKDAT G  La date de la facture
  **VBRK-WAERK G  La devise
  *
  *  DATA : LT_VBRK  TYPE TABLE OF TY_VBRK.
  *
  *  SELECT
  *    VBELN
  *    FKART
  *    FKDAT
  *    WAERK
  *    FROM VBRK
  *    INTO TABLE LT_VBRK
  *    FOR ALL ENTRIES IN LT_VBRP
  *    WHERE VBELN = LT_VBRP-VBELN
  *    AND VBELN IN S_FVBELN.
  *
  *
  *  PERFORM MERGE_DATA_LIVRAISON USING LT_LIKP LT_LIPS LT_MARC LT_VBRK LT_VBRP .
  
  ENDFORM.
  
  
  
  
  *&---------------------------------------------------------------------*
  *& Form MERGE_DATA_LIVRAISON
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *&      --> LT_LIKP
  *&      --> LT_LIPS
  *&      --> LT_MARC
  *&      --> LT_VBRK
  *&      --> LT_VBRP
  *&---------------------------------------------------------------------*
  *FORM MERGE_DATA_LIVRAISON  USING    UT_LIKP TYPE ty_t_LIKP
  *                                    UT_LIPS TYPE ty_t_LIPS
  *                                    UT_MARC TYPE ty_t_MARC
  *                                    UT_VBRK TYPE ty_t_VBRK
  *                                    UT_VBRP TYPE ty_t_VBRP.
  *
  *
  *
  *  DATA : LS_FINAL_LIVRAISON LIKE LINE OF GT_FINAL .
  **DATA : LT_FINAL_LIVRAISON TYPE TABLE OF GT_FINAL .
  *
  *  LOOP AT UT_LIKP ASSIGNING FIELD-SYMBOL(<FS_LIKP>).
  *
  *    CLEAR LS_FINAL_LIVRAISON.
  *    LS_FINAL_LIVRAISON-LIKP_VBELN = <FS_LIKP>-VBELN.
  *    LS_FINAL_LIVRAISON-LIKP_ABLAD = <FS_LIKP>-ABLAD.
  *    LS_FINAL_LIVRAISON-LIKP_VKORG = <FS_LIKP>-VKORG.
  *    LS_FINAL_LIVRAISON-LIKP_ERDAT = <FS_LIKP>-ERDAT.
  *
  *
  *    CONCATENATE sy-datum(4) sy-datum+4(2) sy-datum+6(2) INTO LS_FINAL_LIVRAISON-ZDATE SEPARATED BY '/'.
  *
  *    LOOP AT UT_LIPS ASSIGNING FIELD-SYMBOL(<fs_LIPS>) WHERE VBELN = <fs_LIKP>-VBELN.
  *
  *      LS_FINAL_LIVRAISON-LIPS_POSNR = <FS_LIPS>-POSNR.
  *      LS_FINAL_LIVRAISON-LIPS_MATNR = <FS_LIPS>-MATNR .
  *      LS_FINAL_LIVRAISON-LIPS_WERKS = <FS_LIPS>-WERKS .
  *      LS_FINAL_LIVRAISON-LIPS_LFIMG = <FS_LIPS>-LFIMG  .
  *      LS_FINAL_LIVRAISON-LIPS_MEINS = <FS_LIPS>-MEINS .
  *
  *      READ TABLE UT_MARC ASSIGNING FIELD-SYMBOL(<fs_MARC>) WITH KEY MATNR = <fs_LIPS>-MATNR WERKS = <fs_LIPS>-WERKS .
  *      IF SY-SUBRC = 0.
  *        LS_FINAL_LIVRAISON-MARC_EKGRP = <fs_MARC>-EKGRP.
  *      ELSE.
  **        MESSAGE TEXT-001 TYPE 'E'.   "Je n'ai pas trouvé d'Article dans la MARC"
  **        EXIT.
  *      ENDIF.
  *
  *
  *
  *
  *      LOOP AT UT_VBRP ASSIGNING FIELD-SYMBOL(<fs_VBRP>) WHERE VGBEL = <fs_LIPS>-VBELN AND VGPOS = <fs_LIPS>-POSNR.
  *        LS_FINAL_LIVRAISON-VBRP_POSNR = <fs_VBRP>-POSNR.
  *        LS_FINAL_LIVRAISON-VBRP_FKIMG = <fs_VBRP>-FKIMG.
  *        LS_FINAL_LIVRAISON-VBRP_MEINS = <fs_VBRP>-MEINS.
  *        LS_FINAL_LIVRAISON-VBRP_NTGEW = <fs_VBRP>-NTGEW.
  *        LS_FINAL_LIVRAISON-VBRP_GEWEI = <fs_VBRP>-GEWEI.
  *        LS_FINAL_LIVRAISON-VBRP_NETWR = <fs_VBRP>-VBELN.
  *
  *        READ TABLE UT_VBRK ASSIGNING FIELD-SYMBOL(<fs_VBRK>) WITH KEY VBELN = <FS_VBRP>-VBELN.
  *        IF SY-SUBRC = 0.
  *          LS_FINAL_LIVRAISON-VBRK_VBELN = <fs_VBRK>-VBELN.
  *          LS_FINAL_LIVRAISON-VBRK_FKART = <fs_VBRK>-FKART.
  *          LS_FINAL_LIVRAISON-VBRK_FKDAT = <fs_VBRK>-FKDAT.
  *          LS_FINAL_LIVRAISON-VBRK_WAERK = <fs_VBRK>-WAERK.
  *          APPEND LS_FINAL_LIVRAISON TO GT_FINAL.
  *        ELSE.
  *        MESSAGE TEXT-002 TYPE 'E'.   "Je n'ai pas trouvé de facture"
  *        EXIT.
  *        ENDIF.
  *
  *
  *
  *      ENDLOOP.
  *
  *
  *
  *
  *    ENDLOOP.
  *
  ****LIPS-VBELN <--> VBRP-VGBEL
  ****LIPS-POSNR <--> VBRP-VGPOS
  *
  *
  *  ENDLOOP.
  
  
  *
  *ENDFORM.
  **&---------------------------------------------------------------------*
  **& Form AFFICHER_DATA_LIVRAISON
  **&---------------------------------------------------------------------*
  **& text
  **&---------------------------------------------------------------------*
  **& -->  p1        text
  **& <--  p2        text
  **&---------------------------------------------------------------------*
  *FORM AFFICHER_DATA_LIVRAISON .
  *
  *  DATA : LO_ALV TYPE REF TO CL_SALV_TABLE.
  *
  *  CL_SALV_TABLE=>FACTORY(
  *  IMPORTING
  *    R_SALV_TABLE = LO_ALV
  *  CHANGING
  *    T_TABLE      = GT_FINAL ).
  *
  *  LO_ALV->DISPLAY( ).
  *
  *ENDFORM.
  **&---------------------------------------------------------------------*
  **& Form SELECT_MODIF_DATE
  **&---------------------------------------------------------------------*
  **& text
  **&---------------------------------------------------------------------*
  **& -->  p1        text
  **& <--  p2        text
  **&---------------------------------------------------------------------*
  *FORM SELECT_MODIF_DATE .
  *
  *
  *DATA : LS_DATE LIKE LINE OF GT_DATE .
  *
  **DATE_INIT TYPE DATS ,
  **DATE_MODIF TYPE DATS ,
  **DATE_MODIF2 TYPE DATS ,
  *
  *    LS_DATE-DATE_INIT = sy-datum.
  *    CONCATENATE sy-datum(4) sy-datum+4(2) sy-datum+6(2) INTO LS_DATE-DATE_MODIF SEPARATED BY '/' .
  **    LS_DATE-DATE_MODIF =  .
  **   LS_DATE-DATE_MODIF2 = .
  *
  *    APPEND LS_DATE TO GT_DATE.
  *
  *
  *ENDFORM.
  **&---------------------------------------------------------------------*
  **& Form AFFICHER_MODIF_DATE
  **&---------------------------------------------------------------------*
  **& text
  **&---------------------------------------------------------------------*
  **& -->  p1        text
  **& <--  p2        text
  **&---------------------------------------------------------------------*
  *FORM AFFICHER_MODIF_DATE .
  *  DATA : LO_ALV TYPE REF TO CL_SALV_TABLE.
  *
  *  CL_SALV_TABLE=>FACTORY(
  *  IMPORTING
  *    R_SALV_TABLE = LO_ALV
  *  CHANGING
  *    T_TABLE      = GT_DATE ).
  *
  *  LO_ALV->DISPLAY( ).
  *
  *ENDFORM.